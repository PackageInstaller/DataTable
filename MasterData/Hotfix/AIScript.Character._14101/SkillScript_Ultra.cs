using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14101;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3))
		{
			foreach (AdventureActor item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
			{
				item.buffComponent.AddBuff(14196311, _actor);
			}
		}
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, OnPlayTimeLineFinish, OnNotPlayTimeLine);
	}

	private void OnPlayTimeLineFinish()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("141_Ultra_TL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnNotPlayTimeLine()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("141_Ultra_NoTL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "14101_Ultra_Target"))
		{
			LogicEntity attackTarget = GetAttackTarget();
			TSVector2 item = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config.offsetDistance_UltraSkill_NoTarget;
			if (attackTarget != null)
			{
				item = attackTarget.tsTransform.Position;
			}
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = this;
			adventureActorCustomEvent.actor = _actor;
			if (adventureActorCustomEvent.tsVector2ParamList != null)
			{
				adventureActorCustomEvent.tsVector2ParamList.Add(item);
			}
			else
			{
				adventureActorCustomEvent.tsVector2ParamList = new List<TSVector2> { item };
			}
			adventureActorCustomEvent.eventHashCode = Config.eventHashCode_UltraSkill_BeginLogic;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private LogicEntity GetAttackTarget()
	{
		if (((PlayerAdventureActor)_actor).isAssist)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
			if (!(playerAdventureActor.attackTarget != null))
			{
				return _actor.attackTarget;
			}
			return playerAdventureActor.attackTarget;
		}
		return _actor.attackTarget;
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
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
	}
}
