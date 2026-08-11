using System.Buffers;
using System.Runtime.CompilerServices;

namespace System.Collections.Generic;

internal ref struct ValueListBuilder<T>(Span<T> initialSpan)
{
	private Span<T> _span = initialSpan;

	private T[] _arrayFromPool = null;

	private int _pos = 0;

	public int Length => _pos;

	public ref T this[int index] => ref _span[index];

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Append(T item)
	{
		int pos = _pos;
		if (pos >= _span.Length)
		{
			Grow();
		}
		_span[pos] = item;
		_pos = pos + 1;
	}

	public ReadOnlySpan<T> AsSpan()
	{
		return _span.Slice(0, _pos);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Dispose()
	{
		if (_arrayFromPool != null)
		{
			ArrayPool<T>.Shared.Return(_arrayFromPool);
			_arrayFromPool = null;
		}
	}

	private void Grow()
	{
		T[] array = ArrayPool<T>.Shared.Rent(_span.Length * 2);
		_span.TryCopyTo(array);
		T[] arrayFromPool = _arrayFromPool;
		_span = (_arrayFromPool = array);
		if (arrayFromPool != null)
		{
			ArrayPool<T>.Shared.Return(arrayFromPool);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public T Pop()
	{
		_pos--;
		return _span[_pos];
	}
}
