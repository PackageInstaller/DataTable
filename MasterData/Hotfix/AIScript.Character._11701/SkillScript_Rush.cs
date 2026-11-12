using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._11701;

public class SkillScript_Rush : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey[] actionKeys_Rush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_Rush_Independent = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.L
	};

	private readonly ComboInputBuffer.ActionKey[] actionKeys_SpecialRushEnd = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	private readonly bool useSpecialRushEnd;

	private readonly FP interruptTime = 1f;

	private readonly string endRushLogicTagEventName = "EndRushLogicTag";

	private Skill_Rush _skillRush;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_skillRush == null)
		{
			_skillRush = new Skill_Rush();
		}
		_skillRush.OnEnable(_actor, _skill, actionKeys_Rush, actionKeys_Rush_Independent, interruptTime, useSpecialRushEnd, actionKeys_SpecialRushEnd, endRushLogicTagEventName);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_skillRush?.OnDisable();
	}

	public void OnUpdate()
	{
		_skillRush?.OnUpdate();
	}
}
