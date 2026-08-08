namespace System.Threading;

internal class SparselyPopulatedArray<T> where T : class
{
	private readonly SparselyPopulatedArrayFragment<T> _head;

	private volatile SparselyPopulatedArrayFragment<T> _tail;

	internal SparselyPopulatedArrayFragment<T> Tail => _tail;

	internal SparselyPopulatedArray(int initialSize)
	{
		_head = (_tail = new SparselyPopulatedArrayFragment<T>(initialSize));
	}

	internal SparselyPopulatedArrayAddInfo<T> Add(T element)
	{
		while (true)
		{
			SparselyPopulatedArrayFragment<T> sparselyPopulatedArrayFragment = _tail;
			while (sparselyPopulatedArrayFragment._next != null)
			{
				sparselyPopulatedArrayFragment = (_tail = sparselyPopulatedArrayFragment._next);
			}
			for (SparselyPopulatedArrayFragment<T> sparselyPopulatedArrayFragment2 = sparselyPopulatedArrayFragment; sparselyPopulatedArrayFragment2 != null; sparselyPopulatedArrayFragment2 = sparselyPopulatedArrayFragment2._prev)
			{
				if (sparselyPopulatedArrayFragment2._freeCount < 1)
				{
					sparselyPopulatedArrayFragment2._freeCount--;
				}
				if (sparselyPopulatedArrayFragment2._freeCount > 0 || sparselyPopulatedArrayFragment2._freeCount < -10)
				{
					int length = sparselyPopulatedArrayFragment2.Length;
					int num = (length - sparselyPopulatedArrayFragment2._freeCount) % length;
					if (num < 0)
					{
						num = 0;
						sparselyPopulatedArrayFragment2._freeCount--;
					}
					for (int i = 0; i < length; i++)
					{
						int num2 = (num + i) % length;
						if (sparselyPopulatedArrayFragment2._elements[num2] == null && Interlocked.CompareExchange(ref sparselyPopulatedArrayFragment2._elements[num2], element, null) == null)
						{
							int num3 = sparselyPopulatedArrayFragment2._freeCount - 1;
							sparselyPopulatedArrayFragment2._freeCount = ((num3 > 0) ? num3 : 0);
							return new SparselyPopulatedArrayAddInfo<T>(sparselyPopulatedArrayFragment2, num2);
						}
					}
				}
			}
			SparselyPopulatedArrayFragment<T> sparselyPopulatedArrayFragment3 = new SparselyPopulatedArrayFragment<T>((sparselyPopulatedArrayFragment._elements.Length == 4096) ? 4096 : (sparselyPopulatedArrayFragment._elements.Length * 2), sparselyPopulatedArrayFragment);
			if (Interlocked.CompareExchange(ref sparselyPopulatedArrayFragment._next, sparselyPopulatedArrayFragment3, null) == null)
			{
				_tail = sparselyPopulatedArrayFragment3;
			}
		}
	}
}
