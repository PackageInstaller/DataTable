namespace AIScript.Character._13001;

public class SkillScript_Summoned_CoordinateAttack : SkillScript_Summoned_SkillBase
{
	protected override string GetActionTag()
	{
		if (HavePersonalPerk(513008, out var _))
		{
			return "B1P03P08_LargeHurt";
		}
		return "B1P03_Hurt";
	}
}
