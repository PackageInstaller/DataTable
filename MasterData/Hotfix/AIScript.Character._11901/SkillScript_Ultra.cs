using System;
using AdventureBehaviour;

namespace AIScript.Character._11901;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private string key_TL = "119_Ultra_TL";

	private string key_NotTL = "119_Ultra_NoTL";

	private string evt_Summon = "119Summon";

	private int summonEvt = CommonHelper.StringToHash("Summon");

	private PlayTimeline _playTimeline = new PlayTimeline();

	private string key;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
	}

	public void OnStart()
	{
		if (GetPerk(511910))
		{
			_actor.buffComponent?.AddBuff(11951011, _actor);
		}
		_playTimeline.Play(_actor, () =>
		{
			key = key_TL;
			_actor.logicVariable.ToggleLogicTag("PlayUltraTimeline", value: true);
			DoMainLogic();
		}, () =>
		{
			key = key_NotTL;
			_actor.logicVariable.ToggleLogicTag("PlayUltraTimeline", value: false);
			DoMainLogic();
		});
	}

	private void OnFinishOrInterrupt()
	{
		_skill?.Clear();
	}

	private void DoMainLogic()
	{
		string actionTag = key;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = OnFinishOrInterrupt;
		System.Action onInterrupt = OnFinishOrInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string eventName)
	{
		if (eventName.Equals(evt_Summon))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = summonEvt;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}
}
