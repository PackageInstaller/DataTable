using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_JumpWhirlwind_XuanFengKuiLei_10_1 : SkillSimpleBase
{
	private const string combo_JumpAttack = "JumpAttack";

	private const string combo_Whirlwind = "Whirlwind_10_1";

	private readonly string fx_Alias = "fx_m72013_base_Born";

	private const string warningAlias = "fx_warning_circular_2";

	private const string combo_Die = "Die1_10_1";

	private FP targetRandomRadius = 3.5;

	private FP warningTime = 1.7;

	private FP jumpStagger = 0.6;

	private FP whirlwindDuration = 5.5;

	private FP wanderRadius = 4;

	private FP wanderStopDistance = 0.2;

	private FP traceTriggerDist = 20;

	private FP traceStopDist = 0.5;

	private FP damageImmuneDuration = 0.1;

	protected override void OnSkillEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent { eventName: not null } adventureActorCustomEvent && adventureActorCustomEvent.eventName.Equals("OnCustomEvt"))
		{
			StartCor(DoSomething());
		}
	}

	private IEnumerator DoSomething()
	{
		yield return WaitTime(0.1);
		KillActors(new List<LogicEntity> { _actor });
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		PlayEffect(fx_Alias, 1f, default, GetPosition(), GetEntityAngle(_actor));
		yield return WaitTime(0.2);
		SetHideModelDisable();
		yield return WaitTime(1);
		yield return StartCor(DoJumpAttack());
		yield return StartCor(DoWhirlwind());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator DoJumpAttack()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		Skill_JumpWhirlwind_XuanFengKuiLei_10_1 skill_JumpWhirlwind_XuanFengKuiLei_10_ = this;
		TSVector2 entityPosition = GetEntityPosition(logicEntity);
		FP radius = targetRandomRadius;
		DeterministicShape shapeData = skill_JumpWhirlwind_XuanFengKuiLei_10_.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius);
		TSVector2 landPos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		BeginLookAtByPos(landPos);
		TSVector2 tSVector = TransLocalPosToWorldPos(landPos, landPos - GetPosition(), new TSVector2(0, 2.3));
		Skill_JumpWhirlwind_XuanFengKuiLei_10_1 skill_JumpWhirlwind_XuanFengKuiLei_10_2 = this;
		float duration = (float)warningTime;
		TSVector2 position = tSVector;
		skill_JumpWhirlwind_XuanFengKuiLei_10_2.PlayEarlyWarningEffect("fx_warning_circular_2", duration, default, position, default, 1.7f);
		BeginAttack(1, "JumpAttack", flushInputedKeys: true);
		yield return WaitCustomEvent("JumpStart");
		FP fP = Distance(GetPosition(), landPos);
		yield return CrossJump(landPos, fP / 0.4, 0.4);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator DoWhirlwind()
	{
		BeginAttack(2, "Whirlwind_10_1", flushInputedKeys: true);
		yield return WaitCustomEvent("StartTrace");
		FP endTime = LockStepManager.time + whirlwindDuration;
		FP traceTriggerSq = traceTriggerDist * traceTriggerDist;
		while (LockStepManager.time < endTime)
		{
			LogicEntity currentPlayer = GetCurrentPlayer();
			bool flag = false;
			if (currentPlayer != null)
			{
				flag = TSVector2.DistanceSquared(GetPosition(), GetEntityPosition(currentPlayer)) <= traceTriggerSq;
			}
			if (flag)
			{
				BeginTrace(currentPlayer, traceStopDist, -1, 1);
				yield return WaitTraceFinish();
			}
			else
			{
				Skill_JumpWhirlwind_XuanFengKuiLei_10_1 skill_JumpWhirlwind_XuanFengKuiLei_10_ = this;
				TSVector2 position = GetPosition();
				FP radius = wanderRadius;
				DeterministicShape shapeData = skill_JumpWhirlwind_XuanFengKuiLei_10_.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
				TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
				MoveToPosition(shapeRandomPoint, wanderStopDistance, AdventureActor.MovementMode.Walk);
				yield return WaitMoveStatus();
			}
			yield return null;
		}
		CancelAttack();
		StopMove();
		StopTrace();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(2, "Die1_10_1", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetHideModelEnable();
		ClearActors(new List<LogicEntity> { _actor });
	}
}
