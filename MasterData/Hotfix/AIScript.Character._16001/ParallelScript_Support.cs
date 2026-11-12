using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16001;

public class ParallelScript_Support : ParallelScript
{
	private Config_Support.DecibelState _decibelState;

	private long _areaEffectId_Skill;

	private FP _lastTriggerTime_P26;

	private FP _lastTriggerTime_P27;

	private CoroutineNode _perkLogicCor_P27;

	private CoroutineNode _perkLogicCor_P28;

	private int _addAreaEffectScaleTimes_P28;

	private FP _durationTime_P31;

	private CoroutineNode _perkLogicCor_P31;

	protected override int BuffId_Decibel_Empty => 16000005;

	protected override int BuffId_Decibel_Stack => 16000006;

	protected override int BuffId_Decibel_Max => 16000007;

	private Config_Support.DecibelState DecibelState
	{
		get
		{
			return _decibelState;
		}
		set
		{
			if (value == _decibelState)
			{
				return;
			}
			_decibelState = value;
			_actor.logicVariable.SetLogicTagValue("DecibelState", (int)_decibelState);
			int perkLevel;
			switch (_decibelState)
			{
			case Config_Support.DecibelState.Soft:
				foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
				{
					allPlayerActor.buffComponent.AddBuff(16000008, _actor);
					if (CommonUtils.HavePersonalPerk(_actor.dataID, 516021, out perkLevel))
					{
						allPlayerActor.buffComponent.AddBuff(16000009, _actor);
					}
					else
					{
						allPlayerActor.buffComponent.RemoveBuffByBuffId(16000009);
					}
				}
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 516027, out perkLevel))
				{
					if (_perkLogicCor_P27 != null)
					{
						_actor.StopLogicCoroutine(_perkLogicCor_P27);
					}
					_perkLogicCor_P27 = _actor.StartLogicCoroutine(PerkLogic_P27(), runImmediately: true);
				}
				return;
			case Config_Support.DecibelState.Loud:
				foreach (AdventureActor allPlayerActor2 in ILRuntimeAPI.GetAllPlayerActors(_actor))
				{
					allPlayerActor2.buffComponent.AddBuff(16000008, _actor);
					allPlayerActor2.buffComponent.AddBuff(16000009, _actor);
				}
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 516027, out perkLevel))
				{
					if (_perkLogicCor_P27 != null)
					{
						_actor.StopLogicCoroutine(_perkLogicCor_P27);
					}
					_perkLogicCor_P27 = null;
				}
				return;
			}
			foreach (AdventureActor allPlayerActor3 in ILRuntimeAPI.GetAllPlayerActors(_actor))
			{
				allPlayerActor3.buffComponent.RemoveBuffByBuffId(16000008);
				allPlayerActor3.buffComponent.RemoveBuffByBuffId(16000009);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516027, out perkLevel))
			{
				if (_perkLogicCor_P27 != null)
				{
					_actor.StopLogicCoroutine(_perkLogicCor_P27);
				}
				_perkLogicCor_P27 = null;
			}
		}
	}

	public override void OnEnable()
	{
		base.OnEnable();
		InitDecibelState();
		_areaEffectId_Skill = 0L;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516033, out var _))
		{
			int playerActorCountByElement = CommonUtils.GetPlayerActorCountByElement(HotfixEnum.elementType.WE);
			if (playerActorCountByElement > 0)
			{
				foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
				{
					allPlayerActor.buffComponent.AddBuffNum(16033011, playerActorCountByElement, _actor);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawnComplete);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnEnterExitAreaEffect);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
	}

	private void InitDecibelState()
	{
		DecibelState = Config_Support.DecibelState.None;
		ShowDecibelPerformance = false;
	}

	public void OnUpdate()
	{
		if (((PlayerAdventureActor)_actor).isResidentAssist)
		{
			if (DecibelState == Config_Support.DecibelState.None)
			{
				if (GetDecibelCount() > 40)
				{
					DecibelState = Config_Support.DecibelState.Loud;
				}
				else
				{
					DecibelState = Config_Support.DecibelState.Soft;
				}
			}
		}
		else
		{
			DecibelState = Config_Support.DecibelState.None;
		}
	}

	private IEnumerator PerkLogic_P27()
	{
		FP interval = 0;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
				{
					allPlayerActor.buffComponent.AddBuff(16027011, _actor);
				}
				interval += Config_Support.addBuffInterval_P27;
			}
			yield return null;
		}
	}

	private void OnPlayerSpawnComplete(IEvent evt)
	{
		if (((PlayerAdventureActor)_actor).status == ActorStatus.Special && ((PlayerAdventureActor)_actor).specialStatusTime > 0)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516028, out var _))
			{
				CommonUtils.TryParseStringParamToInt(((PlayerAdventureActor)_actor).GetLocalData("SkillAreaEffectScaleAddTimes_P28"), out _addAreaEffectScaleTimes_P28);
			}
			SceneSingleton<AdventurePlayerController>.Instance.ActiveActor(_actor as PlayerAdventureActor);
			BeginAssit();
		}
	}

	protected override void OnSelfLeave(AdventurePlayerLeaveEvent playerLeaveEvent)
	{
		base.OnSelfLeave(playerLeaveEvent);
		EndAssit();
	}

	protected override void OnReceiveCustomEvent(AdventureActorCustomEvent customEvent)
	{
		base.OnReceiveCustomEvent(customEvent);
		int perkLevel;
		if (customEvent.eventHashCode == Config_Support.eventHashCode_GenerateSkillAreaEffect)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516028, out perkLevel))
			{
				_addAreaEffectScaleTimes_P28 = 0;
				((PlayerAdventureActor)_actor).SetLocalData("SkillAreaEffectScaleAddTimes_P28", "0");
			}
			BeginAssit();
		}
		else if (customEvent.eventHashCode == Config_Support.eventHashCode_CloseAreaEffect)
		{
			if (_areaEffectId_Skill > 0)
			{
				AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(_areaEffectId_Skill);
				if (areaEffect != null)
				{
					new PlayFX().Play(_actor, null, "fx_16001_base_Skill_Sup_WaterRing_close", areaEffect.tsTransform.Position, CommonHelper.GetTerrainHeight(areaEffect.tsTransform.Position, areaEffect.tsTransform.PositionY), default);
				}
				ILRuntimeAPI.StopAreaEffect(_areaEffectId_Skill);
			}
		}
		else if (customEvent.eventHashCode == Config_Support.eventHashCode_TeleportFinish)
		{
			GenerateSkillAreaEffect(_actor.tsTransform.Position);
		}
		else
		{
			if (customEvent.eventHashCode != Config_Support.eventHashCode_TriggerShoot)
			{
				return;
			}
			int num = _actor.logicVariable.GetLogicTagValue("ShootTimes").AsInt();
			num++;
			if (customEvent.intParam > 0)
			{
				AddDecibel(customEvent.intParam);
			}
			else if (customEvent.intParam < 0)
			{
				RemoveDecibel(clear: false, -customEvent.intParam);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516021, out perkLevel) && num % 10 == 0)
			{
				_actor.logicVariable.ToggleLogicTag("CanLineFire_P21", value: true);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516030, out perkLevel) && _areaEffectId_Skill > 0 && num % 8 == 0)
			{
				AreaEffectEntity areaEffect2 = ILRuntimeAPI.GetAreaEffect(_areaEffectId_Skill);
				if (areaEffect2 != null)
				{
					List<DeterministicCollider> list = new List<DeterministicCollider>();
					areaEffect2.DeterministicCollision(list, 256);
					list.RemoveAll((DeterministicCollider x) => !(x.Entity is MonsterAdventureActor monsterAdventureActor) || !CommonHelper.IsEntityAlive(monsterAdventureActor) || !_actor.IsEntityConfrontAndSearchable(monsterAdventureActor));
					if (list != null && list.Count > 0)
					{
						LogicEntity entity = list.get_Item(TSRandom.Range(0, list.Count)).Entity;
						TSVector2 normalized = (areaEffect2.tsTransform.Position - entity.tsTransform.Position).normalized;
						DeterministicShape shape = new DeterministicShape
						{
							shapeType = DeterministicShape.ShapeType.Fan,
							innerRadius = 0,
							radius = Config_Support.randomRadius_P30 + entity.GetRadius(),
							angle = 180,
							position = entity.tsTransform.Position,
							rotation = normalized.GetAngle()
						};
						TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, shape, isReachable: false);
						if (TSRandom.Range(0.0, 100.0) > 50)
						{
							ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_16001_Sup_P30_Red", randomPointInShape);
						}
						else
						{
							ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_16001_Sup_P30_Blue", randomPointInShape);
						}
					}
				}
			}
			_actor.logicVariable.SetLogicTagValue("ShootTimes", num);
		}
	}

	private void BeginAssit()
	{
		ShowDecibelPerformance = true;
		_actor.buffComponent.AddBuff(16000011, _actor);
		GenerateSkillAreaEffect(_actor.tsTransform.Position);
	}

	private void EndAssit()
	{
		ShowDecibelPerformance = false;
		_actor.buffComponent.RemoveBuffByBuffId(16000011);
		if (_areaEffectId_Skill > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectId_Skill);
		}
	}

	private long GenerateSkillAreaEffect(TSVector2 position)
	{
		if (_areaEffectId_Skill > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectId_Skill);
		}
		string fxAlias = "AreaEffect_16001_SupArea";
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
		{
			fxAlias = "AreaEffect_16001_SupArea_T2";
		}
		return ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position, default, null, null, (AreaEffectEntity areaEffect) =>
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516028, out var _))
			{
				if (_addAreaEffectScaleTimes_P28 > 0)
				{
					areaEffect.ModifyScale(1 + Config_Support.addScale_AreaEffect_P28 * _addAreaEffectScaleTimes_P28);
				}
			}
			else
			{
				areaEffect.ResetScale();
			}
		});
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516024, out var _) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P24))
		{
			AdventureActor.AddFromAttr(16024011, _actor);
		}
	}

	protected override void OnBeforePlayerHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforePlayerHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516026, out var _) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P26))
		{
			int buffNum = monsterAdventureActor.buffComponent.GetBuffNum(0, 0, Config_Support.buffTag_Check_P26);
			if (buffNum > 0)
			{
				AdventureActor.AddFromAttr(16026001, _actor, buffNum);
			}
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516021, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P21))
		{
			int buffID = 16021011;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516025, out perkLevel))
			{
				buffID = 16025001;
			}
			monsterAdventureActor.buffComponent.AddBuff(buffID, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516022, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P22))
		{
			int buffID2 = 16021011;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516025, out perkLevel))
			{
				buffID2 = 16025001;
			}
			monsterAdventureActor.buffComponent.AddBuff(buffID2, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516024, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P24))
		{
			monsterAdventureActor.buffComponent.AddBuff(16024011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516025, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P25))
		{
			monsterAdventureActor.buffComponent.AddBuff(16025001, _actor);
		}
	}

	protected override void OnPlayerDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerDamaged(damageEvent);
		if (damageEvent.from == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor && CommonUtils.HavePersonalPerk(_actor.dataID, 516027, out var _) && ((PlayerAdventureActor)_actor).status == ActorStatus.Special && ((PlayerAdventureActor)_actor).specialStatusTime > 0 && DecibelState == Config_Support.DecibelState.Soft)
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 16027011);
			if (_lastTriggerTime_P27 <= 0 || _actor.LogicTime - _lastTriggerTime_P27 > scriptValue)
			{
				AddDecibel(8);
				_lastTriggerTime_P27 = _actor.LogicTime;
			}
		}
	}

	protected override void OnDecibelChange(bool isAdd, bool isConsume)
	{
		base.OnDecibelChange(isAdd, isConsume);
		if (((PlayerAdventureActor)_actor).isResidentAssist)
		{
			if (GetDecibelCount() > 40)
			{
				DecibelState = Config_Support.DecibelState.Loud;
			}
			else
			{
				DecibelState = Config_Support.DecibelState.Soft;
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516022, out var perkLevel))
		{
			_actor.logicVariable.ToggleLogicTag("CanRotateFire_P22", GetDecibelCount() >= 40);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516023, out perkLevel))
		{
			_actor.logicVariable.ToggleLogicTag("CanTriggerPerk_P23", IsDecibelMax());
			_actor.logicVariable.ToggleLogicTag("FinishTorrentialFire_P23", GetDecibelCount() <= 50);
		}
		if (!isConsume || !CommonUtils.HavePersonalPerk(_actor.dataID, 516029, out perkLevel))
		{
			return;
		}
		foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
		{
			allPlayerActor.buffComponent.AddBuff(16029011, _actor);
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEvent && sender == _actor && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			ClearDecibel();
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516023, out var _))
			{
				AddDecibel(70, useAddition: false, playFx: false);
			}
			_actor.logicVariable.SetLogicTagValue("ShootTimes", 0);
		}
	}

	protected override void OnSelfCastSkillEnd(AdventureActorCastSkillEndEvent castSkillEndEvent)
	{
		base.OnSelfCastSkillEnd(castSkillEndEvent);
		if (castSkillEndEvent.skillEventInfo.skillId == 16032001)
		{
			EndAssit();
		}
	}

	private void OnAreaEffectBegin(IEvent evt)
	{
		if (!(evt is AdventureAreaEffectBeginEvent adventureAreaEffectBeginEvent) || !(adventureAreaEffectBeginEvent.owner == _actor) || !(adventureAreaEffectBeginEvent.sender is AreaEffectEntity areaEffectEntity) || !areaEffectEntity.CheckTag(Config_Support.areaEffectTag_Skill))
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516028, out var perkLevel))
		{
			if (_perkLogicCor_P28 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P28);
			}
			_perkLogicCor_P28 = null;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516031, out perkLevel))
		{
			if (_perkLogicCor_P31 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P31);
			}
			_perkLogicCor_P31 = null;
		}
		_areaEffectId_Skill = areaEffectEntity.Id;
	}

	private void OnEnterExitAreaEffect(IEvent evt)
	{
		if (!(evt is AdventureAreaEnterExitEvent adventureAreaEnterExitEvent) || !(adventureAreaEnterExitEvent.owner == _actor) || !(adventureAreaEnterExitEvent.sender is AreaEffectEntity areaEffectEntity) || areaEffectEntity.Id != _areaEffectId_Skill || !(adventureAreaEnterExitEvent.triggerCollider.Entity is PlayerAdventureActor playerAdventureActor))
		{
			return;
		}
		int perkLevel;
		if (playerAdventureActor == _actor)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516028, out perkLevel))
			{
				if (_perkLogicCor_P28 != null)
				{
					_actor.StopLogicCoroutine(_perkLogicCor_P28);
				}
				if (adventureAreaEnterExitEvent.iEnter)
				{
					_perkLogicCor_P28 = _actor.StartLogicCoroutine(PerkLogic_P28(), runImmediately: true);
				}
				else
				{
					_perkLogicCor_P28 = null;
				}
			}
		}
		else
		{
			if (!(playerAdventureActor == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor))
			{
				return;
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516028, out perkLevel))
			{
				if (adventureAreaEnterExitEvent.iEnter)
				{
					playerAdventureActor.buffComponent.AddBuff(16028011, _actor);
				}
				else
				{
					playerAdventureActor.buffComponent.RemoveBuffByBuffId(16028011);
				}
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516031, out perkLevel))
			{
				if (_perkLogicCor_P31 != null)
				{
					_actor.StopLogicCoroutine(_perkLogicCor_P31);
				}
				if (adventureAreaEnterExitEvent.iEnter)
				{
					_perkLogicCor_P31 = _actor.StartLogicCoroutine(PerkLogic_P31(), runImmediately: true);
				}
				else
				{
					_perkLogicCor_P31 = null;
				}
			}
		}
	}

	private IEnumerator PerkLogic_P28()
	{
		FP interval = Config_Support.addScaleInterval_AreaEffect_P28;
		while (_areaEffectId_Skill > 0 && _addAreaEffectScaleTimes_P28 < 60)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				_addAreaEffectScaleTimes_P28++;
				((PlayerAdventureActor)_actor).SetLocalData("SkillAreaEffectScaleAddTimes_P28", _addAreaEffectScaleTimes_P28.ToString());
				ILRuntimeAPI.GetAreaEffect(_areaEffectId_Skill)?.ModifyScale(1 + Config_Support.addScale_AreaEffect_P28 * _addAreaEffectScaleTimes_P28);
				interval += Config_Support.addScaleInterval_AreaEffect_P28;
			}
			yield return null;
		}
		_perkLogicCor_P28 = null;
	}

	private IEnumerator PerkLogic_P31()
	{
		while (_areaEffectId_Skill > 0)
		{
			if (_durationTime_P31 >= Config_Support.durationTime_StayInAreaEffect_P31)
			{
				if (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor is PlayerAdventureActor playerAdventureActor)
				{
					playerAdventureActor.actorShield.AddShield(16031001, _actor);
				}
				_durationTime_P31 -= Config_Support.durationTime_StayInAreaEffect_P31;
			}
			else
			{
				_durationTime_P31 += _actor.LogicDeltaTime;
			}
			yield return null;
		}
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		if (!(evt is AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent) || !(adventureAreaEffectFinishEvent.owner == _actor) || !(adventureAreaEffectFinishEvent.sender is AreaEffectEntity areaEffectEntity))
		{
			return;
		}
		if (areaEffectEntity.CheckTag(Config_Support.areaEffectTag_Skill) && areaEffectEntity.Id == _areaEffectId_Skill)
		{
			_areaEffectId_Skill = 0L;
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 516030, out var _))
		{
			return;
		}
		if (areaEffectEntity.CheckTag(Config_Support.areaEffectTag_Red_P30))
		{
			foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
			{
				allPlayerActor.buffComponent.AddBuff(16030012, _actor);
				allPlayerActor.buffComponent.AddBuff(16030012, _actor);
			}
			if (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor is PlayerAdventureActor playerAdventureActor)
			{
				playerAdventureActor.buffComponent.AddBuff(16030011, _actor);
			}
		}
		else
		{
			if (!areaEffectEntity.CheckTag(Config_Support.areaEffectTag_Blue_P30))
			{
				return;
			}
			foreach (AdventureActor allPlayerActor2 in ILRuntimeAPI.GetAllPlayerActors(_actor))
			{
				allPlayerActor2.buffComponent.AddBuff(16030012, _actor);
			}
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent elementMarkTriggerEvent)
	{
		base.OnElementMarkTrigger(elementMarkTriggerEvent);
		PlayerAdventureActor actor = elementMarkTriggerEvent.triggerActor as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = elementMarkTriggerEvent.markActor as MonsterAdventureActor;
		if (elementMarkTriggerEvent.elementType == HotfixEnum.elementType.WE && CommonUtils.HavePersonalPerk(_actor.dataID, 516026, out var _))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 16026011);
			if ((_lastTriggerTime_P26 <= 0 || _actor.LogicTime - _lastTriggerTime_P26 > scriptValue) && monsterAdventureActor.actorHealthInfo.isAlive && monsterAdventureActor.buffComponent.CheckBuffByBuffTag(Config_Support.buffTag_Check_P26))
			{
				_lastTriggerTime_P26 = _actor.LogicTime;
				ILRuntimeAPI.HitActor(actor, monsterAdventureActor, 160526001, "");
				monsterAdventureActor.buffComponent.AddBuff(4011, _actor);
			}
		}
	}

	private void Clear()
	{
		EndAssit();
		_areaEffectId_Skill = 0L;
		_lastTriggerTime_P26 = 0;
		_lastTriggerTime_P27 = 0;
		if (_perkLogicCor_P27 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P27);
		}
		_perkLogicCor_P27 = null;
		if (_perkLogicCor_P28 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P28);
		}
		_perkLogicCor_P28 = null;
		_addAreaEffectScaleTimes_P28 = 0;
		if (_perkLogicCor_P31 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P31);
		}
		_perkLogicCor_P31 = null;
		_durationTime_P31 = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawnComplete);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnEnterExitAreaEffect);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		Clear();
	}
}
