using System;
using System.Collections.Generic;
using Sirenix.Serialization;
using UnityEngine.Events;

namespace ACT.NPC;

[Serializable]
public class NpcConditionGroup
{
	[NonSerialized]
	public NpcCondition parent;

	[OdinSerialize]
	public List<NpcConditionWrap> conditionWraps = new List<NpcConditionWrap>();

	private bool _isPassed = true;

	public int ConditionCount => conditionWraps?.Count ?? 0;

	public bool IsPassed
	{
		get
		{
			return _isPassed;
		}
		private set
		{
			if (_isPassed != value)
			{
				_isPassed = value;
				OnValueChanged?.Invoke(_isPassed);
				parent?.IsPass();
			}
		}
	}

	[field: NonSerialized]
	public event UnityAction<bool> OnValueChanged;

	public NpcConditionUnit GetCondition(int index)
	{
		if (index < 0 || index >= ConditionCount)
		{
			return null;
		}
		return conditionWraps[index].GetCondition();
	}

	public bool AddConditionWrap(NpcConditionUnit condition)
	{
		if (!NpcConditionWrap.TryCreate(condition, out var conditionWrap))
		{
			return false;
		}
		if (conditionWraps == null)
		{
			conditionWraps = new List<NpcConditionWrap>();
		}
		conditionWraps.Add(conditionWrap);
		return true;
	}

	public bool IsPassWithoutCache()
	{
		ClearEditorForcedState();
		bool isPassed = true;
		for (int i = 0; i < ConditionCount; i++)
		{
			NpcConditionUnit condition = GetCondition(i);
			if (condition == null || !condition.IsPass())
			{
				isPassed = false;
			}
		}
		IsPassed = isPassed;
		return IsPassed;
	}

	public bool IsPass()
	{
		ClearEditorForcedState();
		for (int i = 0; i < ConditionCount; i++)
		{
			NpcConditionUnit condition = GetCondition(i);
			if (condition == null || !condition.IsPassed)
			{
				IsPassed = false;
				return IsPassed;
			}
		}
		IsPassed = true;
		return IsPassed;
	}

	public void ClearCache()
	{
		_isPassed = true;
		for (int i = 0; i < ConditionCount; i++)
		{
			GetCondition(i)?.ClearCache();
		}
	}

	private void ClearEditorForcedState()
	{
	}
}
