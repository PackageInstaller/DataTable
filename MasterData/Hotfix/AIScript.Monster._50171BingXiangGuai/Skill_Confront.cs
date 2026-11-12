#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai;

public class Skill_Confront : SkillSimpleBase
{
	private readonly string combo_TrunKey = "NormalAtk";

	private readonly string combo_left_move = "Confront2L";

	private readonly string combo_right_move = "Confront2R";

	private readonly FP turnAngle_limit = 90;

	private readonly string event_start = "StartToTurn";

	private readonly string even_end = "StopTurn";

	private readonly int loopCount_Normal = 3;

	private readonly FP checkRadius = 5;

	private readonly FP checkAngle = 120;

	private readonly FP distance_b = 15;

	private readonly FP _moveSpeedRatioAbsAmend = 0.5;

	private readonly FP time_min = 1;

	private readonly FP time_max = 6;

	private readonly FP controlPointX_Offset = 0.5;

	private readonly FP controlPointY_Offset = 0.5;

	private bool inRange;

	private int index;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("Skill_Confront==OnSkillEnable");
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("Skill_Confront==OnSkillDisable");
	}

	private FP CrossProduct2D(TSVector2 a, TSVector2 b)
	{
		return a.x * b.y - a.y * b.x;
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayerAdventureActor target = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (target == null)
		{
			yield break;
		}
		TSVector2 targetPos = new TSVector2(0, 0);
		TSVector2 direction = _actor.tsTransform.Position.normalized;
		CoroutineNode lookCor = null;
		if (TSVector2.Angle(-direction, _actor.tsTransform.Forward) > 10)
		{
			BeginAttack(1, combo_TrunKey, flushInputedKeys: true, forceInterruptAttack: true);
			index = 0;
			yield return WaitCustomEvent(event_start);
			if (turnAngle_limit > 0)
			{
				Skill_Confront skill_Confront = this;
				TSVector2 targetPos2 = targetPos;
				FP rotateSpeed = turnAngle_limit;
				lookCor = skill_Confront.BeginLookAtByPos(targetPos2, default, rotateSpeed);
			}
			yield return WaitCustomEvent(even_end);
			StopCor(lookCor);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		TSVector2 normalized = (target.tsTransform.Position - _actor.tsTransform.Position).normalized;
		FP fP = CrossProduct2D(-direction, normalized);
		targetPos = _actor.tsTransform.Position + _actor.tsTransform.Forward.normalized * distance_b;
		string actionKey = combo_left_move;
		FP offset_y = controlPointY_Offset;
		if (fP < 0)
		{
			offset_y = -controlPointY_Offset;
			actionKey = combo_right_move;
		}
		inRange = true;
		BeginAttack(2, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginBezierPathMove(1, targetPos, controlPointX_Offset, offset_y, comboWithAttack: true, _moveSpeedRatioAbsAmend, AdventureActor.MovementMode.Run, 80, time_max);
		yield return WaitTime(time_min);
		while (inRange)
		{
			FP fP2 = CalcAngleBetweenSelfAndAttackTarget();
			FP fP3 = _actor.DistanceWithRadius(target);
			if (fP2 > checkAngle || fP3 > checkRadius)
			{
				inRange = false;
			}
			yield return WaitTime(0.1);
		}
		CancelAttack();
		CancelBezierPathMove();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(3, combo_TrunKey, flushInputedKeys: true, forceInterruptAttack: true);
		index = 0;
		yield return WaitCustomEvent(event_start);
		if (turnAngle_limit > 0)
		{
			Skill_Confront skill_Confront2 = this;
			FP rotateSpeed = turnAngle_limit;
			lookCor = skill_Confront2.BeginLookAt(target, default, rotateSpeed);
		}
		yield return WaitCustomEvent(even_end);
		StopCor(lookCor);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex != 2)
		{
			index++;
			if (index >= loopCount_Normal)
			{
				CancelAttack();
			}
		}
	}

	protected override void OnLookAtComplete()
	{
		base.OnLookAtComplete();
	}

	protected override void OnBezierPathMoveFinish(int index, bool reachTerminal)
	{
		base.OnBezierPathMoveFinish(index, reachTerminal);
		if (inRange)
		{
			_skill.Clear();
		}
	}
}
