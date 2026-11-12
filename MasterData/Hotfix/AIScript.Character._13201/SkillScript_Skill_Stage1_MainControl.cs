namespace AIScript.Character._13201;

public class SkillScript_Skill_Stage1_MainControl : SkillScript_Skill_Base_MainControl
{
	private const string actionTag = "132_Main_Skill_S1";

	private const int perkId_3 = 513203;

	private const string actionTag_P3 = "132_Main_Skill_S1_P03";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.logicVariable.ToggleLogicTag("CanTriggerPerk_2", value: false);
	}

	protected override string GetActionTag()
	{
		if (HavePersonalPerk(513203))
		{
			return "132_Main_Skill_S1_P03";
		}
		return "132_Main_Skill_S1";
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
