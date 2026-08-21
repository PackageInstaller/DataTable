using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionSkillBreakWindow : BuffConditionBase
{
	private RelationTypeEnum relation;

	private HeroSkillTypeEnum skillTypeEnum;

	private HeroSkillTypeEnum breakSkillTypeEnum;

	public override BuffConditionType BuffConditionType => BuffConditionType.SkillBreakWindow;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		relation = Utility.Convert.StringToEnum<RelationTypeEnum>(paramList[0]);
		skillTypeEnum = Utility.Convert.StringToEnum<HeroSkillTypeEnum>(paramList[1]);
		breakSkillTypeEnum = Utility.Convert.StringToEnum<HeroSkillTypeEnum>(paramList[2]);
	}

	protected override string OnGetDataString()
	{
		return $"{relation},{skillTypeEnum},{breakSkillTypeEnum}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		if (AIUtility.GetRelation(entityTarget, entityFrom) == relation)
		{
			return entityTarget.GetComponent<SkillComponent>()?.CommandBreakWindowIsOpen(skillTypeEnum, breakSkillTypeEnum) ?? false;
		}
		return false;
	}
}
