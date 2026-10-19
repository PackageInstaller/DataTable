using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine.Pool;

namespace ACT.MissionSystem;

public class QueueQuestContext : IQuestContext
{
	private static ObjectPool<QueueQuestContext> s_Pool = new ObjectPool<QueueQuestContext>(() => new QueueQuestContext(), (QueueQuestContext o) =>
	{
		o.Reset();
	});

	private LinkedList<IScope> m_ScopeStack = new LinkedList<IScope>();

	private Dictionary<string, IScope> m_ScopeDict = new Dictionary<string, IScope>();

	public static QueueQuestContext Create()
	{
		return s_Pool.Get();
	}

	public static void Release(QueueQuestContext instance)
	{
		if (instance != null)
		{
			s_Pool.Release(instance);
		}
	}

	private void Reset()
	{
		m_ScopeStack.Clear();
		m_ScopeDict.Clear();
	}

	public bool ContainsScope(string scopeId)
	{
		return m_ScopeDict.ContainsKey(scopeId);
	}

	public UniTask BeginScope(IScope scope, object options, CancellationToken token)
	{
		m_ScopeStack.AddLast(scope);
		m_ScopeDict.Add(scope.ScopeId, scope);
		return scope.Enter(options, token);
	}

	public UniTask EndScope(string scopeId, object options, CancellationToken token)
	{
		if (!m_ScopeDict.TryGetValue(scopeId, out var value))
		{
			return UniTask.CompletedTask;
		}
		m_ScopeStack.Remove(value);
		m_ScopeDict.Remove(value.ScopeId);
		return value.Exit(options, token);
	}

	public async UniTask EndAllScope(CancellationToken token)
	{
		while (m_ScopeStack.Last != null)
		{
			IScope value = m_ScopeStack.Last.Value;
			m_ScopeStack.RemoveLast();
			m_ScopeDict.Remove(value.ScopeId);
			await value.Exit(null, token);
		}
	}
}
