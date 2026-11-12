using System.Collections;
using TrueSync;

namespace AIScript.Monster._50582FeiXingDengPao;

public class Surround_2_Lv3 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_1 = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Attack_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Attack_3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly ComboInputBuffer.ActionKey[] Attack_4 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected readonly FP dash_spd = 8f;

	protected readonly FP dash_angle = 90;

	protected readonly FP dash_angleLimit = 60;

	protected readonly string fx_dash = "fx_m50231_loop_Skill1_crush";

	protected FP dis;

	protected override void OnSkillEnable()
	{
		SetSuperArmorEnable();
		AddBuffToTarget(_actor, 880010102);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		GetAttackTarget();
		BeginAttack(1, Attack_1, flushInputedKeys: true, forceInterruptAttack: true);
		dis = 300000f;
		doDash(dis);
		BeginLookAtByPos(new TSVector2(0, 0), 9999, dash_angle);
		for (FP livetime = 60; livetime > 0f; livetime -= (FP)0.03)
		{
			if (_actor.buffComponent.CheckBuffByBuffID(505810001))
			{
				StopDash();
				StopWaitLookAt();
				BeginLookAtByPos(new TSVector2(5, -5), 10, 300);
				Teleport(new TSVector2(5, -5));
				BeginAttack(2, Attack_2, flushInputedKeys: true, forceInterruptAttack: true);
				RemoveBuffFromTarget(_actor, 880010102);
				RemoveBuffFromTarget(_actor, 990013100);
				RemoveBuffFromTarget(_actor, 990021100);
				RemoveBuffFromTarget(_actor, 990010030);
				RemoveBuffFromTarget(_actor, 990010050);
				FP explodetime = 10;
				while (explodetime > 0f)
				{
					if (_actor.buffComponent.CheckBuffByBuffID(505810002))
					{
						BeginAttack(3, Attack_3, flushInputedKeys: true, forceInterruptAttack: true);
						yield return WaitTime(3);
						CancelAttack();
						RemoveBuffFromTarget(_actor, 505810001);
						yield return WaitTime(0.05);
						SetHideModelEnable();
						yield return WaitCombo(ComboAttackType.isComboFinish);
						_actor.ClearMonsterSelf();
					}
					else if (_actor.buffComponent.CheckBuffByBuffID(505810003))
					{
						_actor.DestroySelf();
					}
					explodetime -= (FP)0.03;
					yield return WaitTime(0.03);
				}
				BeginAttack(3, Attack_3, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(2);
				CancelAttack();
				RemoveBuffFromTarget(_actor, 505810001);
				yield return WaitTime(0.05);
				SetHideModelEnable();
				yield return WaitCombo(ComboAttackType.isComboFinish);
				SummonTeammate(4, GetEntityPositionObsoleted(_actor), new TSVector2(0, -1));
				_actor.ClearMonsterSelf();
			}
			yield return WaitTime(0.03);
		}
		yield return WaitTime(1);
		_actor.DestroySelf();
	}

	private void doDash(FP dis)
	{
		BeginDashActorForward(1, dash_spd, dis, dash_angleLimit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
