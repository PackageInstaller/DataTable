using System;
using System.Collections.Generic;
using Ase;

public class SettlementAchievement : Achievement
{
	public CompareFlag CompareFlag;

	private float _recodeActionSuccessNumber;

	private float _targetValue;

	private List<int> _settlementCheckPamIndex;

	private Dictionary<int, List<int>> _doubleConditionParam;

	protected override void InitPrivateData(AchievementMedal medal)
	{
		_settlementCheckPamIndex = medal.SettlementcheckPamIndex;
		List<int> compareFlagList = medal.CompareFlagList;
		if (compareFlagList != null && compareFlagList.Count == 1)
		{
			CompareFlag = (CompareFlag)medal.CompareFlagList[0];
		}
	}

	protected override bool InitCondition(List<int> conditionList, List<List<int>> targetList)
	{
		if (base.InitCondition(conditionList, targetList))
		{
			_doubleConditionParam = new Dictionary<int, List<int>>();
			if (_settlementCheckPamIndex?.Count != conditionList.Count)
			{
				return false;
			}
			for (int i = 0; i < _settlementCheckPamIndex.Count - 1; i++)
			{
				if (_settlementCheckPamIndex[i] == 1)
				{
					_doubleConditionParam.Add(conditionList[i], targetList[i]);
				}
				else
				{
					ConditionParam.Add(conditionList[i], targetList[i]);
				}
			}
			int index = conditionList.Count - 1;
			TargetParamType = conditionList[index];
			index = targetList.Count - 1;
			if (targetList[index] != null)
			{
				index = targetList.Count - 1;
				if (targetList[index].Count != 0)
				{
					int index2 = targetList.Count - 1;
					List<int> list = targetList[index2];
					index = list.Count - 1;
					_targetValue = list[index];
					goto IL_0124;
				}
			}
			_targetValue = -1f;
			goto IL_0124;
		}
		return false;
		IL_0124:
		return true;
	}

	public override void VerityAchievement(Dictionary<int, int> conditionParams, Dictionary<int, int> targetParams)
	{
		if (!targetParams.TryGetValue(TargetParamType, out var value))
		{
			return;
		}
		int num = 0;
		foreach (int key in ConditionParam.Keys)
		{
			List<int> list = ConditionParam[key];
			if (list.Count == 0)
			{
				return;
			}
			if (!list.Contains(-1))
			{
				if (!conditionParams.TryGetValue(key, out var value2))
				{
					return;
				}
				for (int i = 0; i < list.Count; i++)
				{
					if (value2 == list[i])
					{
						num++;
						break;
					}
				}
			}
			else
			{
				num++;
			}
		}
		if (num == ConditionParam.Count)
		{
			_recodeActionSuccessNumber += value;
		}
	}

	public override void DoubleVerityAchievement(Dictionary<int, int> conditionParams)
	{
		int num = 0;
		foreach (int key in _doubleConditionParam.Keys)
		{
			List<int> list = _doubleConditionParam[key];
			if (list.Count == 0)
			{
				return;
			}
			if (!list.Contains(-1))
			{
				if (!conditionParams.TryGetValue(key, out var value))
				{
					return;
				}
				for (int i = 0; i < list.Count; i++)
				{
					if (value == list[i])
					{
						num++;
						break;
					}
				}
			}
			else
			{
				num++;
			}
		}
		if (num == _doubleConditionParam.Count && CompareSuccessNumber())
		{
			targetSuccessValue = 1;
		}
		base.DoubleVerityAchievement(conditionParams);
	}

	private bool CompareSuccessNumber()
	{
		return CompareFlag switch
		{
			CompareFlag.EqualTo => Math.Abs(_recodeActionSuccessNumber - _targetValue) < 0.001f, 
			CompareFlag.GreaterThan => _recodeActionSuccessNumber > _targetValue, 
			CompareFlag.LessThan => _recodeActionSuccessNumber < _targetValue, 
			_ => false, 
		};
	}
}
