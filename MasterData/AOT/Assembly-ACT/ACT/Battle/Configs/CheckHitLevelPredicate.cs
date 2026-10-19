using System;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断命中等级", "Predicate", new string[] { "check", "hit", "level", "predicate", "condition" })]
public class CheckHitLevelPredicate : ConfigPredicate
{
	[Tooltip("比较攻击者攻击动作的hitLevel（左值）和受击者当前的endureLevel（右值）")]
	public CompareMode compareMode;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			int hitEndureLevel = getAttackData.GetAttackData().hitEndureLevel;
			int endureLevel = memory.target.entity.GetCompAbility().endureLevel;
			return compareMode switch
			{
				CompareMode.Equal => hitEndureLevel == endureLevel, 
				CompareMode.NotEqual => hitEndureLevel != endureLevel, 
				CompareMode.Greater => hitEndureLevel > endureLevel, 
				CompareMode.Less => hitEndureLevel < endureLevel, 
				CompareMode.GreaterAndEqual => hitEndureLevel >= endureLevel, 
				CompareMode.LessAndEqual => hitEndureLevel <= endureLevel, 
				_ => throw new NotImplementedException(), 
			};
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("'CheckHitLevelPredicate'只能在有AttackData数据的事件中使用");
		}
		return false;
	}
}
