#define LOG_DEBUG
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50041XiaoFa;

public class Skill_NormalAttack_Moving : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1];

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	private CoroutineNode UpdateDir;

	private LogicEntity AttackTarget;

	private Dash DashTest;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
		if (AttackTarget == null)
		{
			AttackTarget = GetCurrentPlayer();
		}
		DashTest = new Dash();
	}

	protected override void OnSkillDisable()
	{
		StopCoroutine(UpdateDir);
		StopLookAt();
		StopDash();
	}

	protected override IEnumerator DoMainLogic()
	{
		NovaLogger.Debug("isbeginlookatanddash");
		BeginAttack(1, _actionKey, flushInputedKeys: true);
		if (AttackTarget != null)
		{
			BeginLookAt_NotWait(AttackTarget, 10, 600);
		}
		DashTest.BeginDash(_actor, _actor.tsTransform.Left, 4, 5.2, 600, null, null, null, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		UpdateDir = StartCoroutine(UpdateDirection());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator UpdateDirection()
	{
		while (true)
		{
			yield return WaitFrame(3);
			NovaLogger.Debug("testActorForward : " + _actor.tsTransform.Forward.ToString());
			DashTest._direction = _actor.tsTransform.Left;
		}
	}
}
