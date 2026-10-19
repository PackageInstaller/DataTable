using System;
using System.Collections.Generic;

namespace Bamboo.Command;

public class AssignmentPool
{
	private static AssignmentPool _default;

	private readonly Dictionary<Type, List<BaseAssignment>> _map = new Dictionary<Type, List<BaseAssignment>>();

	public static AssignmentPool Default
	{
		get
		{
			if (_default == null)
			{
				_default = new AssignmentPool();
			}
			return _default;
		}
	}

	public T Get<T>() where T : BaseAssignment, new()
	{
		Type tYPE = TypeCache<T>.TYPE;
		_map.TryGetValue(tYPE, out var value);
		if (value == null)
		{
			value = new List<BaseAssignment>();
			_map[tYPE] = value;
		}
		foreach (BaseAssignment item in value)
		{
			if (item.State == AssignmentState.Stoped)
			{
				item.ResetState();
				return item as T;
			}
		}
		T val = new T();
		value.Add(val);
		return val;
	}

	public void Recycle(BaseAssignment assignment)
	{
		if (assignment != null)
		{
			Type type = assignment.GetType();
			_map.TryGetValue(type, out var value);
			if (value == null)
			{
				value = new List<BaseAssignment>();
				_map[type] = value;
			}
			value.Add(assignment);
		}
	}
}
