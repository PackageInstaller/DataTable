using System.Collections;
using TrueSync;

namespace AIScript.Monster._17021ChangQiangQishi;

public class Skill2_Touzhi : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly string area_1 = "AreaEffect_17021_Skill2_TouZhi_1";

	private static readonly string prfx = "fx_common_base_Wind_YuJing_circular_4";

	private static readonly string Startfx = "fx_17021ChangQiangQishi_loop_attack1_loop_01";

	private ComboInputBuffer.ActionKey[] _actionkey;

	private bool breakOff;

	private long spear;

	private readonly int checkbuff = 170210010;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		if (breakOff)
		{
			StopAreaEffect(spear);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		if (target == null)
		{
			GetCurrentPlayer();
			yield break;
		}
		if (CalcAngleBetweenSelfAndAttackTarget() >= 10)
		{
			BeginAttack(1, Attack_Combo2, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(1f);
			AimAtTarget(target, 400);
			yield return WaitTime(0.6f);
			CancelAim();
			CancelAttack();
			yield return WaitTime(0.3f);
		}
		else
		{
			BeginLookAt(target, 0.3f, 300);
		}
		BeginAttack(2, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		FP dis = Distance(GetPosition(), GetEntityPosition(target));
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, dis));
		spear = PlayAreaEffect(area_1, position, GetTSVectToAngle(GetForward(), 0));
		yield return WaitTime(1.73f);
		FP fP = dis + 3.5f;
		fP = ((fP < 5) ? ((FP)5) : fP);
		int num = 24;
		BeginDash(1, GetForward(), num, fP, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		SetCloseBlockEnable();
		yield return WaitTime(fP / num - 0.1f);
		StopAreaEffect(spear);
		CancelAttack();
		SetCloseBlockDisable();
		yield return WaitTime(0.2f);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
