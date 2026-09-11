using System.Buffers;
using System.Runtime.CompilerServices;

namespace System.Text;

internal ref struct ValueStringBuilder(Span<char> initialBuffer)
{
	private char[] _arrayToReturnToPool = null;

	private Span<char> _chars = initialBuffer;

	private int _pos = 0;

	public int Length => _pos;

	public ref char this[int index] => ref _chars[index];

	public override string ToString()
	{
		string result = new string(_chars.Slice(0, _pos));
		Dispose();
		return result;
	}

	public bool TryCopyTo(Span<char> destination, out int charsWritten)
	{
		if (_chars.Slice(0, _pos).TryCopyTo(destination))
		{
			charsWritten = _pos;
			Dispose();
			return true;
		}
		charsWritten = 0;
		Dispose();
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(char c)
	{
		int pos = _pos;
		if (pos < _chars.Length)
		{
			_chars[pos] = c;
			_pos = pos + 1;
		}
		else
		{
			GrowAndAppend(c);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Append(string s)
	{
		int pos = _pos;
		if (s.Length == 1 && pos < _chars.Length)
		{
			_chars[pos] = s[0];
			_pos = pos + 1;
		}
		else
		{
			AppendSlow(s);
		}
	}

	private void AppendSlow(string s)
	{
		int pos = _pos;
		if (pos > _chars.Length - s.Length)
		{
			Grow(s.Length);
		}
		s.AsSpan().CopyTo(_chars.Slice(pos));
		_pos += s.Length;
	}

	public void Append(char c, int count)
	{
		if (_pos > _chars.Length - count)
		{
			Grow(count);
		}
		Span<char> span = _chars.Slice(_pos, count);
		for (int i = 0; i < span.Length; i++)
		{
			span[i] = c;
		}
		_pos += count;
	}

	public unsafe void Append(char* value, int length)
	{
		if (_pos > _chars.Length - length)
		{
			Grow(length);
		}
		Span<char> span = _chars.Slice(_pos, length);
		for (int i = 0; i < span.Length; i++)
		{
			span[i] = *(value++);
		}
		_pos += length;
	}

	[MethodImpl((MethodImplOptions)256)]
	public Span<char> AppendSpan(int length)
	{
		int pos = _pos;
		if (pos > _chars.Length - length)
		{
			Grow(length);
		}
		_pos = pos + length;
		return _chars.Slice(pos, length);
	}

	[MethodImpl((MethodImplOptions)8)]
	private void GrowAndAppend(char c)
	{
		Grow(1);
		Append(c);
	}

	[MethodImpl((MethodImplOptions)8)]
	private void Grow(int requiredAdditionalCapacity)
	{
		char[] array = ArrayPool<char>.Shared.Rent(Math.Max(_pos + requiredAdditionalCapacity, _chars.Length * 2));
		_chars.CopyTo(array);
		char[] arrayToReturnToPool = _arrayToReturnToPool;
		_chars = (_arrayToReturnToPool = array);
		if (arrayToReturnToPool != null)
		{
			ArrayPool<char>.Shared.Return(arrayToReturnToPool);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Dispose()
	{
		char[] arrayToReturnToPool = _arrayToReturnToPool;
		this = default(ValueStringBuilder);
		if (arrayToReturnToPool != null)
		{
			ArrayPool<char>.Shared.Return(arrayToReturnToPool);
		}
	}
}
