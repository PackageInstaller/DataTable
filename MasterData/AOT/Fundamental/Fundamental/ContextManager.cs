using System;
using System.Collections.Generic;

namespace Fundamental;

public class ContextManager
{
	private static Dictionary<ContextType, List<IContext>> m_contexts = new Dictionary<ContextType, List<IContext>>();

	public static IReadOnlyDictionary<ContextType, List<IContext>> ReadOnlyContexts = m_contexts;

	public static Action<IContext> OnContextAdd;

	public static Action<IContext> OnContextRemove;

	public static Action<ContextType> OnContextTypeReset;

	public static void AddContext(IContext context)
	{
		ContextType contextType = context.ContextType;
		if (!m_contexts.ContainsKey(contextType))
		{
			m_contexts.Add(contextType, new List<IContext>());
		}
		else if (m_contexts[contextType].Contains(context))
		{
			return;
		}
		m_contexts[contextType].Add(context);
		OnContextAdd?.Invoke(context);
	}

	public static void RemoveContext(IContext context)
	{
		ContextType contextType = context.ContextType;
		if (m_contexts.ContainsKey(contextType))
		{
			if (m_contexts[contextType].Contains(context))
			{
				m_contexts[contextType].Remove(context);
			}
			OnContextRemove?.Invoke(context);
		}
	}

	public static void DestroyContext(IContext context)
	{
		try
		{
			ContextType contextType = context.ContextType;
			if (m_contexts.ContainsKey(contextType) && m_contexts[contextType].Contains(context))
			{
				context.ContextDestroy();
			}
		}
		catch (Exception)
		{
			throw;
		}
	}

	public static void ResetAll(ContextType type)
	{
		try
		{
			if (!m_contexts.ContainsKey(type))
			{
				return;
			}
			List<IContext> list = m_contexts[type];
			for (int num = list.Count - 1; num >= 0; num--)
			{
				list[num].ContextReset();
			}
		}
		catch (Exception)
		{
			throw;
		}
		OnContextTypeReset?.Invoke(type);
	}
}
