using AIScript.Utils;

namespace AIScript.Character._12501;

public class SkillScript_Rush : SkillAdvancedBase
{
	private Skill_Rush _skillRush;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.logicVariable.ToggleLogicTag("RushState", value: true);
		if (_skillRush == null)
		{
			_skillRush = new Skill_Rush();
		}
		_skillRush.OnEnable(_actor, _skill, Config.comboKeys_Rush, Config.comboKeys_Rush_Independent, Config.interruptTime, useSpecialRushEnd: false, Config.comboKeys_SpecialRushEnd);
	}

	public void OnUpdate()
	{
		_skillRush?.OnUpdate();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.logicVariable.ToggleLogicTag("RushState", value: false);
		_skillRush?.OnDisable();
	}
}
