using System.Collections.Generic;
using Ase.ECS;
using GameFramework;

namespace Ase;

public class BuffConditionTinder : BuffConditionBase
{
	protected int tinderId;

	protected bool conditionVal;

	public override BuffConditionType BuffConditionType => BuffConditionType.Tinder;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		tinderId = Utility.Convert.StringToInt(paramList[0]);
		conditionVal = Utility.Convert.StringToBool(paramList[1]);
	}

	public static BuffConditionTinder Create(int tinderId, bool conditionVal)
	{
		BuffConditionTinder buffConditionTinder = ReferencePool.Acquire<BuffConditionTinder>();
		buffConditionTinder.tinderId = tinderId;
		buffConditionTinder.conditionVal = conditionVal;
		return buffConditionTinder;
	}

	protected override string OnGetDataString()
	{
		return $"{tinderId},{conditionVal}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		if (entityTarget == null || !(entityTarget is HeroEntity heroEntity))
		{
			return false;
		}
		return heroEntity.BattleHeroData.CheckKindlingIsActive(tinderId) == conditionVal;
	}
}
