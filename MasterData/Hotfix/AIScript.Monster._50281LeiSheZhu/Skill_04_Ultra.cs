using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50281LeiSheZhu;

public class Skill_04_Ultra : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private readonly TSVector2 centerPosition = new TSVector2(0, 0);

	private readonly int summonCount = 2;

	private readonly int summonMonsterId = 5028101;

	private readonly FP summonRadius = 10f;

	private readonly int stunBuffId = 990050030;

	private readonly string lightSpawnFxAlias = "lightFX";

	private readonly string lightAreaEffectAlias = "50281LeiSheZhu_Skill_04";

	private readonly FP lightAttackDuration = 15f;

	private readonly FP lightDisperseMoveDuration = 1f;

	private readonly FP lightGatherMoveDuration = 0.5f;

	private readonly FP light1RotateRadius = 1.5f;

	private readonly FP light1InitPositionAngle = 0f;

	private readonly FP rotateAnglePerSecond = 30f;

	private readonly FP light1RotateRadius2 = 7.5f;

	private readonly FP light1InitPositionAngle2 = 90f;

	private readonly FP rotateAnglePerSecond2 = 30f;

	private readonly FP light1RotateRadius3 = 7.5f;

	private readonly FP light1InitPositionAngle3 = 270f;

	private readonly FP rotateAnglePerSecond3 = 30f;

	private readonly FP light1RotateRadius4 = 12.5f;

	private readonly FP light1InitPositionAngle4 = 0f;

	private readonly FP rotateAnglePerSecond4 = 30f;

	private readonly FP light1RotateRadius5 = 12.5f;

	private readonly FP light1InitPositionAngle5 = 180f;

	private readonly FP rotateAnglePerSecond5 = 30f;

	private readonly FP listenGetBuffDelay = 1f;

	private int currentSummonCount;

	private List<long> lightIds = new List<long>();

	private bool finishLightAttack;

	private List<CoroutineNode> moveCoroutineNodeList = new List<CoroutineNode>();

	private bool alreadyMoveTogether;

	private bool listenGetBuffEvent;

	protected override void OnSkillEnable()
	{
		listenGetBuffEvent = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		finishLightAttack = false;
		alreadyMoveTogether = false;
		StartCor(ListenGetBuffDelay());
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		lightIds.Clear();
		moveCoroutineNodeList.Clear();
	}

	private IEnumerator ListenGetBuffDelay()
	{
		yield return WaitTime(listenGetBuffDelay);
		listenGetBuffEvent = true;
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, actionKeys, flushInputedKeys: true);
		AddBuffToTarget(_actor, 505210310);
		AddBuffToTarget(_actor, 990010030);
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Fire"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Water"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Wind"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Light"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Dark"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Earth"));
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		currentSummonCount = summonCount;
		for (int i = 0; i < summonCount; i++)
		{
			TSVector2 tSVector = new TSVector2(GetRandomValue(centerPosition.x - summonRadius, centerPosition.x + summonRadius), GetRandomValue(centerPosition.y - summonRadius, centerPosition.y + summonRadius));
			TSVector2 normalized = (tSVector - GetEntityPositionObsoleted(GetCurrentPlayer())).normalized;
			SummonTeammate(1, tSVector, normalized, 2);
		}
		long FxLoopA = PlayEffect(lightSpawnFxAlias, 1f, GetCurrentPlayer().tsTransform.PositionY, centerPosition);
		yield return WaitTime(0.8);
		StopEffect(FxLoopA);
		BeginLightAttack(centerPosition, rotateAnglePerSecond, centerPosition, lightDisperseMoveDuration, centerPosition + TSVector2.Rotate(TSVector2.down, light1InitPositionAngle) * light1RotateRadius);
		BeginLightAttack(centerPosition, rotateAnglePerSecond2, centerPosition, lightDisperseMoveDuration, centerPosition + TSVector2.Rotate(TSVector2.down, light1InitPositionAngle2) * light1RotateRadius2);
		BeginLightAttack(centerPosition, rotateAnglePerSecond3, centerPosition, lightDisperseMoveDuration, centerPosition + TSVector2.Rotate(TSVector2.down, light1InitPositionAngle3) * light1RotateRadius3);
		BeginLightAttack(centerPosition, rotateAnglePerSecond4, centerPosition, lightDisperseMoveDuration, centerPosition + TSVector2.Rotate(TSVector2.down, light1InitPositionAngle4) * light1RotateRadius4);
		BeginLightAttack(centerPosition, rotateAnglePerSecond5, centerPosition, lightDisperseMoveDuration, centerPosition + TSVector2.Rotate(TSVector2.down, light1InitPositionAngle5) * light1RotateRadius5);
		StartCor(WaitLightAttackFinish());
		while (!finishLightAttack)
		{
			yield return null;
		}
		foreach (long lightId in lightIds)
		{
			ILRuntimeAPI.StopAreaEffect(lightId);
		}
		yield return WaitTime(0.2);
		CancelAttack();
		RemoveBuffFromTarget(_actor, 505210310);
		RemoveBuffFromTarget(_actor, 990010030);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator WaitLightAttackFinish()
	{
		yield return WaitTime(lightAttackDuration);
		StartCor(LightGather(centerPosition, lightGatherMoveDuration));
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

	private void OnGetBuff(IEvent evt)
	{
		if (listenGetBuffEvent && evt is AdventureActorGetBuff adventureActorGetBuff)
		{
			AdventureActor adventureActor = GetCurrentPlayer() as AdventureActor;
			if (!(adventureActor == null) && !(adventureActorGetBuff.sender as AdventureActor != adventureActor) && adventureActorGetBuff.eventInfo.buffId == stunBuffId && adventureActor.isStun && !adventureActor.isStunWeakened)
			{
				StartCor(LightGather(GetEntityPositionObsoleted(GetCurrentPlayer()), lightGatherMoveDuration));
			}
		}
	}

	private IEnumerator LightGather(TSVector2 backPosition, FP duration)
	{
		if (alreadyMoveTogether)
		{
			yield break;
		}
		alreadyMoveTogether = true;
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
