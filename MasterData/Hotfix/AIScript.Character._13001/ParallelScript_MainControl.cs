using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13001;

public class ParallelScript_MainControl : ParallelScript
{
	private ActorState _moveState;

	private int _triggerCount_1;

	private HashSet<long> _triggerSet_6;

	private List<int> _damageTag_7;

	private CoroutineNode _triggerCor_12;

	private ActorState MoveState
	{
		get
		{
			return _moveState;
		}
		set
		{
			if (_moveState == value)
			{
				return;
			}
			_moveState = value;
			if (!CommonUtils.HavePersonalPerk(_actor.dataID, 513012, out var _))
			{
				return;
			}
			if (_moveState == ActorState.StandBy)
			{
				if (_triggerCor_12 == null)
				{
					_triggerCor_12 = _actor.StartLogicCoroutine(TriggerLogic_12());
				}
				return;
			}
			if (_triggerCor_12 != null)
			{
				_actor.StopLogicCoroutine(_triggerCor_12);
			}
			_triggerCor_12 = null;
			_actor.buffComponent?.RemoveBuffByBuffId(13012011);
		}
	}

	public override void OnEnable()
	{
		base.OnEnable();
		_triggerCount_1 = 0;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513013, out var _))
		{
			_damageTag_TriggerWaterCorrosion?.Add(Config_MainControl.damageTag_TriggerWaterCorrosion_P13);
		}
	}

	protected override void OnSelfBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnSelfBeforeHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_Skill))
		{
			AdventureActor.AddFromAttr(13093001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513007, out var _) && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P7))
		{
			FDP fDP = (FDP)CommonUtils.GetScriptValue(_actor, 13007011) / (FDP)100L;
			if (monsterAdventureActor.actorHealthInfo.hpPercentage < fDP)
			{
				AdventureActor.AddFromAttr(13007001, _actor);
			}
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513001, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P1))
		{
			_triggerCount_1++;
			if (_triggerCount_1 >= 10)
			{
				_actor.buffComponent.AddBuff(13005011, _actor);
				_triggerCount_1 = 0;
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513005, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P5))
		{
			monsterAdventureActor.buffComponent.AddBuff(13005012, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513006, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P6) && (monsterAdventureActor.CheckTag(Config.tag_Cold) || CommonUtils.CheckElementMark(CommonDefine.Water, monsterAdventureActor)))
		{
			AdventureWeapon weapon = damageEvent.weapon;
			if (weapon != null)
			{
				if (_triggerSet_6 == null)
				{
					_triggerSet_6 = new HashSet<long>();
				}
				if (_triggerSet_6.Add(weapon.Id))
				{
					_actor.buffComponent?.AddBuff(13006011, _actor);
				}
			}
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 513007, out perkLevel) || monsterAdventureActor.monsterInfo.epicType != HotfixEnum.monsterEpicType.NORMAL || !CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P7))
		{
			return;
		}
		FDP fDP = (FDP)CommonUtils.GetScriptValue(_actor, 13007011) / (FDP)100L;
		if (monsterAdventureActor.actorHealthInfo.hpPercentage < fDP)
		{
			if (_damageTag_7 == null)
			{
				_damageTag_7 = new List<int> { Config_MainControl.damageTag_Trigger_P7 };
			}
			monsterAdventureActor.Kill(_actor, null, HitBox.FeatureFlag.None, null, isHurtEffectScale: true, _damageTag_7);
		}
	}

	protected override void OnTriggerWaterCorrosion(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		base.OnTriggerWaterCorrosion(monster, hitDamageTag);
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 513013, out var _) || !hitDamageTag.Contains(Config_MainControl.damageTag_TriggerWaterCorrosion_P13))
		{
			return;
		}
		foreach (LogicEntity item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
		{
			if (item == _actor || (item.IsPlayerMinion(out var summoner) && summoner == _actor))
			{
				((AdventureActor)item).buffComponent.AddBuff(13013011, _actor);
			}
		}
	}

	public void OnUpdate()
	{
		MoveState = _actor.movementState;
	}

	private IEnumerator TriggerLogic_12()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_MainControl.triggerTime_P12));
		_actor.buffComponent?.AddBuff(13012011, _actor);
		_triggerCor_12 = null;
	}

	private void Clear()
	{
		_triggerCount_1 = 0;
		_triggerSet_6?.Clear();
		_moveState = ActorState.Null;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		Clear();
	}
}
