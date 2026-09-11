namespace System.Collections.Generic;

internal sealed class LowLevelListWithIList<T> : LowLevelList<T>, IList<T>, ICollection<T>, IEnumerable<T>, IEnumerable
{
	private struct Enumerator : IEnumerator<T>, IDisposable, IEnumerator
	{
		private LowLevelListWithIList<T> _list;

		private int _index;

		private int _version;

		private T _current;

		public T Current => _current;

		object IEnumerator.Current
		{
			get
			{
				if (_index == 0 || _index == _list._size + 1)
				{
					throw new InvalidOperationException();
				}
				return Current;
			}
		}

		internal Enumerator(LowLevelListWithIList<T> list)
		{
			_list = list;
			_index = 0;
			_version = list._version;
			_current = default(T);
		}

		public void Dispose()
		{
		}

		public bool MoveNext()
		{
			LowLevelListWithIList<T> list = _list;
			if (_version == list._version && (uint)_index < (uint)list._size)
			{
				_current = list._items[_index];
				_index++;
				return true;
			}
			return MoveNextRare();
		}

		private bool MoveNextRare()
		{
			if (_version != _list._version)
			{
				throw new InvalidOperationException();
			}
			_index = _list._size + 1;
			_current = default(T);
			return false;
		}

		void IEnumerator.Reset()
		{
			if (_version != _list._version)
			{
				throw new InvalidOperationException();
			}
			_index = 0;
			_current = default(T);
		}
	}

	bool ICollection<T>.IsReadOnly => false;

	public LowLevelListWithIList()
	{
	}

	public LowLevelListWithIList(int capacity)
		: base(capacity)
	{
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return new Enumerator(this);
	}
}
