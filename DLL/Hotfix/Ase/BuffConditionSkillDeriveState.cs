using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionSkillDeriveState : BuffConditionBase
{
	protected HeroSkillTypeEnum skillTypeEnum;

	protected int skillId;

	protected bool compare;

	public override BuffConditionType BuffConditionType => BuffConditionType.SkillDeriveState;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		skillTypeEnum = Utility.Convert.StringToEnum<HeroSkillTypeEnum>(paramList[0]);
		skillId = Utility.Convert.StringToInt(paramList[1]);
		compare = Utility.Convert.StringToBool(paramList[2]);
	}

	protected override string OnGetDataString()
	{
		return $"{skillTypeEnum},{skillId},{compare}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		SkillComponent skillComponent = entityTarget?.GetComponent<SkillComponent>();
		if (skillComponent == null)
		{
			return false;
		}
		HeroSkillData skillData = skillComponent.GetSkillData(skillTypeEnum);
		if (skillId == 0)
		{
			return skillData.IsDeriving == compare;
		}
		return skillId == skillData.Id == compare;
	}
}
