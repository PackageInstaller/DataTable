#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai;

public class Skill_Move : SkillSimpleBase
{
	private readonly string combo_key = "DashNoDMG";

	private readonly FP turnAngle_limit = 90;

	private readonly FP move_speed = 7;

	private readonly FP time_move = 2;

	private readonly FP stopDistance = 3;

	private readonly FP turnAngle_limit_toPos = 90;

	private readonly FP stopDistance_move = 0.2;

	private bool beginDash;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("冰箱怪.移动.Enable");
		beginDash = false;
		SetCloseBlockEnable();
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("冰箱怪.移动.Disable");
		SetCloseBlockDisable();
		Parallel_1.toPos = false;
		Parallel_1.safemove = false;
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, combo_key, flushInputedKeys: true, forceInterruptAttack: true);
		FP distance = move_speed * time_move;
		beginDash = true;
		BeginDashActorForward(1, move_speed, distance, turnAngle_limit, comboWithAttack: true, isAngle: true, notChangeForward: false, Parallel_1.toPos, triggerEnemyStop: true, triggerFriendStop: false, Parallel_1.safemove ? 0.05 : 0.3);
		CoroutineNode lookCor = null;
		if (Parallel_1.toPos)
		{
			Skill_Move skill_Move = this;
			TSVector2 targetPos = Parallel_1.targetPos;
			FP rotateSpeed = turnAngle_limit_toPos;
			lookCor = skill_Move.BeginLookAtByPos(targetPos, default, rotateSpeed);
		}
		else if (turnAngle_limit > 0)
		{
			lookCor = BeginLookAtMonsterTarget(999, turnAngle_limit);
		}
		yield return WaitDashFinish();
		beginDash = false;
		if (lookCor != null)
		{
			StopCor(lookCor);
			StopLookAt();
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void DashFinishByObstacle(int index)
	{
	}

	public void OnUpdate()
	{
		if (!beginDash)
		{
			return;
		}
		if (Parallel_1.toPos)
		{
			if (TSVector2.Distance(_actor.tsTransform.Position, Parallel_1.targetPos) <= stopDistance_move)
			{
				StopDash();
			}
		}
		else if (_actor.monsterTarget != null && _actor.DistanceWithRadius(_actor.monsterTarget) < stopDistance)
		{
			StopDash();
		}
	}
}
