using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._12001;

public class SkillScript_Rush : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKeys_Rush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_Rush_Independent = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.L
	};

	protected const bool useSpecialRushEnd = false;

	private readonly FP interruptTime = 1f;

	private Skill_Rush _skillRush;

	protected override void OnSkillEnable()
	{
		Parallel.dodgeSkill = true;
		base.OnSkillEnable();
		if (_skillRush == null)
		{
			_skillRush = new Skill_Rush();
		}
		_skillRush.OnEnable(_actor, _skill, actionKeys_Rush, actionKeys_Rush_Independent, interruptTime, useSpecialRushEnd: false);
	}

	protected override void OnSkillDisable()
	{
		Parallel.dodgeSkill = false;
		base.OnSkillDisable();
		_skillRush?.OnDisable();
	}

	public void OnUpdate()
	{
		_skillRush?.OnUpdate();
	}
}
