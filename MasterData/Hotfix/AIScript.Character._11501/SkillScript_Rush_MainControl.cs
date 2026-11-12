using AIScript.Utils;

namespace AIScript.Character._11501;

public class SkillScript_Rush_MainControl : SkillAdvancedBase
{
	private Skill_Rush _skillRush;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_skillRush == null)
		{
			_skillRush = new Skill_Rush();
		}
		_skillRush.OnEnable(_actor, _skill, Config_MainControl.actionKeys_Rush_TransformState, Config_MainControl.actionKeys_Rush_Independent_TransformState, Config_MainControl.interruptTime_TransformState, useSpecialRushEnd: false, Config_MainControl.actionKeys_SpecialRushEnd_TransformState);
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
