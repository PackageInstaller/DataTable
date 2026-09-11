using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;

namespace System.IO;

public class UnmanagedMemoryStream : Stream
{
	private SafeBuffer _buffer;

	private unsafe byte* _mem;

	private long _length;

	private long _capacity;

	private long _position;

	private long _offset;

	private FileAccess _access;

	internal bool _isOpen;

	private Task<int> _lastReadTask;

	public override bool CanRead
	{
		get
		{
			if (_isOpen)
			{
				return (_access & FileAccess.Read) != 0;
			}
			return false;
		}
	}

	public override bool CanSeek => _isOpen;

	public override bool CanWrite
	{
		get
		{
			if (_isOpen)
			{
				return (_access & FileAccess.Write) != 0;
			}
			return false;
		}
	}

	public override long Length
	{
		get
		{
			EnsureNotClosed();
			return Interlocked.Read(ref _length);
		}
	}

	public override long Position
	{
		get
		{
			if (!CanSeek)
			{
				throw Error.GetStreamIsClosed();
			}
			return Interlocked.Read(ref _position);
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentOutOfRangeException("value", "Non-negative number required.");
			}
			if (!CanSeek)
			{
				throw Error.GetStreamIsClosed();
			}
			Interlocked.Exchange(ref _position, value);
		}
	}

	[CLSCompliant(false)]
	public unsafe byte* PositionPointer
	{
		get
		{
			if (_buffer != null)
			{
				throw new NotSupportedException("This operation is not supported for an UnmanagedMemoryStream created from a SafeBuffer.");
			}
			EnsureNotClosed();
			long num = Interlocked.Read(ref _position);
			if (num > _capacity)
			{
				throw new IndexOutOfRangeException("Unmanaged memory stream position was beyond the capacity of the stream.");
			}
			return _mem + num;
		}
	}

	protected unsafe UnmanagedMemoryStream()
	{
		_mem = null;
		_isOpen = false;
	}

	[CLSCompliant(false)]
	public unsafe UnmanagedMemoryStream(byte* pointer, long length)
	{
		Initialize(pointer, length, length, FileAccess.Read);
	}

	[CLSCompliant(false)]
	public unsafe UnmanagedMemoryStream(byte* pointer, long length, long capacity, FileAccess access)
	{
		Initialize(pointer, length, capacity, access);
	}

	[CLSCompliant(false)]
	protected unsafe void Initialize(byte* pointer, long length, long capacity, FileAccess access)
	{
		if (pointer == null)
		{
			throw new ArgumentNullException("pointer");
		}
		if (length < 0 || capacity < 0)
		{
			throw new ArgumentOutOfRangeException((length < 0) ? "length" : "capacity", "Non-negative number required.");
		}
		if (length > capacity)
		{
			throw new ArgumentOutOfRangeException("length", "The length cannot be greater than the capacity.");
		}
		if ((nuint)((long)pointer + capacity) < (nuint)pointer)
		{
			throw new ArgumentOutOfRangeException("capacity", "The UnmanagedMemoryStream capacity would wrap around the high end of the address space.");
		}
		if (access < FileAccess.Read || access > FileAccess.ReadWrite)
		{
			throw new ArgumentOutOfRangeException("access", "Enum value was out of legal range.");
		}
		if (_isOpen)
		{
			throw new InvalidOperationException("The method cannot be called twice on the same instance.");
		}
		_mem = pointer;
		_offset = 0L;
		_length = length;
		_capacity = capacity;
		_access = access;
		_isOpen = true;
	}

	protected unsafe override void Dispose(bool disposing)
	{
		_isOpen = false;
		_mem = null;
		base.Dispose(disposing);
	}

	private void EnsureNotClosed()
	{
		if (!_isOpen)
		{
			throw Error.GetStreamIsClosed();
		}
	}

	private void EnsureReadable()
	{
		if (!CanRead)
		{
			throw Error.GetReadNotSupported();
		}
	}

	private void EnsureWriteable()
	{
		if (!CanWrite)
		{
			throw Error.GetWriteNotSupported();
		}
	}

	public override void Flush()
	{
		EnsureNotClosed();
	}

	public override Task FlushAsync(CancellationToken cancellationToken)
	{
		if (cancellationToken.IsCancellationRequested)
		{
			return Task.FromCanceled(cancellationToken);
		}
		try
		{
			Flush();
			return Task.CompletedTask;
		}
		catch (Exception exception)
		{
			return Task.FromException(exception);
		}
	}

	public override int Read(byte[] buffer, int offset, int count)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", "Buffer cannot be null.");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (buffer.Length - offset < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		return ReadCore(new Span<byte>(buffer, offset, count));
	}

	public override int Read(Span<byte> buffer)
	{
		if (GetType() == typeof(UnmanagedMemoryStream))
		{
			return ReadCore(buffer);
		}
		return base.Read(buffer);
	}

	internal unsafe int ReadCore(Span<byte> buffer)
	{
		EnsureNotClosed();
		EnsureReadable();
		long num = Interlocked.Read(ref _position);
		long num2 = Math.Min(Interlocked.Read(ref _length) - num, buffer.Length);
		if (num2 <= 0)
		{
			return 0;
		}
		int num3 = (int)num2;
		if (num3 < 0)
		{
			return 0;
		}
		fixed (byte* reference = &MemoryMarshal.GetReference(buffer))
		{
			if (_buffer != null)
			{
				byte* pointer = null;
				RuntimeHelpers.PrepareConstrainedRegions();
				try
				{
					_buffer.AcquirePointer(ref pointer);
					Buffer.Memcpy(reference, pointer + num + _offset, num3);
				}
				finally
				{
					if (pointer != null)
					{
						_buffer.ReleasePointer();
					}
				}
			}
			else
			{
				Buffer.Memcpy(reference, _mem + num, num3);
			}
		}
		Interlocked.Exchange(ref _position, num + num2);
		return num3;
	}

	public override Task<int> ReadAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", "Buffer cannot be null.");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (buffer.Length - offset < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		if (cancellationToken.IsCancellationRequested)
		{
			return Task.FromCanceled<int>(cancellationToken);
		}
		try
		{
			int num = Read(buffer, offset, count);
			Task<int> lastReadTask = _lastReadTask;
			return (lastReadTask != null && lastReadTask.Result == num) ? lastReadTask : (_lastReadTask = Task.FromResult(num));
		}
		catch (Exception exception)
		{
			return Task.FromException<int>(exception);
		}
	}

	public override ValueTask<int> ReadAsync(Memory<byte> buffer, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (cancellationToken.IsCancellationRequested)
		{
			return new ValueTask<int>(Task.FromCanceled<int>(cancellationToken));
		}
		try
		{
			ArraySegment<byte> segment;
			return new ValueTask<int>(MemoryMarshal.TryGetArray((ReadOnlyMemory<byte>)buffer, out segment) ? Read(segment.Array, segment.Offset, segment.Count) : Read(buffer.Span));
		}
		catch (Exception exception)
		{
			return new ValueTask<int>(Task.FromException<int>(exception));
		}
	}

	public unsafe override int ReadByte()
	{
		EnsureNotClosed();
		EnsureReadable();
		long num = Interlocked.Read(ref _position);
		long num2 = Interlocked.Read(ref _length);
		if (num >= num2)
		{
			return -1;
		}
		Interlocked.Exchange(ref _position, num + 1);
		if (_buffer != null)
		{
			byte* pointer = null;
			RuntimeHelpers.PrepareConstrainedRegions();
			try
			{
				_buffer.AcquirePointer(ref pointer);
				return (pointer + num)[_offset];
			}
			finally
			{
				if (pointer != null)
				{
					_buffer.ReleasePointer();
				}
			}
		}
		return _mem[num];
	}

	public override long Seek(long offset, SeekOrigin loc)
	{
		EnsureNotClosed();
		switch (loc)
		{
		case SeekOrigin.Begin:
			if (offset < 0)
			{
				throw new IOException("An attempt was made to move the position before the beginning of the stream.");
			}
			Interlocked.Exchange(ref _position, offset);
			break;
		case SeekOrigin.Current:
		{
			long num2 = Interlocked.Read(ref _position);
			if (offset + num2 < 0)
			{
				throw new IOException("An attempt was made to move the position before the beginning of the stream.");
			}
			Interlocked.Exchange(ref _position, offset + num2);
			break;
		}
		case SeekOrigin.End:
		{
			long num = Interlocked.Read(ref _length);
			if (num + offset < 0)
			{
				throw new IOException("An attempt was made to move the position before the beginning of the stream.");
			}
			Interlocked.Exchange(ref _position, num + offset);
			break;
		}
		default:
			throw new ArgumentException("Invalid seek origin.");
		}
		return Interlocked.Read(ref _position);
	}

	public unsafe override void SetLength(long value)
	{
		if (value < 0)
		{
			throw new ArgumentOutOfRangeException("value", "Non-negative number required.");
		}
		if (_buffer != null)
		{
			throw new NotSupportedException("This operation is not supported for an UnmanagedMemoryStream created from a SafeBuffer.");
		}
		EnsureNotClosed();
		EnsureWriteable();
		if (value > _capacity)
		{
			throw new IOException("Unable to expand length of this stream beyond its capacity.");
		}
		long num = Interlocked.Read(ref _position);
		long num2 = Interlocked.Read(ref _length);
		if (value > num2)
		{
			Buffer.ZeroMemory(_mem + num2, value - num2);
		}
		Interlocked.Exchange(ref _length, value);
		if (num > value)
		{
			Interlocked.Exchange(ref _position, value);
		}
	}

	public override void Write(byte[] buffer, int offset, int count)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", "Buffer cannot be null.");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (buffer.Length - offset < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		WriteCore(new Span<byte>(buffer, offset, count));
	}

	public override void Write(ReadOnlySpan<byte> buffer)
	{
		if (GetType() == typeof(UnmanagedMemoryStream))
		{
			WriteCore(buffer);
		}
		else
		{
			base.Write(buffer);
		}
	}

	internal unsafe void WriteCore(ReadOnlySpan<byte> buffer)
	{
		EnsureNotClosed();
		EnsureWriteable();
		long num = Interlocked.Read(ref _position);
		long num2 = Interlocked.Read(ref _length);
		long num3 = num + buffer.Length;
		if (num3 < 0)
		{
			throw new IOException("Stream was too long.");
		}
		if (num3 > _capacity)
		{
			throw new NotSupportedException("Unable to expand length of this stream beyond its capacity.");
		}
		if (_buffer == null)
		{
			if (num > num2)
			{
				Buffer.ZeroMemory(_mem + num2, num - num2);
			}
			if (num3 > num2)
			{
				Interlocked.Exchange(ref _length, num3);
			}
		}
		fixed (byte* reference = &MemoryMarshal.GetReference(buffer))
		{
			if (_buffer != null)
			{
				if (_capacity - num < buffer.Length)
				{
					throw new ArgumentException("Not enough space available in the buffer.");
				}
				byte* pointer = null;
				RuntimeHelpers.PrepareConstrainedRegions();
				try
				{
					_buffer.AcquirePointer(ref pointer);
					Buffer.Memcpy(pointer + num + _offset, reference, buffer.Length);
				}
				finally
				{
					if (pointer != null)
					{
						_buffer.ReleasePointer();
					}
				}
			}
			else
			{
				Buffer.Memcpy(_mem + num, reference, buffer.Length);
			}
		}
		Interlocked.Exchange(ref _position, num3);
	}

	public override Task WriteAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", "Buffer cannot be null.");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (buffer.Length - offset < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		if (cancellationToken.IsCancellationRequested)
		{
			return Task.FromCanceled(cancellationToken);
		}
		try
		{
			Write(buffer, offset, count);
			return Task.CompletedTask;
		}
		catch (Exception exception)
		{
			return Task.FromException(exception);
		}
	}

	public override ValueTask WriteAsync(ReadOnlyMemory<byte> buffer, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (cancellationToken.IsCancellationRequested)
		{
			return new ValueTask(Task.FromCanceled(cancellationToken));
		}
		try
		{
			if (MemoryMarshal.TryGetArray(buffer, out var segment))
			{
				Write(segment.Array, segment.Offset, segment.Count);
			}
			else
			{
				Write(buffer.Span);
			}
			return default(ValueTask);
		}
		catch (Exception exception)
		{
			return new ValueTask(Task.FromException(exception));
		}
	}

	public unsafe override void WriteByte(byte value)
	{
		EnsureNotClosed();
		EnsureWriteable();
		long num = Interlocked.Read(ref _position);
		long num2 = Interlocked.Read(ref _length);
		long num3 = num + 1;
		if (num >= num2)
		{
			if (num3 < 0)
			{
				throw new IOException("Stream was too long.");
			}
			if (num3 > _capacity)
			{
				throw new NotSupportedException("Unable to expand length of this stream beyond its capacity.");
			}
			if (_buffer == null)
			{
				if (num > num2)
				{
					Buffer.ZeroMemory(_mem + num2, num - num2);
				}
				Interlocked.Exchange(ref _length, num3);
			}
		}
		if (_buffer != null)
		{
			byte* pointer = null;
			RuntimeHelpers.PrepareConstrainedRegions();
			try
			{
				_buffer.AcquirePointer(ref pointer);
				(pointer + num)[_offset] = value;
			}
			finally
			{
				if (pointer != null)
				{
					_buffer.ReleasePointer();
				}
			}
		}
		else
		{
			_mem[num] = value;
		}
		Interlocked.Exchange(ref _position, num3);
	}
}
