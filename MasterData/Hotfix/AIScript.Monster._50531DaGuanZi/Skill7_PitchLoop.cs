using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50531DaGuanZi;

public class Skill7_PitchLoop : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private static readonly int startKeyIndex2 = 2;

	private static readonly ComboInputBuffer.ActionKey[] startKey2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.N };

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	private static readonly string custom_Shoot = "Shoot";

	private static readonly string Stop_Loop = "Stop";

	private LogicEntity AttackTarget;

	private FP TargetDis;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
	}

	protected override IEnumerator DoMainLogic()
	{
		AttackHint();
		_actor.buffComponent.AddBuff(990010030, _actor);
		_actor.buffComponent.AddBuff(990031100, _actor);
		SetBlockPriorityToStatic();
		BeginAttack(startKeyIndex2, startKey2, flushInputedKeys: true);
		TargetDis = Distance(GetPosition(), new TSVector2(0, 0));
		BeginLookAtByPos(new TSVector2(0, 0), 0.2, 2000, 0);
		yield return WaitTime(0.2);
		BeginDashActorForward(2, 30, TargetDis, 180, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		_actor.buffComponent.RemoveBuffByBuffId(990010030);
		_actor.buffComponent.RemoveBuffByBuffId(990031100);
		yield return WaitTime(1);
		BeginAttack(startKeyIndex1, startKey1, flushInputedKeys: true);
		BeginLookAt_NotWait(AttackTarget, 1.3, 360);
		yield return WaitCustomEvent(custom_StopTurn);
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		int times = 5;
		while (times > 0 && AttackTarget != null)
		{
			yield return WaitCustomEvent(Stop_Loop);
			times--;
		}
		comboAttack.CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		ResetBlockPriority();
		AttackHintCancel();
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName != "Shoot")
		{
			return;
		}
		int num = 8;
		int num2 = 360 / num;
		int num3 = 99;
		int num4 = 0;
		FP fP = 8;
		FP fP2 = 1;
		FP fP3 = num2;
		TSVector2 normalized = GetForward().normalized;
		List<TSVector2> list = new List<TSVector2>();
		for (int i = 0; i < num; i++)
		{
			TSVector2 tSVector = RotateTo(normalized, fP3 * i);
			int num5 = TSRandom.Range(-3, 4);
			while (num5 == num3 && num4 < 50)
			{
				num5 = TSRandom.Range(-3, 4);
				num4++;
			}
			list.Add((fP + fP2 * TSRandom.Range(-3, 4)) * tSVector + GetPosition());
			num3 = num5;
		}
		foreach (TSVector2 item in list)
		{
			TSVector2 position = (item - GetPosition()).normalized + GetPosition();
			FP positionY = 2.7;
			FP range = 1;
			TSVector2 targetPosition = item;
			Shoot("Weapon_50531DaGuanZi_Guan_Bullet", position, positionY, range, default, AimType.Position, BulletDirectionType.ActorToBullet, targetPosition);
		}
	}
}
