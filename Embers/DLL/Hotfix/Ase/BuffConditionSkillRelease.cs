using System.Collections.Generic;

namespace Ase;

public class BuffConditionSkillRelease : BuffConditionBase
{
	protected InputOptionEnum skillType;

	protected bool conditionVal;

	private bool cacheBuffEvent;

	public override BuffConditionType BuffConditionType => BuffConditionType.SkillRelease;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		skillType = Utility.Convert.StringToEnum<InputOptionEnum>(paramList[0]);
		conditionVal = Utility.Convert.StringToBool(paramList[1]);
		EventType = BattleObserverEventEnum.ReleaseSkill;
	}

	protected override string OnGetDataString()
	{
		return $"{skillType},{conditionVal}";
	}

	protected override void OnMessage(IObserverParams param)
	{
		ObserverReleaseSkillParams observerReleaseSkillParams = (ObserverReleaseSkillParams)param;
		cacheBuffEvent = observerReleaseSkillParams != null && CheckSkillValid(observerReleaseSkillParams.ReleaseSkillType, skillType);
	}

	private bool CheckSkillValid(HeroSkillTypeEnum skillTypeEnum, InputOptionEnum inputOptionEnum)
	{
		switch (inputOptionEnum)
		{
		case InputOptionEnum.Attack:
			return skillTypeEnum == HeroSkillTypeEnum.Attack;
		case InputOptionEnum.Skill1:
			return skillTypeEnum == HeroSkillTypeEnum.Skill1;
		case InputOptionEnum.Skill2:
			return skillTypeEnum == HeroSkillTypeEnum.Skill2;
		case InputOptionEnum.Skill3:
			return skillTypeEnum == HeroSkillTypeEnum.Skill3;
		case InputOptionEnum.Skill4:
			return skillTypeEnum == HeroSkillTypeEnum.Skill4;
		case InputOptionEnum.Dodge:
			return skillTypeEnum == HeroSkillTypeEnum.Roll;
		case InputOptionEnum.AllSkill:
			if (skillTypeEnum != HeroSkillTypeEnum.Skill1 && skillTypeEnum != HeroSkillTypeEnum.Skill2 && skillTypeEnum != HeroSkillTypeEnum.Skill3)
			{
				return skillTypeEnum == HeroSkillTypeEnum.Skill4;
			}
			return true;
		case InputOptionEnum.All:
			return true;
		case InputOptionEnum.SpecialSkill:
			return false;
		case InputOptionEnum.None:
			return skillTypeEnum == HeroSkillTypeEnum.None;
		case InputOptionEnum.BuffSkill:
			return false;
		default:
			return false;
		}
	}

	public override bool OnCheck(Buff buff = null)
	{
		return cacheBuffEvent == conditionVal;
	}

	protected override void OnReset()
	{
		cacheBuffEvent = false;
	}

	protected override void OnDispose()
	{
		cacheBuffEvent = false;
	}
}
