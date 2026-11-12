using AIScript.Utils;

namespace AIScript.Character._14401;

public class SkillScript_Skill_Strength_MainControl : SkillScript_Skill_Normal_MainControl
{
	protected override string GetComboTag()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514403, out var _))
		{
			return "144_B1P3_Strength";
		}
		return "144_B1_Strength";
	}
}
