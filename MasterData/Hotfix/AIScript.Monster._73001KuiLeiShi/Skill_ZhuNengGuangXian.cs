using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using TrueSync.Physics2D;
using UnityEngine;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_ZhuNengGuangXian : SkillSimpleBase
{
	private const string combo_ZhuNengGuangXian = "ZhuNengGuangXian";

	private const string combo_Teleport = "Teleport";

	private TSVector2 bossTeleportPos = new TSVector2(0, 0);

	private TSVector2 juXingAppearPos = new TSVector2(0, 15);

	private FP conduitRingInnerRadius = 3;

	private FP conduitRingOuterRadius = 7;

	private FP conduitLifespan = 10;

	private FP energyChargeRate = 5;

	private FP beamWidth = 2;

	private FP chargingThreshold = 1;

	private FP phantomSpawnInterval = 5;

	public static readonly List<TSVector2> phantomSpawnPoints = new List<TSVector2>
	{
		new TSVector2(0, -5),
		new TSVector2(5, -5),
		new TSVector2(-5, -5)
	};

	private FP phantomRingInnerRadius = 4;

	private FP phantomRingOuterRadius = 9;

	private const string beamFxAlias_A = "fx_m72011_loop_Skill5_link_3";

	private const string beamFxAlias_B = "fx_m72011_loop_Skill5_link_1";

	private readonly FP getDamageBuffInterval = 1;

	private const int phantomMaxCount = 4;

	private const string chargingAccumTag = "ZhuNengGuangXian_ChargingAccum";

	private PlayFX _beamFxA;

	private PlayFX _beamFxB;

	private bool _beamFxABlocked;

	private bool _beamFxBBlocked;

	private AdventureActor _conduit;

	private SummonCfg _summonCfg;

	private const string playerBlockBeamTag = "ZhuNengGuangXian_PlayerBlockBeam";

	private int spawnIndex;

	private bool finished;

	private int _summonLevel;

	private int _conduitId;

	private int _phantomId;

	private int _damageBuffId;

	private int _damageReductionBuffId;

	private int _vulnerableBuffId;

	private CoroutineNode phantomCor;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_conduitId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.zhuNengKuiLeiMonsterIds);
		_phantomId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.zhuNengPhantomMonsterIds);
		_damageBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.damageBuffIds);
		_damageReductionBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.damageReductionBuffIds);
		_vulnerableBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.vulnerableBuffIds);
	}

	protected override IEnumerator DoMainLogic()
	{
		spawnIndex = 0;
		SetLogicTagFpValue(_actor, "ZhuNengGuangXian_ChargingAccum", FP.Zero);
		DispatchGiantGolemAppear();
		BeginAttack(1, "Teleport", flushInputedKeys: true);
		yield return WaitCustomEvent("TeleportStart");
		Teleport(bossTeleportPos);
		yield return WaitTime(0.1f);
		BeginLookAtByPos_NotWait(juXingAppearPos, default, 2000);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SummonConduit();
		BeginAttack(1, "ZhuNengGuangXian", flushInputedKeys: true);
		yield return WaitCustomEvent("StartCharging");
		_conduit = null;
		while (_conduit == null)
		{
			yield return null;
			List<LogicEntity> targetByDataID = GetTargetByDataID(_conduitId);
			_conduit = ((targetByDataID.Count > 0) ? (targetByDataID.get_Item(0) as AdventureActor) : null);
		}
		StartBeamFx();
		phantomCor = StartCor(PhantomSpawnLoop());
		yield return StartCor(ChannelingLoop());
		StopSpawnCoroutines();
		StopBeamFx();
		CancelAttack();
		DispatchCustomEvent("StopEnergyLine", isSelfEvent: false);
		SetLogicTagFpValue(_actor, "ZhuNengGuangXian_ChargingAccum", FP.Zero);
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator ChannelingLoop()
	{
		FP lastTime = LockStepManager.time;
		while (_conduit != null && !_conduit.IsDead())
		{
			FP time = LockStepManager.time;
			FP fP = time - lastTime;
			lastTime = time;
			TSVector2 position = GetPosition();
			bool flag = GetConduitPos(out var pos) && IsPlayerInBeam(pos, position);
			bool flag2 = IsPlayerInBeam(position, juXingAppearPos);
			if (flag != _beamFxABlocked)
			{
				_beamFxABlocked = flag;
				RecreateBeamFxA(flag);
			}
			if (flag)
			{
				if (_beamFxB?.fxInstance != null)
				{
					_beamFxB.Stop(dontPlaySubFX: true);
					_beamFxB.Clear();
					_beamFxB = null;
					_beamFxBBlocked = false;
				}
			}
			else if (_beamFxB?.fxInstance == null)
			{
				_beamFxBBlocked = flag2;
				RecreateBeamFxB(flag2);
			}
			else if (flag2 != _beamFxBBlocked)
			{
				_beamFxBBlocked = flag2;
				RecreateBeamFxB(flag2);
			}
			LogicEntity currentPlayer = GetCurrentPlayer();
			if (!flag && !flag2)
			{
				if (currentPlayer != null && !currentPlayer.IsDead())
				{
					SetLogicTagFpValue(currentPlayer, "ZhuNengGuangXian_PlayerBlockBeam", FP.Zero);
				}
				AdventureActor juXingActor = GetJuXingActor();
				if (juXingActor != null)
				{
					FP logicTagFpValue = GetLogicTagFpValue(juXingActor, Config_JuXingMoXiang.EnergyTag);
					FP fP2 = logicTagFpValue + energyChargeRate * fP;
					if (fP2 > 100)
					{
						fP2 = 100;
					}
					SetLogicTagFpValue(juXingActor, Config_JuXingMoXiang.EnergyTag, fP2);
					BossEnergyValueChage((int)(long)fP2, _actor);
					if (GetLogicTagFpValue(_actor, Common_73001.EnergyToReductionEnabledTag) == 1 && Common_73001.TryAddDamageReductionByEnergyGain(_actor, fP2 - logicTagFpValue, _damageReductionBuffId, _vulnerableBuffId, 8))
					{
						PlayFx("fx_m72011_base_Shield", 1f, default, GetPosition(), default);
					}
				}
				FP fP3 = GetLogicTagFpValue(_actor, "ZhuNengGuangXian_ChargingAccum") + fP;
				SetLogicTagFpValue(_actor, "ZhuNengGuangXian_ChargingAccum", fP3);
				if (fP3 >= chargingThreshold)
				{
					SetLogicTagFpValue(_actor, "ZhuNengGuangXian_ChargingAccum", FP.Zero);
					AddBossDamageReductionBuff();
				}
			}
			else
			{
				OnPlayerBlockBeam(currentPlayer, fP);
			}
			yield return null;
		}
	}

	private bool IsPlayerInBeam(TSVector2 from, TSVector2 to)
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (currentPlayer == null)
		{
			return false;
		}
		TSVector2 entityPosition = GetEntityPosition(currentPlayer);
		TSVector2 tSVector = to - from;
		FP magnitude = tSVector.magnitude;
		if (magnitude <= FP.Zero)
		{
			return false;
		}
		TSVector2 tSVector2 = tSVector / magnitude;
		FP fP = TSVector2.Dot(entityPosition - from, tSVector2);
		if (fP < FP.Zero || fP > magnitude)
		{
			return false;
		}
		return TSVector2.Distance(entityPosition, from + tSVector2 * fP) <= beamWidth / 2;
	}

	private bool GetConduitPos(out TSVector2 pos)
	{
		pos = TSVector2.zero;
		if (_conduit == null || _conduit.IsDead())
		{
			return false;
		}
		pos = GetEntityPosition(_conduit);
		return true;
	}

	private void StartBeamFx()
	{
		GameObject gameObject = ((_conduit != null) ? _conduit.gameObject : null);
		if (gameObject != null)
		{
			GetConduitPos(out var pos);
			TSVector sourcePosition = new TSVector(pos.x, 0, pos.y);
			_beamFxA = PlayLinkFX("fx_m72011_loop_Skill5_link_3", useCustomSource: true, gameObject, sourcePosition, 0, _actor.gameObject, TSVector.zero, 0);
			_beamFxA?.fxInstance?.Bind(_actor.gameObject);
		}
		GameObject targetObj = GetJuXingActor()?.gameObject;
		_beamFxB = PlayLinkFX("fx_m72011_loop_Skill5_link_1", useCustomSource: false, _actor.gameObject, TSVector.zero, 0, targetObj, new TSVector(juXingAppearPos.x, 0, juXingAppearPos.y), 0);
		_beamFxB?.fxInstance?.Bind(_actor.gameObject);
		_beamFxABlocked = false;
		_beamFxBBlocked = false;
	}

	private void RecreateBeamFxA(bool blocked)
	{
		_beamFxA?.Stop(dontPlaySubFX: true);
		_beamFxA?.Clear();
		_beamFxA = null;
		GameObject gameObject = _conduit?.gameObject;
		if (!(gameObject == null))
		{
			GetConduitPos(out var pos);
			TSVector sourcePosition = new TSVector(pos.x, 0, pos.y);
			GameObject gameObject2 = ((!blocked) ? _actor.gameObject : GetCurrentPlayer()?.gameObject);
			if (!(gameObject2 == null))
			{
				_beamFxA = PlayLinkFX("fx_m72011_loop_Skill5_link_3", useCustomSource: true, gameObject, sourcePosition, 0, gameObject2, TSVector.zero, 0);
				_beamFxA?.fxInstance?.Bind(_actor.gameObject);
			}
		}
	}

	private void RecreateBeamFxB(bool blocked)
	{
		_beamFxB?.Stop(dontPlaySubFX: true);
		_beamFxB?.Clear();
		_beamFxB = null;
		GameObject gameObject = GetJuXingActor()?.gameObject;
		GameObject gameObject2 = ((!blocked) ? gameObject : GetCurrentPlayer()?.gameObject);
		if (!(gameObject2 == null))
		{
			TSVector targetPosition = (blocked ? TSVector.zero : new TSVector(juXingAppearPos.x, 0, juXingAppearPos.y));
			_beamFxB = PlayLinkFX("fx_m72011_loop_Skill5_link_1", useCustomSource: false, _actor.gameObject, TSVector.zero, 0, gameObject2, targetPosition, 0);
			_beamFxB?.fxInstance?.Bind(_actor.gameObject);
		}
	}

	private void StopBeamFx()
	{
		_beamFxA?.Stop(dontPlaySubFX: true);
		_beamFxA?.Clear();
		_beamFxA = null;
		_beamFxB?.Stop(dontPlaySubFX: true);
		_beamFxB?.Clear();
		_beamFxB = null;
	}

	private void SummonConduit()
	{
		TSVector2 position = GetPosition();
		FP radius = conduitRingOuterRadius;
		FP innerRadius = conduitRingInnerRadius;
		GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
		TSVector2 tSVector = ((TSRandom.Range(0, 2) == 0) ? new TSVector2(10, 0) : new TSVector2(-10, 0));
		if (_summonCfg == null)
		{
			_summonCfg = new SummonCfg
			{
				leftTime = conduitLifespan
			};
		}
		ILRuntimeAPI.SummonMonster(_actor, 0, _conduitId, tSVector, GetPosition() - tSVector, _summonCfg);
	}

	private IEnumerator PhantomSpawnLoop()
	{
		while (true)
		{
			if (GetTargetByDataID(_phantomId).Count < 4)
			{
				LogicEntity currentPlayer = GetCurrentPlayer();
				Skill_ZhuNengGuangXian skill_ZhuNengGuangXian = this;
				TSVector2 position = GetPosition();
				FP radius = phantomRingOuterRadius;
				FP innerRadius = phantomRingInnerRadius;
				DeterministicShape shapeData = skill_ZhuNengGuangXian.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
				TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
				spawnIndex %= phantomSpawnPoints.Count;
				spawnIndex = MathUtils.Clamp(0, phantomSpawnPoints.Count, spawnIndex);
				TSVector2 spawnDirection = ((currentPlayer != null) ? (GetEntityPosition(currentPlayer) - shapeRandomPoint) : TSVector2.up);
				SummonMonster(_phantomId, 0, shapeRandomPoint, spawnDirection);
				yield return WaitTime(phantomSpawnInterval);
			}
		}
	}

	private void DispatchGiantGolemAppear()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config_JuXingMoXiang.evt_GiantGolemAppear;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	private AdventureActor GetJuXingActor()
	{
		int dataID = (int)(long)GetLogicTagFpValue(_actor, Config_JuXingMoXiang.SelfDataIdTag);
		List<LogicEntity> targetByDataID = GetTargetByDataID(dataID);
		if (targetByDataID.Count <= 0)
		{
			return null;
		}
		return targetByDataID.get_Item(0) as AdventureActor;
	}

	private AdventureActor GetDamageReductionBuffTarget()
	{
		return _actor;
	}

	private void AddBossDamageReductionBuff()
	{
		AdventureActor damageReductionBuffTarget = GetDamageReductionBuffTarget();
		BuffCom buffCom = damageReductionBuffTarget?.buffComponent;
		if (buffCom != null && buffCom.GetBuffNumByID(_vulnerableBuffId) > 0)
		{
			Common_73001.TryRemoveBuffOrAddBuff(damageReductionBuffTarget, _vulnerableBuffId, _damageReductionBuffId);
		}
		else if (buffCom != null && buffCom.GetBuffNumByID(_damageReductionBuffId) >= 8)
		{
			AdventureActor juXingActor = GetJuXingActor();
			if (juXingActor != null)
			{
				FP logicTagFpValue = GetLogicTagFpValue(juXingActor, Common_73001.EnergyTag);
				FP fP = logicTagFpValue + 5;
				if (fP > 100)
				{
					fP = 100;
				}
				SetLogicTagFpValue(juXingActor, Common_73001.EnergyTag, fP);
				BossEnergyValueChage((int)(long)fP, _actor);
				if (GetLogicTagFpValue(_actor, Common_73001.EnergyToReductionEnabledTag) == 1)
				{
					Common_73001.TryAddDamageReductionByEnergyGain(_actor, fP - logicTagFpValue, _damageReductionBuffId, _vulnerableBuffId, 8);
				}
			}
		}
		else
		{
			Common_73001.TryRemoveBuffOrAddBuff(damageReductionBuffTarget, _vulnerableBuffId, _damageReductionBuffId);
			PlayFx("fx_m72011_base_Shield", 1f, default, GetPosition(), default);
		}
	}

	private void OnPlayerBlockBeam(LogicEntity player, FP deltaTime)
	{
		if (player == null || player.IsDead())
		{
			return;
		}
		FP logicTagFpValue = GetLogicTagFpValue(player, "ZhuNengGuangXian_PlayerBlockBeam");
		logicTagFpValue += deltaTime;
		if (logicTagFpValue >= getDamageBuffInterval)
		{
			logicTagFpValue -= getDamageBuffInterval;
			if (player is AdventureActor)
			{
				List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
				if (list != null)
				{
					foreach (PlayerAdventureActor item in list)
					{
						item?.buffComponent?.AddBuff(_damageBuffId, _actor);
					}
				}
				Common_73001.TryRemoveBuffOrAddBuff(GetDamageReductionBuffTarget(), _damageReductionBuffId, _vulnerableBuffId);
			}
		}
		SetLogicTagFpValue(player, "ZhuNengGuangXian_PlayerBlockBeam", logicTagFpValue);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopBeamFx();
		_beamFxABlocked = false;
		_beamFxBBlocked = false;
		spawnIndex = 0;
		_conduit = null;
		DispatchCustomEvent("StopEnergyLine", isSelfEvent: false);
		StopSpawnCoroutines();
		if (!finished)
		{
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_conduitId));
			ClearActors(GetTargetByDataID(_phantomId));
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		StopBeamFx();
		DispatchCustomEvent("StopEnergyLine", isSelfEvent: false);
		StopSpawnCoroutines();
		ClearOwnerBullet();
		ClearActors(GetTargetByDataID(_conduitId));
		ClearActors(GetTargetByDataID(_phantomId));
	}

	private void StopSpawnCoroutines()
	{
		if (phantomCor != null)
		{
			StopCor(phantomCor);
			phantomCor = null;
		}
	}
}
