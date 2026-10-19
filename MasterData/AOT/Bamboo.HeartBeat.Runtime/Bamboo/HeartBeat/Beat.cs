using System;
using System.Collections.Generic;

namespace Bamboo.HeartBeat;

public class Beat
{
	private readonly List<Action<int>> _actions = new List<Action<int>>();

	private readonly List<Action<int>> _executeActions = new List<Action<int>>();

	public void Add(Action<int> action)
	{
		_actions.Add(action);
	}

	public void Remove(Action<int> action)
	{
		_actions.Remove(action);
	}

	public void Update(int delta)
	{
		_executeActions.Clear();
		foreach (Action<int> action in _actions)
		{
			_executeActions.Add(action);
		}
		foreach (Action<int> executeAction in _executeActions)
		{
			if (executeAction != null)
			{
				try
				{
					executeAction(delta);
				}
				catch (Exception ex)
				{
					throw new ActionException(ex.Message + "\n" + ex.StackTrace);
				}
			}
		}
		_executeActions.Clear();
	}
}
