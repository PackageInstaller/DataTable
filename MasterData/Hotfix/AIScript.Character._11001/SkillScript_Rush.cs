using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._11001;

public class SkillScript_Rush : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKeys_Rush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_Rush_Independent = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.L
	};

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_SpecialRushEnd = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.R };

	protected const bool useSpecialRushEnd = false;

	private readonly FP interruptTime = 1f;

	private Skill_Rush _skillRush;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_BREAK_SKILL", OnInterrupt);
		if (_skillRush == null)
		{
			_skillRush = new Skill_Rush();
		}
		_skillRush.OnEnable(_actor, _skill, actionKeys_Rush, actionKeys_Rush_Independent, interruptTime, useSpecialRushEnd: false, actionKeys_SpecialRushEnd);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_BREAK_SKILL", OnInterrupt);
		_skillRush?.OnDisable();
	}

	public void OnUpdate()
	{
		_skillRush?.OnUpdate();
	}

	private void OnInterrupt(IEvent evt)
	{
		if (evt is AdventurBreakSkill adventurBreakSkill && adventurBreakSkill.sender as AdventureActor == _actor)
		{
			_actor.InterruptAttack(force: true);
		}
	}
}
