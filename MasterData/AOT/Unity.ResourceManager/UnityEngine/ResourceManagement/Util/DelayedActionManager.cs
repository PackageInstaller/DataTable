using System;
using System.Collections.Generic;
using System.Diagnostics;

namespace UnityEngine.ResourceManagement.Util;

internal class DelayedActionManager : ComponentSingleton<DelayedActionManager>
{
	private struct DelegateInfo(Delegate d, float invocationTime, params object[] p)
	{
		private static int s_Id;

		private int m_Id = s_Id++;

		private Delegate m_Delegate = d;

		private object[] m_Target = p;

		public float InvocationTime { get; private set; } = invocationTime;

		public override string ToString()
		{
			if ((object)m_Delegate == null || m_Delegate.Method.DeclaringType == null)
			{
				return "Null m_delegate for " + m_Id;
			}
			string text = m_Id + " (target=" + m_Delegate.Target?.ToString() + ") " + m_Delegate.Method.DeclaringType.Name + "." + m_Delegate.Method.Name + "(";
			string text2 = "";
			object[] target = m_Target;
			for (int i = 0; i < target.Length; i++)
			{
				text = text + text2 + target[i];
				text2 = ", ";
			}
			return text + ") @" + InvocationTime;
		}

		public void Invoke()
		{
			try
			{
				m_Delegate.DynamicInvoke(m_Target);
			}
			catch (Exception ex)
			{
				Debug.LogErrorFormat("Exception thrown in DynamicInvoke: {0} {1}", ex, this);
			}
		}
	}

	private List<DelegateInfo>[] m_Actions = new List<DelegateInfo>[2]
	{
		new List<DelegateInfo>(),
		new List<DelegateInfo>()
	};

	private LinkedList<DelegateInfo> m_DelayedActions = new LinkedList<DelegateInfo>();

	private Stack<LinkedListNode<DelegateInfo>> m_NodeCache = new Stack<LinkedListNode<DelegateInfo>>(10);

	private int m_CollectionIndex;

	private bool m_DestroyOnCompletion;

	public static bool IsActive
	{
		get
		{
			if (!ComponentSingleton<DelayedActionManager>.Exists)
			{
				return false;
			}
			if (ComponentSingleton<DelayedActionManager>.Instance.m_DelayedActions.Count > 0)
			{
				return true;
			}
			for (int i = 0; i < ComponentSingleton<DelayedActionManager>.Instance.m_Actions.Length; i++)
			{
				if (ComponentSingleton<DelayedActionManager>.Instance.m_Actions[i].Count > 0)
				{
					return true;
				}
			}
			return false;
		}
	}

	private LinkedListNode<DelegateInfo> GetNode(ref DelegateInfo del)
	{
		if (m_NodeCache.Count > 0)
		{
			LinkedListNode<DelegateInfo> linkedListNode = m_NodeCache.Pop();
			linkedListNode.Value = del;
			return linkedListNode;
		}
		return new LinkedListNode<DelegateInfo>(del);
	}

	public static void Clear()
	{
		if (ComponentSingleton<DelayedActionManager>.Exists)
		{
			ComponentSingleton<DelayedActionManager>.Instance.DestroyWhenComplete();
		}
	}

	private void DestroyWhenComplete()
	{
		m_DestroyOnCompletion = true;
	}

	public static void AddAction(Delegate action, float delay = 0f, params object[] parameters)
	{
		ComponentSingleton<DelayedActionManager>.Instance.AddActionInternal(action, delay, parameters);
	}

	private void AddActionInternal(Delegate action, float delay, params object[] parameters)
	{
		DelegateInfo del = new DelegateInfo(action, Time.unscaledTime + delay, parameters);
		if (delay > 0f)
		{
			if (m_DelayedActions.Count == 0)
			{
				m_DelayedActions.AddFirst(GetNode(ref del));
				return;
			}
			LinkedListNode<DelegateInfo> linkedListNode = m_DelayedActions.Last;
			while (linkedListNode != null && linkedListNode.Value.InvocationTime > del.InvocationTime)
			{
				linkedListNode = linkedListNode.Previous;
			}
			if (linkedListNode == null)
			{
				m_DelayedActions.AddFirst(GetNode(ref del));
			}
			else
			{
				m_DelayedActions.AddBefore(linkedListNode, GetNode(ref del));
			}
		}
		else
		{
			m_Actions[m_CollectionIndex].Add(del);
		}
	}

	public static bool Wait(float timeout = 0f, float timeAdvanceAmount = 0f)
	{
		if (!IsActive)
		{
			return true;
		}
		Stopwatch stopwatch = new Stopwatch();
		stopwatch.Start();
		float num = Time.unscaledTime;
		do
		{
			ComponentSingleton<DelayedActionManager>.Instance.InternalLateUpdate(num);
			num = ((!(timeAdvanceAmount >= 0f)) ? Time.unscaledTime : (num + timeAdvanceAmount));
		}
		while (IsActive && (timeout <= 0f || stopwatch.Elapsed.TotalSeconds < (double)timeout));
		return !IsActive;
	}

	private void LateUpdate()
	{
		InternalLateUpdate(Time.unscaledTime);
	}

	private void InternalLateUpdate(float t)
	{
		int num = 0;
		while (m_DelayedActions.Count > 0 && m_DelayedActions.First.Value.InvocationTime <= t)
		{
			m_Actions[m_CollectionIndex].Add(m_DelayedActions.First.Value);
			m_NodeCache.Push(m_DelayedActions.First);
			m_DelayedActions.RemoveFirst();
		}
		do
		{
			int collectionIndex = m_CollectionIndex;
			m_CollectionIndex = (m_CollectionIndex + 1) % 2;
			List<DelegateInfo> list = m_Actions[collectionIndex];
			if (list.Count > 0)
			{
				for (int i = 0; i < list.Count; i++)
				{
					list[i].Invoke();
				}
				list.Clear();
			}
			num++;
		}
		while (m_Actions[m_CollectionIndex].Count > 0);
		if (m_DestroyOnCompletion && !IsActive)
		{
			Object.Destroy(gameObject);
		}
	}

	private void OnApplicationQuit()
	{
		if (ComponentSingleton<DelayedActionManager>.Exists)
		{
			Object.Destroy(ComponentSingleton<DelayedActionManager>.Instance.gameObject);
		}
	}
}
