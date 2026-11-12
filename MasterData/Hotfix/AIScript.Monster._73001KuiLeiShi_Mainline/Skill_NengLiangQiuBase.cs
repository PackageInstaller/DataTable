using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public abstract class Skill_NengLiangQiuBase : SkillSimpleBase
{
	protected static readonly int[] nengLiangQiuMonsterIds;

	protected FP orbSpawnInterval = 0.5f;

	protected int orbSpawnCount = 8;

	protected string[] orbPlaceholderNames = new string[9] { "P2_Nv_Skill5_1", "P2_Nv_Skill5_2", "P2_Nv_Skill5_3", "P2_Nv_Skill5_4", "P2_Nv_Skill5_5", "P2_Nv_Skill5_6", "P2_Nv_Skill5_7", "P2_Nv_Skill5_8", "P2_Nv_Skill5_9" };

	protected FP orbSpawnInnerRadius = 0;

	protected FP orbSpawnOuterRadius = 3;

	protected FP orbSpawnRadius = 8;

	protected FP orbMinDist = 3;

	protected const int orbSpawnMaxRetry = 10;

	protected const int orbMaxCount = 8;

	protected static readonly int[] phantomMonsterIds;

	protected FP phantomSpawnInterval = 2;

	protected int phantomSpawnCount = 3;

	protected string[] phantomPlaceholderNames = new string[8] { "P2_Nv_Skill5_1", "P2_Nv_Skill5_3", "P2_Nv_Skill5_4", "P2_Nv_Skill5_5", "P2_Nv_Skill5_6", "P2_Nv_Skill5_7", "P2_Nv_Skill5_8", "P2_Nv_Skill5_9" };

	protected FP phantomSpawnInnerRadius = 1;

	protected FP phantomSpawnOuterRadius = 3;

	protected FP phantomSpawnRadius = 9;

	protected FP phantomMinDist = 5;

	protected const int phantomSpawnMaxRetry = 10;

	protected const int phantomMaxCount = 5;

	protected FP phantomExcludeRadius = 10;

	protected const int playerAbsorbThreshold = 1;

	protected const int juXingAbsorbThreshold = 1;

	protected string juXingAbsorbAreaEffect = "AreaEffect_72012_Skill1_LiPao";

	protected int _summonLevel;

	protected int _orbId;

	protected int _phantomId;

	protected int _playerDamageUpBuffId;

	protected int _damageReductionBuffId;

	protected int _vulnerableBuffId;

	protected abstract AdventureActor GetBossActor();

	protected abstract AdventureActor GetEnergyTarget();

	protected virtual void PlayDamageReductionAddedFx(AdventureActor boss)
	{
	}

	protected virtual void PlayDamageReductionRemovedFx(AdventureActor boss, AdventureActor player)
	{
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		if (_summonLevel <= 2)
		{
			orbSpawnCount = 6;
		}
		_orbId = Common_73001.GetMonsterIdByLevel(_summonLevel, nengLiangQiuMonsterIds);
		_phantomId = Common_73001.GetMonsterIdByLevel(_summonLevel, phantomMonsterIds);
		_playerDamageUpBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.orbPlayerDamageUpBuffIds);
		_damageReductionBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.damageReductionBuffIds);
		_vulnerableBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.vulnerableBuffIds);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnOrbEvent);
	}

	protected override void OnSkillDisable()
	{
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnOrbEvent);
		base.OnSkillDisable();
	}

	protected void InitNLQState()
	{
		SetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_PlayerAbsorbCountTag, FP.Zero);
		SetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_JuXingAbsorbCountTag, FP.Zero);
		SetLogicTagToggleValue(_actor, Config_XiaoMoXiang.NLQ_PullStartTag, value: false);
	}

	protected IEnumerator OrbSpawnLoop()
	{
		List<TSVector2> spawnedPositions = new List<TSVector2>();
		FP minDistSq = orbMinDist * orbMinDist;
		int[] shuffledIndices = null;
		if (orbPlaceholderNames != null && orbPlaceholderNames.Length != 0)
		{
			shuffledIndices = ShufflePlaceholderIndices(orbPlaceholderNames.Length);
		}
		for (int i = 0; i < orbSpawnCount; i++)
		{
			if (GetTargetByDataID(_orbId).Count >= 8)
			{
				continue;
			}
			int placeholderIdx = -1;
			if (shuffledIndices != null)
			{
				if (i > 0 && i % orbPlaceholderNames.Length == 0)
				{
					shuffledIndices = ShufflePlaceholderIndices(orbPlaceholderNames.Length);
				}
				placeholderIdx = shuffledIndices[i % orbPlaceholderNames.Length];
			}
			TSVector2 tSVector = PickOrbPosition(spawnedPositions, minDistSq, placeholderIdx);
			spawnedPositions.Add(tSVector);
			SummonMonster(_orbId, 0, tSVector, TSVector2.up);
			yield return WaitTime(orbSpawnInterval);
		}
	}

	private int[] ShufflePlaceholderIndices(int length)
	{
		int[] array = new int[length];
		for (int i = 0; i < length; i++)
		{
			array[i] = i;
		}
		for (int num = length - 1; num > 0; num--)
		{
			int num2 = TSRandom.Range(0, num);
			ref int reference = ref array[num];
			ref int reference2 = ref array[num2];
			int num3 = array[num2];
			int num4 = array[num];
			reference = num3;
			reference2 = num4;
		}
		return array;
	}

	private TSVector2 PickOrbPosition(List<TSVector2> placed, FP minDistSq, int placeholderIdx)
	{
		TSVector2 result = TSVector2.zero;
		for (int i = 0; i < 10; i++)
		{
			TSVector2 shapeRandomPoint;
			if (placeholderIdx >= 0)
			{
				TSVector2 placeHolderPosition = GetPlaceHolderPosition(orbPlaceholderNames[placeholderIdx]);
				FP radius = orbSpawnOuterRadius;
				FP innerRadius = orbSpawnInnerRadius;
				DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, placeHolderPosition, default, default, radius, innerRadius);
				shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			}
			else
			{
				TSVector2 position = GetPosition();
				FP innerRadius = orbSpawnRadius;
				DeterministicShape shapeData2 = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, innerRadius);
				shapeRandomPoint = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
			}
			result = shapeRandomPoint;
			bool flag = false;
			for (int j = 0; j < placed.Count; j++)
			{
				if (TSVector2.DistanceSquared(shapeRandomPoint, placed.get_Item(j)) < minDistSq)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				return shapeRandomPoint;
			}
		}
		return result;
	}

	protected IEnumerator PhantomSpawnLoop()
	{
		List<TSVector2> spawnedPositions = new List<TSVector2>();
		FP minDistSq = phantomMinDist * phantomMinDist;
		int[] shuffledIndices = null;
		if (phantomPlaceholderNames != null && phantomPlaceholderNames.Length != 0)
		{
			shuffledIndices = ShufflePlaceholderIndices(phantomPlaceholderNames.Length);
		}
		for (int i = 0; i < phantomSpawnCount; i++)
		{
			if (GetTargetByDataID(_phantomId).Count >= 5)
			{
				continue;
			}
			int placeholderIdx = -1;
			if (shuffledIndices != null)
			{
				if (i > 0 && i % phantomPlaceholderNames.Length == 0)
				{
					shuffledIndices = ShufflePlaceholderIndices(phantomPlaceholderNames.Length);
				}
				placeholderIdx = shuffledIndices[i % phantomPlaceholderNames.Length];
			}
			TSVector2 tSVector = PickPhantomPosition(spawnedPositions, minDistSq, placeholderIdx);
			spawnedPositions.Add(tSVector);
			LogicEntity currentPlayer = GetCurrentPlayer();
			TSVector2 spawnDirection = ((currentPlayer != null) ? (GetEntityPosition(currentPlayer) - tSVector) : TSVector2.up);
			SummonMonster(_phantomId, 0, tSVector, spawnDirection);
			yield return WaitTime(phantomSpawnInterval);
		}
	}

	private TSVector2 PickPhantomPosition(List<TSVector2> placed, FP minDistSq, int placeholderIdx)
	{
		AdventureActor energyTarget = GetEnergyTarget();
		bool flag = energyTarget != null && !energyTarget.isDead;
		TSVector2 value = (flag ? GetEntityPosition(energyTarget) : TSVector2.zero);
		int num = (int)(flag ? ((long)GetLogicTagFpValue(energyTarget, Config_JuXingMoXiang.PartnerDataIdTag)) : 0);
		List<LogicEntity> list = ((num > 0) ? GetTargetByDataID(num) : null);
		AdventureActor adventureActor = ((list != null && list.Count > 0) ? (list.get_Item(0) as AdventureActor) : null);
		bool flag2 = adventureActor != null && !adventureActor.isDead;
		TSVector2 value2 = (flag2 ? GetEntityPosition(adventureActor) : TSVector2.zero);
		FP fP = phantomExcludeRadius * phantomExcludeRadius;
		TSVector2 result = TSVector2.zero;
		for (int i = 0; i < 10; i++)
		{
			TSVector2 shapeRandomPoint;
			if (placeholderIdx >= 0)
			{
				TSVector2 placeHolderPosition = GetPlaceHolderPosition(phantomPlaceholderNames[placeholderIdx]);
				FP radius = phantomSpawnOuterRadius;
				FP innerRadius = phantomSpawnInnerRadius;
				DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, placeHolderPosition, default, default, radius, innerRadius);
				shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			}
			else
			{
				TSVector2 position = GetPosition();
				FP innerRadius = phantomSpawnRadius;
				DeterministicShape shapeData2 = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, innerRadius);
				shapeRandomPoint = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
			}
			result = shapeRandomPoint;
			if ((flag && TSVector2.DistanceSquared(shapeRandomPoint, value) < fP) || (flag2 && TSVector2.DistanceSquared(shapeRandomPoint, value2) < fP))
			{
				continue;
			}
			bool flag3 = false;
			for (int j = 0; j < placed.Count; j++)
			{
				if (TSVector2.DistanceSquared(shapeRandomPoint, placed.get_Item(j)) < minDistSq)
				{
					flag3 = true;
					break;
				}
			}
			if (!flag3)
			{
				return shapeRandomPoint;
			}
		}
		return result;
	}

	private void OnOrbEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent adventureActorCustomEvent))
		{
			return;
		}
		AdventureActor bossActor = GetBossActor();
		if (adventureActorCustomEvent.eventHashCode == Config_XiaoMoXiang.evt_OrbAbsorbedByPlayer)
		{
			AdventureActor player = adventureActorCustomEvent.sender as AdventureActor;
			List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
			if (list != null)
			{
				foreach (PlayerAdventureActor item in list)
				{
					item?.buffComponent?.AddBuff(_playerDamageUpBuffId, _actor);
				}
			}
			FP fP = GetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_PlayerAbsorbCountTag) + 1;
			SetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_PlayerAbsorbCountTag, fP);
			if (fP >= 1)
			{
				SetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_PlayerAbsorbCountTag, FP.Zero);
				Common_73001.TryRemoveBuffOrAddBuff(bossActor, _damageReductionBuffId, _vulnerableBuffId);
				PlayDamageReductionRemovedFx(bossActor, player);
			}
		}
		else
		{
			if (adventureActorCustomEvent.eventHashCode != Config_XiaoMoXiang.evt_OrbAbsorbedByJuXing)
			{
				return;
			}
			FP fP2 = GetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_JuXingAbsorbCountTag) + 1;
			SetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_JuXingAbsorbCountTag, fP2);
			if (!(fP2 >= 1))
			{
				return;
			}
			SetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_JuXingAbsorbCountTag, FP.Zero);
			int num = ((bossActor != null && bossActor.buffComponent != null) ? bossActor.buffComponent.GetBuffNumByID(_damageReductionBuffId) : 0);
			if (Common_73001.TryAddDamageReduction(bossActor, _damageReductionBuffId, _vulnerableBuffId, 8))
			{
				AdventureActor energyTarget = GetEnergyTarget();
				if (energyTarget != null)
				{
					FP logicTagFpValue = GetLogicTagFpValue(energyTarget, Common_73001.EnergyTag);
					FP fP3 = logicTagFpValue + 5;
					if (fP3 > 100)
					{
						fP3 = 100;
					}
					SetLogicTagFpValue(energyTarget, Common_73001.EnergyTag, fP3);
					BossEnergyValueChage((int)(long)fP3, GetBossActor());
					if (GetLogicTagFpValue(bossActor, Common_73001.EnergyToReductionEnabledTag) == 1)
					{
						Common_73001.TryAddDamageReductionByEnergyGain(bossActor, fP3 - logicTagFpValue, _damageReductionBuffId, _vulnerableBuffId, 8);
					}
				}
			}
			if (((bossActor != null && bossActor.buffComponent != null) ? bossActor.buffComponent.GetBuffNumByID(_damageReductionBuffId) : 0) > num)
			{
				PlayDamageReductionAddedFx(bossActor);
			}
			if (!string.IsNullOrEmpty(juXingAbsorbAreaEffect) && bossActor != null)
			{
				LogicEntity currentPlayer = GetCurrentPlayer();
				TSVector2 position = ((currentPlayer != null) ? GetEntityPosition(currentPlayer) : GetEntityPosition(bossActor));
				FP radius = 3;
				FP innerRadius = 1;
				DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
				PlayAreaEffect(juXingAbsorbAreaEffect, GetShapeRandomPoint(shapeData, _actor, isReachable: true));
			}
		}
	}

	static Skill_NengLiangQiuBase()
	{
		//IL_0022: Field data (rva=0x538) could not be found in any section!
		//IL_0022: Field data (rva=0x538) could not be found in any section!
		//IL_000c: Field data (rva=0x510) could not be found in any section!
		//IL_000c: Field data (rva=0x510) could not be found in any section!
		int[] array = new int[6];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._0934105E7A1DCCE5426C80921717951A0AF9D1A8FFFDF1AB68EA303BE98C28B3));
		nengLiangQiuMonsterIds = array;
		int[] array2 = new int[6];
		RuntimeHelpers.InitializeArray(array2, __ldtoken(_003CPrivateImplementationDetails_003E._0A91DB7A4A89AEC2F314828D046A94616077E1426AE02D00CC92704B00205259));
		phantomMonsterIds = array2;
	}
}
