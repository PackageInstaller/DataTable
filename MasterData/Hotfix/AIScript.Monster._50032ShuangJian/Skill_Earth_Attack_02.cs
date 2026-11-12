#define LOG_DEBUG
using System.Collections;

namespace AIScript.Monster._50032ShuangJian;

public class Skill_Earth_Attack_02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._0
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._2
	};

	private static readonly string ComboAttack = "ComboAttack";

	private static readonly string ChargeTo = "Charge";

	private static readonly string DashTo = "DashStart";

	private long Effect;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(logicEntity, 0.3, 720);
		yield return WaitCustomEvent(ChargeTo);
		StopWaitLookAt();
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(DashTo);
		Dash_Start();
		yield return WaitDashFinish();
		CancelAttack();
		BeginAttack(3, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
		NovaLogger.Debug("触发结束");
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Dash_Start()
	{
		BeginDashActorForward(1, 50, 8, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
