#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai;

public class Skill_Dash : SkillSimpleBase
{
	private readonly string combo_dash = "DashDMG";

	private readonly string combo_shuaiwei = "Drift";

	private readonly string combo_shache = "Dash_Brake";

	private readonly string combo_stun = "DashDMGWeak";

	private readonly FP _acceleration = 20;

	private readonly FP _initialVelocity = 5;

	private readonly FP _maxVelocity = 50;

	private readonly bool _useComboSpd = true;

	private readonly FP _initialComboSpd = 0.5;

	private readonly FP _maxComboSpd = 1.5;

	private readonly FP turnAngle_limit = 240;

	private readonly FP time_max = 5;

	private readonly FP timeStun_1 = 1.5;

	private readonly FP timeStun_2 = 3;

	private readonly FP angle = 180;

	private readonly FP angle_limit_1 = 10;

	private readonly FP angle_limit_2 = 1;

	private readonly string event_shache = "BrakeTurn";

	private readonly string event_shuaiwei = "DriftTurn";

	private bool dashFinish;

	private bool beBreak;

	private FP beginTime;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("冰箱怪.冲锋.Enable");
		SetCloseBlockEnable();
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("冰箱怪.冲锋.Disabel");
		SetCloseBlockDisable();
	}

	private LogicEntity GetTarget()
	{
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		if (CheckTargetIsValid(attackTarget))
		{
			return attackTarget;
		}
		return SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetTarget();
		if (target == null)
		{
			yield break;
		}
		beginTime = _actor.LogicTime;
		dashFinish = false;
		int num = 999;
		BeginDashWithAcc(1, combo_dash, _acceleration, _initialVelocity, _maxVelocity, _useComboSpd, _initialComboSpd, _maxComboSpd, 0.1f, num, turnAngle_limit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 0.5f);
		CoroutineNode lookCor = null;
		if (turnAngle_limit > 0)
		{
			Skill_Dash skill_Dash = this;
			FP rotateSpeed = turnAngle_limit;
			lookCor = skill_Dash.BeginLookAt(target, default, rotateSpeed);
		}
		FP state = GetLogicTagFpValue(_actor, "state");
		while (!dashFinish && beginTime + time_max > _actor.LogicTime)
		{
			yield return null;
		}
		StopCor(lookCor);
		StopDash();
		beBreak = beginTime + time_max > _actor.LogicTime;
		if (beBreak && state > 0)
		{
			BeginAttack(2, combo_stun, flushInputedKeys: true, forceInterruptAttack: true);
			FP waitSeconds = (GetLogicTagToggleValue(_actor, "OddNumer") ? timeStun_2 : timeStun_1);
			yield return WaitTime(waitSeconds);
			CancelAttack();
			yield break;
		}
		TSVector2 normalized = (target.tsTransform.Position - _actor.tsTransform.Position).normalized;
		FP angle_limit = angle_limit_2;
		string eventName = event_shuaiwei;
		FP fP = TSVector2.Angle(normalized, _actor.tsTransform.Forward);
		if (fP < angle / 2 || fP > 360 - angle / 2)
		{
			BeginAttack(3, combo_shache, flushInputedKeys: true, forceInterruptAttack: true);
			angle_limit = angle_limit_1;
			eventName = event_shache;
		}
		else
		{
			BeginAttack(3, combo_shuaiwei, flushInputedKeys: true, forceInterruptAttack: true);
		}
		yield return WaitCustomEvent(eventName);
		if (angle_limit > 0)
		{
			lookCor = BeginLookAt(target, default, angle_limit);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopCor(lookCor);
	}

	protected override void OnDashFinish(int index)
	{
		dashFinish = true;
	}

	protected override void DashFinishByObstacle(int index)
	{
		dashFinish = true;
	}
}
