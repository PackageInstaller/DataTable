using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal abstract class WebConnectionStream : Stream
{
	protected bool closed;

	private bool disposed;

	private object locker = new object();

	private int read_timeout;

	private int write_timeout;

	internal bool IgnoreIOErrors;

	internal HttpWebRequest Request { get; }

	internal WebConnection Connection { get; }

	internal WebOperation Operation { get; }

	internal ServicePoint ServicePoint => Connection.ServicePoint;

	public override bool CanTimeout => true;

	public override int ReadTimeout
	{
		get
		{
			return read_timeout;
		}
		set
		{
			if (value < -1)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			read_timeout = value;
		}
	}

	public override int WriteTimeout
	{
		get
		{
			return write_timeout;
		}
		set
		{
			if (value < -1)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			write_timeout = value;
		}
	}

	public override bool CanSeek => false;

	public override long Length
	{
		get
		{
			throw new NotSupportedException("This stream does not support seek operations.");
		}
	}

	public override long Position
	{
		get
		{
			throw new NotSupportedException("This stream does not support seek operations.");
		}
		set
		{
			throw new NotSupportedException("This stream does not support seek operations.");
		}
	}

	protected WebConnectionStream(WebConnection cnc, WebOperation operation)
	{
		Connection = cnc;
		Operation = operation;
		Request = operation.Request;
		read_timeout = Request.ReadWriteTimeout;
		write_timeout = read_timeout;
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

	protected abstract bool TryReadFromBufferedContent(byte[] buffer, int offset, int count, out int result);

	public override int Read(byte[] buffer, int offset, int count)
	{
		if (!CanRead)
		{
			throw new NotSupportedException("The stream does not support reading.");
		}
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
		if (TryReadFromBufferedContent(buffer, offset, count, out var result))
		{
			return result;
		}
		Operation.ThrowIfClosedOrDisposed();
		try
		{
			return ReadAsync(buffer, offset, count, CancellationToken.None).Result;
		}
		catch (Exception e)
		{
			throw GetException(e);
		}
	}

	public override IAsyncResult BeginRead(byte[] buffer, int offset, int count, AsyncCallback cb, object state)
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
		if (count < 0 || num - offset < count)
		{
			throw new ArgumentOutOfRangeException("count");
		}
		return TaskToApm.Begin(ReadAsync(buffer, offset, count, CancellationToken.None), cb, state);
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

	public override IAsyncResult BeginWrite(byte[] buffer, int offset, int count, AsyncCallback cb, object state)
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
		if (!CanWrite)
		{
			throw new NotSupportedException("The stream does not support writing.");
		}
		Operation.ThrowIfClosedOrDisposed();
		return TaskToApm.Begin(WriteAsync(buffer, offset, count, CancellationToken.None), cb, state);
	}

	public override void EndWrite(IAsyncResult r)
	{
		if (r == null)
		{
			throw new ArgumentNullException("r");
		}
		try
		{
			TaskToApm.End(r);
		}
		catch (Exception e)
		{
			throw GetException(e);
		}
	}

	public override void Write(byte[] buffer, int offset, int count)
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
		if (!CanWrite)
		{
			throw new NotSupportedException("The stream does not support writing.");
		}
		Operation.ThrowIfClosedOrDisposed();
		try
		{
			WriteAsync(buffer, offset, count).Wait();
		}
		catch (Exception e)
		{
			throw GetException(e);
		}
	}

	public override void Flush()
	{
	}

	public override Task FlushAsync(CancellationToken cancellationToken)
	{
		if (!cancellationToken.IsCancellationRequested)
		{
			return Task.CompletedTask;
		}
		return Task.FromCancellation(cancellationToken);
	}

	internal void InternalClose()
	{
		disposed = true;
	}

	protected abstract void Close_internal(ref bool disposed);

	public override void Close()
	{
		Close_internal(ref disposed);
	}

	public override long Seek(long a, SeekOrigin b)
	{
		throw new NotSupportedException("This stream does not support seek operations.");
	}

	public override void SetLength(long a)
	{
		throw new NotSupportedException("This stream does not support seek operations.");
	}
}
