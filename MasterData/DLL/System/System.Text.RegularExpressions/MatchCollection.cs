using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using Unity;

namespace System.Text.RegularExpressions;

[Serializable]
[DebuggerDisplay("Count = {Count}")]
[DebuggerTypeProxy(typeof(CollectionDebuggerProxy<Match>))]
public class MatchCollection : IList<Match>, ICollection<Match>, IEnumerable<Match>, IEnumerable, IReadOnlyList<Match>, IReadOnlyCollection<Match>, IList, ICollection
{
	[Serializable]
	private sealed class Enumerator : IEnumerator<Match>, IDisposable, IEnumerator
	{
		private readonly MatchCollection _collection;

		private int _index;

		public Match Current
		{
			get
			{
				if (_index < 0)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return _collection.GetMatch(_index);
			}
		}

		object IEnumerator.Current => Current;

		internal Enumerator(MatchCollection collection)
		{
			_collection = collection;
			_index = -1;
		}

		public bool MoveNext()
		{
			if (_index == -2)
			{
				return false;
			}
			_index++;
			if (_collection.GetMatch(_index) == null)
			{
				_index = -2;
				return false;
			}
			return true;
		}

		void IEnumerator.Reset()
		{
			_index = -1;
		}

		void IDisposable.Dispose()
		{
		}
	}

	private readonly Regex _regex;

	private readonly List<Match> _matches;

	private bool _done;

	private readonly string _input;

	private readonly int _beginning;

	private readonly int _length;

	private int _startat;

	private int _prevlen;

	public bool IsReadOnly => true;

	public int Count
	{
		get
		{
			EnsureInitialized();
			return _matches.Count;
		}
	}

	public virtual Match this[int i]
	{
		get
		{
			if (i < 0)
			{
				throw new ArgumentOutOfRangeException("i");
			}
			return GetMatch(i) ?? throw new ArgumentOutOfRangeException("i");
		}
	}

	public bool IsSynchronized => false;

	public object SyncRoot => this;

	Match IList<Match>.this[int index]
	{
		get
		{
			return this[index];
		}
		set
		{
			throw new NotSupportedException("Collection is read-only.");
		}
	}

	bool IList.IsFixedSize => true;

	object IList.this[int index]
	{
		get
		{
			return this[index];
		}
		set
		{
			throw new NotSupportedException("Collection is read-only.");
		}
	}

	internal MatchCollection(Regex regex, string input, int beginning, int length, int startat)
	{
		if (startat < 0 || startat > input.Length)
		{
			throw new ArgumentOutOfRangeException("startat", "Start index cannot be less than 0 or greater than input length.");
		}
		_regex = regex;
		_input = input;
		_beginning = beginning;
		_length = length;
		_startat = startat;
		_prevlen = -1;
		_matches = new List<Match>();
		_done = false;
	}

	public IEnumerator GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator<Match> IEnumerable<Match>.GetEnumerator()
	{
		return new Enumerator(this);
	}

	private Match GetMatch(int i)
	{
		if (_matches.Count > i)
		{
			return _matches[i];
		}
		if (_done)
		{
			return null;
		}
		Match match;
		do
		{
			match = _regex.Run(quick: false, _prevlen, _input, _beginning, _length, _startat);
			if (!match.Success)
			{
				_done = true;
				return null;
			}
			_matches.Add(match);
			_prevlen = match.Length;
			_startat = match._textpos;
		}
		while (_matches.Count <= i);
		return match;
	}

	private void EnsureInitialized()
	{
		if (!_done)
		{
			GetMatch(int.MaxValue);
		}
	}

	public void CopyTo(Array array, int arrayIndex)
	{
		EnsureInitialized();
		((ICollection)_matches).CopyTo(array, arrayIndex);
	}

	public void CopyTo(Match[] array, int arrayIndex)
	{
		EnsureInitialized();
		_matches.CopyTo(array, arrayIndex);
	}

	int IList<Match>.IndexOf(Match item)
	{
		EnsureInitialized();
		return _matches.IndexOf(item);
	}

	void IList<Match>.Insert(int index, Match item)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void IList<Match>.RemoveAt(int index)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void ICollection<Match>.Add(Match item)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void ICollection<Match>.Clear()
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	bool ICollection<Match>.Contains(Match item)
	{
		EnsureInitialized();
		return _matches.Contains(item);
	}

	bool ICollection<Match>.Remove(Match item)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	int IList.Add(object value)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void IList.Clear()
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	bool IList.Contains(object value)
	{
		if (value is Match)
		{
			return ((ICollection<Match>)this).Contains((Match)value);
		}
		return false;
	}

	int IList.IndexOf(object value)
	{
		if (!(value is Match))
		{
			return -1;
		}
		return ((IList<Match>)this).IndexOf((Match)value);
	}

	void IList.Insert(int index, object value)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void IList.Remove(object value)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void IList.RemoveAt(int index)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	internal MatchCollection()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
