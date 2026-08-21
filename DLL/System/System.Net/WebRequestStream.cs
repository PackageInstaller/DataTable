using System.IO;
using System.Net.Sockets;
using System.Runtime.ExceptionServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal class WebRequestStream : WebConnectionStream
{
	private static byte[] crlf = new byte[2] { 13, 10 };

	private MemoryStream writeBuffer;

	private bool requestWritten;

	private bool allowBuffering;

	private bool sendChunked;

	private WebCompletionSource pendingWrite;

	private long totalWritten;

	private byte[] headers;

	private bool headersSent;

	private int completeRequestWritten;

	private int chunkTrailerWritten;

	internal Stream InnerStream { get; }

	public bool KeepAlive { get; }

	public override bool CanRead => false;

	public override bool CanWrite => true;

	internal bool HasWriteBuffer
	{
		get
		{
			if (base.Operation.WriteBuffer == null)
			{
				return writeBuffer != null;
			}
			return true;
		}
	}

	internal int WriteBufferLength
	{
		get
		{
			if (base.Operation.WriteBuffer != null)
			{
				return base.Operation.WriteBuffer.Size;
			}
			if (writeBuffer != null)
			{
				return (int)writeBuffer.Length;
			}
			return -1;
		}
	}

	public WebRequestStream(WebConnection connection, WebOperation operation, Stream stream, WebConnectionTunnel tunnel)
		: base(connection, operation)
	{
		InnerStream = stream;
		allowBuffering = operation.Request.InternalAllowBuffering;
		sendChunked = operation.Request.SendChunked && operation.WriteBuffer == null;
		if (!sendChunked && allowBuffering && operation.WriteBuffer == null)
		{
			writeBuffer = new MemoryStream();
		}
		KeepAlive = base.Request.KeepAlive;
		if (tunnel?.ProxyVersion != null && tunnel?.ProxyVersion != HttpVersion.Version11)
		{
			KeepAlive = false;
		}
	}

	internal BufferOffsetSize GetWriteBuffer()
	{
		if (base.Operation.WriteBuffer != null)
		{
			return base.Operation.WriteBuffer;
		}
		if (writeBuffer == null || writeBuffer.Length == 0L)
		{
			return null;
		}
		return new BufferOffsetSize(writeBuffer.GetBuffer(), 0, (int)writeBuffer.Length, copyBuffer: false);
	}

	private async Task FinishWriting(CancellationToken cancellationToken)
	{
		if (Interlocked.CompareExchange(ref completeRequestWritten, 1, 0) != 0)
		{
			return;
		}
		try
		{
			base.Operation.ThrowIfClosedOrDisposed(cancellationToken);
			if (sendChunked)
			{
				await WriteChunkTrailer_inner(cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			}
		}
		catch (Exception error)
		{
			base.Operation.CompleteRequestWritten(this, error);
			throw;
		}
		finally
		{
			_ = 0;
		}
		base.Operation.CompleteRequestWritten(this);
	}

	public override Task WriteAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		int num = buffer.Length;
		if (offset < 0 || num < offset)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if (count < 0 || num - offset < count)
		{
			throw new ArgumentOutOfRangeException("count");
		}
		if (cancellationToken.IsCancellationRequested)
		{
			return Task.FromCanceled(cancellationToken);
		}
		base.Operation.ThrowIfClosedOrDisposed(cancellationToken);
		if (base.Operation.WriteBuffer != null)
		{
			throw new InvalidOperationException();
		}
		WebCompletionSource webCompletionSource = new WebCompletionSource();
		if (Interlocked.CompareExchange(ref pendingWrite, webCompletionSource, null) != null)
		{
			throw new InvalidOperationException(global::SR.GetString("Cannot re-call BeginGetRequestStream/BeginGetResponse while a previous call is still in progress."));
		}
		return WriteAsyncInner(buffer, offset, count, webCompletionSource, cancellationToken);
	}

	private async Task WriteAsyncInner(byte[] buffer, int offset, int size, WebCompletionSource completion, CancellationToken cancellationToken)
	{
		_ = 1;
		try
		{
			await ProcessWrite(buffer, offset, size, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			if (base.Request.ContentLength > 0 && totalWritten == base.Request.ContentLength)
			{
				await FinishWriting(cancellationToken);
			}
			pendingWrite = null;
			completion.TrySetCompleted();
		}
		catch (Exception ex)
		{
			KillBuffer();
			closed = true;
			ExceptionDispatchInfo exceptionDispatchInfo = base.Operation.CheckDisposed(cancellationToken);
			if (exceptionDispatchInfo != null)
			{
				ex = exceptionDispatchInfo.SourceException;
			}
			else if (ex is SocketException)
			{
				ex = new IOException("Error writing request", ex);
			}
			base.Operation.CompleteRequestWritten(this, ex);
			pendingWrite = null;
			completion.TrySetException(ex);
			exceptionDispatchInfo?.Throw();
			throw;
		}
	}

	private async Task ProcessWrite(byte[] buffer, int offset, int size, CancellationToken cancellationToken)
	{
		base.Operation.ThrowIfClosedOrDisposed(cancellationToken);
		if (sendChunked)
		{
			requestWritten = true;
			string s = $"{size:X}\r\n";
			byte[] bytes = Encoding.ASCII.GetBytes(s);
			int num = 2 + size + bytes.Length;
			byte[] array = new byte[num];
			Buffer.BlockCopy(bytes, 0, array, 0, bytes.Length);
			Buffer.BlockCopy(buffer, offset, array, bytes.Length, size);
			Buffer.BlockCopy(crlf, 0, array, bytes.Length + size, crlf.Length);
			if (allowBuffering)
			{
				if (writeBuffer == null)
				{
					writeBuffer = new MemoryStream();
				}
				writeBuffer.Write(buffer, offset, size);
			}
			totalWritten += size;
			buffer = array;
			offset = 0;
			size = num;
		}
		else
		{
			CheckWriteOverflow(base.Request.ContentLength, totalWritten, size);
			if (allowBuffering)
			{
				if (writeBuffer == null)
				{
					writeBuffer = new MemoryStream();
				}
				writeBuffer.Write(buffer, offset, size);
				totalWritten += size;
				if (base.Request.ContentLength <= 0 || totalWritten < base.Request.ContentLength)
				{
					return;
				}
				requestWritten = true;
				buffer = writeBuffer.GetBuffer();
				offset = 0;
				size = (int)totalWritten;
			}
			else
			{
				totalWritten += size;
			}
		}
		await InnerStream.WriteAsync(buffer, offset, size, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
	}

	private void CheckWriteOverflow(long contentLength, long totalWritten, long size)
	{
		if (contentLength != -1)
		{
			long num = contentLength - totalWritten;
			if (size > num)
			{
				KillBuffer();
				closed = true;
				ProtocolViolationException ex = new ProtocolViolationException("The number of bytes to be written is greater than the specified ContentLength.");
				base.Operation.CompleteRequestWritten(this, ex);
				throw ex;
			}
		}
	}

	internal async Task Initialize(CancellationToken cancellationToken)
	{
		base.Operation.ThrowIfClosedOrDisposed(cancellationToken);
		if (base.Operation.WriteBuffer != null)
		{
			if (base.Operation.IsNtlmChallenge)
			{
				base.Request.InternalContentLength = 0L;
			}
			else
			{
				base.Request.InternalContentLength = base.Operation.WriteBuffer.Size;
			}
		}
		await SetHeadersAsync(setInternalLength: false, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		base.Operation.ThrowIfClosedOrDisposed(cancellationToken);
		if (base.Operation.WriteBuffer != null && !base.Operation.IsNtlmChallenge)
		{
			await WriteRequestAsync(cancellationToken);
			Close();
		}
	}

	private async Task SetHeadersAsync(bool setInternalLength, CancellationToken cancellationToken)
	{
		base.Operation.ThrowIfClosedOrDisposed(cancellationToken);
		if (headersSent)
		{
			return;
		}
		string method = base.Request.Method;
		int num;
		switch (method)
		{
		default:
			num = ((method == "TRACE") ? 1 : 0);
			break;
		case "GET":
		case "CONNECT":
		case "HEAD":
			num = 1;
			break;
		}
		bool flag = (byte)num != 0;
		int num2;
		switch (method)
		{
		default:
			num2 = ((method == "UNLOCK") ? 1 : 0);
			break;
		case "PROPFIND":
		case "PROPPATCH":
		case "MKCOL":
		case "COPY":
		case "MOVE":
		case "LOCK":
			num2 = 1;
			break;
		}
		bool flag2 = (byte)num2 != 0;
		if (base.Operation.IsNtlmChallenge)
		{
			flag = true;
		}
		if (setInternalLength && !flag && HasWriteBuffer)
		{
			base.Request.InternalContentLength = WriteBufferLength;
		}
		bool flag3 = !flag && (!HasWriteBuffer || base.Request.ContentLength > -1);
		if (!(sendChunked | flag3 | flag | flag2))
		{
			return;
		}
		headersSent = true;
		headers = base.Request.GetRequestHeaders();
		try
		{
			await InnerStream.WriteAsync(headers, 0, headers.Length, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			long contentLength = base.Request.ContentLength;
			if (!sendChunked && contentLength == 0L)
			{
				requestWritten = true;
			}
		}
		catch (Exception ex)
		{
			if (ex is WebException || ex is OperationCanceledException)
			{
				throw;
			}
			throw new WebException("Error writing headers", WebExceptionStatus.SendFailure, WebExceptionInternalStatus.RequestFatal, ex);
		}
	}

	internal async Task WriteRequestAsync(CancellationToken cancellationToken)
	{
		base.Operation.ThrowIfClosedOrDisposed(cancellationToken);
		if (requestWritten)
		{
			return;
		}
		requestWritten = true;
		if (!sendChunked && HasWriteBuffer)
		{
			BufferOffsetSize buffer = GetWriteBuffer();
			if (buffer != null && !base.Operation.IsNtlmChallenge && base.Request.ContentLength != -1 && base.Request.ContentLength < buffer.Size)
			{
				closed = true;
				WebException ex = new WebException("Specified Content-Length is less than the number of bytes to write", null, WebExceptionStatus.ServerProtocolViolation, null);
				base.Operation.CompleteRequestWritten(this, ex);
				throw ex;
			}
			await SetHeadersAsync(setInternalLength: true, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			base.Operation.ThrowIfClosedOrDisposed(cancellationToken);
			if (buffer != null && buffer.Size > 0)
			{
				await InnerStream.WriteAsync(buffer.Buffer, 0, buffer.Size, cancellationToken);
			}
			await FinishWriting(cancellationToken);
		}
	}

	private async Task WriteChunkTrailer_inner(CancellationToken cancellationToken)
	{
		if (Interlocked.CompareExchange(ref chunkTrailerWritten, 1, 0) == 0)
		{
			base.Operation.ThrowIfClosedOrDisposed(cancellationToken);
			byte[] bytes = Encoding.ASCII.GetBytes("0\r\n\r\n");
			await InnerStream.WriteAsync(bytes, 0, bytes.Length, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		}
	}

	private async Task WriteChunkTrailer()
	{
		CancellationTokenSource cts = new CancellationTokenSource();
		try
		{
			cts.CancelAfter(WriteTimeout);
			Task timeoutTask = Task.Delay(WriteTimeout, cts.Token);
			while (true)
			{
				WebCompletionSource value = new WebCompletionSource();
				WebCompletionSource webCompletionSource = Interlocked.CompareExchange(ref pendingWrite, value, null);
				if (webCompletionSource == null)
				{
					break;
				}
				Task<object> task = webCompletionSource.WaitForCompletion();
				if (await Task.WhenAny(timeoutTask, task).ConfigureAwait(continueOnCapturedContext: false) == timeoutTask)
				{
					throw new WebException("The operation has timed out.", WebExceptionStatus.Timeout);
				}
			}
			await WriteChunkTrailer_inner(cts.Token).ConfigureAwait(continueOnCapturedContext: false);
		}
		catch
		{
		}
		finally
		{
			pendingWrite = null;
			cts.Cancel();
			cts.Dispose();
		}
	}

	internal void KillBuffer()
	{
		writeBuffer = null;
	}

	public override Task<int> ReadAsync(byte[] buffer, int offset, int size, CancellationToken cancellationToken)
	{
		return Task.FromException<int>(new NotSupportedException("The stream does not support reading."));
	}

	protected override bool TryReadFromBufferedContent(byte[] buffer, int offset, int count, out int result)
	{
		throw new InvalidOperationException();
	}

	protected override void Close_internal(ref bool disposed)
	{
		if (disposed)
		{
			return;
		}
		disposed = true;
		if (sendChunked)
		{
			WriteChunkTrailer().Wait();
			return;
		}
		if (!allowBuffering || requestWritten)
		{
			base.Operation.CompleteRequestWritten(this);
			return;
		}
		long contentLength = base.Request.ContentLength;
		if (!sendChunked && !base.Operation.IsNtlmChallenge && contentLength != -1 && totalWritten != contentLength)
		{
			IOException innerException = new IOException("Cannot close the stream until all bytes are written");
			closed = true;
			disposed = true;
			WebException ex = new WebException("Request was cancelled.", WebExceptionStatus.RequestCanceled, WebExceptionInternalStatus.RequestFatal, innerException);
			base.Operation.CompleteRequestWritten(this, ex);
			throw ex;
		}
		disposed = true;
		base.Operation.CompleteRequestWritten(this);
	}
}
