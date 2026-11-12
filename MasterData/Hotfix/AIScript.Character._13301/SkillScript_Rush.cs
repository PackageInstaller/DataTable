using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._13301;

internal class SkillScript_Rush : SkillAdvancedBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_Rush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_Rush_Independent = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.L
	};

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_SpecialRushEnd = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	private const bool useSpecialRushEnd = false;

	private static readonly FP interruptTime = 1f;

	private Skill_Rush _skillRush;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_skillRush == null)
		{
			_skillRush = new Skill_Rush();
		}
		_skillRush.OnEnable(_actor, _skill, actionKeys_Rush, actionKeys_Rush_Independent, interruptTime, useSpecialRushEnd: false, actionKeys_SpecialRushEnd);
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
