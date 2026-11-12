using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._11401;

public class SkillScript_Rush : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKeys_Rush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_Rush_Independent = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.L
	};

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_SpecialRushEnd = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.R };

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_Rush_Strong = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_Rush_Independent_Strong = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.L
	};

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_SpecialRushEnd_Strong = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.R };

	protected const bool useSpecialRushEnd = false;

	private readonly FP interruptTime = 1f;

	private Skill_Rush _skillRush;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_skillRush == null)
		{
			_skillRush = new Skill_Rush();
		}
		bool flag = _actor.buffComponent.CheckBuffByBuffID(Config.buffStrong);
		ComboInputBuffer.ActionKey[] array = (flag ? actionKeys_Rush_Strong : actionKeys_Rush);
		ComboInputBuffer.ActionKey[] array2 = (flag ? actionKeys_Rush_Independent_Strong : actionKeys_Rush_Independent);
		ComboInputBuffer.ActionKey[] array3 = (flag ? actionKeys_SpecialRushEnd_Strong : actionKeys_SpecialRushEnd);
		_skillRush.OnEnable(_actor, _skill, array, array2, interruptTime, useSpecialRushEnd: false, array3);
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
