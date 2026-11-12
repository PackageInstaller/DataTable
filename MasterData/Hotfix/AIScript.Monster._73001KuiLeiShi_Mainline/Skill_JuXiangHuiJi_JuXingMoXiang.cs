using System.Collections;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_JuXiangHuiJi_JuXingMoXiang : SkillSimpleBase
{
	private string combo_JuXiangHuiJi = "JuXiangHuiJi";

	private const string evt_GroundSlam = "GroundSlam";

	private const string evt_Strike = "Strike";

	private const string areaAlias_GroundWave = "";

	private static readonly int[] jumpPhantomMonsterIds;

	private FP turnTime = 0.5;

	private FP jumpSyncDelay = 0.5;

	private FP silkSpawnDelay = 0.5;

	private FP remoteSpawnInnerRadius = 10;

	private FP remoteSpawnOuterRadius = 14;

	private FP silkSpawnInnerRadius = 6;

	private FP silkSpawnOuterRadius = 10;

	private FP fanRadius = 8;

	private FP fanAngle = 270;

	private int fanHitDamageId;

	private FP fanRotationOffset = 0;

	private FP damageImmuneDuration = 0.1;

	private bool finished;

	private int _summonLevel;

	private int _jumpPhantomId;

	private int _silkPhantomId;

	private CoroutineNode silkPhantomCor;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_jumpPhantomId = Common_73001.GetMonsterIdByLevel(_summonLevel, jumpPhantomMonsterIds);
		_silkPhantomId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.silkPhantomMonsterIds);
		GetMonsterTagValue(_actor, 1);
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		if (logicEntity != null)
		{
			BeginLookAt_NotWait(logicEntity, turnTime, GetRotSpdInSkill());
			yield return WaitTime(turnTime);
		}
		BeginAttack(1, combo_JuXiangHuiJi, flushInputedKeys: true);
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopSpawnCoroutines();
		if (!finished)
		{
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_jumpPhantomId));
			ClearActors(GetTargetByDataID(_silkPhantomId));
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		StopSpawnCoroutines();
		ClearOwnerBullet();
		ClearActors(GetTargetByDataID(_jumpPhantomId));
		ClearActors(GetTargetByDataID(_silkPhantomId));
	}

	private void StopSpawnCoroutines()
	{
		if (silkPhantomCor != null)
		{
			StopCoroutine(silkPhantomCor);
			silkPhantomCor = null;
		}
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "GroundSlam")
		{
			OnGroundSlam();
		}
		else if (eventName == "Strike")
		{
			OnStrike();
		}
	}

	private void OnGroundSlam()
	{
		PlayAreaEffect("", GetPosition());
		SpawnJumpPhantom();
	}

	private void OnStrike()
	{
		silkPhantomCor = StartCoroutine(DelaySpawnSilkPhantom());
	}

	private void SpawnJumpPhantom()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		if (!(logicEntity == null))
		{
			SetLogicTagFpValue(_actor, Common_73001.PuppetSeqCounter_Tag, 0);
			TSVector2 entityPosition = GetEntityPosition(logicEntity);
			FP radius = remoteSpawnOuterRadius;
			FP innerRadius = remoteSpawnInnerRadius;
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			SummonMonster(_jumpPhantomId, 0, shapeRandomPoint, entityPosition - shapeRandomPoint);
			StartCoroutine(DelayDispatchJumpSync());
		}
	}

	private IEnumerator DelayDispatchJumpSync()
	{
		yield return WaitTime(jumpSyncDelay);
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Common_73001.evt_PuppetSyncAttack;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	private void SpawnSilkPhantom()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		if (!(logicEntity == null))
		{
			TSVector2 entityPosition = GetEntityPosition(logicEntity);
			FP radius = silkSpawnOuterRadius;
			FP innerRadius = silkSpawnInnerRadius;
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			SummonMonster(_silkPhantomId, 0, shapeRandomPoint, entityPosition - shapeRandomPoint);
		}
	}

	private IEnumerator DelaySpawnSilkPhantom()
	{
		yield return WaitTime(silkSpawnDelay);
		SpawnSilkPhantom();
	}

	private void HitLargeFan()
	{
		FP hitStrenth = 2;
		HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
		TSVector2 position = GetPosition();
		hitStrenth = fanRadius;
		FP angle = fanAngle;
		FP rotation = GetRotation() + fanRotationOffset;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, hitStrenth, default, angle, rotation);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, fanHitDamageId, damageImmuneDuration, HitBox.HurtAnimType.Small);
	}

	static Skill_JuXiangHuiJi_JuXingMoXiang()
	{
		//IL_000c: Field data (rva=0x6f8) could not be found in any section!
		//IL_000c: Field data (rva=0x6f8) could not be found in any section!
		int[] array = new int[6];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._2E3254AB534E49B046ED17D0B1FF2502DF3BEC139A41C08F8F3FD59A0AE5754D));
		jumpPhantomMonsterIds = array;
	}
}
