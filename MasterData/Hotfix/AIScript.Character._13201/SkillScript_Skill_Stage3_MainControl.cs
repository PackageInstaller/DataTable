namespace AIScript.Character._13201;

public class SkillScript_Skill_Stage3_MainControl : SkillScript_Skill_Base_MainControl
{
	private const string actionTag = "132_Main_Skill_S3_P01";

	private const int perkId_2 = 513202;

	private const string actionTag_P2 = "132_Main_Skill_S3_P01P02";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
	}

	protected override string GetActionTag()
	{
		if (HavePersonalPerk(513202) && _actor.logicVariable.GetLogicTagToggle("CanTriggerPerk_2"))
		{
			return "132_Main_Skill_S3_P01P02";
		}
		return "132_Main_Skill_S3_P01";
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
	}
}
