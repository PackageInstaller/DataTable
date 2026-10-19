namespace System.Threading;

internal class SparselyPopulatedArrayFragment<T> where T : class
{
	internal readonly T[] _elements;

	internal volatile int _freeCount;

	internal volatile SparselyPopulatedArrayFragment<T> _next;

	internal volatile SparselyPopulatedArrayFragment<T> _prev;

	internal T this[int index] => Volatile.Read(ref _elements[index]);

	internal int Length => _elements.Length;

	internal SparselyPopulatedArrayFragment<T> Prev => _prev;

	internal SparselyPopulatedArrayFragment(int size)
		: this(size, (SparselyPopulatedArrayFragment<T>)null)
	{
	}

	internal SparselyPopulatedArrayFragment(int size, SparselyPopulatedArrayFragment<T> prev)
	{
		_elements = new T[size];
		_freeCount = size;
		_prev = prev;
	}

	internal T SafeAtomicRemove(int index, T expectedElement)
	{
		T val = Interlocked.CompareExchange(ref _elements[index], null, expectedElement);
		if (val != null)
		{
			_freeCount++;
		}
		return val;
	}
}
