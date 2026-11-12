using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._FengCao_Level._16510FengCao;

public class Skill_Change_Hard : SkillSimpleBase
{
	private static readonly string StartChange_Event = "Change";

	private static readonly string StopNext_Event = "StopNext";

	private static readonly string AddBuff_Event1 = "AddBuffEvent_01";

	private static readonly string AddBuff_Event2 = "AddBuffEvent_02";

	private static readonly string MoveBuff_Event = "movebuff";

	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.I };

	private FP TargetDis;

	private LogicEntity AttackTarget;

	private int currentSummonCount;

	private List<long> lightIds = new List<long>();

	private bool finishLightAttack;

	private List<CoroutineNode> moveCoroutineNodeList = new List<CoroutineNode>();

	private readonly TSVector2 centerPosition = new TSVector2(0, 0);

	private readonly int summonCount = 2;

	private readonly int summonMonsterId = 1501111;

	private readonly FP summonRadius = 8f;

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

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
		AttackPOS01.Clear();
		AttackPOS02.Clear();
		TargetDis = Distance(GetPosition(), new TSVector2(0, 0));
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 505210310);
		AddBuffToTarget(_actor, 990010030);
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		SetLockToughnessEnable();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Fire"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Water"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Wind"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Light"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Dark"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Earth"));
		BeginLookAtByPos(new TSVector2(0, 0), 0.2, 2000, 0);
		yield return WaitTime(1);
		BeginDashActorForward(1, 60, TargetDis, 360, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		BeginLookAtByPos(new TSVector2(0, -10), 0.2, 2000, 0);
		CancelAttack();
		BeginLightAttack(centerPosition, rotateAnglePerSecond, centerPosition, lightDisperseMoveDuration, centerPosition + TSVector2.Rotate(TSVector2.down, light1InitPositionAngle) * light1RotateRadius);
		BeginLightAttack(centerPosition, rotateAnglePerSecond2, centerPosition, lightDisperseMoveDuration, centerPosition + TSVector2.Rotate(TSVector2.down, light1InitPositionAngle2) * light1RotateRadius2);
		BeginLightAttack(centerPosition, rotateAnglePerSecond3, centerPosition, lightDisperseMoveDuration, centerPosition + TSVector2.Rotate(TSVector2.down, light1InitPositionAngle3) * light1RotateRadius3);
		BeginLightAttack(centerPosition, rotateAnglePerSecond4, centerPosition, lightDisperseMoveDuration, centerPosition + TSVector2.Rotate(TSVector2.down, light1InitPositionAngle4) * light1RotateRadius4);
		yield return WaitTime(1.5);
		for (int times = 2; times > 0; times--)
		{
			AttackTarget = GetAttackTarget();
			if (!(AttackTarget != null))
			{
				break;
			}
			StartCor(AreaAttack1());
			StartCor(AreaAttack2());
			yield return WaitTime(5);
		}
		yield return WaitCustomEvent(StartChange_Event);
		ReplaceAnimationGroup();
		yield return WaitCustomEvent(MoveBuff_Event);
		SetLockToughnessDisable();
		RemoveBuffFromTarget(_actor, 505210310);
		RemoveBuffFromTarget(_actor, 990010030);
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
	}

	protected override void OnSkillDisable()
	{
		AttackPOS01.Clear();
		AttackPOS02.Clear();
		RemoveBuffFromTarget(_actor, 505210310);
		RemoveBuffFromTarget(_actor, 990010030);
		FinishLightMove();
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
			Attackshape02 = GetShapeData(DeterministicShape.ShapeType.Circle, GetEntityPosition(AttackTarget), default, default, 1, 0.1);
			AttackPOS02.Add(GetShapeRandomPoint(Attackshape02, _actor, isReachable: true));
			PlayAreaEffect(AreaEffectAlias01, AttackPOS02.get_Item(i));
			fxLoopA = PlayFxForNeedStop(fxA, 1f, _actor.tsTransform.PositionY, AttackPOS02.get_Item(i), _actor.tsTransform.Rotation);
			yield return WaitTime(GetRandomValue(0.5, 1));
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
}
