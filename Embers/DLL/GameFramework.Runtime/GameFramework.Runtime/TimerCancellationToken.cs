#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;

namespace GameFramework.Runtime;

public class TimerCancellationToken
{
	private HashSet<Action> m_Actions = new HashSet<Action>();

	public void Add(Action callback)
	{
		m_Actions.Add(callback);
	}

	public void Remove(Action callback)
	{
		m_Actions?.Remove(callback);
	}

	public void Cancel()
	{
		if (m_Actions != null && m_Actions.Count != 0)
		{
			Invoke();
		}
	}

	private void Invoke()
	{
		HashSet<Action> actions = m_Actions;
		m_Actions = null;
		try
		{
			foreach (Action item in actions)
			{
				item();
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex.ToString());
		}
	}
}
