using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._15701;

public class ParallelScript_MainControl : ParallelScript
{
	private MonsterAdventureActor _huntingTarget;

	private PlayFX _playFX_Hunting;

	private CoroutineNode _huntingLinkFxLogic;

	private FP _lastTriggerTime_P1;

	private ISpecialEntity _fishOverloadEntity_P2;

	private CoroutineNode _perkLogicCor_P3;

	private int _damageTimes_P5;

	private FP _lastTriggerTime_P5;

	private MonsterAdventureActor HuntingTarget
	{
		get
		{
			return _huntingTarget;
		}
		set
		{
			if (value == _huntingTarget)
			{
				return;
			}
			MonsterAdventureActor huntingTarget = _huntingTarget;
			_huntingTarget = value;
			int perkLevel;
			if (huntingTarget != null)
			{
				huntingTarget.buffComponent.RemoveBuffByBuffId(15790012);
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 515708, out perkLevel))
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_157_P8_HuntBreak", huntingTarget.tsTransform.Position);
					_actor.buffComponent.AddBuff(15708011, _actor);
				}
			}
			if (_huntingTarget != null)
			{
				BuffEntity buffEntity = _huntingTarget.buffComponent.AddBuff(15790012, _actor);
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 515704, out perkLevel))
				{
					buffEntity?.AddLeftTime(CommonUtils.GetScriptValue(_actor, 15704011));
				}
				_actor.logicVariable.SetLogicTagValue("HuntingTargetId", _huntingTarget.Id);
				if (_huntingLinkFxLogic != null)
				{
					_actor.StopLogicCoroutine(_huntingLinkFxLogic);
				}
				_huntingLinkFxLogic = _actor.StartLogicCoroutine(HuntingLinkFxLogic(), runImmediately: true);
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 515703, out perkLevel))
				{
					_actor.buffComponent.AddBuffNum(15703011, 3, _actor);
					_actor.buffComponent.AddBuff(15703012, _actor);
					if (_perkLogicCor_P3 != null)
					{
						_actor.StopLogicCoroutine(_perkLogicCor_P3);
					}
					_perkLogicCor_P3 = _actor.StartLogicCoroutine(PerkLogic_P3(), runImmediately: true);
				}
			}
			else
			{
				_actor.logicVariable.SetLogicTagValue("HuntingTargetId", 0);
				_playFX_Hunting?.Stop();
				_playFX_Hunting?.Clear();
				if (_huntingLinkFxLogic != null)
				{
					_actor.StopLogicCoroutine(_huntingLinkFxLogic);
				}
				_huntingLinkFxLogic = null;
				_actor.buffComponent.RemoveBuffByBuffId(15790013);
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 515703, out perkLevel))
				{
					_actor.buffComponent.RemoveBuffByBuffId(15703012);
				}
			}
		}
	}

	public override void OnEnable()
	{
		base.OnEnable();
		HuntingTarget = null;
		if (((PlayerAdventureActor)_actor).status == ActorStatus.Default)
		{
			((PlayerAdventureActor)_actor).status = ActorStatus.Special;
			_actor.buffComponent.AddBuffNum(15790011, 100, _actor);
			if (_actor.buffComponent.HaveBuffNumMax(15790011))
			{
				_playerSkillCd?.BindSkillIdToButton(ActionKey.Normal, 15710001);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515712, out var perkLevel))
		{
			_playerSkillCd?.SetSkillTotalSection(ActionKey.A, _playerSkillCd.GetSkillCD(ActionKey.A).originalTotalSectionAmount + 1, forceMaxSection: true);
		}
		else
		{
			_playerSkillCd?.ResetSkillTotalSection(ActionKey.A);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515713, out perkLevel))
		{
			int playerActorCountByElement = CommonUtils.GetPlayerActorCountByElement(HotfixEnum.elementType.DE);
			if (playerActorCountByElement > 0)
			{
				_actor.buffComponent.AddBuffNum(15713011, playerActorCountByElement, _actor);
				foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
				{
					allPlayerActor.buffComponent.AddBuffNum(15713012, playerActorCountByElement, _actor);
				}
			}
		}
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveSelfCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("SPECIAL_ENTITY_FINISH", OnSpecialEntityFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
	}

	private void OnReceiveSelfCustomEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent adventureActorCustomEvent))
		{
			return;
		}
		if (adventureActorCustomEvent.eventHashCode == Config_MainControl.eventHashCode_MarkHuntingTarget)
		{
			HuntingTarget = null;
			if (_actor.attackTarget is MonsterAdventureActor huntingTarget)
			{
				HuntingTarget = huntingTarget;
			}
		}
		else if (adventureActorCustomEvent.eventHashCode == Config_MainControl.eventHashCode_SkillShoot)
		{
			Transform slotNode = _actor.slotConfig.GetSlotNode(AnimationSlotConfigComponent.SlotType.Extra_1);
			Vector3 vector = ((slotNode != null) ? slotNode.transform.position : _actor.transform.position);
			TSVector2 position = ((_actor.attackTarget != null) ? (_actor.tsTransform.Position + (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized * (TSVector2.Distance(_actor.tsTransform.Position, _actor.attackTarget.tsTransform.Position) - _actor.attackTarget.GetRadius())) : (_actor.tsTransform.Position + _actor.tsTransform.Forward * Config_MainControl.offset_NoTarget_Skill));
			Vector3 vector2 = new Vector3(position.x.AsFloat(), _actor.tsTransform.PositionY.AsFloat(), position.y.AsFloat());
			float speed = Vector3.Distance(vector, vector2) / Config_MainControl.moveTime_BulletFx_Skill.AsFloat();
			_actor.PlayMovableFx("157_Skll_Main_FlyBullt_Fx", vector, vector2, speed);
			_actor.StartLogicCoroutine(DelayGenerateAreaEffect(Config_MainControl.moveTime_BulletFx_Skill, position), runImmediately: true);
		}
	}

	private IEnumerator DelayGenerateAreaEffect(FP delay, TSVector2 position)
	{
		yield return _actor.WaitTime(delay);
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_157_SkillMain_ShotBoom", position);
	}

	protected override void OnSelfGetBuff(AdventureActorGetBuff getBuffEvent)
	{
		base.OnSelfGetBuff(getBuffEvent);
		switch (getBuffEvent.eventInfo.buffId)
		{
		case 15790011:
			if (_actor.buffComponent.HaveBuffNumMax(15790011))
			{
				_playerSkillCd?.BindSkillIdToButton(ActionKey.Normal, 15710001);
			}
			break;
		case 15702011:
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515702, out var _) && _fishOverloadEntity_P2 == null)
			{
				GameObject fXByAlias = _actor.comboGroup.relatedResourceConfig.GetFXByAlias("157SkillMainP2FishObject");
				_fishOverloadEntity_P2 = SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, fXByAlias, _actor.transform.position, Quaternion.identity);
			}
			break;
		}
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff { sender: MonsterAdventureActor sender } adventureActorRemoveBuff && adventureActorRemoveBuff.eventInfo.buffId == 15790012 && HuntingTarget == sender)
		{
			HuntingTarget = null;
		}
	}

	private void OnSpecialEntityFinish(IEvent evt)
	{
		if (evt is SpecialEntityFinishEvent specialEntityFinishEvent && specialEntityFinishEvent.entity == _fishOverloadEntity_P2)
		{
			_fishOverloadEntity_P2 = null;
		}
	}

	private void OnMonsterDied(IEvent evt)
	{
		if (evt is AdventureMonsterDiedEvent { sender: MonsterAdventureActor sender } && HuntingTarget == sender)
		{
			HuntingTarget = null;
		}
	}

	private IEnumerator HuntingLinkFxLogic()
	{
		if (HuntingTarget == null)
		{
			yield break;
		}
		if (_playFX_Hunting == null)
		{
			_playFX_Hunting = new PlayFX();
		}
		_playFX_Hunting.Stop();
		_playFX_Hunting.Clear();
		long huntingTargetId = HuntingTarget.Id;
		bool havePerk_P4 = CommonUtils.HavePersonalPerk(_actor.dataID, 515704, out var _);
		CommomAreaHitConfig commonAreaHitConfig_P4 = null;
		FP hitInterval_P4 = Config_MainControl.hitInterval_P4;
		while (true)
		{
			if (CommonUtils.CheckTargetIsValid(HuntingTarget, huntingTargetId))
			{
				FP fP = _actor.DistanceWithRadius(HuntingTarget);
				if (fP <= Config_MainControl.interruptDistance_LinkFx_Hunting)
				{
					if (!_playFX_Hunting.isPlaying)
					{
						string fxAlias = "157_SuoLian";
						if (havePerk_P4)
						{
							fxAlias = "157_SuoLian_P4";
						}
						_playFX_Hunting.PlayLinFx(_actor, fxAlias, 1f, useCustSource: true, _actor.gameObject, default, default, HuntingTarget.gameObject, default, default);
						_actor.buffComponent.AddBuff(15790013, _actor);
					}
					if (havePerk_P4)
					{
						if (hitInterval_P4 > 0)
						{
							hitInterval_P4 -= _actor.LogicDeltaTime;
						}
						else
						{
							if (commonAreaHitConfig_P4 == null)
							{
								commonAreaHitConfig_P4 = new CommomAreaHitConfig
								{
									hitDamageId = 157300005,
									hittedEffectAlias = "fx_15701_hit_01"
								};
							}
							TSVector2 tSVector = HuntingTarget.tsTransform.Position - _actor.tsTransform.Position;
							commonAreaHitConfig_P4.position = _actor.tsTransform.Position + tSVector * 0.5f;
							commonAreaHitConfig_P4.direction = tSVector.normalized;
							ILRuntimeAPI.RectangleAreaHit(_actor, commonAreaHitConfig_P4, Config_MainControl.hitWidth_P4, TSVector2.Distance(HuntingTarget.tsTransform.Position, _actor.tsTransform.Position));
							_actor.buffComponent.AddBuffNum(15790011, 10, _actor);
							hitInterval_P4 += Config_MainControl.hitInterval_P4;
						}
					}
				}
				else if (fP > Config_MainControl.interruptDistance_LinkFx_Hunting)
				{
					if (_playFX_Hunting.isPlaying)
					{
						_playFX_Hunting.Stop();
						_actor.buffComponent.RemoveBuffByBuffId(15790013);
					}
					hitInterval_P4 = Config_MainControl.hitInterval_P4;
				}
			}
			else
			{
				if (_playFX_Hunting.isPlaying)
				{
					_playFX_Hunting.Stop();
					_actor.buffComponent.RemoveBuffByBuffId(15790013);
				}
				hitInterval_P4 = Config_MainControl.hitInterval_P4;
			}
			yield return null;
		}
	}

	private IEnumerator PerkLogic_P3()
	{
		while (_actor.buffComponent.GetBuffNumByID(15703011) > 0)
		{
			yield return _actor.WaitTime(CommonUtils.GetScriptValue(_actor, 15703011));
			_actor.buffComponent.RemoveBuffByBuffId(15703011, 1);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515701, out var perkLevel) && monsterAdventureActor.buffComponent.CheckBuffByBuffTag(Config.buffTag_DarkBurn))
		{
			AdventureActor.AddFromAttr(15701011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515707, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P7) && monsterAdventureActor.buffComponent.CheckBuffByBuffTag(Config.buffTag_DarkBurn) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.DE))
		{
			AdventureActor.AddFromAttr(15707001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515709, out perkLevel) && _playerSkillCd.CheckCD(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B)) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.DE) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P9) && monsterAdventureActor.buffComponent.CheckBuffByBuffTag(Config.buffTag_DarkBurn))
		{
			AdventureActor.AddFromAttr(15709001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515701, out var perkLevel))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 15701011);
			if ((_lastTriggerTime_P1 <= 0 || _actor.LogicTime - _lastTriggerTime_P1 > scriptValue) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P1))
			{
				_lastTriggerTime_P1 = _actor.LogicTime;
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_157_P1_FishAtk", monsterAdventureActor.tsTransform.Position);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515705, out perkLevel) && damageEvent.damageType == HotfixEnum.damageType.ULTIMATE)
		{
			FP scriptValue2 = CommonUtils.GetScriptValue(_actor, 15705011);
			if (_lastTriggerTime_P5 <= 0 || _actor.LogicTime - _lastTriggerTime_P5 > scriptValue2)
			{
				_damageTimes_P5++;
				if (_damageTimes_P5 >= 5)
				{
					_lastTriggerTime_P5 = _actor.LogicTime;
					TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
					{
						shapeType = DeterministicShape.ShapeType.Circle,
						innerRadius = 3,
						radius = 3,
						position = monsterAdventureActor.tsTransform.Position
					}, isReachable: false);
					ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_157_P5_FishAtk", randomPointInShape);
					_damageTimes_P5 = 0;
				}
			}
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 515706, out perkLevel) || !CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P6))
		{
			return;
		}
		_actor.buffComponent.AddBuff(15706011, _actor);
		foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor, includeSelf: false))
		{
			if (allPlayerActor.actorElementInfo.elementType == HotfixEnum.elementType.DE && allPlayerActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance)
			{
				allPlayerActor.buffComponent.AddBuff(15706012, _actor);
			}
		}
	}

	protected override void OnTriggerDarkMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		base.OnTriggerDarkMark(monster, hitDamageTag);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515710, out var perkLevel) && HuntingTarget == monster)
		{
			_actor.buffComponent.AddBuff(15710011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515711, out perkLevel))
		{
			_actor.buffComponent.AddBuff(15711011, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveSelfCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("SPECIAL_ENTITY_FINISH", OnSpecialEntityFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
		HuntingTarget = null;
		_playFX_Hunting?.Stop();
		_playFX_Hunting?.Clear();
		_lastTriggerTime_P1 = 0;
		if (_perkLogicCor_P3 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P3);
		}
		_perkLogicCor_P3 = null;
		_fishOverloadEntity_P2?.Finish();
		_fishOverloadEntity_P2 = null;
		_damageTimes_P5 = 0;
		_lastTriggerTime_P5 = 0;
	}
}
