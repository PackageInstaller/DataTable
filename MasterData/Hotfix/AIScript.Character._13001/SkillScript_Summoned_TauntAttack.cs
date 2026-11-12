namespace AIScript.Character._13001;

public class SkillScript_Summoned_TauntAttack : SkillScript_Summoned_SkillBase
{
	protected override string GetActionTag()
	{
		if (HavePersonalPerk(513008, out var _))
		{
			return "Taunt_Skill_P08_Large";
		}
		return "Taunt_Skill";
	}
}
