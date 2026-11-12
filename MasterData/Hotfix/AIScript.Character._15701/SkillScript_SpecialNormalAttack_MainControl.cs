using System;
using AIScript.Utils;

namespace AIScript.Character._15701;

public class SkillScript_SpecialNormalAttack_MainControl : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.buffComponent.RemoveBuffByBuffId(15790011);
		_actor.GetLogicComponent<PlayerSkillCd>()?.BindSkillIdToButton(ActionKey.Normal, 15710000);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515704, out var _))
		{
			_actor.buffComponent.AddBuff(15704011, _actor);
		}
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Atk_SuoLian", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "157paosuolian"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_MarkHuntingTarget;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
