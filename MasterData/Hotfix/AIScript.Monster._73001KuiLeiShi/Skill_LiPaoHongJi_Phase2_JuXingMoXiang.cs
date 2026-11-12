using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_LiPaoHongJi_Phase2_JuXingMoXiang : SkillSimpleBase
{
	private const string combo_LiPaoHongJi_Phase2 = "LiPaoHongJiP2";

	private const int barrageWaveCount = 2;

	private FP waveInterval = 1;

	private const string barrageBulletAlias = "AreaEffect_72012_Skill1_LiPao";

	private const string finalBulletAlias = "AreaEffect_72012_Skill1_Final_NoRing";

	private FP barrageBulletSpawnHeight = 2;

	private FP finalBulletSpawnHeight = 2;

	private readonly string[] fixedLandPlaceHolders = new string[5] { "P2_Nv_Skill1_1", "P2_Nv_Skill1_2", "P2_Nv_Skill1_3", "P2_Nv_Skill1_4", "P2_Nv_Skill1_5" };

	private int fixedLandPointNearCount = 3;

	private FP fixedRingInnerRadius = 1;

	private FP fixedRingOuterRadius = 4;

	private FP fixedBulletInterval = 0f;

	private int randomLandPointCountPerWave = 2;

	private FP randomLandPointRadius = 4;

	private FP randomLandPointInnRadius = 0;

	private FP randomBulletInterval = 0f;

	private FP landPointMinSpacing = 3;

	private static readonly int[] whirlwindMonsterIds = new int[6];

	private const int phantomMonsterId = 4;

	private int phantomCountPerWave = 1;

	private FP phantomSpawnInnerRadius = 4;

	private FP phantomSpawnOuterRadius = 8;

	private int _playerDamageUpBuffId;

	private int _damageReductionBuffId;

	private int _vulnerableBuffId;

	private int _orbId;

	private const int playerAbsorbThreshold = 1;

	private const int juXingAbsorbThreshold = 1;

	private string juXingAbsorbAreaEffect = "AreaEffect_72012_Skill1_LiPao";

	private SummonCfg _orbSummonCfg;

	private static readonly int[] _nengLiangQiuMonsterIds;

	private static readonly TSVector2[] _orbCandidatePositions;

	private int orbLifetime = 12;

	private List<long> _barrageBulletIds = new List<long>();

	private bool finished;

	private int _summonLevel;

	private int _whirlwindId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_whirlwindId = Common_73001.GetMonsterIdByLevel(_summonLevel, whirlwindMonsterIds);
		_playerDamageUpBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.orbPlayerDamageUpBuffIds);
		_damageReductionBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.damageReductionBuffIds);
		_vulnerableBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.vulnerableBuffIds);
		_orbId = Common_73001.GetMonsterIdByLevel(_summonLevel, _nengLiangQiuMonsterIds);
		_barrageBulletIds.Clear();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnOrbEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnOrbEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		if (finished)
		{
			return;
		}
		ClearOwnerBullet();
		foreach (long barrageBulletId in _barrageBulletIds)
		{
			StopAreaEffect(barrageBulletId);
		}
		_barrageBulletIds.Clear();
		ClearActors(GetTargetByTeammateIndex(4));
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		foreach (long barrageBulletId in _barrageBulletIds)
		{
			StopAreaEffect(barrageBulletId);
		}
		_barrageBulletIds.Clear();
		ClearActors(GetTargetByTeammateIndex(4));
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "LiPaoHongJiP2", flushInputedKeys: true);
		yield return WaitCustomEvent("StartFire");
		TSVector2 pos = _orbCandidatePositions[TSRandom.Range(0, 3)];
		if (_orbSummonCfg == null)
		{
			_orbSummonCfg = new SummonCfg
			{
				leftTime = orbLifetime
			};
		}
		ILRuntimeAPI.SummonMonster(_actor, 0, _orbId, pos, TSVector2.up, _orbSummonCfg);
		for (int waveIndex = 0; waveIndex < 2; waveIndex++)
		{
			yield return StartCor(FireBarrageWave());
			SpawnPhantomsForWave();
			if (waveIndex < 1)
			{
				yield return WaitTime(waveInterval);
			}
		}
		yield return WaitTime(2);
		CancelAttack();
		yield return WaitCustomEvent("FinalShoot");
		long id = PlayAreaEffect("AreaEffect_72012_Skill1_Final_NoRing", GetEntityPosition(GetCurrentPlayer()));
		AreaEffectEntity finalAreaEntity = GetAreaEffect(id);
		long _lockFxId = PlayLinkEffect("fx_m72012_loop_skill1_bullet_link_LeftHand", useCustomSource: false, null, default, default, finalAreaEntity, default, default, breakWhenLostSourceOrTarget: false);
		long _lockFxId2 = PlayLinkEffect("fx_m72012_loop_skill1_bullet_link_RightHand", useCustomSource: false, null, default, default, finalAreaEntity, default, default, breakWhenLostSourceOrTarget: false);
		yield return WaitTime(1.5);
		FreezeLinkEffectTarget(_lockFxId);
		FreezeLinkEffectTarget(_lockFxId2);
		yield return WaitTime(0.4);
		StopEffect(_lockFxId);
		StopEffect(_lockFxId2);
		long _ShootFxId = PlayLinkEffect("fx_m72012_bullet_skill1_LeftHand", useCustomSource: false, null, default, default, finalAreaEntity, default, default, breakWhenLostSourceOrTarget: false);
		long _ShootFxId2 = PlayLinkEffect("fx_m72012_bullet_skill1_RightHand", useCustomSource: false, null, default, default, finalAreaEntity, default, default, breakWhenLostSourceOrTarget: false);
		yield return WaitTime(0.15);
		StopEffect(_ShootFxId);
		StopEffect(_ShootFxId2);
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void FreezeLinkEffectTarget(long id)
	{
		List<AdventureFXHandler> handlers = SceneSingleton<AdventureFXManager>.Instance.handlers;
		for (int i = 0; i < handlers.Count; i++)
		{
			AdventureFXPlayer adventureFXPlayer = handlers.get_Item(i) as AdventureFXPlayer;
			if (!(adventureFXPlayer == null) && adventureFXPlayer.token == id)
			{
				Vector3 targetPosition = adventureFXPlayer.targetPosition;
				adventureFXPlayer.target = null;
				adventureFXPlayer.targetPosition = targetPosition;
				break;
			}
		}
	}

	private IEnumerator FireBarrageWave()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (!(currentPlayer == null))
		{
			TSVector2 playerPos = GetEntityPosition(currentPlayer);
			List<TSVector2> list = new List<TSVector2>();
			List<string> list2 = new List<string>(fixedLandPlaceHolders);
			list2.Sort((string a, string b) =>
			{
				FP fP2 = TSVector2.Distance(GetPlaceHolderPosition(a), playerPos);
				FP other = TSVector2.Distance(GetPlaceHolderPosition(b), playerPos);
				return fP2.CompareTo(other);
			});
			FP fP = TSMath.Min(fixedLandPointNearCount, list2.Count);
			for (int num = 0; num < fP; num++)
			{
				TSVector2 placeHolderPosition = GetPlaceHolderPosition(list2.get_Item(num));
				Skill_LiPaoHongJi_Phase2_JuXingMoXiang skill_LiPaoHongJi_Phase2_JuXingMoXiang = this;
				FP radius = fixedRingOuterRadius;
				FP innerRadius = fixedRingInnerRadius;
				DeterministicShape shapeData = skill_LiPaoHongJi_Phase2_JuXingMoXiang.GetShapeData(DeterministicShape.ShapeType.Circle, placeHolderPosition, default, default, radius, innerRadius);
				list.Add(SampleSpacedPoint(shapeData, list, playerPos));
			}
			for (int num2 = 0; num2 < randomLandPointCountPerWave; num2++)
			{
				Skill_LiPaoHongJi_Phase2_JuXingMoXiang skill_LiPaoHongJi_Phase2_JuXingMoXiang2 = this;
				TSVector2 position = playerPos;
				FP innerRadius = randomLandPointRadius;
				FP radius = randomLandPointInnRadius;
				DeterministicShape shapeData2 = skill_LiPaoHongJi_Phase2_JuXingMoXiang2.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, innerRadius, radius);
				list.Add(SampleSpacedPoint(shapeData2, list, playerPos));
			}
			for (int num3 = 0; num3 < list.Count; num3++)
			{
				FireBarrageBullet(list.get_Item(num3));
			}
			yield return null;
		}
	}

	private TSVector2 SampleSpacedPoint(DeterministicShape shape, List<TSVector2> existing, TSVector2 fallback)
	{
		for (int i = 0; i < 10; i++)
		{
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shape, _actor, isReachable: true);
			if (IsSpacedFromAll(shapeRandomPoint, existing))
			{
				return shapeRandomPoint;
			}
		}
		return fallback;
	}

	private bool IsSpacedFromAll(TSVector2 pt, List<TSVector2> others)
	{
		for (int i = 0; i < others.Count; i++)
		{
			if (TSVector2.Distance(pt, others.get_Item(i)) < landPointMinSpacing)
			{
				return false;
			}
		}
		return true;
	}

	private void FireBarrageBullet(TSVector2 landPos)
	{
		long num = PlayAreaEffect("AreaEffect_72012_Skill1_LiPao", landPos);
		if (num > 0)
		{
			_barrageBulletIds.Add(num);
		}
	}

	private void FireFinalShell()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (!(currentPlayer == null))
		{
			PlayAreaEffect("AreaEffect_72012_Skill1_Final_NoRing", GetEntityPosition(currentPlayer));
		}
	}

	private void SpawnPhantomsForWave()
	{
		if (phantomCountPerWave <= 0)
		{
			return;
		}
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (!(currentPlayer == null))
		{
			TSVector2 entityPosition = GetEntityPosition(currentPlayer);
			FP radius = phantomSpawnOuterRadius;
			FP innerRadius = phantomSpawnInnerRadius;
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
			for (int i = 0; i < phantomCountPerWave; i++)
			{
				TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
				SummonTeammate(4, shapeRandomPoint, entityPosition - shapeRandomPoint);
			}
		}
	}

	private AdventureActor GetBossActor()
	{
		return _actor;
	}

	private AdventureActor GetEnergyTarget()
	{
		return _actor;
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
					FP fP3 = GetLogicTagFpValue(energyTarget, Common_73001.EnergyTag) + 5;
					if (fP3 > 100)
					{
						fP3 = 100;
					}
					SetLogicTagFpValue(energyTarget, Common_73001.EnergyTag, fP3);
					BossEnergyValueChage((int)(long)fP3, GetBossActor());
				}
			}
			if (((bossActor != null && bossActor.buffComponent != null) ? bossActor.buffComponent.GetBuffNumByID(_damageReductionBuffId) : 0) > num)
			{
				PlayDamageReductionAddedFx(bossActor);
			}
			if (!string.IsNullOrEmpty(juXingAbsorbAreaEffect) && bossActor != null)
			{
				PlayAreaEffect(juXingAbsorbAreaEffect, GetEntityPosition(bossActor));
			}
		}
	}

	private void PlayDamageReductionAddedFx(AdventureActor boss)
	{
		if (!(boss == null))
		{
			PlayFx("fx_m72012_base_Shield", 1f, default, GetEntityPosition(boss), default);
		}
	}

	private void PlayDamageReductionRemovedFx(AdventureActor boss, AdventureActor player)
	{
		if (!(boss == null))
		{
			GameObject gameObject = player?.gameObject;
			if (gameObject != null)
			{
				TSVector2 entityPosition = GetEntityPosition(player);
				TSVector sourcePosition = new TSVector(entityPosition.x, 0, entityPosition.y);
				PlayLinkFX("fx_m72012_base_shootline_1", useCustomSource: true, gameObject, sourcePosition, FP.Zero, boss.gameObject, TSVector.zero, FP.Zero, breakWhenLostSourceOrTarget: false);
			}
			PlayFx("fx_m72012_base_Shield_down", 1f, default, GetEntityPosition(boss), default);
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent && !(adventureBulletFinishEvent.owner != _actor) && _barrageBulletIds.Remove(adventureBulletFinishEvent.id))
		{
			SummonMonster(_whirlwindId, 0, adventureBulletFinishEvent.bulletPosition, TSVector2.up);
		}
	}

	static Skill_LiPaoHongJi_Phase2_JuXingMoXiang()
	{
		//IL_0017: Field data (rva=0x510) could not be found in any section!
		//IL_0017: Field data (rva=0x510) could not be found in any section!
		int[] array = new int[6];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._0934105E7A1DCCE5426C80921717951A0AF9D1A8FFFDF1AB68EA303BE98C28B3));
		_nengLiangQiuMonsterIds = array;
		_orbCandidatePositions = new TSVector2[3]
		{
			new TSVector2(10, 10),
			new TSVector2(-10, 10),
			new TSVector2(0, 5)
		};
	}
}
