using System;
using System.Collections.Generic;
using ACT.Condition.Interface;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.NPC;

[Serializable]
public class NpcCondition : IValueChangeNotify
{
	[SerializeReference]
	public List<NpcConditionGroup> groups = new List<NpcConditionGroup>();

	private bool _isPassed;

	[NonSerialized]
	private int _runtimeBindCount;

	public bool IsPassed
	{
		get
		{
			return _isPassed;
		}
		private set
		{
			if (value != _isPassed)
			{
				_isPassed = value;
				OnValueChanged?.Invoke(_isPassed);
			}
		}
	}

	[field: NonSerialized]
	public event UnityAction<bool> OnValueChanged;

	public bool IsPass()
	{
		foreach (NpcConditionGroup group in groups)
		{
			if (group.IsPassed)
			{
				IsPassed = true;
				return IsPassed;
			}
		}
		IsPassed = false;
		return IsPassed;
	}

	public bool IsPassWithoutCache()
	{
		List<NpcConditionGroup> list = groups;
		if (list == null || list.Count <= 0)
		{
			IsPassed = true;
			return IsPassed;
		}
		bool isPassed = false;
		foreach (NpcConditionGroup group in groups)
		{
			if (group.IsPassWithoutCache())
			{
				isPassed = true;
			}
		}
		IsPassed = isPassed;
		return IsPassed;
	}

	public void BindRuntimeContext()
	{
		_runtimeBindCount++;
		if (_runtimeBindCount > 1)
		{
			return;
		}
		foreach (NpcConditionGroup group in groups)
		{
			group.parent = this;
			for (int i = 0; i < group.ConditionCount; i++)
			{
				NpcConditionUnit condition = group.GetCondition(i);
				if (condition != null)
				{
					condition.parent = group;
					condition.RegisterToConditionModel();
				}
			}
		}
		ClearCache();
	}

	public void FreeRuntimeContext()
	{
		if (_runtimeBindCount <= 0)
		{
			return;
		}
		_runtimeBindCount--;
		if (_runtimeBindCount > 0)
		{
			return;
		}
		foreach (NpcConditionGroup group in groups)
		{
			group.parent = null;
			for (int i = 0; i < group.ConditionCount; i++)
			{
				NpcConditionUnit condition = group.GetCondition(i);
				if (condition != null)
				{
					condition.parent = null;
					condition.UnRegisterToConditionModel();
				}
			}
		}
		ClearCache();
	}

	private void ClearCache()
	{
		_isPassed = false;
		foreach (NpcConditionGroup group in groups)
		{
			group?.ClearCache();
		}
	}
}
