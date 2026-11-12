using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._15501;

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

	private int rushBeginEvt = CommonHelper.StringToHash("Rush_Begin");

	private int rushEndEvt = CommonHelper.StringToHash("Rush_End");

	private Skill_Rush _skillRush;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_skillRush == null)
		{
			_skillRush = new Skill_Rush();
		}
		_skillRush.OnEnable(_actor, _skill, actionKeys_Rush, actionKeys_Rush_Independent, interruptTime, useSpecialRushEnd: false, actionKeys_SpecialRushEnd);
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventHashCode = rushBeginEvt;
		adventureActorCustomEvent.sender = _actor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_skillRush?.OnDisable();
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventHashCode = rushEndEvt;
		adventureActorCustomEvent.sender = _actor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}

	public void OnUpdate()
	{
		_skillRush?.OnUpdate();
	}
}
