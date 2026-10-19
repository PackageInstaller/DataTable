using System.Buffers;

namespace System.Text;

internal ref struct ValueUtf8Converter(Span<byte> initialBuffer)
{
	private byte[] _arrayToReturnToPool = null;

	private Span<byte> _bytes = initialBuffer;

	public Span<byte> ConvertAndTerminateString(ReadOnlySpan<char> value)
	{
		int num = Encoding.UTF8.GetMaxByteCount(value.Length) + 1;
		if (_bytes.Length < num)
		{
			Dispose();
			_arrayToReturnToPool = ArrayPool<byte>.Shared.Rent(num);
			_bytes = new Span<byte>(_arrayToReturnToPool);
		}
		int bytes = Encoding.UTF8.GetBytes(value, _bytes);
		_bytes[bytes] = 0;
		return _bytes.Slice(0, bytes + 1);
	}

	public void Dispose()
	{
		byte[] arrayToReturnToPool = _arrayToReturnToPool;
		if (arrayToReturnToPool != null)
		{
			_arrayToReturnToPool = null;
			ArrayPool<byte>.Shared.Return(arrayToReturnToPool);
		}
	}
}
