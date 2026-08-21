using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionDestinyLevel : BuffConditionBase
{
	protected int level;

	protected CompareMethodType compare;

	public override BuffConditionType BuffConditionType => BuffConditionType.DestinyLevel;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		level = Utility.Convert.StringToInt(paramList[0]);
		compare = Utility.Convert.StringToEnum<CompareMethodType>(paramList[1]);
	}

	protected override string OnGetDataString()
	{
		return $"{level},{compare}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		if (entityTarget == null || !(entityTarget is HeroEntity heroEntity))
		{
			return false;
		}
		return heroEntity.BattleHeroData.CompareDestinyLevel(level, compare);
	}
}
