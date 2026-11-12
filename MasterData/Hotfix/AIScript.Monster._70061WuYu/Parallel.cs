using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private readonly Dictionary<long, TSVector2> _layBulletLastPos = new Dictionary<long, TSVector2>();

	private readonly Dictionary<long, int> _layBulletPhase = new Dictionary<long, int>();

	private readonly Dictionary<long, TSVector2> _skill9BigHeadAreas = new Dictionary<long, TSVector2>();

	private readonly List<TSVector2> _skill9LingerPoints = new List<TSVector2>();

	private readonly List<long> _skill9LingerFxIds = new List<long>();

	private CoroutineNode _skill9LingerCoroutine;

	private int _skill9BigHeadSummonCount;

	private readonly List<CoroutineNode> _skill1SummonCoroutines = new List<CoroutineNode>();

	private readonly List<CoroutineNode> _skill9ExplodeSummonCoroutines = new List<CoroutineNode>();

	private int _pendingDispelBulletCount;

	private readonly PlayFX[] _playerLampFx = new PlayFX[Config.PlayerLampHolders.Length];

	private readonly PlayFX[] _bossLampFx = new PlayFX[Config.BossLampHolders.Length];

	private int _playerLampCount;

	private int _bossLampCount;

	private readonly TSVector2[] _playerLampPositions = new TSVector2[Config.PlayerLampHolders.Length];

	private readonly TSVector2[] _bossLampPositions = new TSVector2[Config.BossLampHolders.Length];

	private PlayFX _bossLandedBottleFx;

	private bool _bossBottleInFlight;

	private readonly Dictionary<string, PlayFX> _playerLandedBottleFxMap = new Dictionary<string, PlayFX>();

	private readonly HashSet<string> _inFlightHolders = new HashSet<string>();

	private readonly Dictionary<long, string> _bulletIdToHolder = new Dictionary<long, string>();

	private bool _playerBottleThrowPending;

	private readonly HashSet<string> _usedInteractiveIds = new HashSet<string>();

	private CoroutineNode _broomRingStopCoroutine;

	private FP _perkTimer;

	private bool _perkAssistWasOnField;

	private bool _perk35Consumed;

	private CoroutineNode _perk35Coroutine;

	private bool _selfDeadCleanupDone;

	public override void OnStart()
	{
		base.OnStart();
		_actor.logicVariable.SetLogicTagValue("PerfumeValue", 0);
		_actor.logicVariable.SetLogicTagValue("DispelStunPending", 0);
		FP logicTagValue = _actor.logicVariable.GetLogicTagValue("PerfumeValue");
		PerfumeHelper.FireBossPerfumeChange(_actor, logicTagValue.AsInt(), 100, forceSend: true);
		if (_player != null)
		{
			FP logicTagValue2 = _player.logicVariable.GetLogicTagValue("PerfumeValue");
			PerfumeHelper.FireMoWangPerfumeChange(_player, logicTagValue2.AsInt(), 100, forceSend: true);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("INTERACTIVEID", OnPlayerInput);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnActorCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonerSpawned);
		_perkTimer = FP.Zero;
		_perkAssistWasOnField = false;
		_skill9BigHeadSummonCount = 0;
		_perk35Consumed = false;
		_selfDeadCleanupDone = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnCanCauseDead);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DEAD_IMMUNITY", OnPerk35DeadImmunity);
		for (int i = 0; i < Config.PlayerLampHolders.Length; i++)
		{
			_playerLampPositions[i] = CommonUtils_MonsterAPI.GetPlaceHolderPosition(Config.PlayerLampHolders[i]);
		}
		for (int j = 0; j < Config.BossLampHolders.Length; j++)
		{
			_bossLampPositions[j] = CommonUtils_MonsterAPI.GetPlaceHolderPosition(Config.BossLampHolders[j]);
		}
	}

	public override void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("INTERACTIVEID", OnPlayerInput);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		_actor?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnActorCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonerSpawned);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnCanCauseDead);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DEAD_IMMUNITY", OnPerk35DeadImmunity);
		if (_perk35Coroutine != null)
		{
			_actor?.StopLogicCoroutine(_perk35Coroutine);
			_perk35Coroutine = null;
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
			if (playerAdventureActor != null)
			{
				playerAdventureActor.UnlockHp();
				playerAdventureActor.DisableDeadImmunity();
			}
		}
		_layBulletLastPos.Clear();
		_layBulletPhase.Clear();
		_skill9BigHeadAreas.Clear();
		_skill9LingerPoints.Clear();
		_skill9LingerFxIds.Clear();
		_actor?.StopLogicCoroutine(_skill9LingerCoroutine);
		_skill9LingerCoroutine = null;
		foreach (CoroutineNode skill1SummonCoroutine in _skill1SummonCoroutines)
		{
			_actor?.StopLogicCoroutine(skill1SummonCoroutine);
		}
		_skill1SummonCoroutines.Clear();
		foreach (CoroutineNode skill9ExplodeSummonCoroutine in _skill9ExplodeSummonCoroutines)
		{
			_actor?.StopLogicCoroutine(skill9ExplodeSummonCoroutine);
		}
		_skill9ExplodeSummonCoroutines.Clear();
		_actor?.StopLogicCoroutine(_broomRingStopCoroutine);
		_broomRingStopCoroutine = null;
		_pendingDispelBulletCount = 0;
		for (int i = 0; i < _playerLampFx.Length; i++)
		{
			if (_playerLampFx[i] != null)
			{
				ILRuntimeAPI.StopFx(_playerLampFx[i]);
				_playerLampFx[i] = null;
			}
			if (_bossLampFx[i] != null)
			{
				ILRuntimeAPI.StopFx(_bossLampFx[i]);
				_bossLampFx[i] = null;
			}
		}
		if (_bossLandedBottleFx != null)
		{
			ILRuntimeAPI.StopFx(_bossLandedBottleFx);
			_bossLandedBottleFx = null;
		}
		foreach (PlayFX value in _playerLandedBottleFxMap.Values)
		{
			if (value != null)
			{
				ILRuntimeAPI.StopFx(value);
			}
		}
		_playerLandedBottleFxMap.Clear();
		_inFlightHolders.Clear();
		_bulletIdToHolder.Clear();
		_usedInteractiveIds.Clear();
		_playerLampCount = (_bossLampCount = 0);
		_bossBottleInFlight = false;
		_playerBottleThrowPending = false;
		_perkTimer = FP.Zero;
		_perkAssistWasOnField = false;
		_skill9BigHeadSummonCount = 0;
		_selfDeadCleanupDone = false;
		base.OnDisable();
	}

	private void OnToughnessStateChange(IEvent evt)
	{
		if (evt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent && !(monsterToughnessStateChangeEvent.actor != _actor) && monsterToughnessStateChangeEvent.isToughnessBroken)
		{
			CleanupOnStun();
			if (_broomRingStopCoroutine == null)
			{
				_broomRingStopCoroutine = _actor.StartLogicCoroutine(KeepStoppingBroomRingArea());
			}
		}
	}

	private IEnumerator KeepStoppingBroomRingArea()
	{
		MonsterAdventureActor monsterActor = _actor as MonsterAdventureActor;
		while (monsterActor != null && monsterActor.monsterToughnessInfo.isToughnessBroken)
		{
			ILRuntimeAPI.StopAreaEffectByTag("BroomRingAreaEffect");
			yield return null;
		}
		_broomRingStopCoroutine = null;
	}

	private void OnSummonerSpawned(IEvent evt)
	{
		if (!(evt is AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent) || adventureMonsterSummonerSpawnedEvent.summonerId != _actor.Id)
		{
			return;
		}
		int teamId = (_actor as MonsterAdventureActor).monsterInfo.teamId;
		FP fP;
		if (adventureMonsterSummonerSpawnedEvent.dataId == CommonHelper.GetMonsterTeammateId(teamId, 1))
		{
			fP = Config.ExplodeHpPercent;
		}
		else if (adventureMonsterSummonerSpawnedEvent.dataId == CommonHelper.GetMonsterTeammateId(teamId, 2) || adventureMonsterSummonerSpawnedEvent.dataId == CommonHelper.GetMonsterTeammateId(teamId, 6))
		{
			fP = Config.BigHeadPercent;
		}
		else
		{
			if (adventureMonsterSummonerSpawnedEvent.dataId != CommonHelper.GetMonsterTeammateId(teamId, 3) && adventureMonsterSummonerSpawnedEvent.dataId != CommonHelper.GetMonsterTeammateId(teamId, 5))
			{
				return;
			}
			fP = Config.WarlockPercent;
		}
		AdventureActor adventureActor = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(adventureMonsterSummonerSpawnedEvent.id) as AdventureActor;
		if (!(adventureActor == null))
		{
			FDP baseValue = adventureActor.attributeList.GetBaseValue(HotfixEnum.effectAttributeType.MAXHP);
			FDP value = _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.MAXHP) * fP - baseValue;
			adventureActor.attributeList.ChangeValue(3, 1, value);
			adventureActor.actorHealthInfo.hp = adventureActor.actorHealthInfo.hpMax;
		}
	}

	private void CleanupOnStun(bool stopSkill1SummonCoroutines = true)
	{
		_actor.StopLogicCoroutine(_skill9LingerCoroutine);
		_skill9LingerCoroutine = null;
		foreach (long skill9LingerFxId in _skill9LingerFxIds)
		{
			if (skill9LingerFxId != 0L)
			{
				SceneSingleton<AdventureFXManager>.Instance.StopSubFXPlayers(skill9LingerFxId);
			}
		}
		_skill9LingerPoints.Clear();
		_skill9LingerFxIds.Clear();
		_skill9BigHeadAreas.Clear();
		if (_layBulletPhase.Count > 0)
		{
			foreach (long item in new List<long>(_layBulletPhase.Keys))
			{
				_actor.QueryOwnedBullet(item)?.Finish(cancel: true);
			}
		}
		_layBulletLastPos.Clear();
		_layBulletPhase.Clear();
		if (stopSkill1SummonCoroutines)
		{
			foreach (CoroutineNode skill1SummonCoroutine in _skill1SummonCoroutines)
			{
				_actor.StopLogicCoroutine(skill1SummonCoroutine);
			}
			_skill1SummonCoroutines.Clear();
		}
		foreach (CoroutineNode skill9ExplodeSummonCoroutine in _skill9ExplodeSummonCoroutines)
		{
			_actor.StopLogicCoroutine(skill9ExplodeSummonCoroutine);
		}
		_skill9ExplodeSummonCoroutines.Clear();
		if (_bossLandedBottleFx != null)
		{
			ILRuntimeAPI.StopFx(_bossLandedBottleFx);
			_bossLandedBottleFx = null;
		}
	}

	private void OnSkill9Event(AdventureActorCustomEvent customEvt)
	{
		if (customEvt.eventName == "WuYu_Skill9_RegisterBigHeadArea")
		{
			AreaEffectEntity areaEffectEntity = customEvt.target as AreaEffectEntity;
			if (areaEffectEntity != null)
			{
				_skill9BigHeadAreas.set_Item(areaEffectEntity.Id, areaEffectEntity.tsTransform.Position);
			}
		}
		else if (customEvt.eventName == "WuYu_Skill9_RegisterLingerMark")
		{
			if (customEvt.tsVector2ParamList != null && customEvt.tsVector2ParamList.Count > 0)
			{
				TSVector2 tSVector = customEvt.tsVector2ParamList.get_Item(0);
				_skill9LingerPoints.Add(tSVector);
				TSVector2 direction = CommonUtils_MonsterAPI.GetPlaceHolderPosition("CenterPoint") - tSVector;
				PlayFX playFX = null;
				ILRuntimeAPI.PlayFX(ref playFX, _actor, null, "fx_m70061_bullet_MageGhost_Atk01", tSVector, Skill9_GhostArmy.LingerHeight, direction);
				_skill9LingerFxIds.Add(playFX?.GetFxPlayerToken() ?? 0);
			}
		}
		else if (customEvt.eventName == "WuYu_Skill9_CenterReached")
		{
			if (customEvt.intParam == 3)
			{
				_skill9LingerCoroutine = _actor.StartLogicCoroutine(FireLingerBulletsToCenter());
			}
		}
		else if (customEvt.eventName == "WuYu_Skill9_Cleanup")
		{
			CleanupOnStun();
		}
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		if (evt is AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent && !(adventureAreaEffectFinishEvent.owner != _actor) && _skill9BigHeadAreas.TryGetValue(adventureAreaEffectFinishEvent.entityID, out var value))
		{
			_skill9BigHeadAreas.Remove(adventureAreaEffectFinishEvent.entityID);
			_skill9BigHeadSummonCount = (_skill9BigHeadSummonCount + 1) % 2;
			int index = ((_skill9BigHeadSummonCount == 1) ? 6 : 2);
			CommonUtils_MonsterAPI.SummonTeammate(_actor as MonsterAdventureActor, index, value, DirToPlayer(value));
		}
	}

	private IEnumerator FireLingerBulletsToCenter()
	{
		TSVector2 center = CommonUtils_MonsterAPI.GetPlaceHolderPosition("CenterPoint");
		for (int i = 0; i < _skill9LingerPoints.Count; i++)
		{
			ILRuntimeAPI.Shoot("Weapon_70061WuYu_MageGhost_Skill1_MageAttack", _actor, default, _skill9LingerPoints.get_Item(i), Skill9_GhostArmy.LingerHeight, center, null, AimType.Position, BulletDirectionType.BulletToTarget);
			if (i < _skill9LingerFxIds.Count && _skill9LingerFxIds.get_Item(i) != 0L)
			{
				SceneSingleton<AdventureFXManager>.Instance.StopSubFXPlayers(_skill9LingerFxIds.get_Item(i));
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Skill9_GhostArmy.WarlockLingerShotInterval));
		}
		_skill9LingerPoints.Clear();
		_skill9LingerFxIds.Clear();
		_skill9LingerCoroutine = null;
	}

	private IEnumerator Skill1SummonProcess(TSVector2 spawnPos, System.Action onFinished)
	{
		FP delay = FP.Zero;
		while (delay < Skill1_SummonBoomGhost.SummonDelay)
		{
			delay += LockStepManager.deltaTime;
			yield return null;
		}
		CommonUtils_MonsterAPI.GetLogicTagToggleValue(_actor, "LoyalServantTagId");
		FP interval = Skill1_SummonBoomGhost.SummonProcessInterval;
		FP totalDuration = Skill1_SummonBoomGhost.SummonTotalDuration;
		FP elapsed = FP.Zero;
		FP summonTimer = FP.Zero;
		CommonUtils_MonsterAPI.SummonTeammate(_actor as MonsterAdventureActor, 1, spawnPos, DirToPlayer(spawnPos));
		while (elapsed <= totalDuration)
		{
			elapsed += LockStepManager.deltaTime;
			summonTimer += LockStepManager.deltaTime;
			if (summonTimer >= interval)
			{
				CommonUtils_MonsterAPI.SummonTeammate(_actor as MonsterAdventureActor, 1, spawnPos, DirToPlayer(spawnPos));
				summonTimer -= interval;
			}
			yield return null;
		}
		onFinished?.Invoke();
	}

	private IEnumerator Skill9ExplodeSummonProcess(TSVector2 spawnPos, System.Action onFinished)
	{
		FP delay = FP.Zero;
		while (delay < Skill1_SummonBoomGhost.SummonDelay)
		{
			delay += LockStepManager.deltaTime;
			yield return null;
		}
		CommonUtils_MonsterAPI.SummonTeammate(_actor as MonsterAdventureActor, 1, spawnPos, DirToPlayer(spawnPos));
		onFinished?.Invoke();
	}

	private TSVector2 DirToPlayer(TSVector2 from)
	{
		TSVector2 tSVector = ((_player != null) ? (_player.tsTransform.Position - from) : TSVector2.zero);
		if (!(tSVector.magnitude > FP.Zero))
		{
			return TSVector2.up;
		}
		return tSVector.normalized;
	}

	private void OnActorCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent customEvt)
		{
			OnLayBulletRegistered(customEvt);
			OnSkill9Event(customEvt);
			OnBossBottleClear(customEvt);
		}
	}

	private void OnBossBottleClear(AdventureActorCustomEvent customEvt)
	{
		if (!(customEvt.eventName != "WuYu_BossBottleClear") && _bossLandedBottleFx != null)
		{
			TSVector2 placeHolderPosition = CommonUtils_MonsterAPI.GetPlaceHolderPosition("Position_BossBottleLanding");
			ILRuntimeAPI.StopFx(_bossLandedBottleFx);
			_bossLandedBottleFx = null;
			PlayFX playFX = null;
			ILRuntimeAPI.PlayFX(ref playFX, _actor, null, "fx_70061_base_perfume_purple", placeHolderPosition, FP.Zero, TSVector2.zero);
		}
	}

	private void OnLayBulletRegistered(AdventureActorCustomEvent customEvt)
	{
		if (!(customEvt.eventName != "WuYu_Skill5_RegisterLayBullet"))
		{
			AdventureBulletBase adventureBulletBase = customEvt.target as AdventureBulletBase;
			if (!(adventureBulletBase == null))
			{
				_layBulletLastPos.set_Item(adventureBulletBase.Id, adventureBulletBase.tsTransform.Position);
				_layBulletPhase.set_Item(adventureBulletBase.Id, customEvt.intParam);
			}
		}
	}

	public void OnUpdate()
	{
		UpdatePerk();
		if (!_actor.actorHealthInfo.isAlive)
		{
			return;
		}
		int num = _actor.logicVariable.GetLogicTagValue("Phase").AsInt();
		if (num < 1)
		{
			num = 1;
		}
		int num2 = _actor.logicVariable.GetLogicTagValue("PerfumeValue").AsInt();
		if (_actor.state == ActorState.Action && _actor.logicVariable.GetLogicTagToggle("CanGetPerfume"))
		{
			bool logicTagToggleValue = CommonUtils_MonsterAPI.GetLogicTagToggleValue(_actor, "PerfumeBrewTagId");
			FP fP = num switch
			{
				1 => logicTagToggleValue ? Config.Entry_Phase1Accumlate : Config.Phase1Accumlate, 
				2 => logicTagToggleValue ? Config.Entry_Phase2Accumlate : Config.Phase2Accumlate, 
				_ => logicTagToggleValue ? Config.Entry_Phase3Accumlate : Config.Phase3Accumlate, 
			};
			FP fP2 = _actor.logicVariable.GetLogicTagValue("PerfumeValue") + fP * LockStepManager.deltaTime;
			if (fP2 > 100)
			{
				fP2 = 100;
			}
			_actor.logicVariable.SetLogicTagValue("PerfumeValue", fP2);
			num2 = fP2.AsInt();
			PerfumeHelper.FireBossPerfumeChange(_actor, num2, 100);
		}
		RefreshLamps(_bossLampFx, ref _bossLampCount, _bossLampPositions, num2, "fx_70061WuYu_loop_scene_light_r");
		int perfume = ((_player != null) ? _player.logicVariable.GetLogicTagValue("PerfumeValue").AsInt() : 0);
		RefreshLamps(_playerLampFx, ref _playerLampCount, _playerLampPositions, perfume, "fx_70061WuYu_loop_scene_light_l");
		CheckAndThrowBottle(num2, isBoss: true);
		CheckAndThrowBottle(perfume, isBoss: false);
		foreach (KeyValuePair<long, int> item in _layBulletPhase)
		{
			long key = item.Key;
			int value = item.Value;
			AdventureBulletBase adventureBulletBase = _actor.QueryOwnedBullet(key);
			if (adventureBulletBase == null)
			{
				continue;
			}
			TSVector2 position = adventureBulletBase.tsTransform.Position;
			if (_layBulletLastPos.TryGetValue(key, out var value2))
			{
				FP fP3 = ((value == 2) ? Skill5_BroomShoot.LayInterval_Phase2 : Skill5_BroomShoot.LayInterval_Phase3);
				if (!(TSVector2.Distance(value2, position) < fP3))
				{
					LayBulletAreaEffect(value, position, adventureBulletBase.tsTransform.Forward);
					_layBulletLastPos.set_Item(key, position);
				}
			}
		}
	}

	private void RefreshLamps(PlayFX[] lampFx, ref int currentCount, TSVector2[] positions, int perfume, string onFx)
	{
		int num = ((perfume >= 100) ? lampFx.Length : (perfume / 20 + 1));
		if (num == currentCount)
		{
			return;
		}
		if (num > currentCount)
		{
			for (int i = 0; i < num; i++)
			{
				if (lampFx[i] == null)
				{
					ILRuntimeAPI.PlayFX(ref lampFx[i], _actor, null, onFx, positions[i], FP.Zero, TSVector2.zero);
				}
			}
		}
		else
		{
			for (int j = num; j < currentCount; j++)
			{
				if (lampFx[j] != null)
				{
					ILRuntimeAPI.StopFx(lampFx[j]);
					lampFx[j] = null;
				}
			}
		}
		currentCount = num;
	}

	private void CheckAndThrowBottle(int perfume, bool isBoss)
	{
		if (perfume < 100 || _player == null)
		{
			return;
		}
		TSVector2 placeHolderPosition = CommonUtils_MonsterAPI.GetPlaceHolderPosition("BigPerfumePosition");
		if (isBoss)
		{
			if (!CommonUtils_MonsterAPI.GetLogicTagToggleValue(_actor, "BossPerfumeFullTag"))
			{
				if (_bossLandedBottleFx != null)
				{
					ILRuntimeAPI.StopFx(_bossLandedBottleFx);
					_bossLandedBottleFx = null;
				}
				if (!_bossBottleInFlight)
				{
					CommonUtils_MonsterAPI.TriggerOpLisener("UITEXT_WuYuPerfume");
					PlayFX playFX = null;
					ILRuntimeAPI.PlayFX(ref playFX, _actor, null, "fx_70061_base_perfume_gaoliang", placeHolderPosition, Config.Fx_PerfumeBottleFlashHeight, TSVector2.zero);
					TSVector2 placeHolderPosition2 = CommonUtils_MonsterAPI.GetPlaceHolderPosition("Position_BossBottleLanding");
					ILRuntimeAPI.Shoot("Weapon_70061WuYu_PerfumeBullet_WuYu", _player, default, placeHolderPosition, Config.DispelBulletShootHeight, placeHolderPosition2, null, AimType.Position, BulletDirectionType.BulletToTarget)?.ModifyBulletTag("Weapon_70061WuYu_Skill1_Bullet_Boss");
					_bossBottleInFlight = true;
					CommonUtils_MonsterAPI.SetLogicTagToggleValue(_actor, "BossPerfumeFullTag", value: true);
				}
			}
		}
		else
		{
			if (_playerBottleThrowPending)
			{
				return;
			}
			string text = null;
			FP fP = FP.MaxValue;
			foreach (string key in Config.BottleLandingMap.Keys)
			{
				if (!_playerLandedBottleFxMap.ContainsKey(key) && !_inFlightHolders.Contains(key))
				{
					FP fP2 = TSVector2.DistanceSquared(CommonUtils_MonsterAPI.GetPlaceHolderPosition(key), _player.tsTransform.Position);
					if (fP2 < fP)
					{
						fP = fP2;
						text = key;
					}
				}
			}
			if (text == null)
			{
				_player.logicVariable.SetLogicTagValue("PerfumeValue", FP.Zero);
				PerfumeHelper.FireMoWangPerfumeChange(_player, 0, 100, forceSend: true);
				return;
			}
			CommonUtils_MonsterAPI.TriggerOpLisener("UITEXT_PlayerPerfume");
			PlayFX playFX2 = null;
			ILRuntimeAPI.PlayFX(ref playFX2, _actor, null, "fx_70061_base_perfume_gaoliang", placeHolderPosition, Config.Fx_PerfumeBottleFlashHeight, TSVector2.zero);
			TSVector2 placeHolderPosition3 = CommonUtils_MonsterAPI.GetPlaceHolderPosition(text);
			PlayFX playFX3 = null;
			ILRuntimeAPI.PlayFX(ref playFX3, _actor, null, "fx_70061_base_perfume_purple", placeHolderPosition3, FP.Zero, TSVector2.zero);
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot("Weapon_70061WuYu_PerfumeBullet_Player", _player, default, placeHolderPosition, Config.DispelBulletShootHeight, placeHolderPosition3, null, AimType.Position, BulletDirectionType.BulletToTarget);
			adventureBulletBase?.ModifyBulletTag("Weapon_70061WuYu_Skill1_Bullet_Player");
			if (adventureBulletBase != null)
			{
				_inFlightHolders.Add(text);
				_bulletIdToHolder.set_Item(adventureBulletBase.Id, text);
				_playerBottleThrowPending = true;
			}
		}
	}

	private void LayBulletAreaEffect(int bulletPhase, TSVector2 pos, TSVector2 forward)
	{
		switch (bulletPhase)
		{
		case 3:
			if (_actor.QueryPositionWalkable(pos))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_70061WuYu_Skill5_BroomBulletArea", pos, forward.GetAngle());
			}
			break;
		case 2:
		{
			TSVector2 position = pos - forward * Skill5_BroomShoot.LaySideOffset_Phase2;
			if (_actor.QueryPositionWalkable(position))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_70061WuYu_Skill5_BroomBulletArea", position, forward.GetAngle());
			}
			break;
		}
		}
	}

	private void OnPlayerInput(IEvent evt)
	{
		if (!(evt is AdventureInteractiveIDTrigger adventureInteractiveIDTrigger))
		{
			return;
		}
		string text = null;
		foreach (KeyValuePair<string, (string, string)> item2 in Config.BottleLandingMap)
		{
			if (item2.Value.Item2 == adventureInteractiveIDTrigger.interactiveID)
			{
				text = item2.Key;
				break;
			}
		}
		if (text != null && !(_player == null) && _pendingDispelBulletCount <= 0 && _playerLandedBottleFxMap.TryGetValue(text, out var value))
		{
			TSVector2 placeHolderPosition = CommonUtils_MonsterAPI.GetPlaceHolderPosition(text);
			PlayFX playFX = null;
			ILRuntimeAPI.PlayFX(ref playFX, _actor, null, Config.FxPerfumeDispel, placeHolderPosition, Config.DispelBulletShootHeight, TSVector2.zero, null, 1f, 1.5f);
			ILRuntimeAPI.StopFx(value);
			_playerLandedBottleFxMap.Remove(text);
			string item = Config.BottleLandingMap.get_Item(text).Item1;
			_usedInteractiveIds.Add(item);
			Singleton<InteractiveManager>.Instance.setInteractiveObjActiveState(item, InteractiveManager.processState.deactive, null);
			ShootDispelBullet(_player, placeHolderPosition);
		}
	}

	private void ShootDispelBullet(AdventureActor shooter, TSVector2 position)
	{
		FP dispelBulletShootHeight = Config.DispelBulletShootHeight;
		LogicEntity actor = _actor;
		AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot("Weapon_70061WuYu_PerfumeAttack_Player", shooter, default, position, dispelBulletShootHeight, default, actor, AimType.Target, BulletDirectionType.BulletToTarget);
		if (!(adventureBulletBase == null))
		{
			adventureBulletBase.ModifyBulletTag("Weapon_70061WuYu_PerfumeAttack_Player");
			_pendingDispelBulletCount++;
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (!(evt is AdventureBulletFinishEvent adventureBulletFinishEvent))
		{
			return;
		}
		if (adventureBulletFinishEvent.tag == "Weapon_70061WuYu_PerfumeAttack_Player")
		{
			if (_pendingDispelBulletCount > 0)
			{
				_pendingDispelBulletCount--;
			}
			if (adventureBulletFinishEvent.finishReason != BulletFinishReason.HitActor && adventureBulletFinishEvent.finishReason != BulletFinishReason.Timeout)
			{
				return;
			}
			CommonUtils_MonsterAPI.RemoveBuffFromTarget(_actor, 700619100);
			PlayFX playFX = null;
			ILRuntimeAPI.PlayFX(ref playFX, _actor, null, Config.FxPerfumeDispel, _actor.tsTransform.Position, 0, TSVector2.zero, null, 1f, 1.5f);
			_actor.logicVariable.SetLogicTagValue("DispelStunPending", 1);
			_actor.actorSkillManage?.DestoryAllSkill();
			_actor.InterruptAttack();
			CleanupOnStun(stopSkill1SummonCoroutines: false);
			MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
			if (!(monsterAdventureActor != null))
			{
				return;
			}
			int teamId = monsterAdventureActor.monsterInfo.teamId;
			{
				foreach (int item in Config.ClearMonsterWhenDispel)
				{
					int monsterTeammateId = CommonHelper.GetMonsterTeammateId(teamId, item);
					if (monsterTeammateId > 0)
					{
						CommonUtils_MonsterAPI.KillActors(CommonUtils_MonsterAPI.GetTargetByDataID(monsterTeammateId));
					}
				}
				return;
			}
		}
		if (adventureBulletFinishEvent.tag == "Weapon_70061WuYu_Skill1_Bullet_Boss")
		{
			_bossBottleInFlight = false;
			_actor.logicVariable.SetLogicTagValue("PerfumeValue", FP.Zero);
			PerfumeHelper.FireBossPerfumeChange(_actor, 0, 100, forceSend: true);
			if (adventureBulletFinishEvent.finishReason == BulletFinishReason.HitActor || adventureBulletFinishEvent.finishReason == BulletFinishReason.Timeout)
			{
				TSVector2 placeHolderPosition = CommonUtils_MonsterAPI.GetPlaceHolderPosition("Position_BossBottleLanding");
				if (_bossLandedBottleFx != null)
				{
					ILRuntimeAPI.StopFx(_bossLandedBottleFx);
				}
				ILRuntimeAPI.PlayFX(ref _bossLandedBottleFx, _actor, null, "fx_70061_loop_perfume_purple", placeHolderPosition, FP.Zero, TSVector2.zero);
			}
		}
		else if (adventureBulletFinishEvent.tag == "Weapon_70061WuYu_Skill1_Bullet_Player")
		{
			if (!_bulletIdToHolder.TryGetValue(adventureBulletFinishEvent.id, out var value))
			{
				return;
			}
			_bulletIdToHolder.Remove(adventureBulletFinishEvent.id);
			_inFlightHolders.Remove(value);
			_playerBottleThrowPending = false;
			if (adventureBulletFinishEvent.finishReason != BulletFinishReason.HitActor && adventureBulletFinishEvent.finishReason != BulletFinishReason.Timeout)
			{
				return;
			}
			_player.logicVariable.SetLogicTagValue("PerfumeValue", FP.Zero);
			PerfumeHelper.FireMoWangPerfumeChange(_player, 0, 100, forceSend: true);
			object obj;
			if (Config.BottleLandingMap.TryGetValue(value, out (string, string) value2))
			{
				(obj, _) = value2;
			}
			else
			{
				obj = null;
			}
			string text = (string)obj;
			TSVector2 placeHolderPosition2 = CommonUtils_MonsterAPI.GetPlaceHolderPosition(value);
			if (_playerLandedBottleFxMap.TryGetValue(value, out var value3) && value3 != null)
			{
				ILRuntimeAPI.StopFx(value3);
			}
			PlayFX playFX2 = null;
			ILRuntimeAPI.PlayFX(ref playFX2, _actor, null, "fx_70061_loop_perfume", placeHolderPosition2, FP.Zero, TSVector2.zero);
			_playerLandedBottleFxMap.set_Item(value, playFX2);
			if (text != null)
			{
				if (_usedInteractiveIds.Contains(text))
				{
					Singleton<InteractiveManager>.Instance.setInteractiveObjActiveState(text, InteractiveManager.processState.active, null);
				}
				else
				{
					Singleton<InteractiveManager>.Instance.ForceActiveInterObj("", text);
				}
			}
		}
		else if (adventureBulletFinishEvent.tag == "Weapon_70061WuYu_Skill9_ExplodeBulletTag")
		{
			if (adventureBulletFinishEvent.finishReason != BulletFinishReason.Kill)
			{
				CoroutineNode cor = null;
				cor = _actor.StartLogicCoroutine(Skill9ExplodeSummonProcess(adventureBulletFinishEvent.bulletPosition, () =>
				{
					_skill9ExplodeSummonCoroutines.Remove(cor);
				}));
				_skill9ExplodeSummonCoroutines.Add(cor);
			}
		}
		else if (adventureBulletFinishEvent.tag == "Weapon_70061WuYu_Skill1_SummonBoomGhostBulletTag")
		{
			if (adventureBulletFinishEvent.finishReason != BulletFinishReason.Kill)
			{
				CoroutineNode cor2 = null;
				cor2 = _actor.StartLogicCoroutine(Skill1SummonProcess(adventureBulletFinishEvent.bulletPosition, () =>
				{
					_skill1SummonCoroutines.Remove(cor2);
				}));
				_skill1SummonCoroutines.Add(cor2);
			}
		}
		else
		{
			long id = adventureBulletFinishEvent.id;
			_layBulletLastPos.Remove(id);
			_layBulletPhase.Remove(id);
		}
	}

	private void UpdatePerk()
	{
		bool logicTagToggleValue = CommonUtils_MonsterAPI.GetLogicTagToggleValue(_actor, "Perk8TagId");
		bool logicTagToggleValue2 = CommonUtils_MonsterAPI.GetLogicTagToggleValue(_actor, "Perk9TagId");
		if (!logicTagToggleValue && !logicTagToggleValue2)
		{
			return;
		}
		List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
		if (list == null)
		{
			return;
		}
		bool flag = false;
		for (int i = 1; i < list.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = list.get_Item(i);
			if (playerAdventureActor != null && playerAdventureActor.isAssist && playerAdventureActor.actived)
			{
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			_perkTimer = FP.Zero;
			_perkAssistWasOnField = false;
			return;
		}
		PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
		if (playerAdventureActor2 == null || playerAdventureActor2.IsDead())
		{
			return;
		}
		if (!_perkAssistWasOnField)
		{
			_perkAssistWasOnField = true;
			_perkTimer = FP.Zero;
			ApplyPerk8Perk9(playerAdventureActor2, logicTagToggleValue, logicTagToggleValue2);
			return;
		}
		_perkTimer += LockStepManager.deltaTime;
		if (!(_perkTimer < FP.One))
		{
			_perkTimer -= FP.One;
			ApplyPerk8Perk9(playerAdventureActor2, logicTagToggleValue, logicTagToggleValue2);
		}
	}

	private void ApplyPerk8Perk9(AdventureActor player, bool hasPerk8, bool hasPerk9)
	{
		if (hasPerk8)
		{
			player.actorShield?.AddShield(709054081, _actor);
			player.buffComponent?.AddBuff(709054080, _actor);
		}
		if (hasPerk9)
		{
			player.buffComponent?.AddBuff(709054090, _actor);
		}
	}

	private void OnCanCauseDead(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageCanCauseDeadEvent adventureActorReceiveDamageCanCauseDeadEvent))
		{
			return;
		}
		if (adventureActorReceiveDamageCanCauseDeadEvent.to as AdventureActor == _actor)
		{
			OnSelfCanCauseDead();
		}
		else if (!_perk35Consumed && CommonUtils_MonsterAPI.GetLogicTagToggleValue(_actor, "Perk35TagId"))
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
			if (!(adventureActorReceiveDamageCanCauseDeadEvent.to as AdventureActor != playerAdventureActor))
			{
				playerAdventureActor.EnableDeadImmunity();
			}
		}
	}

	private void OnSelfCanCauseDead()
	{
		if (_selfDeadCleanupDone)
		{
			return;
		}
		_selfDeadCleanupDone = true;
		CleanupOnStun();
		CommonUtils_MonsterAPI.ClearActors(CommonUtils_MonsterAPI.GetTargetsByFaction(_actor, isFriend: true));
		List<AdventureBulletBase> list = new List<AdventureBulletBase>();
		_actor.QueryOwnedAliveBullets(list);
		foreach (AdventureBulletBase item in list)
		{
			item?.Finish(cancel: true);
		}
	}

	private void OnPerk35DeadImmunity(IEvent evt)
	{
		if (!_perk35Consumed && CommonUtils_MonsterAPI.GetLogicTagToggleValue(_actor, "Perk35TagId") && evt is AdventureActorDeadImmunityEvent adventureActorDeadImmunityEvent)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
			if (!(playerAdventureActor == null) && !(adventureActorDeadImmunityEvent.to as AdventureActor != playerAdventureActor))
			{
				_perk35Consumed = true;
				_perk35Coroutine = _actor.StartLogicCoroutine(Perk35PostImmune(playerAdventureActor));
			}
		}
	}

	private IEnumerator Perk35PostImmune(AdventureActor player)
	{
		player.LockHpAbs(1L);
		List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = list.get_Item(i);
				if (!(playerAdventureActor == null) && !playerAdventureActor.IsDead() && !(playerAdventureActor.buffComponent == null))
				{
					playerAdventureActor.buffComponent.AddBuff(709054350, _actor);
				}
			}
		}
		yield return _actor.WaitTime(Config.Perk35_ImmuneDeadDuration);
		player.UnlockHp();
		player.DisableDeadImmunity();
		_perk35Coroutine = null;
	}
}
