using System;
using System.Collections.Generic;
using Bamboo;

namespace ACT.LogicQueue;

public class GameLogicActionPool
{
	private static GameLogicActionPool _pool;

	private readonly Dictionary<Type, List<LogicAction>> _map = new Dictionary<Type, List<LogicAction>>();

	public static GameLogicActionPool Pool => _pool ?? (_pool = new GameLogicActionPool());

	public T Get<T>() where T : LogicAction, new()
	{
		Type tYPE = TypeCache<T>.TYPE;
		_map.TryGetValue(tYPE, out var value);
		if (value == null)
		{
			value = new List<LogicAction>();
			_map[tYPE] = value;
		}
		if (value.Count > 0)
		{
			LogicAction logicAction = value[0];
			value.RemoveAt(0);
			return (T)logicAction;
		}
		return new T();
	}

	public void Recycle(LogicAction logicAction)
	{
		if (logicAction != null)
		{
			Type type = logicAction.GetType();
			_map.TryGetValue(type, out var value);
			if (value == null)
			{
				value = new List<LogicAction>();
				_map[type] = value;
			}
			value.Add(logicAction);
		}
	}
}
