using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16001;

public class ParallelScript_MainControl : ParallelScript
{
	private MonsterAdventureActor _summoned;

	private FP _lastTriggerTime_AddBuff_Summoned;

	private Dictionary<long, CoroutineNode> _genBubbleCorDic_P1;

	private readonly List<int> _summonedDataIdList_P1 = new List<int> { 16000011 };

	private FP _lastTriggerTime_P12;

	protected override int BuffId_Decibel_Empty => 16000002;

	protected override int BuffId_Decibel_Stack => 16000003;

	protected override int BuffId_Decibel_Max => 16000004;

	public override void OnEnable()
	{
		base.OnEnable();
		_summoned = null;
		_lastTriggerTime_AddBuff_Summoned = 0;
		ShowDecibelPerformance = true;
		if (((PlayerAdventureActor)_actor).specialStatusTime <= 0)
		{
			AddDecibel(80, useAddition: false, playFx: false);
			((PlayerAdventureActor)_actor).specialStatusTime = 80;
		}
		if (((PlayerAdventureActor)_actor).status == ActorStatus.Default)
		{
			_actor.buffComponent.RemoveBuffByBuffId(16000022);
			_actor.buffComponent.AddBuff(16000021, _actor);
		}
		else
		{
			_actor.buffComponent.RemoveBuffByBuffId(16000021);
			_actor.buffComponent.AddBuff(16000022, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516003, out var perkLevel) && CommonUtils.HavePersonalPerk(_actor.dataID, 516004, out perkLevel))
		{
			((PlayerAdventureActor)_actor).status = ActorStatus.Special;
			_playerSkillCd?.BindSkillIdToButton(ActionKey.B, 16031001);
		}
		else if (((PlayerAdventureActor)_actor).status == ActorStatus.Default)
		{
			_playerSkillCd?.BindSkillIdToButton(ActionKey.B, 16031000);
		}
		else if (((PlayerAdventureActor)_actor).status == ActorStatus.Special)
		{
			_playerSkillCd?.BindSkillIdToButton(ActionKey.B, 16031001);
		}
		((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, canCast: false);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516011, out perkLevel))
		{
			_playerSkillCd?.SetSkillTotalSection(ActionKey.A, _playerSkillCd.GetSkillCD(ActionKey.A).originalTotalSectionAmount + 1, forceMaxSection: true);
		}
		else
		{
			_playerSkillCd?.ResetSkillTotalSection(ActionKey.A);
		}
		((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, _playerSkillCd.GetSkillCD(ActionKey.B).skillId == 16031002);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DROP_EFFECT_BEGIN", OnDropItemBegin);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonedSpawn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
	}

	protected override void OnReceiveCustomEvent(AdventureActorCustomEvent customEvent)
	{
		base.OnReceiveCustomEvent(customEvent);
		if (customEvent.eventHashCode != Config_MainControl.eventHashCode_Bounce_Summoned)
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516003, out var perkLevel))
		{
			AddDecibel(CommonUtils.GetScriptValue(_actor, 16008011).AsInt());
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516004, out perkLevel) && ((PlayerAdventureActor)_actor).status == ActorStatus.Special)
		{
			List<TSVector2> tsVector2ParamList = customEvent.tsVector2ParamList;
			if (tsVector2ParamList != null && tsVector2ParamList.Count > 0)
			{
				_actor.StartLogicCoroutine(PerkLoigc_P4(customEvent.tsVector2ParamList.get_Item(0)), runImmediately: true);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516009, out perkLevel))
		{
			foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
			{
				allPlayerActor.buffComponent.AddBuff(16009011, _actor);
				if (allPlayerActor.actorElementInfo.elementType != HotfixEnum.elementType.WE)
				{
					allPlayerActor.buffComponent.AddBuff(16009012, _actor);
				}
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516010, out perkLevel) && customEvent.intParam % 2 == 0)
		{
			List<TSVector2> tsVector2ParamList = customEvent.tsVector2ParamList;
			if (tsVector2ParamList != null && tsVector2ParamList.Count > 0)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_16001_Main_P10", customEvent.tsVector2ParamList.get_Item(0));
			}
		}
	}

	private IEnumerator PerkLoigc_P4(TSVector2 position)
	{
		long areaEffectId = PlayAreaEffect(position);
		int reboundCount = 0;
		List<DeterministicCollider> targetColliders = new List<DeterministicCollider>();
		long lastTargetId = 0L;
		bool canReboundSummoned = false;
		while (areaEffectId > 0 && reboundCount < 3)
		{
			yield return _actor.WaitTime(Config_MainControl.reboundInterval_P4);
			AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(areaEffectId);
			if (areaEffect != null)
			{
				areaEffect.DeterministicCollision(targetColliders, 256);
				canReboundSummoned = canReboundSummoned && _summoned != null && targetColliders.Contains(_summoned.dtCollider);
				targetColliders.RemoveAll((DeterministicCollider x) => !(x.Entity is MonsterAdventureActor monsterAdventureActor) || (lastTargetId != 0L && monsterAdventureActor.Id == lastTargetId) || !CommonHelper.IsEntityAlive(monsterAdventureActor) || !_actor.IsEntityConfrontAndSearchable(monsterAdventureActor));
				if (targetColliders != null && targetColliders.Count > 0)
				{
					areaEffectId = PlayAreaEffect(targetColliders.get_Item(0).Entity.tsTransform.Position);
					lastTargetId = targetColliders.get_Item(0).Entity.Id;
					canReboundSummoned = true;
					reboundCount++;
				}
				else if (canReboundSummoned)
				{
					areaEffectId = PlayAreaEffect(_summoned.tsTransform.Position);
					lastTargetId = 0L;
					canReboundSummoned = false;
					reboundCount++;
				}
				else
				{
					areaEffectId = 0L;
				}
			}
			else
			{
				areaEffectId = 0L;
			}
		}
		long PlayAreaEffect(TSVector2 position2)
		{
			return ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_16001_Main_P04", position2, default, (AreaEffectEntity areaEffectEntity) =>
			{
				FP fP = GetDecibelCount() / 10 * Config_MainControl.unitAddScale_AreaEffect_P4;
				areaEffectEntity.ModifyScale(1 + fP);
			});
		}
	}

	protected override void OnGetBuff(AdventureActorGetBuff getBuffEvent)
	{
		base.OnGetBuff(getBuffEvent);
		if (!(getBuffEvent.sender is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (getBuffEvent.eventInfo.buffId == 16000010 && CommonUtils.HavePersonalPerk(_actor.dataID, 516001, out var perkLevel))
		{
			if (_genBubbleCorDic_P1 == null)
			{
				_genBubbleCorDic_P1 = new Dictionary<long, CoroutineNode>();
			}
			if (!_genBubbleCorDic_P1.ContainsKey(monsterAdventureActor.Id))
			{
				_genBubbleCorDic_P1.Add(monsterAdventureActor.Id, _actor.StartLogicCoroutine(PerkLogic_P1(monsterAdventureActor), runImmediately: true));
			}
		}
		if (!getBuffEvent.eventInfo.buffTags.Contains(CommonDefine.Water) || !CommonUtils.HavePersonalPerk(_actor.dataID, 516006, out perkLevel) || !(getBuffEvent.from is PlayerAdventureActor playerAdventureActor) || !(playerAdventureActor != _actor) || !monsterAdventureActor.buffComponent.CheckBuffByBuffID(16000010))
		{
			return;
		}
		foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
		{
			allPlayerActor.buffComponent.AddBuff(16006011, _actor);
		}
	}

	protected override void OnRemoveBuff(AdventureActorRemoveBuff removeBuffEvent)
	{
		base.OnRemoveBuff(removeBuffEvent);
		if (removeBuffEvent.sender is MonsterAdventureActor monsterAdventureActor && removeBuffEvent.eventInfo.buffId == 16000010 && CommonUtils.HavePersonalPerk(_actor.dataID, 516001, out var _))
		{
			Dictionary<long, CoroutineNode> genBubbleCorDic_P = _genBubbleCorDic_P1;
			if (genBubbleCorDic_P != null && genBubbleCorDic_P.Count > 0 && _genBubbleCorDic_P1.TryGetValue(monsterAdventureActor.Id, out var value))
			{
				_actor.StopLogicCoroutine(value);
				_genBubbleCorDic_P1.Remove(monsterAdventureActor.Id);
			}
		}
	}

	private IEnumerator PerkLogic_P1(MonsterAdventureActor monster)
	{
		long monsterId = monster.Id;
		FP dropInterval = monster.monsterInfo.epicType switch
		{
			HotfixEnum.monsterEpicType.NORMAL => Config_MainControl.dropInterval_Normal_P1, 
			HotfixEnum.monsterEpicType.ELITE => Config_MainControl.dropInterval_Elite_P1, 
			_ => Config_MainControl.dropInterval_Boss_P1, 
		};
		int dropCount = monster.monsterInfo.epicType switch
		{
			HotfixEnum.monsterEpicType.NORMAL => 1, 
			HotfixEnum.monsterEpicType.ELITE => 1, 
			_ => 2, 
		};
		FP interval = dropInterval;
		while (monster.actorHealthInfo.isAlive)
		{
			if (((PlayerAdventureActor)_actor).status == ActorStatus.Default)
			{
				if (interval > 0)
				{
					interval -= _actor.LogicDeltaTime;
				}
				else
				{
					for (int i = 0; i < dropCount; i++)
					{
						ILRuntimeAPI.PlayDrop(_actor, "Item_16001_Main_P01_Bubble", monster.tsTransform.Position, Config_MainControl.dropItemPositionY_P1);
					}
					interval += dropInterval;
				}
			}
			else
			{
				interval = dropInterval;
			}
			yield return null;
		}
		_genBubbleCorDic_P1.Remove(monsterId);
	}

	protected override void OnDecibelChange(bool isAdd, bool isConsume)
	{
		base.OnDecibelChange(isAdd, isConsume);
		if (IsDecibelMax() && _playerSkillCd.GetCurrentBindSkillId(ActionKey.B) != 16031002)
		{
			_playerSkillCd.BindSkillIdToButton(ActionKey.B, 16031002);
			((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, canCast: true);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		if ((beforeHitEvent.to as MonsterAdventureActor).buffComponent.CheckBuffByBuffID(16000010))
		{
			AdventureActor.AddFromAttr(16000010, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516001, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P1) && _summoned != null)
		{
			int num = ((_summoned.actorScaleInfo.modelScale - _summoned.actorScaleInfo.originModelScale) / Config_MainControl.unitExtraModelScale_P1).AsInt();
			if (num > 0)
			{
				AdventureActor.AddFromAttr(16001011, _actor, num);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516003, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P3))
		{
			AdventureActor.AddFromAttr(16003011, _actor);
		}
	}

	protected override void OnBeforePlayerHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforePlayerHit(beforeHitEvent);
		PlayerAdventureActor playerAdventureActor = beforeHitEvent.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516007, out var _) && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.WE && monsterAdventureActor.buffComponent.CheckBuffByBuffID(16000010))
		{
			AdventureActor.AddFromAttr(16007001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_AddBuffForPlayer_Summoned) && (_lastTriggerTime_AddBuff_Summoned <= 0 || _actor.LogicTime - _lastTriggerTime_AddBuff_Summoned > Config_MainControl.triggerCD_AddBuff_Summoned))
		{
			foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
			{
				allPlayerActor.buffComponent.AddBuff(Config_MainControl.buffId_ForPlayer_Summoned, _actor);
			}
			_lastTriggerTime_AddBuff_Summoned = _actor.LogicTime;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516005, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P5) && monsterAdventureActor.buffComponent.CheckBuffByBuffID(16000010))
		{
			monsterAdventureActor.buffComponent.AddBuff(16005011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516008, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P8))
		{
			foreach (AdventureActor allPlayerActor2 in ILRuntimeAPI.GetAllPlayerActors(_actor))
			{
				if (allPlayerActor2 == _actor || allPlayerActor2.actorElementInfo.elementType != HotfixEnum.elementType.WE)
				{
					allPlayerActor2.buffComponent.AddBuff(16008011, _actor);
				}
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516012, out perkLevel) && (_lastTriggerTime_P12 <= 0 || _actor.LogicTime - _lastTriggerTime_P12 > CommonUtils.GetScriptValue(_actor, 16012011)) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P12))
		{
			_lastTriggerTime_P12 = _actor.LogicTime;
			_actor.actorShield.AddShield(16012001, _actor);
		}
	}

	private void OnDropItemBegin(IEvent evt)
	{
		if (evt is AdventureDropBeginEvent adventureDropBeginEvent && adventureDropBeginEvent.owner == _actor && CommonUtils.HavePersonalPerk(_actor.dataID, 516001, out var _) && string.Equals(adventureDropBeginEvent.dropTag, "Item_16001_Main_P01_Bubble_Tag") && adventureDropBeginEvent.sender is DropEntity dropEntity)
		{
			if (_summoned != null)
			{
				dropEntity.AddTarget(_summoned);
			}
			dropEntity.SetTargetDataId(_summonedDataIdList_P1);
			dropEntity.PickByTarget = true;
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent elementMarkTriggerEvent)
	{
		base.OnElementMarkTrigger(elementMarkTriggerEvent);
		if (elementMarkTriggerEvent.elementType != HotfixEnum.elementType.WE)
		{
			return;
		}
		PlayerAdventureActor playerAdventureActor = elementMarkTriggerEvent.triggerActor as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = elementMarkTriggerEvent.markActor as MonsterAdventureActor;
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 516006, out var _) || !(playerAdventureActor != _actor) || !monsterAdventureActor.buffComponent.CheckBuffByBuffID(16000010))
		{
			return;
		}
		foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
		{
			allPlayerActor.buffComponent.AddBuff(16006011, _actor);
		}
	}

	private void OnSummonedSpawn(IEvent evt)
	{
		if (!(evt is AdventureMonsterSummonerSpawnedEvent { sender: MonsterAdventureActor sender }) || !sender.IsPlayerSummoned(out var summoner, out var _) || !(summoner == _actor) || sender.dataID != 16000011)
		{
			return;
		}
		_summoned = sender;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516008, out var perkLevel))
		{
			_actor.buffComponent.RemoveBuffByBuffId(16008011);
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 516013, out perkLevel))
		{
			return;
		}
		foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
		{
			allPlayerActor.buffComponent.AddBuff(16013011, _actor);
		}
	}

	private void OnMonsterDied(IEvent evt)
	{
		if (!(evt is AdventureMonsterDiedEvent { sender: MonsterAdventureActor sender }) || !sender.IsPlayerSummoned(out var summoner, out var _) || !(summoner == _actor) || sender.dataID != 16000011 || !(sender == _summoned))
		{
			return;
		}
		_summoned = null;
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 516013, out var _))
		{
			return;
		}
		foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
		{
			allPlayerActor.buffComponent.RemoveBuffByBuffId(16013011);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("DROP_EFFECT_BEGIN", OnDropItemBegin);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonedSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
		_summoned = null;
		_lastTriggerTime_AddBuff_Summoned = 0;
		_lastTriggerTime_P12 = 0;
	}
}
