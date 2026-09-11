using System.Collections.Generic;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal class WebResponseStream : WebConnectionStream
{
	private WebReadStream innerStream;

	private bool nextReadCalled;

	private bool bufferedEntireContent;

	private WebCompletionSource pendingRead;

	private object locker = new object();

	private int nestedRead;

	private bool read_eof;

	internal readonly string ME;

	public WebRequestStream RequestStream { get; }

	public WebHeaderCollection Headers { get; private set; }

	public HttpStatusCode StatusCode { get; private set; }

	public string StatusDescription { get; private set; }

	public Version Version { get; private set; }

	public bool KeepAlive { get; private set; }

	public override bool CanRead => true;

	public override bool CanWrite => false;

	private bool ChunkedRead { get; set; }

	private bool ExpectContent
	{
		get
		{
			if (base.Request.Method == "HEAD")
			{
				return false;
			}
			if (StatusCode >= HttpStatusCode.OK && StatusCode != HttpStatusCode.NoContent)
			{
				return StatusCode != HttpStatusCode.NotModified;
			}
			return false;
		}
	}

	public WebResponseStream(WebRequestStream request)
		: base(request.Connection, request.Operation)
	{
		RequestStream = request;
	}

	public override async Task<int> ReadAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		cancellationToken.ThrowIfCancellationRequested();
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
		if (Interlocked.CompareExchange(ref nestedRead, 1, 0) != 0)
		{
			throw new InvalidOperationException("Invalid nested call.");
		}
		WebCompletionSource completion = new WebCompletionSource();
		while (!cancellationToken.IsCancellationRequested)
		{
			WebCompletionSource webCompletionSource = Interlocked.CompareExchange(ref pendingRead, completion, null);
			if (webCompletionSource == null)
			{
				break;
			}
			await webCompletionSource.WaitForCompletion().ConfigureAwait(continueOnCapturedContext: false);
		}
		int nbytes = 0;
		Exception throwMe = null;
		try
		{
			nbytes = await ProcessRead(buffer, offset, count, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		}
		catch (Exception error)
		{
			throwMe = GetReadException(WebExceptionStatus.ReceiveFailure, error, "ReadAsync");
		}
		if (throwMe != null)
		{
			lock (locker)
			{
				completion.TrySetException(throwMe);
				pendingRead = null;
				nestedRead = 0;
			}
			closed = true;
			base.Operation.Finish(ok: false, throwMe);
			throw throwMe;
		}
		lock (locker)
		{
			completion.TrySetCompleted();
			pendingRead = null;
			nestedRead = 0;
		}
		if (nbytes <= 0 && !read_eof)
		{
			read_eof = true;
			if (!nextReadCalled && !nextReadCalled)
			{
				nextReadCalled = true;
				base.Operation.Finish(ok: true);
			}
		}
		return nbytes;
	}

	private Task<int> ProcessRead(byte[] buffer, int offset, int size, CancellationToken cancellationToken)
	{
		if (read_eof)
		{
			return Task.FromResult(0);
		}
		if (cancellationToken.IsCancellationRequested)
		{
			return Task.FromCanceled<int>(cancellationToken);
		}
		return HttpWebRequest.RunWithTimeout((CancellationToken ct) => innerStream.ReadAsync(buffer, offset, size, ct), ReadTimeout, delegate
		{
			base.Operation.Abort();
			innerStream.Dispose();
		}, () => base.Operation.Aborted, cancellationToken);
	}

	protected override bool TryReadFromBufferedContent(byte[] buffer, int offset, int count, out int result)
	{
		if (bufferedEntireContent && innerStream is BufferedReadStream bufferedReadStream)
		{
			return bufferedReadStream.TryReadFromBuffer(buffer, offset, count, out result);
		}
		result = 0;
		return false;
	}

	private void Initialize(BufferOffsetSize buffer)
	{
		string text = Headers["Transfer-Encoding"];
		bool num = text != null && text.IndexOf("chunked", StringComparison.OrdinalIgnoreCase) != -1;
		string text2 = Headers["Content-Length"];
		long result;
		if (!num && !string.IsNullOrEmpty(text2))
		{
			if (!long.TryParse(text2, out result))
			{
				result = long.MaxValue;
			}
		}
		else
		{
			result = long.MaxValue;
		}
		string text3 = null;
		if (ExpectContent)
		{
			text3 = Headers["Transfer-Encoding"];
		}
		ChunkedRead = text3 != null && text3.IndexOf("chunked", StringComparison.OrdinalIgnoreCase) != -1;
		if (Version == HttpVersion.Version11 && RequestStream.KeepAlive)
		{
			KeepAlive = true;
			string text4 = Headers[base.ServicePoint.UsesProxy ? "Proxy-Connection" : "Connection"];
			if (text4 != null)
			{
				text4 = text4.ToLower();
				KeepAlive = text4.IndexOf("keep-alive", StringComparison.Ordinal) != -1;
				if (text4.IndexOf("close", StringComparison.Ordinal) != -1)
				{
					KeepAlive = false;
				}
			}
			if (!ChunkedRead && result == long.MaxValue)
			{
				KeepAlive = false;
			}
		}
		Stream stream;
		if (ExpectContent && (ChunkedRead || buffer.Size < result))
		{
			stream = ((buffer.Size <= 0) ? RequestStream.InnerStream : new BufferedReadStream(base.Operation, RequestStream.InnerStream, buffer));
		}
		else
		{
			bufferedEntireContent = true;
			innerStream = new BufferedReadStream(base.Operation, null, buffer);
			stream = innerStream;
		}
		if (ChunkedRead)
		{
			innerStream = new MonoChunkStream(base.Operation, stream, Headers);
		}
		else if (!bufferedEntireContent)
		{
			if (result != long.MaxValue)
			{
				innerStream = new FixedSizeReadStream(base.Operation, stream, result);
			}
			else
			{
				innerStream = new BufferedReadStream(base.Operation, stream, null);
			}
		}
		string text5 = Headers["Content-Encoding"];
		if (text5 == "gzip" && (base.Request.AutomaticDecompression & DecompressionMethods.GZip) != DecompressionMethods.None)
		{
			innerStream = ContentDecodeStream.Create(base.Operation, innerStream, ContentDecodeStream.Mode.GZip);
			Headers.Remove(HttpRequestHeader.ContentEncoding);
		}
		else if (text5 == "deflate" && (base.Request.AutomaticDecompression & DecompressionMethods.Deflate) != DecompressionMethods.None)
		{
			innerStream = ContentDecodeStream.Create(base.Operation, innerStream, ContentDecodeStream.Mode.Deflate);
			Headers.Remove(HttpRequestHeader.ContentEncoding);
		}
		if (!ExpectContent)
		{
			nextReadCalled = true;
			base.Operation.Finish(ok: true);
		}
	}

	private async Task<byte[]> ReadAllAsyncInner(CancellationToken cancellationToken)
	{
		long maximumSize = (long)HttpWebRequest.DefaultMaximumErrorResponseLength << 16;
		using MemoryStream ms = new MemoryStream();
		while (ms.Position < maximumSize)
		{
			cancellationToken.ThrowIfCancellationRequested();
			byte[] buffer = new byte[16384];
			int num = await ProcessRead(buffer, 0, buffer.Length, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			if (num < 0)
			{
				throw new IOException();
			}
			if (num == 0)
			{
				break;
			}
			ms.Write(buffer, 0, num);
		}
		return ms.ToArray();
	}

	internal async Task ReadAllAsync(bool resending, CancellationToken cancellationToken)
	{
		if (read_eof || bufferedEntireContent || nextReadCalled)
		{
			if (!nextReadCalled)
			{
				nextReadCalled = true;
				base.Operation.Finish(ok: true);
			}
			return;
		}
		WebCompletionSource completion = new WebCompletionSource();
		CancellationTokenSource timeoutCts = new CancellationTokenSource();
		try
		{
			Task timeoutTask = Task.Delay(ReadTimeout, timeoutCts.Token);
			while (true)
			{
				cancellationToken.ThrowIfCancellationRequested();
				WebCompletionSource webCompletionSource = Interlocked.CompareExchange(ref pendingRead, completion, null);
				if (webCompletionSource != null)
				{
					Task<object> task = webCompletionSource.WaitForCompletion();
					if (await Task.WhenAny(task, timeoutTask).ConfigureAwait(continueOnCapturedContext: false) == timeoutTask)
					{
						throw new WebException("The operation has timed out.", WebExceptionStatus.Timeout);
					}
					continue;
				}
				break;
			}
		}
		finally
		{
			timeoutCts.Cancel();
			timeoutCts.Dispose();
		}
		try
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (read_eof || bufferedEntireContent)
			{
				return;
			}
			if (resending && !KeepAlive)
			{
				Close();
				return;
			}
			byte[] array = await ReadAllAsyncInner(cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			BufferOffsetSize readBuffer = new BufferOffsetSize(array, 0, array.Length, copyBuffer: false);
			innerStream = new BufferedReadStream(base.Operation, null, readBuffer);
			bufferedEntireContent = true;
			nextReadCalled = true;
			completion.TrySetCompleted();
		}
		catch (Exception error)
		{
			completion.TrySetException(error);
			throw;
		}
		finally
		{
			pendingRead = null;
		}
		base.Operation.Finish(ok: true);
	}

	public override Task WriteAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		return Task.FromException(new NotSupportedException("The stream does not support writing."));
	}

	protected override void Close_internal(ref bool disposed)
	{
		if (!closed && !nextReadCalled)
		{
			nextReadCalled = true;
			if (read_eof || bufferedEntireContent)
			{
				disposed = true;
				innerStream?.Dispose();
				innerStream = null;
				base.Operation.Finish(ok: true);
			}
			else
			{
				closed = true;
				disposed = true;
				base.Operation.Finish(ok: false);
			}
		}
	}

	private WebException GetReadException(WebExceptionStatus status, Exception error, string where)
	{
		error = GetException(error);
		_ = $"Error getting response stream ({where}): {status}";
		if (error == null)
		{
			return new WebException($"Error getting response stream ({where}): {status}", status);
		}
		if (error is WebException result)
		{
			return result;
		}
		if (base.Operation.Aborted || error is OperationCanceledException || error is ObjectDisposedException)
		{
			return HttpWebRequest.CreateRequestAbortedException();
		}
		return new WebException($"Error getting response stream ({where}): {status} {error.Message}", status, WebExceptionInternalStatus.RequestFatal, error);
	}

	internal async Task InitReadAsync(CancellationToken cancellationToken)
	{
		BufferOffsetSize buffer = new BufferOffsetSize(new byte[4096], copyBuffer: false);
		ReadState state = ReadState.None;
		int position = 0;
		while (true)
		{
			base.Operation.ThrowIfClosedOrDisposed(cancellationToken);
			int num = await RequestStream.InnerStream.ReadAsync(buffer.Buffer, buffer.Offset, buffer.Size, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			if (num == 0)
			{
				throw GetReadException(WebExceptionStatus.ReceiveFailure, null, "ReadDoneAsync2");
			}
			if (num < 0)
			{
				break;
			}
			buffer.Offset += num;
			buffer.Size -= num;
			if (state == ReadState.None)
			{
				try
				{
					int num2 = position;
					if (!GetResponse(buffer, ref position, ref state))
					{
						position = num2;
					}
				}
				catch (Exception error)
				{
					throw GetReadException(WebExceptionStatus.ServerProtocolViolation, error, "ReadDoneAsync4");
				}
			}
			switch (state)
			{
			case ReadState.Aborted:
				throw GetReadException(WebExceptionStatus.RequestCanceled, null, "ReadDoneAsync5");
			case ReadState.Content:
				buffer.Size = buffer.Offset - position;
				buffer.Offset = position;
				try
				{
					Initialize(buffer);
					return;
				}
				catch (Exception error2)
				{
					throw GetReadException(WebExceptionStatus.ReceiveFailure, error2, "ReadDoneAsync6");
				}
			}
			int num3 = num * 2;
			if (num3 > buffer.Size)
			{
				byte[] array = new byte[buffer.Buffer.Length + num3];
				Buffer.BlockCopy(buffer.Buffer, 0, array, 0, buffer.Offset);
				buffer = new BufferOffsetSize(array, buffer.Offset, array.Length - buffer.Offset, copyBuffer: false);
			}
			state = ReadState.None;
			position = 0;
		}
		throw GetReadException(WebExceptionStatus.ServerProtocolViolation, null, "ReadDoneAsync3");
	}

	private bool GetResponse(BufferOffsetSize buffer, ref int pos, ref ReadState state)
	{
		string output = null;
		bool flag = false;
		bool flag2 = false;
		do
		{
			if (state == ReadState.Aborted)
			{
				throw GetReadException(WebExceptionStatus.RequestCanceled, null, "GetResponse");
			}
			if (state == ReadState.None)
			{
				if (!WebConnection.ReadLine(buffer.Buffer, ref pos, buffer.Offset, ref output))
				{
					return false;
				}
				if (output == null)
				{
					flag2 = true;
					continue;
				}
				flag2 = false;
				state = ReadState.Status;
				string[] array = output.Split(' ');
				if (array.Length < 2)
				{
					throw GetReadException(WebExceptionStatus.ServerProtocolViolation, null, "GetResponse");
				}
				if (string.Compare(array[0], "HTTP/1.1", ignoreCase: true) == 0)
				{
					Version = HttpVersion.Version11;
					base.ServicePoint.SetVersion(HttpVersion.Version11);
				}
				else
				{
					Version = HttpVersion.Version10;
					base.ServicePoint.SetVersion(HttpVersion.Version10);
				}
				StatusCode = (HttpStatusCode)uint.Parse(array[1]);
				if (array.Length >= 3)
				{
					StatusDescription = string.Join(" ", array, 2, array.Length - 2);
				}
				else
				{
					StatusDescription = string.Empty;
				}
				if (pos >= buffer.Offset)
				{
					return true;
				}
			}
			flag2 = false;
			if (state != ReadState.Status)
			{
				continue;
			}
			state = ReadState.Headers;
			Headers = new WebHeaderCollection();
			List<string> list = new List<string>();
			bool flag3 = false;
			while (!flag3 && WebConnection.ReadLine(buffer.Buffer, ref pos, buffer.Offset, ref output))
			{
				if (output == null)
				{
					flag3 = true;
				}
				else if (output.Length > 0 && (output[0] == ' ' || output[0] == '\t'))
				{
					int num = list.Count - 1;
					if (num < 0)
					{
						break;
					}
					string value = list[num] + output;
					list[num] = value;
				}
				else
				{
					list.Add(output);
				}
			}
			if (!flag3)
			{
				return false;
			}
			foreach (string item in list)
			{
				int num2 = item.IndexOf(':');
				if (num2 == -1)
				{
					throw new ArgumentException("no colon found", "header");
				}
				string name = item.Substring(0, num2);
				string value2 = item.Substring(num2 + 1).Trim();
				if (WebHeaderCollection.AllowMultiValues(name))
				{
					Headers.AddInternal(name, value2);
				}
				else
				{
					Headers.SetInternal(name, value2);
				}
			}
			if (StatusCode == HttpStatusCode.Continue)
			{
				base.ServicePoint.SendContinue = true;
				if (pos >= buffer.Offset)
				{
					return true;
				}
				if (base.Request.ExpectContinue)
				{
					base.Request.DoContinueDelegate((int)StatusCode, Headers);
					base.Request.ExpectContinue = false;
				}
				state = ReadState.None;
				flag = true;
				continue;
			}
			state = ReadState.Content;
			return true;
		}
		while (flag2 | flag);
		throw GetReadException(WebExceptionStatus.ServerProtocolViolation, null, "GetResponse");
	}
}
