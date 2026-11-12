using System;
using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Character._11501;

public class SkillScript_Skill_Enter_MainControl : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
	}

	public void OnStart()
	{
		string text = "Main_Cannon_Enter";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511508, out var _))
		{
			text = "Main_Cannon_P08_Start_Hurt";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		_actor.ReplaceAnimationGroup(1);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "115_P08_Finish") && CommonUtils.HavePersonalPerk(_actor.dataID, 511508, out var _))
		{
			SendFunnelFireHitEvent(AnimationSlotConfigComponent.SlotType.Extra_1);
			SendFunnelFireHitEvent(AnimationSlotConfigComponent.SlotType.Extra_2);
			SendFunnelFireHitEvent(AnimationSlotConfigComponent.SlotType.Extra_3);
			SendFunnelFireHitEvent(AnimationSlotConfigComponent.SlotType.Extra_4);
		}
	}

	private void SendFunnelFireHitEvent(AnimationSlotConfigComponent.SlotType slotType)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_AfterFunnelFireHit;
		if (adventureActorCustomEvent.intParamList == null)
		{
			adventureActorCustomEvent.intParamList = new List<int>();
		}
		adventureActorCustomEvent.intParamList.Clear();
		adventureActorCustomEvent.intParamList.Add((int)slotType);
		_actor.DispatchEvent(adventureActorCustomEvent);
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
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
		{
			_actor.buffComponent.AddBuff(11596211, _actor);
		}
	}
}
