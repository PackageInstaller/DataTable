using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_ZhuNengGuangXian_JuXingMoXiang : SkillSimpleBase
{
	private const string combo_ZhuNengGuangXian_P2 = "NLQPhase2";

	private TSVector2 fieldCenter = new TSVector2(0, 0);

	private const int conduitCount = 2;

	private readonly TSVector2[] conduitFixedPositions = new TSVector2[2]
	{
		new TSVector2(-8, 8),
		new TSVector2(8, 8)
	};

	private FP conduitLifespan = 10;

	private FP energyChargeRate = 5;

	private FP beamWidth = 1.5;

	private FP chargingThreshold = 5;

	private FP phantomSpawnInterval = 3;

	private FP phantomRingInnerRadius = 6;

	private FP phantomRingOuterRadius = 9;

	private const int phantomMaxCount = 4;

	private const string beamFxAlias_A = "fx_m72011_loop_Skill5_link_5";

	private readonly FP getDamageBuffInterval = 1;

	private const string playerBlockBeamTag = "ZhuNengGuangXian_PlayerBlockBeam";

	private List<PlayFX> _beamFxList = new List<PlayFX>();

	private List<bool> _beamFxBlockedList = new List<bool>();

	private List<AdventureActor> _conduits = new List<AdventureActor>();

	private List<FP> _conduitAccumList = new List<FP>();

	private SummonCfg _summonCfg;

	private bool finished;

	private int _summonLevel;

	private int _conduitId;

	private int _phantomId;

	private int _damageBuffId;

	private int _damageReductionBuffId;

	private int _vulnerableBuffId;

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
		_conduits.Clear();
		_conduitAccumList.Clear();
		BeginLookAtByPos_NotWait(fieldCenter);
		BeginAttack(1, "NLQPhase2", flushInputedKeys: true);
		yield return WaitTime(2);
		for (int i = 0; i < 2; i++)
		{
			SummonConduit(i);
		}
		yield return WaitTime(0.8);
		_conduits.Clear();
		foreach (LogicEntity item2 in GetTargetByDataID(_conduitId))
		{
			if (item2 is AdventureActor item)
			{
				_conduits.Add(item);
			}
		}
		_conduitAccumList.Clear();
		for (int j = 0; j < _conduits.Count; j++)
		{
			_conduitAccumList.Add(FP.Zero);
		}
		StartBeamFxes();
		yield return StartCor(ChannelingLoop());
		StopBeamFxes();
		CancelAttack();
		DispatchCustomEvent("StopEnergyLine", isSelfEvent: false);
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator ChannelingLoop()
	{
		FP lastTime = LockStepManager.time;
		while (!AllConduitsDead())
		{
			FP time = LockStepManager.time;
			FP fP = time - lastTime;
			lastTime = time;
			TSVector2 position = GetPosition();
			LogicEntity currentPlayer = GetCurrentPlayer();
			bool flag = false;
			for (int i = 0; i < _conduits.Count; i++)
			{
				AdventureActor adventureActor = _conduits.get_Item(i);
				if (adventureActor == null || adventureActor.IsDead())
				{
					if (i < _beamFxList.Count && _beamFxList.get_Item(i) != null)
					{
						_beamFxList.get_Item(i).Stop(dontPlaySubFX: true);
						_beamFxList.get_Item(i).Clear();
						_beamFxList.set_Item(i, (PlayFX)null);
					}
					continue;
				}
				TSVector2 entityPosition = GetEntityPosition(adventureActor);
				bool flag2 = IsPlayerInBeam(entityPosition, position);
				if (i < _beamFxBlockedList.Count && flag2 != _beamFxBlockedList.get_Item(i))
				{
					_beamFxBlockedList.set_Item(i, flag2);
					RecreateBeamFx(i, flag2);
				}
				if (!flag2)
				{
					FP logicTagFpValue = GetLogicTagFpValue(_actor, Config_JuXingMoXiang.EnergyTag);
					FP fP2 = logicTagFpValue + energyChargeRate * fP;
					if (fP2 > 100)
					{
						fP2 = 100;
					}
					SetLogicTagFpValue(_actor, Config_JuXingMoXiang.EnergyTag, fP2);
					BossEnergyValueChage((int)(long)fP2, _actor);
					if (GetLogicTagFpValue(_actor, Common_73001.EnergyToReductionEnabledTag) == 1 && Common_73001.TryAddDamageReductionByEnergyGain(_actor, fP2 - logicTagFpValue, _damageReductionBuffId, _vulnerableBuffId, 8))
					{
						PlayFx("fx_m72012_base_Shield", 1f, default, GetPosition(), default);
					}
					if (i < _conduitAccumList.Count)
					{
						_conduitAccumList.get_Item(i) += fP;
						if (_conduitAccumList.get_Item(i) >= chargingThreshold)
						{
							_conduitAccumList.set_Item(i, FP.Zero);
							AddBossDamageReductionBuff();
						}
					}
				}
				else
				{
					flag = true;
				}
			}
			if (flag)
			{
				OnPlayerBlockBeam(currentPlayer, fP);
			}
			else if (currentPlayer != null && !currentPlayer.IsDead())
			{
				SetLogicTagFpValue(currentPlayer, "ZhuNengGuangXian_PlayerBlockBeam", FP.Zero);
			}
			yield return null;
		}
	}

	private bool AllConduitsDead()
	{
		for (int i = 0; i < _conduits.Count; i++)
		{
			if (_conduits.get_Item(i) != null && !_conduits.get_Item(i).IsDead())
			{
				return false;
			}
		}
		return true;
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

	private void StartBeamFxes()
	{
		_beamFxList.Clear();
		_beamFxBlockedList.Clear();
		GameObject gameObject = _actor.gameObject;
		for (int i = 0; i < _conduits.Count; i++)
		{
			AdventureActor adventureActor = _conduits.get_Item(i);
			if (adventureActor == null || adventureActor.IsDead())
			{
				_beamFxList.Add(null);
				_beamFxBlockedList.Add(item: false);
				continue;
			}
			TSVector2 entityPosition = GetEntityPosition(adventureActor);
			PlayFX playFX = PlayLinkFX(sourcePosition: new TSVector(entityPosition.x, 0, entityPosition.y), fxAlias: "fx_m72011_loop_Skill5_link_5", useCustomSource: true, source: adventureActor.gameObject, sourcePositionY: FP.Zero, targetObj: gameObject, targetPosition: TSVector.zero, targetPositionY: FP.Zero);
			playFX?.fxInstance?.Bind(_actor.gameObject);
			_beamFxList.Add(playFX);
			_beamFxBlockedList.Add(item: false);
		}
	}

	private void StopBeamFxes()
	{
		for (int i = 0; i < _beamFxList.Count; i++)
		{
			_beamFxList.get_Item(i)?.Stop();
			_beamFxList.get_Item(i)?.Clear();
		}
		_beamFxList.Clear();
		_beamFxBlockedList.Clear();
	}

	private void RecreateBeamFx(int i, bool blocked)
	{
		if (i >= _beamFxList.Count)
		{
			return;
		}
		_beamFxList.get_Item(i)?.Stop(dontPlaySubFX: true);
		_beamFxList.get_Item(i)?.Clear();
		_beamFxList.set_Item(i, (PlayFX)null);
		AdventureActor adventureActor = ((i < _conduits.Count) ? _conduits.get_Item(i) : null);
		if (!(adventureActor == null) && !adventureActor.IsDead())
		{
			TSVector2 entityPosition = GetEntityPosition(adventureActor);
			TSVector sourcePosition = new TSVector(entityPosition.x, 0, entityPosition.y);
			GameObject gameObject = ((!blocked) ? _actor.gameObject : GetCurrentPlayer()?.gameObject);
			if (!(gameObject == null))
			{
				_beamFxList.set_Item(i, PlayLinkFX("fx_m72011_loop_Skill5_link_5", useCustomSource: true, adventureActor.gameObject, sourcePosition, FP.Zero, gameObject, TSVector.zero, FP.Zero));
				_beamFxList.get_Item(i)?.fxInstance?.Bind(_actor.gameObject);
			}
		}
	}

	private void SummonConduit(int index)
	{
		TSVector2 tSVector = conduitFixedPositions[index % conduitFixedPositions.Length];
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
			yield return WaitTime(phantomSpawnInterval);
			if (GetTargetByDataID(_phantomId).Count < 4)
			{
				LogicEntity currentPlayer = GetCurrentPlayer();
				Skill_ZhuNengGuangXian_JuXingMoXiang skill_ZhuNengGuangXian_JuXingMoXiang = this;
				TSVector2 position = GetPosition();
				FP radius = phantomRingOuterRadius;
				FP innerRadius = phantomRingInnerRadius;
				DeterministicShape shapeData = skill_ZhuNengGuangXian_JuXingMoXiang.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
				TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
				TSVector2 spawnDirection = ((currentPlayer != null) ? (GetEntityPosition(currentPlayer) - shapeRandomPoint) : TSVector2.up);
				SummonMonster(_phantomId, 0, shapeRandomPoint, spawnDirection);
			}
		}
	}

	private void AddBossDamageReductionBuff()
	{
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		int num = ((monsterAdventureActor != null && monsterAdventureActor.buffComponent != null) ? monsterAdventureActor.buffComponent.GetBuffNumByID(_damageReductionBuffId) : 0);
		if (Common_73001.TryAddDamageReduction(monsterAdventureActor, _damageReductionBuffId, _vulnerableBuffId, 8))
		{
			FP logicTagFpValue = GetLogicTagFpValue(_actor, Common_73001.EnergyTag);
			FP fP = logicTagFpValue + 5;
			if (fP > 100)
			{
				fP = 100;
			}
			SetLogicTagFpValue(_actor, Common_73001.EnergyTag, fP);
			BossEnergyValueChage((int)(long)fP, _actor);
			if (GetLogicTagFpValue(_actor, Common_73001.EnergyToReductionEnabledTag) == 1)
			{
				Common_73001.TryAddDamageReductionByEnergyGain(_actor, fP - logicTagFpValue, _damageReductionBuffId, _vulnerableBuffId, 8);
			}
		}
		if (((monsterAdventureActor != null && monsterAdventureActor.buffComponent != null) ? monsterAdventureActor.buffComponent.GetBuffNumByID(_damageReductionBuffId) : 0) > num)
		{
			PlayFx("fx_m72012_base_Shield", 1f, default, GetPosition(), default);
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
			}
		}
		SetLogicTagFpValue(player, "ZhuNengGuangXian_PlayerBlockBeam", logicTagFpValue);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		DispatchCustomEvent("StopEnergyLine", isSelfEvent: false);
		StopBeamFxes();
		_conduits.Clear();
		_conduitAccumList.Clear();
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
		DispatchCustomEvent("StopEnergyLine", isSelfEvent: false);
		StopBeamFxes();
		ClearOwnerBullet();
		ClearActors(GetTargetByDataID(_conduitId));
		ClearActors(GetTargetByDataID(_phantomId));
	}
}
