using System.Collections;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_JumpWhirlwind_XuanFengKuiLei : SkillSimpleBase
{
	private const string combo_JumpAttack = "JumpAttack";

	private const string combo_Whirlwind = "Whirlwind";

	private const string warningAlias = "fx_warning_circular_2";

	private FP targetRandomRadius = 6;

	private FP warningTime = 1.7;

	private FP jumpStagger = 0.6;

	private FP whirlwindDuration = 3;

	private FP wanderRadius = 4;

	private FP wanderStopDistance = 0.2;

	private FP traceTriggerDist = 5;

	private FP traceStopDist = 3;

	private FP damageImmuneDuration = 0.1;

	protected override IEnumerator DoMainLogic()
	{
		while (!GetLogicTagToggleValue(_actor, Common_73001.PuppetSync_Tag))
		{
			yield return null;
		}
		int num = (int)(long)GetLogicTagFpValue(_actor, Common_73001.PuppetSeqIndex_Tag);
		yield return WaitTime(jumpStagger * num);
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
		Skill_JumpWhirlwind_XuanFengKuiLei skill_JumpWhirlwind_XuanFengKuiLei = this;
		TSVector2 entityPosition = GetEntityPosition(logicEntity);
		FP radius = targetRandomRadius;
		DeterministicShape shapeData = skill_JumpWhirlwind_XuanFengKuiLei.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius);
		TSVector2 landPos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		BeginLookAtByPos(landPos);
		TSVector2 tSVector = TransLocalPosToWorldPos(landPos, landPos - GetPosition(), new TSVector2(0, 2.3));
		Skill_JumpWhirlwind_XuanFengKuiLei skill_JumpWhirlwind_XuanFengKuiLei2 = this;
		float duration = (float)warningTime;
		TSVector2 position = tSVector;
		skill_JumpWhirlwind_XuanFengKuiLei2.PlayEarlyWarningEffect("fx_warning_circular_2", duration, default, position, default, 1.7f);
		BeginAttack(1, "JumpAttack", flushInputedKeys: true);
		yield return WaitCustomEvent("JumpStart");
		FP fP = Distance(GetPosition(), landPos);
		yield return CrossJump(landPos, fP / 0.4, 0.4);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator DoWhirlwind()
	{
		BeginAttack(2, "Whirlwind", flushInputedKeys: true);
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
				Skill_JumpWhirlwind_XuanFengKuiLei skill_JumpWhirlwind_XuanFengKuiLei = this;
				TSVector2 position = GetPosition();
				FP radius = wanderRadius;
				DeterministicShape shapeData = skill_JumpWhirlwind_XuanFengKuiLei.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
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
	}
}
