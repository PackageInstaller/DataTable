using System.Buffers;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace System.Collections.Generic;

[DefaultMember("Item")]
internal ref struct ValueListBuilder<T>(Span<T> initialSpan)
{
	private Span<T> _span = initialSpan;

	private T[] _arrayFromPool = null;

	private int _pos = 0;

	public int Length => _pos;

	[MethodImpl((MethodImplOptions)256)]
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

	[MethodImpl((MethodImplOptions)256)]
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
}
