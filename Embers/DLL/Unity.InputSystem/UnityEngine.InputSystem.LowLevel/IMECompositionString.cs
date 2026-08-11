using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 132)]
public struct IMECompositionString : IEnumerable<char>, IEnumerable
{
	internal struct Enumerator(IMECompositionString compositionString) : IEnumerator<char>, IEnumerator, IDisposable
	{
		private IMECompositionString m_CompositionString = compositionString;

		private char m_CurrentCharacter = '\0';

		private int m_CurrentIndex = -1;

		public char Current => m_CurrentCharacter;

		object IEnumerator.Current => Current;

		public unsafe bool MoveNext()
		{
			int count = m_CompositionString.Count;
			m_CurrentIndex++;
			if (m_CurrentIndex == count)
			{
				return false;
			}
			fixed (char* buffer = m_CompositionString.buffer)
			{
				m_CurrentCharacter = buffer[m_CurrentIndex];
			}
			return true;
		}

		public void Reset()
		{
			m_CurrentIndex = -1;
		}

		public void Dispose()
		{
		}
	}

	[FieldOffset(0)]
	private int size;

	[FieldOffset(4)]
	private unsafe fixed char buffer[64];

	public int Count => size;

	public unsafe char this[int index]
	{
		get
		{
			if (index >= Count || index < 0)
			{
				throw new ArgumentOutOfRangeException("index");
			}
			fixed (char* ptr = buffer)
			{
				return ptr[index];
			}
		}
	}

	public unsafe IMECompositionString(string characters)
	{
		if (string.IsNullOrEmpty(characters))
		{
			size = 0;
			return;
		}
		size = characters.Length;
		for (int i = 0; i < size; i++)
		{
			buffer[i] = characters[i];
		}
	}

	public unsafe override string ToString()
	{
		fixed (char* value = buffer)
		{
			return new string(value, 0, size);
		}
	}

	public IEnumerator<char> GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
