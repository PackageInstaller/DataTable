using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_LaserSweep_JuXingMoXiang : SkillSimpleBase
{
	private const string combo_LaserSweep = "JiGuangFangShe";

	private const string projectileEvent = "ShootLeft";

	private const string projectileEvent2 = "ShootRight";

	private static FP EnergyThreshold_Low = 33;

	private static FP EnergyThreshold_Mid = 67;

	private static readonly int[] orbCounts_Low;

	private static readonly int[] orbCounts_Mid;

	private static readonly int[] orbCounts_High;

	private FP orbSpawnHeight = 7;

	private FP orbFlightTime = 1;

	private FP orbWarningTime = 1;

	private FP landJitterInnerRadius = 0;

	private FP landJitterOuterRadius = 4;

	private FP landMinDist = 8;

	private const int landMinDistMaxRetry = 210;

	private const string orbWarningAlias = "";

	private const string orbBulletAlias = "Bullet_72012_SKill2_Throw";

	private readonly string[] landPlaceHolders = new string[9] { "P1_Nv_Skill1_1", "P1_Nv_Skill1_2", "P1_Nv_Skill1_3", "P1_Nv_Skill1_4", "P1_Nv_Skill1_5", "P1_Nv_Skill1_6", "P1_Nv_Skill1_7", "P1_Nv_Skill1_8", "P1_Nv_Skill1_9" };

	private static readonly string[] fromPositionHolders;

	private static readonly string[] toPositionHolders;

	private FP approachMoveSpeed = 10;

	private FP partnerExcludeRadius = 6;

	private bool finished;

	private int _summonLevel;

	private int _laserOrbId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_laserOrbId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.laserOrbMonsterIds);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		if (!finished)
		{
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_laserOrbId));
			AddBuffToTarget(_actor, 720130108);
			RemoveBuffFromTarget(_actor, 720130107);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		int num = (int)(long)GetRandomValue(0, fromPositionHolders.Length, isInt: true);
		TSVector2 fromPos = GetPlaceHolderPosition(fromPositionHolders[num]);
		TSVector2 toPos = GetPlaceHolderPosition(toPositionHolders[num]);
		Teleport(fromPos, checkPositionReachable: false);
		BeginLookAtByPos(new TSVector2(0, 0), default, 1000);
		yield return WaitTime(0.2);
		AddBuffToTarget(_actor, 720130109);
		AddBuffToTarget(_actor, 720130107);
		FP origSpeed = _actor.actorInfo.runSpeed;
		_actor.actorInfo.runSpeed = approachMoveSpeed;
		_actor.actorInfo.walkSpeed = approachMoveSpeed;
		MoveToPosition(toPos, 0.2f);
		PlayWwiseSound("mon_72012_move");
		yield return WaitMoveStatus();
		_actor.actorInfo.runSpeed = origSpeed;
		_actor.actorInfo.walkSpeed = origSpeed;
		BeginAttack(1, "JiGuangFangShe", flushInputedKeys: true);
		int strength = GetStrength();
		int count = GetOrbCount(strength) / 2;
		SetLogicTagFpValue(_actor, Common_73001.PillarStrengthTag, strength);
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		bool[] array = new bool[landPlaceHolders.Length];
		int[] wave1Indices = GetNearestPlaceholderIndices(entityPosition, count, array);
		int[] array2 = wave1Indices;
		foreach (int num2 in array2)
		{
			array[num2] = true;
		}
		int[] wave2Indices = GetNearestPlaceholderIndices(entityPosition, count, array);
		List<TSVector2> usedLandPositions = new List<TSVector2>();
		yield return WaitCustomEvent("ShootLeft");
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-4, 3));
		array2 = wave1Indices;
		foreach (int placeholderIdx in array2)
		{
			TSVector2 ringLandPos = GetRingLandPos(placeholderIdx, usedLandPositions);
			usedLandPositions.Add(ringLandPos);
			Skill_LaserSweep_JuXingMoXiang skill_LaserSweep_JuXingMoXiang = this;
			FP positionY = orbSpawnHeight;
			FP range = 0;
			TSVector2 targetPosition = ringLandPos;
			skill_LaserSweep_JuXingMoXiang.Shoot("Bullet_72012_SKill2_Throw", position, positionY, range, default, AimType.Position, BulletDirectionType.BulletToTarget, targetPosition);
		}
		yield return WaitCustomEvent("ShootRight");
		TSVector2 position2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(4, 3));
		array2 = wave2Indices;
		foreach (int placeholderIdx2 in array2)
		{
			TSVector2 ringLandPos2 = GetRingLandPos(placeholderIdx2, usedLandPositions);
			usedLandPositions.Add(ringLandPos2);
			Skill_LaserSweep_JuXingMoXiang skill_LaserSweep_JuXingMoXiang2 = this;
			FP positionY2 = orbSpawnHeight;
			FP range2 = 0;
			TSVector2 targetPosition = ringLandPos2;
			skill_LaserSweep_JuXingMoXiang2.Shoot("Bullet_72012_SKill2_Throw", position2, positionY2, range2, default, AimType.Position, BulletDirectionType.BulletToTarget, targetPosition);
		}
		finished = true;
		yield return WaitTime(orbFlightTime + 0.2);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		AimAtPosition(TSVector2.zero, 1000);
		FP retSpeed = _actor.actorInfo.runSpeed;
		_actor.actorInfo.runSpeed = approachMoveSpeed;
		_actor.actorInfo.walkSpeed = approachMoveSpeed;
		MoveToPosition(fromPos, 0.2f);
		yield return WaitMoveStatus();
		AddBuffToTarget(_actor, 720130108);
		RemoveBuffFromTarget(_actor, 720130107);
		_actor.actorInfo.runSpeed = retSpeed;
		_actor.actorInfo.walkSpeed = retSpeed;
		CancelAim();
	}

	private int[] GetNearestPlaceholderIndices(TSVector2 referencePos, int count, bool[] usedIndices)
	{
		int num = (int)(long)GetLogicTagFpValue(_actor, Config_JuXingMoXiang.PartnerDataIdTag);
		List<LogicEntity> list = ((num > 0) ? GetTargetByDataID(num) : null);
		AdventureActor adventureActor = ((list != null && list.Count > 0) ? (list.get_Item(0) as AdventureActor) : null);
		bool flag = adventureActor != null && !adventureActor.isDead;
		TSVector2 value = (flag ? GetEntityPosition(adventureActor) : TSVector2.zero);
		FP fP = partnerExcludeRadius * partnerExcludeRadius;
		List<(int, FP)> list2 = new List<(int, FP)>(landPlaceHolders.Length);
		for (int i = 0; i < landPlaceHolders.Length; i++)
		{
			if (usedIndices == null || !usedIndices[i])
			{
				TSVector2 placeHolderPosition = GetPlaceHolderPosition(landPlaceHolders[i]);
				if (!flag || !(TSVector2.DistanceSquared(placeHolderPosition, value) < fP))
				{
					FP item = TSVector2.DistanceSquared(referencePos, placeHolderPosition);
					list2.Add((i, item));
				}
			}
		}
		for (int j = 1; j < list2.Count; j++)
		{
			(int, FP) value2 = list2.get_Item(j);
			int num2 = j - 1;
			while (num2 >= 0 && list2.get_Item(num2).Item2 > value2.Item2)
			{
				list2.set_Item(num2 + 1, list2.get_Item(num2));
				num2--;
			}
			list2.set_Item(num2 + 1, value2);
		}
		int num3 = Math.Min(count, list2.Count);
		int[] array = new int[num3];
		for (int k = 0; k < num3; k++)
		{
			array[k] = list2.get_Item(k).Item1;
		}
		return array;
	}

	private TSVector2 GetRingLandPos(int placeholderIdx, List<TSVector2> placed)
	{
		TSVector2 placeHolderPosition = GetPlaceHolderPosition(landPlaceHolders[placeholderIdx]);
		FP radius = landJitterOuterRadius;
		FP innerRadius = landJitterInnerRadius;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, placeHolderPosition, default, default, radius, innerRadius);
		FP fP = landMinDist * landMinDist;
		TSVector2 result = TSVector2.zero;
		for (int i = 0; i < 210; i++)
		{
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			result = shapeRandomPoint;
			bool flag = false;
			for (int j = 0; j < placed.Count; j++)
			{
				if (TSVector2.DistanceSquared(shapeRandomPoint, placed.get_Item(j)) < fP)
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

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent && !(adventureBulletFinishEvent.owner != _actor))
		{
			SummonMonster(_laserOrbId, 0, adventureBulletFinishEvent.bulletPosition, TSVector2.up);
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
		ClearActors(GetTargetByDataID(_laserOrbId));
		AddBuffToTarget(_actor, 720130109);
		RemoveBuffFromTarget(_actor, 720130107);
	}

	private int GetStrength()
	{
		FP logicTagFpValue = GetLogicTagFpValue(_actor, Config_JuXingMoXiang.EnergyTag);
		if (logicTagFpValue <= EnergyThreshold_Low)
		{
			return 0;
		}
		if (logicTagFpValue <= EnergyThreshold_Mid)
		{
			return 1;
		}
		return 2;
	}

	private int GetOrbCount(int strength)
	{
		int num = ((_summonLevel >= 0) ? ((_summonLevel >= orbCounts_Low.Length) ? (orbCounts_Low.Length - 1) : _summonLevel) : 0);
		return strength switch
		{
			0 => orbCounts_Low[num], 
			1 => orbCounts_Mid[num], 
			_ => orbCounts_High[num], 
		};
	}

	static Skill_LaserSweep_JuXingMoXiang()
	{
		//IL_0024: Field data (rva=0x660) could not be found in any section!
		//IL_0024: Field data (rva=0x660) could not be found in any section!
		int[] array = new int[6];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._25484821EFDAD984914C400E8AFB58524A508655CC867EF8D07193420000792D));
		orbCounts_Low = array;
		orbCounts_Mid = new int[6] { 1415342962, 1701668200, 1919501919, 1986090853, 1935879781, 16777216 };
		orbCounts_High = new int[6] { 7562030, 65536, 1547829248, 1702064961, 1398567796, 1214210930 };
		fromPositionHolders = new string[3] { "JuXingApproach_From_Left", "JuXingApproach_From_Right", "JuXingApproach_From_Up" };
		toPositionHolders = new string[3] { "JuXingApproach_To_Left", "JuXingApproach_To_Right", "JuXingApproach_To_Up" };
	}
}
