using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal abstract class WebReadStream : Stream
{
	private bool disposed;

	public WebOperation Operation { get; }

	protected Stream InnerStream { get; }

	public override long Length
	{
		get
		{
			throw new NotSupportedException();
		}
	}

	public override long Position
	{
		get
		{
			throw new NotSupportedException();
		}
		set
		{
			throw new NotSupportedException();
		}
	}

	public override bool CanSeek => false;

	public override bool CanRead => true;

	public override bool CanWrite => false;

	public WebReadStream(WebOperation operation, Stream innerStream)
	{
		Operation = operation;
		InnerStream = innerStream;
	}

	public override void SetLength(long value)
	{
		throw new NotSupportedException();
	}

	public override long Seek(long offset, SeekOrigin origin)
	{
		throw new NotSupportedException();
	}

	public override void Write(byte[] buffer, int offset, int count)
	{
		throw new NotSupportedException();
	}

	public override void Flush()
	{
		throw new NotSupportedException();
	}

	protected Exception GetException(Exception e)
	{
		e = HttpWebRequest.FlattenException(e);
		if (e is WebException)
		{
			return e;
		}
		if (Operation.Aborted || e is OperationCanceledException || e is ObjectDisposedException)
		{
			return HttpWebRequest.CreateRequestAbortedException();
		}
		return e;
	}

	public override int Read(byte[] buffer, int offset, int size)
	{
		if (!CanRead)
		{
			throw new NotSupportedException("The stream does not support reading.");
		}
		Operation.ThrowIfClosedOrDisposed();
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		int num = buffer.Length;
		if (offset < 0 || num < offset)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if (size < 0 || num - offset < size)
		{
			throw new ArgumentOutOfRangeException("size");
		}
		try
		{
			return ReadAsync(buffer, offset, size, CancellationToken.None).Result;
		}
		catch (Exception e)
		{
			throw GetException(e);
		}
	}

	public override IAsyncResult BeginRead(byte[] buffer, int offset, int size, AsyncCallback cb, object state)
	{
		if (!CanRead)
		{
			throw new NotSupportedException("The stream does not support reading.");
		}
		Operation.ThrowIfClosedOrDisposed();
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		int num = buffer.Length;
		if (offset < 0 || num < offset)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if (size < 0 || num - offset < size)
		{
			throw new ArgumentOutOfRangeException("size");
		}
		return TaskToApm.Begin(ReadAsync(buffer, offset, size, CancellationToken.None), cb, state);
	}

	public override int EndRead(IAsyncResult r)
	{
		if (r == null)
		{
			throw new ArgumentNullException("r");
		}
		try
		{
			return TaskToApm.End<int>(r);
		}
		catch (Exception e)
		{
			throw GetException(e);
		}
	}

	public sealed override async Task<int> ReadAsync(byte[] buffer, int offset, int size, CancellationToken cancellationToken)
	{
		Operation.ThrowIfDisposed(cancellationToken);
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		int num = buffer.Length;
		if (offset < 0 || num < offset)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if (size < 0 || num - offset < size)
		{
			throw new ArgumentOutOfRangeException("size");
		}
		try
		{
			int num2 = await ProcessReadAsync(buffer, offset, size, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			if (num2 != 0)
			{
				return num2;
			}
			await FinishReading(cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			return 0;
		}
		catch (OperationCanceledException)
		{
			throw;
		}
		catch (Exception)
		{
			throw;
		}
		finally
		{
			_ = 0;
		}
	}

	protected abstract Task<int> ProcessReadAsync(byte[] buffer, int offset, int size, CancellationToken cancellationToken);

	internal virtual Task FinishReading(CancellationToken cancellationToken)
	{
		Operation.ThrowIfDisposed(cancellationToken);
		if (InnerStream is WebReadStream webReadStream)
		{
			return webReadStream.FinishReading(cancellationToken);
		}
		return Task.CompletedTask;
	}

	protected override void Dispose(bool disposing)
	{
		if (disposing && !disposed)
		{
			disposed = true;
			if (InnerStream != null)
			{
				InnerStream.Dispose();
			}
		}
		base.Dispose(disposing);
	}
}
