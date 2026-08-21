using System.Collections;

namespace System.Runtime.Serialization;

public sealed class SerializationInfoEnumerator : IEnumerator
{
	private readonly string[] _members;

	private readonly object[] _data;

	private readonly Type[] _types;

	private readonly int _numItems;

	private int _currItem;

	private bool _current;

	object IEnumerator.Current => Current;

	public SerializationEntry Current
	{
		get
		{
			if (!_current)
			{
				throw new InvalidOperationException("Enumeration has either not started or has already finished.");
			}
			return new SerializationEntry(_members[_currItem], _data[_currItem], _types[_currItem]);
		}
	}

	public string Name
	{
		get
		{
			if (!_current)
			{
				throw new InvalidOperationException("Enumeration has either not started or has already finished.");
			}
			return _members[_currItem];
		}
	}

	public object Value
	{
		get
		{
			if (!_current)
			{
				throw new InvalidOperationException("Enumeration has either not started or has already finished.");
			}
			return _data[_currItem];
		}
	}

	public Type ObjectType
	{
		get
		{
			if (!_current)
			{
				throw new InvalidOperationException("Enumeration has either not started or has already finished.");
			}
			return _types[_currItem];
		}
	}

	internal SerializationInfoEnumerator(string[] members, object[] info, Type[] types, int numItems)
	{
		_members = members;
		_data = info;
		_types = types;
		_numItems = numItems - 1;
		_currItem = -1;
		_current = false;
	}

	public bool MoveNext()
	{
		if (_currItem < _numItems)
		{
			_currItem++;
			_current = true;
		}
		else
		{
			_current = false;
		}
		return _current;
	}

	public void Reset()
	{
		_currItem = -1;
		_current = false;
	}
}
