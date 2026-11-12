using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._12501;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	private List<LogicEntity> _pullTargetList;

	private GameObject _pullLinkFx;

	private Dictionary<long, AdventureFXPlayer> _pullFxDic;

	private CoroutineNode _pullLogicCor;

	private HashSet<long> _attackTargetIdSet_P41;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		_actor.SetBlockPriorityToStatic();
		DefaultLookAt();
		_pullLinkFx = _actor.comboGroup.relatedResourceConfig?.GetFXByAlias("fx_12501_bullet_Ultra_TL2_tengman");
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
		BeginAttack("Ultra_TL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		_actor.ReplaceAnimationGroup();
	}

	private void OnNotPlayTimeLine()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Ultra_NoTL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		_actor.ReplaceAnimationGroup();
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "StartRage"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = this;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config.eventHashCode_EnterBerserk;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		}
		else if (string.Equals(eventName, "Start_Catch"))
		{
			if (_pullLogicCor != null)
			{
				_actor.StopLogicCoroutine(_pullLogicCor);
			}
			_pullLogicCor = _actor.StartLogicCoroutine(PullLogic(), runImmediately: true);
		}
	}

	protected override void OnReceiveAttack(IEvent evt)
	{
		base.OnReceiveAttack(evt);
		if (evt is AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent && adventureActorReceiveAttackEvent.from == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor monsterAdventureActor && CommonUtils.HavePersonalPerk(_actor.dataID, 512541, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveAttackEvent.hitDamageTag, Config.damageTag_Trigger_P41))
		{
			if (_attackTargetIdSet_P41 == null)
			{
				_attackTargetIdSet_P41 = new HashSet<long>();
			}
			if (_attackTargetIdSet_P41.Add(monsterAdventureActor.Id))
			{
				_actor.buffComponent?.AddBuff(12541011, _actor);
			}
		}
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		base.OnReceiveDamage(evt);
		if (!(evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent) || !(adventureActorReceiveDamageEvent.from == _actor) || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor) || !CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_UltraSkill_Pull) || adventureActorReceiveDamageEvent.isKill)
		{
			return;
		}
		if (_pullTargetList == null)
		{
			_pullTargetList = new List<LogicEntity>();
		}
		_pullTargetList.Add(monsterAdventureActor);
		if (_pullLinkFx != null)
		{
			if (_pullFxDic == null)
			{
				_pullFxDic = new Dictionary<long, AdventureFXPlayer>();
			}
			if (!_pullFxDic.ContainsKey(monsterAdventureActor.Id))
			{
				Dictionary<long, AdventureFXPlayer> pullFxDic = _pullFxDic;
				long id = monsterAdventureActor.Id;
				GameObject pullLinkFx = _pullLinkFx;
				Vector3 position = _actor.transform.position;
				Quaternion identity = Quaternion.identity;
				Transform transform = _actor.transform;
				Transform transform2 = monsterAdventureActor.transform;
				pullFxDic.Add(id, AdventureFXPlayer.PlayFX(pullLinkFx, 1f, position, identity, 1f, transform, default, transform2));
			}
		}
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		if ((evt as AdventureActorDiedEvent).actor is MonsterAdventureActor monsterAdventureActor)
		{
			_pullTargetList?.Remove(monsterAdventureActor);
			if (_pullFxDic != null && _pullFxDic.ContainsKey(monsterAdventureActor.Id))
			{
				_pullFxDic.get_Item(monsterAdventureActor.Id)?.Stop();
				_pullFxDic.Remove(monsterAdventureActor.Id);
			}
		}
	}

	private IEnumerator PullLogic()
	{
		FP pullTime = Config.pullTime_UltraSkill;
		FP pullInterval = 0;
		while (pullTime > 0)
		{
			if (pullInterval > 0)
			{
				pullInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				if (_pullTargetList != null && _pullTargetList.Count > 0)
				{
					FP distance = Config.pullSpeed_UltraSkill * Config.pullInterval_UltraSkill;
					ILRuntimeAPI.ForceMoveByDistanceToPosition(_actor, _actor.tsTransform.Position, _pullTargetList, distance, Config.pullSpeed_UltraSkill, Config.pullStrength_UltraSkill, 99, isPull: true, withRadius: true, isCoExist: true, isChangeForward: true, Config.pullStopDistance_UltraSkill);
				}
				pullInterval = Config.pullInterval_UltraSkill;
			}
			pullTime -= _actor.LogicDeltaTime;
			yield return null;
		}
		StopPullFx();
	}

	private void StopPullFx()
	{
		if (_pullFxDic == null || _pullFxDic.Count <= 0)
		{
			return;
		}
		foreach (AdventureFXPlayer value in _pullFxDic.Values)
		{
			value?.Stop();
		}
		_pullFxDic.Clear();
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	private void Clear()
	{
		if (_pullLogicCor != null)
		{
			_actor.StopLogicCoroutine(_pullLogicCor);
		}
		_pullLogicCor = null;
		_pullTargetList?.Clear();
		StopPullFx();
		_pullLinkFx = null;
		_attackTargetIdSet_P41?.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.ResetBlockPriority();
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512506, out var perkLevel))
		{
			_actor.buffComponent?.RemoveBuffByBuffId(12506011);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512543, out perkLevel))
		{
			_actor.buffComponent?.AddBuff(12543011, _actor);
		}
		Clear();
	}
}
