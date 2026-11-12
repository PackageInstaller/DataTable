using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._FengCao_1st._16510FengCao;

public class Skill_Change_2to3 : SkillSimpleBase
{
	private bool hasareaCorFinish;

	private bool waitCondition;

	private static readonly string StartChange_Event = "Change";

	private static readonly string StopNext_Event = "StopNext";

	private static readonly string AddBuff_Event1 = "AddBuffEvent_01";

	private static readonly string AddBuff_Event2 = "AddBuffEvent_02";

	private static readonly string MoveBuff_Event = "movebuff";

	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.I };

	private readonly int endIndex2 = 2;

	private readonly string endKey2 = "Show02_End_Once";

	private readonly int generalAtkIndex = 3;

	private readonly string generalAtkKey = "GeneralAttack";

	private LogicEntity attackTarget;

	private int currentSummonCount;

	private List<long> lightIds = new List<long>();

	private bool finishLightAttack;

	private List<CoroutineNode> moveCoroutineNodeList = new List<CoroutineNode>();

	private static DeterministicShape Attackshape01;

	private static TSVector2 RandomPOS01 = new TSVector2(0, 0);

	private static List<TSVector2> AttackPOS01 = new List<TSVector2>();

	private static DeterministicShape Attackshape02;

	private static TSVector2 RandomPOS02 = new TSVector2(0, 0);

	private static List<TSVector2> AttackPOS02 = new List<TSVector2>();

	protected readonly string fxA = "fx_16510FengCao_base_WindsSphere_01";

	protected PlayFX fxLoopA;

	private static readonly string Stop_Event = "Stop";

	private static readonly string AreaEffectAlias01 = "AreaAttack_Warning";

	private readonly TSVector2 centerPosition = new TSVector2(0, 0);

	private readonly int summonCount = 2;

	private readonly int summonMonsterId = 1501111;

	private readonly FP summonRadius = 3f;

	private readonly string lightAreaEffectAlias = "Weapon_16510FengCao_Change";

	private readonly FP lightAttackDuration = 8f;

	private readonly FP lightDisperseMoveDuration = 1f;

	private readonly FP lightGatherMoveDuration = 1f;

	private readonly FP light1RotateRadius = 10.5f;

	private readonly FP rotateAnglePerSecond = -40f;

	private readonly FP light1InitPositionAngle = 0f;

	private readonly FP light1RotateRadius2 = 10.5f;

	private readonly FP rotateAnglePerSecond2 = -40f;

	private readonly FP light1InitPositionAngle2 = 180f;

	private readonly FP light1RotateRadius3 = 7f;

	private readonly FP rotateAnglePerSecond3 = 40f;

	private readonly FP light1InitPositionAngle3 = 90f;

	private readonly FP light1RotateRadius4 = 7f;

	private readonly FP rotateAnglePerSecond4 = 40f;

	private readonly FP light1InitPositionAngle4 = 270f;

	protected override void OnSkillEnable()
	{
		hasareaCorFinish = true;
		waitCondition = false;
		attackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(attackTarget))
		{
			attackTarget = GetCurrentPlayer();
		}
		SetBattleOutEnable();
		SetCloseBlockEnable();
		SetLockToughnessEnable();
	}

	protected override void OnSkillDisable()
	{
		SetBattleOutDisable();
		SetCloseBlockDisable();
		SetLockToughnessDisable();
		FinishLightMove();
		lightIds.Clear();
		moveCoroutineNodeList.Clear();
	}

	private void TornadoAttack()
	{
		BeginLightAttack(centerPosition, rotateAnglePerSecond, GetPosition(), lightDisperseMoveDuration, centerPosition + TSVector2.Rotate(TSVector2.down, light1InitPositionAngle) * light1RotateRadius);
		BeginLightAttack(centerPosition, rotateAnglePerSecond2, GetPosition(), lightDisperseMoveDuration, centerPosition + TSVector2.Rotate(TSVector2.down, light1InitPositionAngle2) * light1RotateRadius2);
		BeginLightAttack(centerPosition, rotateAnglePerSecond3, GetPosition(), lightDisperseMoveDuration, centerPosition + TSVector2.Rotate(TSVector2.down, light1InitPositionAngle3) * light1RotateRadius3);
		BeginLightAttack(centerPosition, rotateAnglePerSecond4, GetPosition(), lightDisperseMoveDuration, centerPosition + TSVector2.Rotate(TSVector2.down, light1InitPositionAngle4) * light1RotateRadius4);
	}

	private IEnumerator AreaAttack()
	{
		int attackRound = 2;
		int areaCount = 3;
		FP randomValue = GetRandomValue(0, 180);
		TSVector2 areaCSPOS = TransLocalPosToWorldPos(TSVector2.zero, TSVector2.up, new TSVector2(0, 4));
		FP angularSpacing = 360 / areaCount;
		for (int j = 0; j < attackRound; j++)
		{
			for (int i = 0; i < areaCount; i++)
			{
				TSVector2 position = RotateTo(areaCSPOS, randomValue + angularSpacing * i);
				PlayAreaEffect("DropAttack_DropFx", position);
			}
			if (j < attackRound - 1)
			{
				yield return WaitTime(2.5);
			}
			randomValue = GetRandomValue(0, 180);
		}
		waitCondition = true;
		hasareaCorFinish = true;
	}

	private void SummonMonster()
	{
		currentSummonCount = summonCount;
		for (int i = 0; i < summonCount; i++)
		{
			TSVector2 tSVector = new TSVector2(GetRandomValue(centerPosition.x - summonRadius, centerPosition.x + summonRadius), GetRandomValue(centerPosition.y - summonRadius, centerPosition.y + summonRadius));
			TSVector2 normalized = (tSVector - GetEntityPosition(GetCurrentPlayer())).normalized;
			SummonTeammate(1, tSVector, normalized);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		yield return WaitFrame(13);
		TornadoAttack();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		SetHideModelEnable();
		Teleport(TSVector2.zero);
		BeginLookAtByPos(new TSVector2(0, -10), 0.2, 2000, 0);
		yield return WaitTime(2.5);
		SummonMonster();
		yield return WaitTime(3);
		SetHideModelDisable();
		BeginAttack(endIndex2, endKey2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(generalAtkIndex, generalAtkKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		hasareaCorFinish = false;
		CoroutineNode areaCor = StartCor(AreaAttack());
		bool loopCondition = !waitCondition;
		while (loopCondition)
		{
			loopCondition = !waitCondition;
			yield return WaitTime(0.2);
		}
		if (!hasareaCorFinish)
		{
			StopCor(areaCor);
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int startKeyIndex1, string eventName)
	{
		if (eventName.Equals(AddBuff_Event1))
		{
			AddBuffToTarget(_actor, 160510110);
		}
		else if (eventName.Equals(AddBuff_Event2))
		{
			AddBuffToTarget(_actor, 160510120);
		}
		if (eventName == StartChange_Event)
		{
			ReplaceAnimationGroup();
		}
		if (eventName == MoveBuff_Event)
		{
			SetBattleOutDisable();
			SetCloseBlockDisable();
			SetLockToughnessDisable();
		}
	}

	private void BeginLightAttack(TSVector2 rotateCenterPosition, FP rotateAnglePerSecond, TSVector2 initPosition, FP directMoveDuration = default(FP), TSVector2 endPosition = default(TSVector2))
	{
		long num = PlayAreaEffect(lightAreaEffectAlias, initPosition);
		if (num != 0L)
		{
			lightIds.Add(num);
			CoroutineNode item = StartCor(LightMove(num, rotateCenterPosition, rotateAnglePerSecond, directMoveDuration, endPosition));
			moveCoroutineNodeList.Add(item);
		}
	}

	private IEnumerator LightMove(long areaEffectId, TSVector2 rotateCenterPosition, FP rotateAnglePerSecond, FP directMoveDuration = default(FP), TSVector2 endPosition = default(TSVector2))
	{
		AreaEffectEntity area = ILRuntimeAPI.GetAreaEffect(areaEffectId);
		if (area == null)
		{
			yield break;
		}
		if (directMoveDuration > FP.Zero)
		{
			yield return StartCor(LightDirectMove(area, directMoveDuration, endPosition));
		}
		TSVector2 direction = area.tsTransform.Position - rotateCenterPosition;
		while (true)
		{
			FP degrees = rotateAnglePerSecond * _actor.LogicDeltaTime;
			direction = TSVector2.Rotate(direction, degrees);
			area.tsTransform.Position = rotateCenterPosition + direction;
			yield return null;
		}
	}

	private IEnumerator LightDirectMove(AreaEffectEntity areaEffect, FP directMoveDuration, TSVector2 endPosition)
	{
		FP fP = TSVector2.Distance(areaEffect.tsTransform.Position, endPosition) / directMoveDuration;
		TSVector2 normalized = (endPosition - areaEffect.tsTransform.Position).normalized;
		TSVector2 velocity = normalized * fP;
		FP lifeTime = directMoveDuration;
		while (lifeTime > FP.Zero)
		{
			lifeTime -= _actor.LogicDeltaTime;
			areaEffect.tsTransform.Position += velocity * _actor.LogicDeltaTime;
			yield return null;
		}
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor.dataID == summonMonsterId)
		{
			currentSummonCount--;
			if (currentSummonCount <= 0)
			{
				FinishLightMove();
				finishLightAttack = true;
			}
		}
	}

	private IEnumerator LightGather(TSVector2 backPosition, FP duration)
	{
		FinishLightMove();
		foreach (long lightId in lightIds)
		{
			AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(lightId);
			if (areaEffect != null)
			{
				StartCor(LightDirectMove(areaEffect, duration, backPosition));
			}
		}
		yield return WaitTime(duration);
		Teleport(backPosition);
		finishLightAttack = true;
	}

	private void FinishLightMove()
	{
		foreach (CoroutineNode moveCoroutineNode in moveCoroutineNodeList)
		{
			StopCor(moveCoroutineNode);
		}
	}

	protected IEnumerator AreaAttack1()
	{
		Attackshape01 = GetShapeData(DeterministicShape.ShapeType.Circle, RandomPOS01, default, default, 10, 1);
		for (int i = 0; i < 7; i++)
		{
			AttackPOS01.Add(GetShapeRandomPoint(Attackshape01, _actor, isReachable: true));
		}
		for (int j = 0; j < AttackPOS01.Count; j++)
		{
			PlayAreaEffect(AreaEffectAlias01, AttackPOS01.get_Item(j));
			fxLoopA = PlayFxForNeedStop(fxA, 1f, _actor.tsTransform.PositionY, AttackPOS01.get_Item(j), _actor.tsTransform.Rotation);
			yield return WaitTime(GetRandomValue(0.2, 0.6));
		}
	}

	protected IEnumerator AreaAttack2()
	{
		for (int i = 0; i < 6; i++)
		{
			Attackshape02 = GetShapeData(DeterministicShape.ShapeType.Circle, GetEntityPosition(attackTarget), default, default, 1, 0.1);
			AttackPOS02.Add(GetShapeRandomPoint(Attackshape02, _actor, isReachable: true));
			PlayAreaEffect(AreaEffectAlias01, AttackPOS02.get_Item(i));
			fxLoopA = PlayFxForNeedStop(fxA, 1f, _actor.tsTransform.PositionY, AttackPOS02.get_Item(i), _actor.tsTransform.Rotation);
			yield return WaitTime(GetRandomValue(0.5, 1));
		}
	}
}
