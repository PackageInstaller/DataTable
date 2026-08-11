using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionTeamSameNum : BuffConditionBase
{
	private HeroAttributeEnum key;

	private int value;

	private CompareMethodType methodType;

	public override BuffConditionType BuffConditionType => BuffConditionType.TeamSameNum;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		key = Utility.Convert.StringToEnum<HeroAttributeEnum>(paramList[0]);
		value = Utility.Convert.StringToInt(paramList[1]);
		methodType = Utility.Convert.StringToEnum<CompareMethodType>(paramList[2]);
		if (key == HeroAttributeEnum.None && entityTarget is HeroEntity heroEntity)
		{
			key = heroEntity.BattleHeroData.Attribute;
		}
	}

	protected override string OnGetDataString()
	{
		return $"{key},{value},{methodType}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		int teamAttributeCountByEntity = entityTarget.GetSystem<EntitySystem>().GetTeamAttributeCountByEntity(key);
		return ConditionExtensions.CompareValueMethod(methodType, teamAttributeCountByEntity, value);
	}
}
