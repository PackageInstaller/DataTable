using System.Collections;
using TrueSync;

namespace AIScript.Monster._Hot._70031Huochui;

public class Skill_KuaiJianManJian_Hot : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.M,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string StopAttack_Event = "StopAttack";

	private static readonly string StopTurn_Event = "StopTurn";

	private static readonly string CameraUp_Event = "CameraUp";

	private static readonly string CameraDown_Event = "CameraDown";

	private static readonly string AreaEffectAlias1 = "fx_warning_circular_5";

	private static readonly string AreaEffectAlias2 = "fx_common_base_Dark_YuJing_circular_2";

	private LogicEntity AttackTarget;

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.K,
		ComboInputBuffer.ActionKey._2
	};

	private static readonly FP DashSpeed = 45;

	private static readonly FP DashTime = 0.45;

	private FP TargetDis;

	private static readonly string Dash_Event = "Dash";

	private static readonly string StartTurn_Event = "StartTurn";

	private readonly ComboInputBuffer.ActionKey[] _actionKey3 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey4 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.P,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly string EndPostRock_Event = "EndPostRock";

	private static readonly string KuaiJianManJian_Event = "KuaiJianManJian";

	private static readonly string AreaEffectAlias = "Hot_Skill_03_KuaiJianManJian";

	private readonly ComboInputBuffer.ActionKey[] _actionKey5 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.I,
		ComboInputBuffer.ActionKey._2
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey6 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.U,
		ComboInputBuffer.ActionKey._2
	};

	private static readonly string TeleportStart_Event = "TeleportStart";

	private static readonly string FeiLeiShen_Event = "FeiLeiShen";

	private static readonly string AreaEffectFeiLeiShen = "Hot_Skill_07_FeiLeiShen";

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		TargetDis = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		if (TargetDis < 4)
		{
			BeginLookAt_NotWait(AttackTarget, 1, 360);
			yield return WaitTime(1);
			StopLookAt();
			BeginAttack(1, _actionKey1);
			yield return WaitTime(1.5);
			BeginLookAt_NotWait(AttackTarget, 1, 360);
			yield return WaitTime(0.5);
			StopLookAt();
			yield return WaitFrame(45);
		}
		else
		{
			BeginAttack(2, _actionKey2);
			BeginLookAt_NotWait(AttackTarget, 8, 360);
			yield return WaitCustomEvent(Dash_Event);
			FP fP = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) - 1;
			SetCloseBlockEnable();
			PlayEarlyWarningEffect(AreaEffectAlias2, 0.6f, default, GetEntityPosition(AttackTarget), default, 1.2f, actorScale: true);
			BeginDashActorForward(1, fP / DashTime, fP, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
			SetCloseBlockDisable();
			StopLookAt();
			yield return WaitCustomEvent(StartTurn_Event);
			BeginLookAt_NotWait(AttackTarget, 2, 360);
			yield return WaitFrame(7);
			StopLookAt();
		}
		TargetDis = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		if (TargetDis < 3.5)
		{
			BeginLookAt_NotWait(AttackTarget, 0.2, 360);
			yield return WaitTime(0.2);
			StopLookAt();
			BeginAttack(3, _actionKey3, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent(StartTurn_Event);
		}
		else
		{
			BeginAttack(5, _actionKey4, flushInputedKeys: true, forceInterruptAttack: true);
			BeginLookAt_NotWait(AttackTarget, 5, 360);
			yield return WaitCustomEvent(StopTurn_Event);
			StopLookAt();
			yield return WaitCustomEvent(KuaiJianManJian_Event);
			PlayAreaEffect(AreaEffectAlias, GetPosition(), GetRotation());
			yield return WaitFrame(20);
		}
		if (GetLogicTagToggleValue(_actor, "SkillTag_HotCombo"))
		{
			int num = TSRandom.Range(0, 100);
			int num2 = 1;
			if (num < num2)
			{
				BeginAttack(7, _actionKey5, flushInputedKeys: true, forceInterruptAttack: true);
				BeginLookAt_NotWait(AttackTarget, 8, 360);
				yield return WaitCombo(ComboAttackType.isAnticipationEnd);
				for (int i = 0; i < 3; i++)
				{
					yield return WaitCustomEvent(StopAttack_Event);
				}
				CancelAttack();
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
			else
			{
				BeginAttack(8, _actionKey6, flushInputedKeys: true, forceInterruptAttack: true);
				BeginLookAt_NotWait(AttackTarget, 8, 360);
				yield return WaitCombo(ComboAttackType.isAnticipationEnd);
				yield return WaitCustomEvent(TeleportStart_Event);
				SetHideModelEnable();
				SetUnparalleledEnable();
				yield return WaitCustomEvent(StopAttack_Event);
				TSVector2 entityPosition = GetEntityPosition(AttackTarget);
				PlayEarlyWarningEffect(AreaEffectAlias1, 0.8f, default, entityPosition, default, 0.8f, actorScale: true);
				Teleport(entityPosition);
				StopLookAt();
				yield return WaitTime(0.8f);
				CancelAttack();
				SetUnparalleledDisable();
				SetHideModelDisable();
				yield return WaitCustomEvent(FeiLeiShen_Event);
				PlayAreaEffect(AreaEffectFeiLeiShen, GetPosition(), GetRotation());
				BeginLookAt_NotWait(AttackTarget, 1, 540);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
		yield return WaitTime(1);
	}

	protected override void OnSkillDisable()
	{
		SetCloseBlockDisable();
		SetHideModelDisable();
		SetUnparalleledDisable();
	}
}
