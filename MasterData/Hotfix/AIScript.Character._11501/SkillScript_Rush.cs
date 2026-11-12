using AIScript.Utils;

namespace AIScript.Character._11501;

public class SkillScript_Rush : SkillAdvancedBase
{
	private Skill_Rush _skillRush;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_skillRush == null)
		{
			_skillRush = new Skill_Rush();
		}
		_skillRush.OnEnable(_actor, _skill, Config.actionKeys_Rush, Config.actionKeys_Rush_Independent, Config.interruptTime_Rush, useSpecialRushEnd: false, Config.actionKeys_SpecialRushEnd);
	}

	public void OnUpdate()
	{
		_skillRush?.OnUpdate();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_skillRush?.OnDisable();
	}
}
