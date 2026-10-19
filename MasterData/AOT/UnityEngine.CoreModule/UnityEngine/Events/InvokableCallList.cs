using System.Collections.Generic;
using System.Reflection;

namespace UnityEngine.Events;

internal class InvokableCallList
{
	private readonly List<BaseInvokableCall> m_PersistentCalls = new List<BaseInvokableCall>();

	private readonly List<BaseInvokableCall> m_RuntimeCalls = new List<BaseInvokableCall>();

	private List<BaseInvokableCall> m_ExecutingCalls = new List<BaseInvokableCall>();

	private bool m_NeedsUpdate = true;

	public int Count => m_PersistentCalls.Count + m_RuntimeCalls.Count;

	public void AddPersistentInvokableCall(BaseInvokableCall call)
	{
		m_PersistentCalls.Add(call);
		m_NeedsUpdate = true;
	}

	public void AddListener(BaseInvokableCall call)
	{
		m_RuntimeCalls.Add(call);
		m_NeedsUpdate = true;
	}

	public void RemoveListener(object targetObj, MethodInfo method)
	{
		List<BaseInvokableCall> list = new List<BaseInvokableCall>();
		for (int i = 0; i < m_RuntimeCalls.Count; i++)
		{
			if (m_RuntimeCalls[i].Find(targetObj, method))
			{
				list.Add(m_RuntimeCalls[i]);
			}
		}
		m_RuntimeCalls.RemoveAll(list.Contains);
		List<BaseInvokableCall> list2 = new List<BaseInvokableCall>(m_PersistentCalls.Count + m_RuntimeCalls.Count);
		list2.AddRange(m_PersistentCalls);
		list2.AddRange(m_RuntimeCalls);
		m_ExecutingCalls = list2;
		m_NeedsUpdate = false;
	}

	public void Clear()
	{
		m_RuntimeCalls.Clear();
		List<BaseInvokableCall> executingCalls = new List<BaseInvokableCall>(m_PersistentCalls);
		m_ExecutingCalls = executingCalls;
		m_NeedsUpdate = false;
	}

	public void ClearPersistent()
	{
		m_PersistentCalls.Clear();
		List<BaseInvokableCall> executingCalls = new List<BaseInvokableCall>(m_RuntimeCalls);
		m_ExecutingCalls = executingCalls;
		m_NeedsUpdate = false;
	}

	public List<BaseInvokableCall> PrepareInvoke()
	{
		if (m_NeedsUpdate)
		{
			m_ExecutingCalls.Clear();
			m_ExecutingCalls.AddRange(m_PersistentCalls);
			m_ExecutingCalls.AddRange(m_RuntimeCalls);
			m_NeedsUpdate = false;
		}
		return m_ExecutingCalls;
	}
}
