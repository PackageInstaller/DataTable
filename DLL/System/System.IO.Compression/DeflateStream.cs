using System.Runtime.Remoting.Messaging;
using System.Threading;
using System.Threading.Tasks;

namespace System.IO.Compression;

public class DeflateStream : Stream
{
	private delegate int ReadMethod(byte[] array, int offset, int count);

	private delegate void WriteMethod(byte[] array, int offset, int count);

	private Stream base_stream;

	private CompressionMode mode;

	private bool leaveOpen;

	private bool disposed;

	private DeflateStreamNative native;

	public override bool CanRead
	{
		get
		{
			if (!disposed && mode == CompressionMode.Decompress)
			{
				return base_stream.CanRead;
			}
			return false;
		}
	}

	public override bool CanSeek => false;

	public override bool CanWrite
	{
		get
		{
			if (!disposed && mode == CompressionMode.Compress)
			{
				return base_stream.CanWrite;
			}
			return false;
		}
	}

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

	public DeflateStream(Stream stream, CompressionMode mode)
		: this(stream, mode, leaveOpen: false, gzip: false)
	{
	}

	internal DeflateStream(Stream stream, CompressionMode mode, bool leaveOpen, int windowsBits)
		: this(stream, mode, leaveOpen, gzip: true)
	{
	}

	internal DeflateStream(Stream compressedStream, CompressionMode mode, bool leaveOpen, bool gzip)
	{
		if (compressedStream == null)
		{
			throw new ArgumentNullException("compressedStream");
		}
		if (mode != CompressionMode.Compress && mode != CompressionMode.Decompress)
		{
			throw new ArgumentException("mode");
		}
		base_stream = compressedStream;
		native = DeflateStreamNative.Create(compressedStream, mode, gzip);
		if (native == null)
		{
			throw new NotImplementedException("Failed to initialize zlib. You probably have an old zlib installed. Version 1.2.0.4 or later is required.");
		}
		this.mode = mode;
		this.leaveOpen = leaveOpen;
	}

	~DeflateStream()
	{
		Dispose(disposing: false);
	}

	protected override void Dispose(bool disposing)
	{
		if (disposing)
		{
			GC.SuppressFinalize(this);
		}
		native?.Dispose(disposing);
		if (disposing && !disposed)
		{
			disposed = true;
			if (!leaveOpen)
			{
				base_stream?.Close();
				base_stream = null;
			}
		}
		base.Dispose(disposing);
	}

	private unsafe int ReadInternal(byte[] array, int offset, int count)
	{
		if (count == 0)
		{
			return 0;
		}
		fixed (byte* ptr = array)
		{
			IntPtr buffer = new IntPtr(ptr + offset);
			return native.ReadZStream(buffer, count);
		}
	}

	internal ValueTask<int> ReadAsyncMemory(Memory<byte> destination, CancellationToken cancellationToken)
	{
		return base.ReadAsync(destination, cancellationToken);
	}

	internal int ReadCore(Span<byte> destination)
	{
		byte[] array = new byte[destination.Length];
		int num = Read(array, 0, array.Length);
		MemoryExtensions.AsSpan(array, 0, num).CopyTo(destination);
		return num;
	}

	public override int Read(byte[] array, int offset, int count)
	{
		if (disposed)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (array == null)
		{
			throw new ArgumentNullException("Destination array is null.");
		}
		if (!CanRead)
		{
			throw new InvalidOperationException("Stream does not support reading.");
		}
		int num = array.Length;
		if (offset < 0 || count < 0)
		{
			throw new ArgumentException("Dest or count is negative.");
		}
		if (offset > num)
		{
			throw new ArgumentException("destination offset is beyond array size");
		}
		if (offset + count > num)
		{
			throw new ArgumentException("Reading would overrun buffer");
		}
		return ReadInternal(array, offset, count);
	}

	private unsafe void WriteInternal(byte[] array, int offset, int count)
	{
		if (count != 0)
		{
			fixed (byte* ptr = array)
			{
				IntPtr buffer = new IntPtr(ptr + offset);
				native.WriteZStream(buffer, count);
			}
		}
	}

	internal ValueTask WriteAsyncMemory(ReadOnlyMemory<byte> source, CancellationToken cancellationToken)
	{
		return base.WriteAsync(source, cancellationToken);
	}

	internal void WriteCore(ReadOnlySpan<byte> source)
	{
		Write(source.ToArray(), 0, source.Length);
	}

	public override void Write(byte[] array, int offset, int count)
	{
		if (disposed)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count");
		}
		if (!CanWrite)
		{
			throw new NotSupportedException("Stream does not support writing");
		}
		if (offset > array.Length - count)
		{
			throw new ArgumentException("Buffer too small. count/offset wrong.");
		}
		WriteInternal(array, offset, count);
	}

	public override void Flush()
	{
		if (disposed)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (CanWrite)
		{
			native.Flush();
		}
	}

	public override IAsyncResult BeginRead(byte[] array, int offset, int count, AsyncCallback asyncCallback, object asyncState)
	{
		if (disposed)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (!CanRead)
		{
			throw new NotSupportedException("This stream does not support reading");
		}
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Must be >= 0");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "Must be >= 0");
		}
		if (count + offset > array.Length)
		{
			throw new ArgumentException("Buffer too small. count/offset wrong.");
		}
		return new ReadMethod(ReadInternal).BeginInvoke(array, offset, count, asyncCallback, asyncState);
	}

	public override IAsyncResult BeginWrite(byte[] array, int offset, int count, AsyncCallback asyncCallback, object asyncState)
	{
		if (disposed)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
		if (!CanWrite)
		{
			throw new InvalidOperationException("This stream does not support writing");
		}
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Must be >= 0");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "Must be >= 0");
		}
		if (count + offset > array.Length)
		{
			throw new ArgumentException("Buffer too small. count/offset wrong.");
		}
		return new WriteMethod(WriteInternal).BeginInvoke(array, offset, count, asyncCallback, asyncState);
	}

	public override int EndRead(IAsyncResult asyncResult)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		return ((((asyncResult as AsyncResult) ?? throw new ArgumentException("Invalid IAsyncResult", "asyncResult")).AsyncDelegate as ReadMethod) ?? throw new ArgumentException("Invalid IAsyncResult", "asyncResult")).EndInvoke(asyncResult);
	}

	public override void EndWrite(IAsyncResult asyncResult)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		((((asyncResult as AsyncResult) ?? throw new ArgumentException("Invalid IAsyncResult", "asyncResult")).AsyncDelegate as WriteMethod) ?? throw new ArgumentException("Invalid IAsyncResult", "asyncResult")).EndInvoke(asyncResult);
	}

	public override long Seek(long offset, SeekOrigin origin)
	{
		throw new NotSupportedException();
	}

	public override void SetLength(long value)
	{
		throw new NotSupportedException();
	}
}
