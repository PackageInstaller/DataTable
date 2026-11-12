using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_RangedCombo : SkillSimpleBase
{
	private const string combo_Teleport = "Teleport";

	private string combo_Start = "RangedCombo";

	private FP teleportMinDistance = 8;

	private FP faceAimSpeed = 480;

	private FP faceAimDuration = 0.3;

	private const int waveCount = 3;

	private const string evt_Shoot = "Shoot";

	private const string bulletAlias = "Bullet_Weapon_72011_Skill3";

	private const string evt_Insert = "Insert";

	private const string areaEffect_EnergyRing = "";

	private static readonly int[] phantomMonsterIds;

	private static readonly int[] phantomInitCounts;

	private static readonly int[] phantomMaxCounts;

	private FP summonInnerRadius = 4;

	private FP summonOuterRadius = 7;

	private FP summonMinSpacing = 4;

	private const int summonMaxRetry = 20;

	private bool finished;

	private static readonly string[] waveWarningFxAliases;

	private const string castCountTag = "RangedComboCastCount";

	private int _loopIndex;

	private int _summonLevel;

	private int _phantomId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_phantomId = Common_73001.GetMonsterIdByLevel(_summonLevel, phantomMonsterIds);
		if (_summonLevel <= 5)
		{
			combo_Start = "RangedCombo_NoRing";
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (!finished)
		{
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_phantomId));
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		List<AdventureBulletBase> list = new List<AdventureBulletBase>();
		_actor.QueryOwnedAliveBullets(list);
		foreach (AdventureBulletBase item in list)
		{
			item.Finish(cancel: true);
		}
		ClearActors(GetTargetByDataID(_phantomId));
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		if (target == null)
		{
			target = GetCurrentPlayer();
		}
		BeginAttack(1, "Teleport", flushInputedKeys: true);
		yield return WaitCustomEvent("TeleportStart");
		Teleport(PickTeleportPoint(target));
		yield return WaitTime(0.1f);
		BeginLookAt_NotWait(target, 0.2, 1000);
		yield return WaitCustomEvent("TeleportEnd");
		BeginAttack(2, combo_Start, flushInputedKeys: true, forceInterruptAttack: true);
		AimAtTarget(target, 240);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAim();
		_loopIndex = 0;
		int num = (int)(long)GetLogicTagFpValue(_actor, "RangedComboCastCount");
		SpawnPhantoms(GetPhantomCount(num), target);
		SetLogicTagFpValue(_actor, "RangedComboCastCount", num + 1);
		for (int i = 0; i < 3; i++)
		{
			string text = ((i < waveWarningFxAliases.Length) ? waveWarningFxAliases[i] : "");
			if (!string.IsNullOrEmpty(text))
			{
				PlayEarlyWarningEffect(text, 0.75f, default, GetPosition(), GetRotation());
			}
			yield return WaitCustomEvent("Shoot");
			FireTraceWave();
			_loopIndex++;
			target = GetAttackTarget();
			if (target == null)
			{
				target = GetCurrentPlayer();
			}
			if (target != null)
			{
				yield return WaitTime(0.2);
			}
			BeginLookAt_NotWait(target, faceAimDuration, faceAimSpeed);
			yield return WaitTime(faceAimDuration);
		}
		CancelAttack();
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private TSVector2 PickTeleportPoint(LogicEntity target)
	{
		TSVector2 entityPosition = GetEntityPosition(target);
		FP radius = teleportMinDistance + 3.5f;
		FP innerRadius = teleportMinDistance;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
		return Common_73001.ClampToCenter(GetShapeRandomPoint(shapeData, _actor, isReachable: true), 10);
	}

	private void FireTraceWave()
	{
		if (GetAttackTarget() == null)
		{
			GetCurrentPlayer();
		}
		TSVector2 shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.5));
		FanMultipleShoot("Bullet_Weapon_72011_Skill3", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, _loopIndex + 2, 0, shootPosition, 2.5f, GetForward(), 0, AimType.Default, BulletDirectionType.BulletToTarget, 30 + 15 * _loopIndex, 6, 1);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "Insert")
		{
			PlayAreaEffect("", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)));
			DispatchEnergyRingSync();
		}
	}

	private int GetPhantomCount(int castCount)
	{
		int monsterIdByLevel = Common_73001.GetMonsterIdByLevel(_summonLevel, phantomInitCounts);
		int monsterIdByLevel2 = Common_73001.GetMonsterIdByLevel(_summonLevel, phantomMaxCounts);
		int num = monsterIdByLevel + castCount;
		if (num <= monsterIdByLevel2)
		{
			return num;
		}
		return monsterIdByLevel2;
	}

	private void SpawnPhantoms(int n, LogicEntity target)
	{
		if (n <= 0)
		{
			return;
		}
		TSVector2 entityPosition = GetEntityPosition(target);
		FP radius = summonOuterRadius;
		FP innerRadius = summonInnerRadius;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
		List<TSVector2> list = new List<TSVector2>(n);
		FP fP = summonMinSpacing * summonMinSpacing;
		for (int i = 0; i < n; i++)
		{
			TSVector2 tSVector = default;
			for (int j = 0; j < 20; j++)
			{
				TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
				bool flag = false;
				foreach (TSVector2 item in list)
				{
					if (TSVector2.DistanceSquared(shapeRandomPoint, item) < fP)
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					tSVector = shapeRandomPoint;
					break;
				}
				if (j == 19)
				{
					tSVector = shapeRandomPoint;
				}
			}
			list.Add(tSVector);
			TSVector2 spawnDirection = entityPosition - tSVector;
			SummonMonster(_phantomId, 0, tSVector, spawnDirection);
		}
	}

	private void DispatchEnergyRingSync()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Common_73001.evt_EnergyRingSync;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	static Skill_RangedCombo()
	{
		//IL_000c: Field data (rva=0x4f8) could not be found in any section!
		//IL_000c: Field data (rva=0x4f8) could not be found in any section!
		int[] array = new int[6];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._060C584043E720D28AAA433D0C1C52C6D99E62A3F3F133E8BE03581F48EDB2CD));
		phantomMonsterIds = array;
		phantomInitCounts = new int[6] { 805306368, 1936933212, 1551070309, 1600352851, 1718906696, 1415346281 };
		phantomMaxCounts = new int[6] { 1547829248, 1702064961, 1398567796, 1214210930, 1768322159, 1918131320 };
		waveWarningFxAliases = new string[3] { "fx_warning_square_3side_0_1x30_72011x2", "fx_warning_square_3side_0_1x45_72011x3", "fx_warning_square_3side_0_1x60_72011x4" };
	}
}
