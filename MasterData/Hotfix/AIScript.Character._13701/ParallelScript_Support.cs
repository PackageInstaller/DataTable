using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13701;

public class ParallelScript_Support : ParallelScript
{
	private int _hitCount_513724;

	private LogicEntity _lastSeenMainTarget_513724;

	private FP _lastTriggerTime_513724;

	private List<MonsterAdventureActor> _tmpDroneBuffList_513724 = new List<MonsterAdventureActor>();

	private List<MonsterAdventureActor> _tmpSpawnDroneList = new List<MonsterAdventureActor>();

	private FP _jumpIndexSeen_513721 = -1;

	private FP _sessionSeen_513721;

	private FP _time_513730 = -1;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnDroneSpawned);
	}

	public void OnUpdate()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513724, out var perkLevel))
		{
			LogicEntity logicEntity = (SceneSingleton<AdventurePlayerController>.Instance?.activedPlayerActor as PlayerAdventureActor)?.attackTarget;
			if (logicEntity != _lastSeenMainTarget_513724)
			{
				_hitCount_513724 = 0;
				_lastSeenMainTarget_513724 = logicEntity;
			}
			RefreshDroneAtkSpeedBuff_513724();
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513721, out perkLevel))
		{
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("JumpAtkSessionStart");
			FP logicTagValue2 = _actor.logicVariable.GetLogicTagValue("JumpAtkJumpIndex");
			if (logicTagValue != _sessionSeen_513721)
			{
				_sessionSeen_513721 = logicTagValue;
				_jumpIndexSeen_513721 = -1;
			}
			if (logicTagValue2 != _jumpIndexSeen_513721 && logicTagValue2 >= 1)
			{
				_jumpIndexSeen_513721 = logicTagValue2;
				int loops = (int)(long)logicTagValue2;
				int sharedIdx = (int)(long)_actor.logicVariable.GetLogicTagValue("JumpAtkExplodeIndex");
				TSVector2 logicTagTSVector2Value = _actor.logicVariable.GetLogicTagTSVector2Value("JumpAtkAnchor");
				TSVector2 logicTagTSVector2Value2 = _actor.logicVariable.GetLogicTagTSVector2Value("JumpAtkForward");
				_actor.StartLogicCoroutine(PlayExtraExplodesSequence_513721(logicTagTSVector2Value, logicTagTSVector2Value2, sharedIdx, loops));
			}
		}
	}

	protected override void OnSelfBulletFinish(AdventureBulletFinishEvent bulletEvt)
	{
		base.OnSelfBulletFinish(bulletEvt);
		if (bulletEvt != null && !(bulletEvt.owner != _actor) && !(bulletEvt.tag != "137_UAVBirthFly"))
		{
			SpawnDroneAt(bulletEvt.bulletPosition);
		}
	}

	private void SpawnDroneAt(TSVector2 spawnPos)
	{
		_tmpSpawnDroneList.Clear();
		CommonUtils.GetAllSummonsById(_tmpSpawnDroneList, 13700011);
		int num = 0;
		MonsterAdventureActor monsterAdventureActor = null;
		FP fP = FP.MaxValue;
		SummonType summonType;
		for (int i = 0; i < _tmpSpawnDroneList.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor2 = _tmpSpawnDroneList.get_Item(i);
			if (!(monsterAdventureActor2 == null) && !monsterAdventureActor2.IsDead() && monsterAdventureActor2.IsPlayerSummoned(out var summoner, out summonType) && !(summoner != _actor))
			{
				num++;
				FP leftTime = monsterAdventureActor2.monsterSummonInfo.LeftTime;
				if (leftTime < fP)
				{
					fP = leftTime;
					monsterAdventureActor = monsterAdventureActor2;
				}
			}
		}
		if (num >= 3 && monsterAdventureActor != null)
		{
			monsterAdventureActor.DestroySelf();
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513723, out var _))
		{
			for (int j = 0; j < _tmpSpawnDroneList.Count; j++)
			{
				MonsterAdventureActor monsterAdventureActor3 = _tmpSpawnDroneList.get_Item(j);
				if (!(monsterAdventureActor3 == null) && !monsterAdventureActor3.IsDead() && monsterAdventureActor3.IsPlayerSummoned(out var summoner2, out summonType) && !(summoner2 != _actor))
				{
					monsterAdventureActor3.monsterSummonInfo.ResetLeftTime();
				}
			}
		}
		SummonCfg cfg = new SummonCfg
		{
			leftTime = Config_Support.DroneLeftTime,
			summonType = SummonType.None,
			summonAttrType = SummonAttrType.InheritByInitialSnapshot,
			summonRelation = SummonRelation.Coexisted,
			summonFollowType = SummonFollowType.NotFollow,
			useSummonHit = true
		};
		ILRuntimeAPI.SummonMonster(_actor, 0, 13700011, spawnPos, _actor.tsTransform.Forward, cfg);
	}

	private int GetTeamSupportCount()
	{
		int num = 0;
		List<AdventureActor> allPlayerActors = ILRuntimeAPI.GetAllPlayerActors(_actor);
		for (int i = 0; i < allPlayerActors.Count; i++)
		{
			if (allPlayerActors.get_Item(i) is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Support)
			{
				num++;
			}
		}
		return num;
	}

	private IEnumerator PlayExtraExplodesSequence_513721(TSVector2 anchor, TSVector2 forward, int sharedIdx, int loops)
	{
		bool hasPerk_513722 = CommonUtils.HavePersonalPerk(_actor.dataID, 513722, out var _);
		int supportCount = GetTeamSupportCount();
		for (int k = 0; k < loops; k++)
		{
			if (Config_Support.JumpAtkExtraDelayStep_513721 > 0)
			{
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.JumpAtkExtraDelayStep_513721));
			}
			int stackCount_513722 = 0;
			if (hasPerk_513722)
			{
				int num = _actor.logicVariable.GetLogicTagValue("JumpAtkOnceStack_513722").AsInt() + 1;
				_actor.logicVariable.SetLogicTagValue("JumpAtkOnceStack_513722", num);
				stackCount_513722 = ((num > 9) ? 9 : num);
			}
			FP fP = Config_Support.JumpAtkExtraOffset_513721 * (1 << k / 4);
			TSVector2 extraDirection_ = GetExtraDirection_513721(forward, k % 4);
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_137_SkillSup_JumpAtk_Boom_P21", anchor + extraDirection_ * fP, default, (AreaEffectEntity entity) =>
			{
				if (stackCount_513722 > 0)
				{
					if (supportCount == 1)
					{
						entity.AddAdditionalAttr(13722011, stackCount_513722);
					}
					entity.AddAdditionalAttr(13722021);
				}
			}, null, (AreaEffectEntity entity) =>
			{
				if (((sharedIdx > 0) & hasPerk_513722) && supportCount == 1)
				{
					FP scriptValue = CommonUtils.GetScriptValue(_actor, 13721011);
					entity.ModifyScale(1 + scriptValue * sharedIdx / 100);
				}
			});
		}
	}

	private TSVector2 GetExtraDirection_513721(TSVector2 forward, int dirIdx)
	{
		return dirIdx switch
		{
			0 => forward, 
			1 => new TSVector2(forward.y, -forward.x), 
			2 => new TSVector2(-forward.x, -forward.y), 
			3 => new TSVector2(-forward.y, forward.x), 
			_ => forward, 
		};
	}

	private void RefreshDroneAtkSpeedBuff_513724()
	{
		_tmpDroneBuffList_513724.Clear();
		CommonUtils.GetAllSummonsById(_tmpDroneBuffList_513724, 13700011);
		int num = 0;
		for (int i = 0; i < _tmpDroneBuffList_513724.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = _tmpDroneBuffList_513724.get_Item(i);
			if (!(monsterAdventureActor == null) && !monsterAdventureActor.IsDead() && monsterAdventureActor.IsPlayerSummoned(out var summoner, out var _) && !(summoner != _actor))
			{
				_tmpDroneBuffList_513724.set_Item(num++, monsterAdventureActor);
			}
		}
		int buffID = 13724011;
		for (int j = 0; j < num; j++)
		{
			MonsterAdventureActor monsterAdventureActor2 = _tmpDroneBuffList_513724.get_Item(j);
			int buffNumByID = monsterAdventureActor2.buffComponent.GetBuffNumByID(buffID);
			int num2 = num - buffNumByID;
			if (num2 > 0)
			{
				monsterAdventureActor2.buffComponent.AddBuffNum(buffID, num2, _actor);
			}
			else if (num2 < 0)
			{
				monsterAdventureActor2.buffComponent.RemoveBuffByBuffId(buffID, -num2);
			}
		}
	}

	private int GetOwnedLivingDroneCount()
	{
		_tmpDroneBuffList_513724.Clear();
		CommonUtils.GetAllSummonsById(_tmpDroneBuffList_513724, 13700011);
		int num = 0;
		for (int i = 0; i < _tmpDroneBuffList_513724.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = _tmpDroneBuffList_513724.get_Item(i);
			if (!(monsterAdventureActor == null) && !monsterAdventureActor.IsDead() && monsterAdventureActor.IsPlayerSummoned(out var summoner, out var _) && summoner == _actor)
			{
				num++;
			}
		}
		return num;
	}

	private void CheckDroneAccumulate_513724(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 513724, out var _) || !CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.bulletTag_drone))
		{
			return;
		}
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.activedPlayerActor as PlayerAdventureActor;
		if (!(playerAdventureActor == null) && damageEvent.to is AdventureActor adventureActor && !(adventureActor != playerAdventureActor.attackTarget))
		{
			_hitCount_513724++;
			if (_hitCount_513724 >= 3 && (!(_lastTriggerTime_513724 > FP.Zero) || !(_actor.LogicTime <= _lastTriggerTime_513724 + Config_Support.cd_513724)))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_137_P24_UAV_AtkAoe", adventureActor.tsTransform.Position);
				_lastTriggerTime_513724 = _actor.LogicTime;
				_hitCount_513724 = 0;
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnDroneSpawned);
		_hitCount_513724 = 0;
		_lastSeenMainTarget_513724 = null;
		_lastTriggerTime_513724 = FP.Zero;
		_tmpDroneBuffList_513724.Clear();
		_tmpSpawnDroneList.Clear();
		_jumpIndexSeen_513721 = -1;
		_sessionSeen_513721 = FP.Zero;
		_time_513730 = -1;
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (evt is AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent && !(_actor == null) && CommonUtils.HavePersonalPerk(_actor.dataID, 513731, out var _) && adventureElementMarkTriggerEvent.elementType == HotfixEnum.elementType.AE && adventureElementMarkTriggerEvent.triggerActor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE)
		{
			_actor.buffComponent.AddBuff(13731011, _actor);
		}
	}

	private void OnDroneSpawned(IEvent evt)
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513730, out var _) && evt is AdventureMonsterSummonerSpawnedEvent { sender: MonsterAdventureActor sender } adventureMonsterSummonerSpawnedEvent && sender.IsPlayerSummoned(out var summoner, out var _) && !(summoner != _actor) && adventureMonsterSummonerSpawnedEvent.dataId == 13700011 && GetOwnedLivingDroneCount() >= 3)
		{
			_time_513730 = _actor.LogicTime;
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		CheckDroneAccumulate_513724(damageEvent);
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_JumpAtk))
		{
			monsterAdventureActor.buffComponent.AddBuff(2011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513732, out var perkLevel))
		{
			monsterAdventureActor.buffComponent.AddBuff(13732011, _actor);
			if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config.UltraHitTag_137))
			{
				monsterAdventureActor.buffComponent.AddBuff(2011, _actor);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513733, out perkLevel))
		{
			AddTeamWindDamageBuff_513733();
		}
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_JumpAtk) && CommonUtils.HavePersonalPerk(_actor.dataID, 513726, out perkLevel))
		{
			_actor.buffComponent.AddBuff(13726011, _actor);
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.activedPlayerActor as PlayerAdventureActor;
			if (playerAdventureActor != null && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE && playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Vanguard)
			{
				playerAdventureActor.buffComponent.AddBuff(13726021, _actor);
			}
		}
	}

	protected override void OnSelfBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHit)
	{
		base.OnSelfBeforeHit(beforeHit);
		if (CommonUtils.CheckHitByTag(beforeHit.hitDamageTag, Config_Support.damageTag_JumpAtk) && CommonUtils.HavePersonalPerk(_actor.dataID, 513721, out var perkLevel))
		{
			AdventureActor.AddFromAttr(13721011, _actor);
		}
		if (CommonUtils.CheckHitByTag(beforeHit.hitDamageTag, Config_Support.damageTag_JumpAtk) && CommonUtils.HavePersonalPerk(_actor.dataID, 513725, out perkLevel))
		{
			AdventureActor.AddFromAttr(13725001, _actor);
			AdventureActor.AddFromAttr(13725012, _actor);
		}
		if (CommonUtils.CheckHitByTag(beforeHit.hitDamageTag, Config_Support.damageTag_JumpAtk) && CommonUtils.HavePersonalPerk(_actor.dataID, 513727, out perkLevel))
		{
			AdventureActor.AddFromAttr(13727001, _actor);
			AdventureActor.AddFromAttr(13727002, _actor);
		}
	}

	protected override void OnMainBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHit, PlayerAdventureActor main)
	{
		base.OnMainBeforeHit(beforeHit, main);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513730, out var _) && beforeHit.skillSlotType == HotfixEnum.skillSlotType.NORMAL && main.actorElementInfo.elementType == HotfixEnum.elementType.AE && main.actorInfo.jobClass == HotfixEnum.characterJobClass.Vanguard && _time_513730 >= FP.Zero && _actor.LogicTime <= _time_513730 + Config_Support.duration_513730)
		{
			AdventureActor.AddFromAttr(13730002, main);
		}
	}

	private void AddTeamWindDamageBuff_513733()
	{
		List<AdventureActor> allPlayerActors = ILRuntimeAPI.GetAllPlayerActors(_actor);
		for (int i = 0; i < allPlayerActors.Count; i++)
		{
			AdventureActor adventureActor = allPlayerActors.get_Item(i);
			if (adventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE)
			{
				adventureActor.buffComponent.AddBuff(13733011, _actor);
			}
		}
	}
}
