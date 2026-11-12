using System.Collections;
using TrueSync;

namespace AIScript.Monster._50032ShuangJian;

public class Skill_Fire_Attack_02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack02 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

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

	private static readonly string ChargeTo = "Charge";

	private static readonly string DashTo = "DashStart";

	private readonly string Area = "AreaEffect_ShuangJian_Fire";

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		BeginAttack(1, Attack01, flushInputedKeys: true);
		BeginLookAt_NotWait(logicEntity, 0.3, 720);
		yield return WaitCustomEvent(ChargeTo);
		StopWaitLookAt();
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(DashTo);
		Dash_Start();
		yield return WaitTime(0.04);
		AreaEffect();
		yield return WaitTime(0.04);
		AreaEffect();
		yield return WaitTime(0.04);
		AreaEffect();
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Dash_Start()
	{
		BeginDashActorForward(1, 45, 8, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void AreaEffect()
	{
		TSVector2 position = _actor.tsTransform.Position;
		PlayAreaEffect(Area, position);
	}
}
