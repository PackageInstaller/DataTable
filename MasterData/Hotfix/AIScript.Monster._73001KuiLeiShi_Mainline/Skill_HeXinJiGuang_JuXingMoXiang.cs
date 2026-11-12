using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_HeXinJiGuang_JuXingMoXiang : SkillSimpleBase
{
	private const string combo_HeXinJiGuang = "HeXinJiGuang";

	private const string beamFxAlias_Left = "fx_m72012_loop_RangedAttack_jiguang";

	private const string beamFxAlias_Right = "fx_m72012_loop_RangedAttack_jiguang";

	private FP beamLength = 36;

	private FP beamWidth = 1;

	private FP beamDamageInterval = 0.03;

	private int beamHitDamageId = 72012021;

	private PlayFX _beamFxLeft;

	private PlayFX _beamFxRight;

	private readonly List<long> _spawnedPhantomEntityIds = new List<long>();

	private FP damageImmuneDuration = 0.3;

	private TSVector2 _beamOrigin;

	private long fx_Laser_Left;

	private long fx_Laser_Right;

	private long fx_laserBall;

	private string fx_Laser_Ball = "fx_m72012_loop_RangedAttack_ball";

	private bool finished;

	private int _summonLevel;

	private int _phantomId;

	private int rotateSpeed = 20;

	private int rotateAngle = 40;

	private CoroutineNode laserEffectCor;

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

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_playerDamageUpBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.orbPlayerDamageUpBuffIds);
		_damageReductionBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.damageReductionBuffIds);
		_vulnerableBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.vulnerableBuffIds);
		_phantomId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.silkPhantomMonsterIds);
		_orbId = Common_73001.GetMonsterIdByLevel(_summonLevel, _nengLiangQiuMonsterIds);
		if (_summonLevel >= 5)
		{
			rotateSpeed = 25;
			rotateAngle = 50;
		}
		else if (_summonLevel == 4)
		{
			rotateSpeed = 25;
			rotateAngle = 50;
		}
		else
		{
			rotateSpeed = 20;
			rotateAngle = 40;
		}
		_spawnedPhantomEntityIds.Clear();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnPhantomSpawned);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnOrbEvent);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnOrbEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnPhantomSpawned);
		StopBeamFx();
		StopEffect(fx_Laser_Left);
		StopEffect(fx_Laser_Right);
		StopEffect(fx_laserBall);
		StopSpawnCoroutines();
		if (!finished)
		{
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_phantomId));
		}
		_spawnedPhantomEntityIds.Clear();
	}

	private void StopSpawnCoroutines()
	{
		if (laserEffectCor != null)
		{
			StopCor(laserEffectCor);
			laserEffectCor = null;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAtCameraDir(DirectionType.Down, default, 400);
		BeginAttack(1, "HeXinJiGuang", flushInputedKeys: true);
		yield return WaitCustomEvent("laserball");
		fx_laserBall = PlayEffect(fx_Laser_Ball);
		yield return WaitCustomEvent("LaserStart");
		TSVector2 pos = _orbCandidatePositions[TSRandom.Range(0, 3)];
		if (_orbSummonCfg == null)
		{
			_orbSummonCfg = new SummonCfg
			{
				leftTime = orbLifetime
			};
		}
		ILRuntimeAPI.SummonMonster(_actor, 0, _orbId, pos, TSVector2.up, _orbSummonCfg);
		laserEffectCor = StartCor(PlayLaserEffect());
		yield return laserEffectCor;
		CancelAttack();
		StopEffect(fx_laserBall);
		StopEffect(fx_Laser_Left);
		StopEffect(fx_Laser_Right);
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator PlayLaserEffect()
	{
		_beamOrigin = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2.5));
		fx_Laser_Left = PlayEffect("fx_m72012_loop_RangedAttack_jiguang", 1f, 1.1f, _beamOrigin, 180);
		fx_Laser_Right = PlayEffect("fx_m72012_loop_RangedAttack_jiguang", 1f, 1.1f, _beamOrigin, 180);
		yield return WaitCustomEvent("LaserTurn");
		SummonMonster(_phantomId, 0, GetSpawnpos(GetPlaceHolderPosition("Nv_RangeAttack_1")), default);
		if (_summonLevel >= 4)
		{
			SummonMonster(_phantomId, 0, GetSpawnpos(GetPlaceHolderPosition("Nv_RangeAttack_2")), default);
		}
		FP leftAngle = 180;
		FP rightAngle = 180;
		FP rotateTime = (FP)rotateAngle / (FP)rotateSpeed;
		BeginRotateEffect(fx_Laser_Left, -rotateAngle, rotateSpeed);
		BeginRotateEffect(fx_Laser_Right, rotateAngle, rotateSpeed);
		yield return StartCor(SweepBeamsDamage(rotateTime, leftAngle, leftAngle - rotateAngle, rightAngle, rightAngle + rotateAngle));
		leftAngle -= (FP)rotateAngle;
		rightAngle += (FP)rotateAngle;
		yield return WaitTime(0.5);
		SummonMonster(_phantomId, 0, GetSpawnpos(GetPlaceHolderPosition("Nv_RangeAttack_3")), default);
		if (_summonLevel >= 4)
		{
			SummonMonster(_phantomId, 0, GetSpawnpos(GetPlaceHolderPosition("Nv_RangeAttack_4")), default);
		}
		BeginRotateEffect(fx_Laser_Left, rotateAngle * 2, rotateSpeed);
		BeginRotateEffect(fx_Laser_Right, -rotateAngle * 2, rotateSpeed);
		yield return StartCor(SweepBeamsDamage(rotateTime * 2, leftAngle, leftAngle + rotateAngle * 2, rightAngle, rightAngle - rotateAngle * 2));
		leftAngle += (FP)(rotateAngle * 2);
		rightAngle -= (FP)(rotateAngle * 2);
		yield return WaitTime(0.5);
		SummonMonster(_phantomId, 0, GetSpawnpos(GetPlaceHolderPosition("Nv_RangeAttack_2")), default);
		if (_summonLevel >= 4)
		{
			SummonMonster(_phantomId, 0, GetSpawnpos(GetPlaceHolderPosition("Nv_RangeAttack_3")), default);
		}
		BeginRotateEffect(fx_Laser_Left, -rotateAngle, rotateSpeed);
		BeginRotateEffect(fx_Laser_Right, rotateAngle, rotateSpeed);
		yield return StartCor(SweepBeamsDamage(rotateTime, leftAngle, leftAngle - rotateAngle, rightAngle, rightAngle + rotateAngle));
		yield return WaitTime(0.5);
	}

	private IEnumerator SweepBeamsDamage(FP duration, FP leftStart, FP leftEnd, FP rightStart, FP rightEnd)
	{
		if (duration <= FP.Zero)
		{
			HitBeam(leftEnd);
			HitBeam(rightEnd);
			yield break;
		}
		FP elapsed = FP.Zero;
		FP hitAccum = FP.Zero;
		while (elapsed < duration)
		{
			FP t = elapsed / duration;
			if (hitAccum >= beamDamageInterval)
			{
				HitBeam(Lerp(leftStart, leftEnd, t));
				HitBeam(Lerp(rightStart, rightEnd, t));
				hitAccum -= beamDamageInterval;
			}
			yield return null;
			elapsed += _actor.LogicDeltaTime;
			hitAccum += _actor.LogicDeltaTime;
		}
		HitBeam(leftEnd);
		HitBeam(rightEnd);
	}

	private void HitBeam(FP worldAngle)
	{
		TSVector2 dirByAngle = GetDirByAngle(worldAngle);
		_ = _beamOrigin + dirByAngle * (beamLength / 2);
		TSVector2 beamOrigin = _beamOrigin;
		FP width = beamWidth;
		FP length = beamLength;
		FP rotation = worldAngle;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, beamOrigin, width, length, default, default, default, rotation);
		rotation = 2;
		HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, rotation);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, beamHitDamageId, damageImmuneDuration, HitBox.HurtAnimType.Small, "fx_common_hit_dark_magic");
	}

	private TSVector2 GetSpawnpos(TSVector2 scenepos)
	{
		FP radius = 4;
		FP innerRadius = 2;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, scenepos, default, default, radius, innerRadius);
		return GetShapeRandomPoint(shapeData, _actor, isReachable: true);
	}

	private void StopBeamFx()
	{
		_beamFxLeft?.Stop();
		_beamFxLeft?.Clear();
		_beamFxLeft = null;
		_beamFxRight?.Stop();
		_beamFxRight?.Clear();
		_beamFxRight = null;
	}

	private void OnPhantomSpawned(IEvent evt)
	{
		if (evt is AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent && adventureMonsterSummonerSpawnedEvent.summonerId == _actor.Id)
		{
			MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(adventureMonsterSummonerSpawnedEvent.id) as MonsterAdventureActor;
			if (monsterAdventureActor != null && monsterAdventureActor.dataID == _phantomId)
			{
				_spawnedPhantomEntityIds.Add(monsterAdventureActor.Id);
			}
		}
	}

	private TSVector2 GetDirByAngle(FP angle)
	{
		FP value = angle * FP.Deg2Rad;
		return new TSVector2(TSMath.Sin(value), TSMath.Cos(value));
	}

	private FP Lerp(FP from, FP to, FP t)
	{
		return from + (to - from) * t;
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

	static Skill_HeXinJiGuang_JuXingMoXiang()
	{
		//IL_000c: Field data (rva=0x510) could not be found in any section!
		//IL_000c: Field data (rva=0x510) could not be found in any section!
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
