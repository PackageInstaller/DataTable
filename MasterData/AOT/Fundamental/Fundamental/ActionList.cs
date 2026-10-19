using System;
using System.Collections.Generic;

namespace Fundamental;

public class ActionList
{
	private List<Action> m_Actions = new List<Action>();

	private int m_Count;

	public void Clear()
	{
		m_Actions.Clear();
		m_Count = 0;
	}

	public void Invoke()
	{
		for (int num = m_Actions.Count - 1; num >= 0; num--)
		{
			if (m_Actions[num] == null)
			{
				m_Actions.RemoveAt(num);
			}
		}
		int count = m_Actions.Count;
		for (int i = 0; i < count; i++)
		{
			if (m_Actions[i] != null)
			{
				m_Actions[i]();
			}
		}
	}

	public override bool Equals(object obj)
	{
		if (obj is ActionList)
		{
			return this == (ActionList)obj;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return m_Actions.GetHashCode();
	}

	public static ActionList operator +(ActionList list, Action action)
	{
		if ((object)list == null)
		{
			list = new ActionList();
		}
		list.Add(action);
		return list;
	}

	public void Add(Action action)
	{
		m_Actions.Add(action);
		m_Count++;
	}

	public void Remove(Action action)
	{
		for (int i = 0; i < m_Actions.Count; i++)
		{
			if (m_Actions[i] == action)
			{
				m_Actions[i] = null;
				m_Count--;
				break;
			}
		}
	}

	public static ActionList operator -(ActionList list, Action action)
	{
		list?.Remove(action);
		return list;
	}

	public static bool operator ==(ActionList a, ActionList b)
	{
		if (((object)a == null || a.m_Count == 0) && ((object)b == null || b.m_Count == 0))
		{
			return true;
		}
		return (object)a == b;
	}

	public static bool operator !=(ActionList a, ActionList b)
	{
		if (((object)a == null || a.m_Count == 0) && ((object)b == null || b.m_Count == 0))
		{
			return false;
		}
		return (object)a != b;
	}
}
public class ActionList<T>
{
	private HashSet<Action<T>> m_Actions = new HashSet<Action<T>>();

	public void Clear()
	{
		m_Actions.Clear();
	}

	public void Invoke(T arg)
	{
		List<Action<T>> list = ListPool<Action<T>>.Get();
		list.AddRange(m_Actions);
		foreach (Action<T> item in list)
		{
			if (item != null)
			{
				try
				{
					item(arg);
				}
				catch (Exception)
				{
				}
			}
		}
		ListPool<Action<T>>.Release(list);
	}

	public override bool Equals(object obj)
	{
		if (obj is ActionList<T>)
		{
			return this == (ActionList<T>)obj;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return m_Actions.GetHashCode();
	}

	public void Add(Action<T> action)
	{
		if (action != null)
		{
			m_Actions.Add(action);
		}
	}

	public void Remove(Action<T> action)
	{
		if (action != null)
		{
			m_Actions.Remove(action);
		}
	}

	public static ActionList<T> operator +(ActionList<T> list, Action<T> action)
	{
		if ((object)list == null)
		{
			list = new ActionList<T>();
		}
		list.Add(action);
		return list;
	}

	public static ActionList<T> operator -(ActionList<T> list, Action<T> action)
	{
		list?.Remove(action);
		return list;
	}

	public static bool operator ==(ActionList<T> a, ActionList<T> b)
	{
		if (((object)a == null || a.m_Actions.Count == 0) && ((object)b == null || b.m_Actions.Count == 0))
		{
			return true;
		}
		return (object)a == b;
	}

	public static bool operator !=(ActionList<T> a, ActionList<T> b)
	{
		if (((object)a == null || a.m_Actions.Count == 0) && ((object)b == null || b.m_Actions.Count == 0))
		{
			return false;
		}
		return (object)a != b;
	}

	public int GetLength()
	{
		return m_Actions.Count;
	}
}
public class ActionList<T1, T2>
{
	private List<Action<T1, T2>> m_Actions = new List<Action<T1, T2>>();

	private int m_Count;

	public void Invoke(T1 arg1, T2 arg2)
	{
		for (int num = m_Actions.Count - 1; num >= 0; num--)
		{
			if (m_Actions[num] == null)
			{
				m_Actions.RemoveAt(num);
			}
		}
		int count = m_Actions.Count;
		for (int i = 0; i < count; i++)
		{
			if (m_Actions[i] != null)
			{
				m_Actions[i](arg1, arg2);
			}
		}
	}

	public override bool Equals(object obj)
	{
		if (obj is ActionList<T1, T2>)
		{
			return this == (ActionList<T1, T2>)obj;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return m_Actions.GetHashCode();
	}

	public void Clear()
	{
		m_Actions.Clear();
		m_Count = 0;
	}

	public void Add(Action<T1, T2> action)
	{
		if (!m_Actions.Contains(action))
		{
			m_Actions.Add(action);
			m_Count++;
		}
	}

	public void Remove(Action<T1, T2> action)
	{
		for (int i = 0; i < m_Actions.Count; i++)
		{
			if (m_Actions[i] == action)
			{
				m_Actions[i] = null;
				m_Count--;
				break;
			}
		}
	}

	public static ActionList<T1, T2> operator +(ActionList<T1, T2> list, Action<T1, T2> action)
	{
		if ((object)list == null)
		{
			list = new ActionList<T1, T2>();
		}
		if (!list.m_Actions.Contains(action))
		{
			list.m_Actions.Add(action);
			list.m_Count++;
		}
		return list;
	}

	public static ActionList<T1, T2> operator -(ActionList<T1, T2> list, Action<T1, T2> action)
	{
		if ((object)list != null)
		{
			for (int i = 0; i < list.m_Actions.Count; i++)
			{
				if (list.m_Actions[i] == action)
				{
					list.m_Actions[i] = null;
					list.m_Count--;
					break;
				}
			}
		}
		return list;
	}

	public static bool operator ==(ActionList<T1, T2> a, ActionList<T1, T2> b)
	{
		if (((object)a == null || a.m_Count == 0) && ((object)b == null || b.m_Count == 0))
		{
			return true;
		}
		return (object)a == b;
	}

	public static bool operator !=(ActionList<T1, T2> a, ActionList<T1, T2> b)
	{
		if (((object)a == null || a.m_Count == 0) && ((object)b == null || b.m_Count == 0))
		{
			return false;
		}
		return (object)a != b;
	}
}
public class ActionList<T1, T2, T3>
{
	private List<Action<T1, T2, T3>> m_Actions = new List<Action<T1, T2, T3>>();

	private int m_Count;

	public void Invoke(T1 arg1, T2 arg2, T3 arg3)
	{
		for (int num = m_Actions.Count - 1; num >= 0; num--)
		{
			if (m_Actions[num] == null)
			{
				m_Actions.RemoveAt(num);
			}
		}
		int count = m_Actions.Count;
		for (int i = 0; i < count; i++)
		{
			if (m_Actions[i] != null)
			{
				m_Actions[i](arg1, arg2, arg3);
			}
		}
	}

	public override bool Equals(object obj)
	{
		if (obj is ActionList<T1, T2, T3>)
		{
			return this == (ActionList<T1, T2, T3>)obj;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return m_Actions.GetHashCode();
	}

	public static ActionList<T1, T2, T3> operator +(ActionList<T1, T2, T3> list, Action<T1, T2, T3> action)
	{
		if ((object)list == null)
		{
			list = new ActionList<T1, T2, T3>();
		}
		if (!list.m_Actions.Contains(action))
		{
			list.m_Actions.Add(action);
			list.m_Count++;
		}
		return list;
	}

	public static ActionList<T1, T2, T3> operator -(ActionList<T1, T2, T3> list, Action<T1, T2, T3> action)
	{
		if ((object)list != null)
		{
			for (int i = 0; i < list.m_Actions.Count; i++)
			{
				if (list.m_Actions[i] == action)
				{
					list.m_Actions[i] = null;
					list.m_Count--;
					break;
				}
			}
		}
		return list;
	}

	public static bool operator ==(ActionList<T1, T2, T3> a, ActionList<T1, T2, T3> b)
	{
		if (((object)a == null || a.m_Count == 0) && ((object)b == null || b.m_Count == 0))
		{
			return true;
		}
		return (object)a == b;
	}

	public static bool operator !=(ActionList<T1, T2, T3> a, ActionList<T1, T2, T3> b)
	{
		if (((object)a == null || a.m_Count == 0) && ((object)b == null || b.m_Count == 0))
		{
			return false;
		}
		return (object)a != b;
	}

	public void Clear()
	{
		m_Actions.Clear();
		m_Count = 0;
	}
}
public class ActionList<T1, T2, T3, T4>
{
	private List<Action<T1, T2, T3, T4>> m_Actions = new List<Action<T1, T2, T3, T4>>();

	private int m_Count;

	public void Invoke(T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		for (int num = m_Actions.Count - 1; num >= 0; num--)
		{
			if (m_Actions[num] == null)
			{
				m_Actions.RemoveAt(num);
			}
		}
		int count = m_Actions.Count;
		for (int i = 0; i < count; i++)
		{
			if (m_Actions[i] != null)
			{
				m_Actions[i](arg1, arg2, arg3, arg4);
			}
		}
	}

	public override bool Equals(object obj)
	{
		if (obj is ActionList<T1, T2, T3, T4>)
		{
			return this == (ActionList<T1, T2, T3, T4>)obj;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return m_Actions.GetHashCode();
	}

	public static ActionList<T1, T2, T3, T4> operator +(ActionList<T1, T2, T3, T4> list, Action<T1, T2, T3, T4> action)
	{
		if ((object)list == null)
		{
			list = new ActionList<T1, T2, T3, T4>();
		}
		if (!list.m_Actions.Contains(action))
		{
			list.m_Actions.Add(action);
			list.m_Count++;
		}
		return list;
	}

	public static ActionList<T1, T2, T3, T4> operator -(ActionList<T1, T2, T3, T4> list, Action<T1, T2, T3, T4> action)
	{
		if ((object)list != null)
		{
			for (int i = 0; i < list.m_Actions.Count; i++)
			{
				if (list.m_Actions[i] == action)
				{
					list.m_Actions[i] = null;
					list.m_Count--;
					break;
				}
			}
		}
		return list;
	}

	public static bool operator ==(ActionList<T1, T2, T3, T4> a, ActionList<T1, T2, T3, T4> b)
	{
		if (((object)a == null || a.m_Count == 0) && ((object)b == null || b.m_Count == 0))
		{
			return true;
		}
		return (object)a == b;
	}

	public static bool operator !=(ActionList<T1, T2, T3, T4> a, ActionList<T1, T2, T3, T4> b)
	{
		if (((object)a == null || a.m_Count == 0) && ((object)b == null || b.m_Count == 0))
		{
			return false;
		}
		return (object)a != b;
	}
}
