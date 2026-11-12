using AIScript.Utils;

namespace AIScript.Character._12101;

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
		_skillRush.OnEnable(_actor, _skill, Config.comboKeys_Rush, Config.comboKeys_Rush_Independent, Config.interruptTime_Rush, useSpecialRushEnd: false, Config.comboKeys_SpecialRushEnd);
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
