using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem.EnhancedTouch;

public struct TouchHistory : IReadOnlyList<Touch>, IEnumerable<Touch>, IEnumerable, IReadOnlyCollection<Touch>
{
	private class Enumerator : IEnumerator<Touch>, IEnumerator, IDisposable
	{
		private readonly TouchHistory m_Owner;

		private int m_Index;

		public Touch Current => m_Owner[m_Index];

		object IEnumerator.Current => Current;

		internal Enumerator(TouchHistory owner)
		{
			m_Owner = owner;
			m_Index = -1;
		}

		public bool MoveNext()
		{
			if (m_Index >= m_Owner.Count - 1)
			{
				return false;
			}
			m_Index++;
			return true;
		}

		public void Reset()
		{
			m_Index = -1;
		}

		public void Dispose()
		{
		}
	}

	private readonly InputStateHistory<TouchState> m_History;

	private readonly Finger m_Finger;

	private readonly int m_Count;

	private readonly int m_StartIndex;

	private readonly uint m_Version;

	public int Count => m_Count;

	public Touch this[int index]
	{
		get
		{
			CheckValid();
			if (index < 0 || index >= Count)
			{
				throw new ArgumentOutOfRangeException($"Index {index} is out of range for history with {Count} entries", "index");
			}
			return new Touch(m_Finger, m_History[m_StartIndex - index]);
		}
	}

	internal TouchHistory(Finger finger, InputStateHistory<TouchState> history, int startIndex = -1, int count = -1)
	{
		m_Finger = finger;
		m_History = history;
		m_Version = history.version;
		m_Count = ((count >= 0) ? count : m_History.Count);
		m_StartIndex = ((startIndex >= 0) ? startIndex : (m_History.Count - 1));
	}

	public IEnumerator<Touch> GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	internal void CheckValid()
	{
		if (m_Finger == null || m_History == null)
		{
			throw new InvalidOperationException("Touch history not initialized");
		}
		if (m_History.version != m_Version)
		{
			throw new InvalidOperationException("Touch history is no longer valid; the recorded history has been changed");
		}
	}
}
