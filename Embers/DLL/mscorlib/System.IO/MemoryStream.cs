using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;

namespace System.IO;

[Serializable]
public class MemoryStream : Stream
{
	private byte[] _buffer;

	private int _origin;

	private int _position;

	private int _length;

	private int _capacity;

	private bool _expandable;

	private bool _writable;

	private bool _exposable;

	private bool _isOpen;

	[NonSerialized]
	private Task<int> _lastReadTask;

	private const int MemStreamMaxLength = int.MaxValue;

	public override bool CanRead => _isOpen;

	public override bool CanSeek => _isOpen;

	public override bool CanWrite => _writable;

	public virtual int Capacity
	{
		get
		{
			EnsureNotClosed();
			return _capacity - _origin;
		}
		set
		{
			if (value < Length)
			{
				throw new ArgumentOutOfRangeException("value", "capacity was less than the current size.");
			}
			EnsureNotClosed();
			if (!_expandable && value != Capacity)
			{
				throw new NotSupportedException("Memory stream is not expandable.");
			}
			if (!_expandable || value == _capacity)
			{
				return;
			}
			if (value > 0)
			{
				byte[] array = new byte[value];
				if (_length > 0)
				{
					Buffer.BlockCopy(_buffer, 0, array, 0, _length);
				}
				_buffer = array;
			}
			else
			{
				_buffer = null;
			}
			_capacity = value;
		}
	}

	public override long Length
	{
		get
		{
			EnsureNotClosed();
			return _length - _origin;
		}
	}

	public override long Position
	{
		get
		{
			EnsureNotClosed();
			return _position - _origin;
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentOutOfRangeException("value", "Non-negative number required.");
			}
			EnsureNotClosed();
			if (value > int.MaxValue)
			{
				throw new ArgumentOutOfRangeException("value", "Stream length must be non-negative and less than 2^31 - 1 - origin.");
			}
			_position = _origin + (int)value;
		}
	}

	public MemoryStream()
		: this(0)
	{
	}

	public MemoryStream(int capacity)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity", "Capacity must be positive.");
		}
		_buffer = ((capacity != 0) ? new byte[capacity] : Array.Empty<byte>());
		_capacity = capacity;
		_expandable = true;
		_writable = true;
		_exposable = true;
		_origin = 0;
		_isOpen = true;
	}

	public MemoryStream(byte[] buffer)
		: this(buffer, writable: true)
	{
	}

	public MemoryStream(byte[] buffer, bool writable)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", "Buffer cannot be null.");
		}
		_buffer = buffer;
		_length = (_capacity = buffer.Length);
		_writable = writable;
		_exposable = false;
		_origin = 0;
		_isOpen = true;
	}

	public MemoryStream(byte[] buffer, int index, int count)
		: this(buffer, index, count, writable: true, publiclyVisible: false)
	{
	}

	public MemoryStream(byte[] buffer, int index, int count, bool writable)
		: this(buffer, index, count, writable, publiclyVisible: false)
	{
	}

	public MemoryStream(byte[] buffer, int index, int count, bool writable, bool publiclyVisible)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", "Buffer cannot be null.");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (buffer.Length - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		_buffer = buffer;
		_origin = (_position = index);
		_length = (_capacity = index + count);
		_writable = writable;
		_exposable = publiclyVisible;
		_expandable = false;
		_isOpen = true;
	}

	private void EnsureNotClosed()
	{
		if (!_isOpen)
		{
			throw Error.GetStreamIsClosed();
		}
	}

	private void EnsureWriteable()
	{
		if (!CanWrite)
		{
			throw Error.GetWriteNotSupported();
		}
	}

	protected override void Dispose(bool disposing)
	{
		try
		{
			if (disposing)
			{
				_isOpen = false;
				_writable = false;
				_expandable = false;
				_lastReadTask = null;
			}
		}
		finally
		{
			base.Dispose(disposing);
		}
	}

	private bool EnsureCapacity(int value)
	{
		if (value < 0)
		{
			throw new IOException("Stream was too long.");
		}
		if (value > _capacity)
		{
			int num = value;
			if (num < 256)
			{
				num = 256;
			}
			if (num < _capacity * 2)
			{
				num = _capacity * 2;
			}
			if ((uint)(_capacity * 2) > 2147483591u)
			{
				num = ((value > 2147483591) ? value : 2147483591);
			}
			Capacity = num;
			return true;
		}
		return false;
	}

	public override void Flush()
	{
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

	public virtual byte[] GetBuffer()
	{
		if (!_exposable)
		{
			throw new UnauthorizedAccessException("MemoryStream's internal buffer cannot be accessed.");
		}
		return _buffer;
	}

	public virtual bool TryGetBuffer(out ArraySegment<byte> buffer)
	{
		if (!_exposable)
		{
			buffer = default(ArraySegment<byte>);
			return false;
		}
		buffer = new ArraySegment<byte>(_buffer, _origin, _length - _origin);
		return true;
	}

	internal byte[] InternalGetBuffer()
	{
		return _buffer;
	}

	internal void InternalGetOriginAndLength(out int origin, out int length)
	{
		if (!_isOpen)
		{
			__Error.StreamIsClosed();
		}
		origin = _origin;
		length = _length;
	}

	internal int InternalGetPosition()
	{
		return _position;
	}

	internal int InternalReadInt32()
	{
		EnsureNotClosed();
		int num = (_position += 4);
		if (num > _length)
		{
			_position = _length;
			throw Error.GetEndOfFile();
		}
		return _buffer[num - 4] | (_buffer[num - 3] << 8) | (_buffer[num - 2] << 16) | (_buffer[num - 1] << 24);
	}

	internal int InternalEmulateRead(int count)
	{
		EnsureNotClosed();
		int num = _length - _position;
		if (num > count)
		{
			num = count;
		}
		if (num < 0)
		{
			num = 0;
		}
		_position += num;
		return num;
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
		EnsureNotClosed();
		int num = _length - _position;
		if (num > count)
		{
			num = count;
		}
		if (num <= 0)
		{
			return 0;
		}
		if (num <= 8)
		{
			int num2 = num;
			while (--num2 >= 0)
			{
				buffer[offset + num2] = _buffer[_position + num2];
			}
		}
		else
		{
			Buffer.BlockCopy(_buffer, _position, buffer, offset, num);
		}
		_position += num;
		return num;
	}

	public override int Read(Span<byte> buffer)
	{
		if (GetType() != typeof(MemoryStream))
		{
			return base.Read(buffer);
		}
		EnsureNotClosed();
		int num = Math.Min(_length - _position, buffer.Length);
		if (num <= 0)
		{
			return 0;
		}
		new Span<byte>(_buffer, _position, num).CopyTo(buffer);
		_position += num;
		return num;
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
		catch (OperationCanceledException exception)
		{
			return Task.FromCancellation<int>(exception);
		}
		catch (Exception exception2)
		{
			return Task.FromException<int>(exception2);
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
		catch (OperationCanceledException exception)
		{
			return new ValueTask<int>(Task.FromCancellation<int>(exception));
		}
		catch (Exception exception2)
		{
			return new ValueTask<int>(Task.FromException<int>(exception2));
		}
	}

	public override int ReadByte()
	{
		EnsureNotClosed();
		if (_position >= _length)
		{
			return -1;
		}
		return _buffer[_position++];
	}

	public override void CopyTo(Stream destination, int bufferSize)
	{
		StreamHelpers.ValidateCopyToArgs(this, destination, bufferSize);
		if (GetType() != typeof(MemoryStream))
		{
			base.CopyTo(destination, bufferSize);
			return;
		}
		int position = _position;
		int num = InternalEmulateRead(_length - position);
		if (num > 0)
		{
			destination.Write(_buffer, position, num);
		}
	}

	public override Task CopyToAsync(Stream destination, int bufferSize, CancellationToken cancellationToken)
	{
		StreamHelpers.ValidateCopyToArgs(this, destination, bufferSize);
		if (GetType() != typeof(MemoryStream))
		{
			return base.CopyToAsync(destination, bufferSize, cancellationToken);
		}
		if (cancellationToken.IsCancellationRequested)
		{
			return Task.FromCanceled(cancellationToken);
		}
		int position = _position;
		int num = InternalEmulateRead(_length - _position);
		if (num == 0)
		{
			return Task.CompletedTask;
		}
		if (!(destination is MemoryStream memoryStream))
		{
			return destination.WriteAsync(_buffer, position, num, cancellationToken);
		}
		try
		{
			memoryStream.Write(_buffer, position, num);
			return Task.CompletedTask;
		}
		catch (Exception exception)
		{
			return Task.FromException(exception);
		}
	}

	public override long Seek(long offset, SeekOrigin loc)
	{
		EnsureNotClosed();
		if (offset > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("offset", "Stream length must be non-negative and less than 2^31 - 1 - origin.");
		}
		switch (loc)
		{
		case SeekOrigin.Begin:
		{
			int num3 = _origin + (int)offset;
			if (offset < 0 || num3 < _origin)
			{
				throw new IOException("An attempt was made to move the position before the beginning of the stream.");
			}
			_position = num3;
			break;
		}
		case SeekOrigin.Current:
		{
			int num2 = _position + (int)offset;
			if (_position + offset < _origin || num2 < _origin)
			{
				throw new IOException("An attempt was made to move the position before the beginning of the stream.");
			}
			_position = num2;
			break;
		}
		case SeekOrigin.End:
		{
			int num = _length + (int)offset;
			if (_length + offset < _origin || num < _origin)
			{
				throw new IOException("An attempt was made to move the position before the beginning of the stream.");
			}
			_position = num;
			break;
		}
		default:
			throw new ArgumentException("Invalid seek origin.");
		}
		return _position;
	}

	public override void SetLength(long value)
	{
		if (value < 0 || value > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("value", "Stream length must be non-negative and less than 2^31 - 1 - origin.");
		}
		EnsureWriteable();
		if (value > int.MaxValue - _origin)
		{
			throw new ArgumentOutOfRangeException("value", "Stream length must be non-negative and less than 2^31 - 1 - origin.");
		}
		int num = _origin + (int)value;
		if (!EnsureCapacity(num) && num > _length)
		{
			Array.Clear(_buffer, _length, num - _length);
		}
		_length = num;
		if (_position > num)
		{
			_position = num;
		}
	}

	public virtual byte[] ToArray()
	{
		int num = _length - _origin;
		if (num == 0)
		{
			return Array.Empty<byte>();
		}
		byte[] array = new byte[num];
		Buffer.BlockCopy(_buffer, _origin, array, 0, num);
		return array;
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
		EnsureNotClosed();
		EnsureWriteable();
		int num = _position + count;
		if (num < 0)
		{
			throw new IOException("Stream was too long.");
		}
		if (num > _length)
		{
			bool flag = _position > _length;
			if (num > _capacity && EnsureCapacity(num))
			{
				flag = false;
			}
			if (flag)
			{
				Array.Clear(_buffer, _length, num - _length);
			}
			_length = num;
		}
		if (count <= 8 && buffer != _buffer)
		{
			int num2 = count;
			while (--num2 >= 0)
			{
				_buffer[_position + num2] = buffer[offset + num2];
			}
		}
		else
		{
			Buffer.BlockCopy(buffer, offset, _buffer, _position, count);
		}
		_position = num;
	}

	public override void Write(ReadOnlySpan<byte> buffer)
	{
		if (GetType() != typeof(MemoryStream))
		{
			base.Write(buffer);
			return;
		}
		EnsureNotClosed();
		EnsureWriteable();
		int num = _position + buffer.Length;
		if (num < 0)
		{
			throw new IOException("Stream was too long.");
		}
		if (num > _length)
		{
			bool flag = _position > _length;
			if (num > _capacity && EnsureCapacity(num))
			{
				flag = false;
			}
			if (flag)
			{
				Array.Clear(_buffer, _length, num - _length);
			}
			_length = num;
		}
		buffer.CopyTo(new Span<byte>(_buffer, _position, buffer.Length));
		_position = num;
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
		catch (OperationCanceledException exception)
		{
			return Task.FromCancellation<VoidTaskResult>(exception);
		}
		catch (Exception exception2)
		{
			return Task.FromException(exception2);
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
		catch (OperationCanceledException exception)
		{
			return new ValueTask(Task.FromCancellation<VoidTaskResult>(exception));
		}
		catch (Exception exception2)
		{
			return new ValueTask(Task.FromException(exception2));
		}
	}

	public override void WriteByte(byte value)
	{
		EnsureNotClosed();
		EnsureWriteable();
		if (_position >= _length)
		{
			int num = _position + 1;
			bool flag = _position > _length;
			if (num >= _capacity && EnsureCapacity(num))
			{
				flag = false;
			}
			if (flag)
			{
				Array.Clear(_buffer, _length, _position - _length);
			}
			_length = num;
		}
		_buffer[_position++] = value;
	}

	public virtual void WriteTo(Stream stream)
	{
		if (stream == null)
		{
			throw new ArgumentNullException("stream", "Stream cannot be null.");
		}
		EnsureNotClosed();
		stream.Write(_buffer, _origin, _length - _origin);
	}
}
