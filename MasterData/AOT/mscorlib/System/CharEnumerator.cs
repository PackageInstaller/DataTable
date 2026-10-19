using System.Collections;
using System.Collections.Generic;
using Unity;

namespace System;

[Serializable]
public sealed class CharEnumerator : IEnumerator, IEnumerator<char>, IDisposable, ICloneable
{
	private string _str;

	private int _index;

	private char _currentElement;

	object IEnumerator.Current => Current;

	public char Current
	{
		get
		{
			if (_index == -1)
			{
				throw new InvalidOperationException("Enumeration has not started. Call MoveNext.");
			}
			if (_index >= _str.Length)
			{
				throw new InvalidOperationException("Enumeration already finished.");
			}
			return _currentElement;
		}
	}

	internal CharEnumerator(string str)
	{
		_str = str;
		_index = -1;
	}

	public object Clone()
	{
		return MemberwiseClone();
	}

	public bool MoveNext()
	{
		if (_index < _str.Length - 1)
		{
			_index++;
			_currentElement = _str[_index];
			return true;
		}
		_index = _str.Length;
		return false;
	}

	public void Dispose()
	{
		if (_str != null)
		{
			_index = _str.Length;
		}
		_str = null;
	}

	public void Reset()
	{
		_currentElement = '\0';
		_index = -1;
	}

	internal CharEnumerator()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
