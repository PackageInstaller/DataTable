#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase.Paradox;
using GameFramework;
using UnityEngine.Pool;

namespace Ase.ECS;

public class EventTree : IReference
{
	private Dictionary<int, EventTreeConditionParams> _conditionUnitDataDic;

	private string _blackKey;

	private float _blackValue;

	private BaseEntity _ownerEntity;

	public int ID { get; private set; }

	public static EventTree Create(BaseEntity ownerEntity, string blackKey, float blackValue, int id, Dictionary<int, EventTreeConditionParams> conditionUnitDataDic)
	{
		EventTree eventTree = ReferencePool.Acquire<EventTree>();
		eventTree.ID = id;
		eventTree._blackKey = blackKey;
		eventTree._conditionUnitDataDic = CollectionPool<Dictionary<int, EventTreeConditionParams>, KeyValuePair<int, EventTreeConditionParams>>.Get();
		foreach (KeyValuePair<int, EventTreeConditionParams> item in conditionUnitDataDic)
		{
			eventTree._conditionUnitDataDic.Add(item.Key, item.Value);
		}
		eventTree._ownerEntity = ownerEntity;
		eventTree._blackValue = blackValue;
		return eventTree;
	}

	public void Notify(Dictionary<int, EventTreeConditionParams> battleEventParam)
	{
		if (_conditionUnitDataDic.IsNullOrEmpty() || battleEventParam.IsNullOrEmpty())
		{
			return;
		}
		foreach (KeyValuePair<int, EventTreeConditionParams> item in _conditionUnitDataDic)
		{
			if (battleEventParam.TryGetValue(item.Key, out var value))
			{
				bool flag = false;
				if (!((!(item.Value is EventTreeConditionParamsString condition)) ? ((!(item.Value is EventTreeConditionParamsArray<string> condition2)) ? ValueCondition(item.Value, value) : ArrayCondition(condition2, value)) : StringCondition(condition, value)))
				{
					return;
				}
				continue;
			}
			Log.Error($"行为树黑板Key {_blackKey} 关注的事件没有对应参数 {item}");
			return;
		}
		_ownerEntity?.GetComponent<AIParadoxComponent>()?.SetVariableValues(_blackKey, _blackValue);
	}

	private bool ValueCondition(EventTreeConditionParams condition, EventTreeConditionParams value)
	{
		switch (condition.numberContact)
		{
		case NumberContact.than:
			if (condition.Value > value.Value)
			{
				return true;
			}
			break;
		case NumberContact.thanEqual:
			if (condition.Value >= value.Value)
			{
				return true;
			}
			break;
		case NumberContact.equal:
			if ((double)Math.Abs(condition.Value - value.Value) <= 0.0010000000474974513)
			{
				return true;
			}
			break;
		case NumberContact.lessEqual:
			if (condition.Value <= value.Value)
			{
				return true;
			}
			break;
		case NumberContact.less:
			if (condition.Value < value.Value)
			{
				return true;
			}
			break;
		case NumberContact.noEqual:
			if (condition.Value != value.Value)
			{
				return true;
			}
			break;
		}
		return false;
	}

	private bool StringCondition(EventTreeConditionParamsString condition, EventTreeConditionParams value)
	{
		if (value is EventTreeConditionParamsString eventTreeConditionParamsString)
		{
			switch (condition.numberContact)
			{
			case NumberContact.equal:
				return condition.Value.Equals(eventTreeConditionParamsString.Value);
			case NumberContact.noEqual:
				return !condition.Value.Equals(eventTreeConditionParamsString.Value);
			case NumberContact.contains:
				return condition.Value.Contains(eventTreeConditionParamsString.Value);
			case NumberContact.noContains:
				return !condition.Value.Contains(eventTreeConditionParamsString.Value);
			}
		}
		else if (value is EventTreeConditionParamsArray<string> eventTreeConditionParamsArray)
		{
			switch (condition.numberContact)
			{
			case NumberContact.contains:
				return eventTreeConditionParamsArray?.Value.Contains(condition.Value) ?? false;
			case NumberContact.noContains:
				if (eventTreeConditionParamsArray != null)
				{
					return !eventTreeConditionParamsArray.Value.Contains(condition.Value);
				}
				return false;
			}
		}
		return false;
	}

	private bool ArrayCondition(EventTreeConditionParamsArray<string> condition, EventTreeConditionParams value)
	{
		if (value is EventTreeConditionParamsString eventTreeConditionParamsString)
		{
			switch (condition.numberContact)
			{
			case NumberContact.contains:
				return condition.Value.Contains(eventTreeConditionParamsString.Value);
			case NumberContact.noContains:
				return !condition.Value.Contains(eventTreeConditionParamsString.Value);
			}
		}
		else if (value is EventTreeConditionParamsArray<string> eventTreeConditionParamsArray)
		{
			switch (condition.numberContact)
			{
			case NumberContact.contains:
				return eventTreeConditionParamsArray.Value.HasCommonWith(condition.Value);
			case NumberContact.noContains:
				return !eventTreeConditionParamsArray.Value.HasCommonWith(condition.Value);
			}
		}
		return false;
	}

	public void Clear()
	{
		_blackKey = null;
		_blackValue = 0f;
		_ownerEntity = null;
		if (_conditionUnitDataDic != null)
		{
			CollectionPool<Dictionary<int, EventTreeConditionParams>, KeyValuePair<int, EventTreeConditionParams>>.Release(_conditionUnitDataDic);
			_conditionUnitDataDic = null;
		}
	}
}
