using System.Collections;
using TrueSync;

namespace AIScript.Monster._10004YeZhu;

public class Skill_CommonDash_Hardcore : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Dash_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected readonly FP Dash_spd = 16;

	protected readonly FP Dash_Spd_B = 6;

	protected readonly FP Dash_Dis_B = 3;

	private long FxLoopA;

	private long FxLoopB;

	private FP DashDistance;

	private FP DashTime;

	private int SkillMode;

	protected override void OnSkillEnable()
	{
		DashTime = GetLogicTagFpValue(_actor, "DashTime");
		if (DashTime == 0)
		{
			SetSuperArmorEnable();
			SetBlockPriorityToStatic();
		}
		if (GetTargetByTeammateIndex(3).Count >= 5 && DashTime < 2)
		{
			SkillMode = 1;
		}
		else
		{
			SkillMode = 2;
			InterruptSuperArmor();
			ResetBlockPriority();
		}
		DashTime += (FP)1;
		SetLogicTagFpValue(_actor, "DashTime", DashTime);
	}

	protected override void OnSkillDisable()
	{
		StopEffect(FxLoopA);
		StopEffect(FxLoopB);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (SkillMode == 2)
		{
			yield return WaitLookAt(GetAttackTarget(isUpToDate: true), 1, 250);
		}
		BeginAttack(1, Dash_Combo, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		Skill_CommonDash_Hardcore skill_CommonDash_Hardcore = this;
		Skill_CommonDash_Hardcore skill_CommonDash_Hardcore2 = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_CommonDash_Hardcore.FxLoopA = skill_CommonDash_Hardcore2.PlayEffect("Dash", 1f, default, position, rotation);
		if (SkillMode == 2)
		{
			DashDistance = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) + 4;
		}
		else
		{
			DashDistance = 12;
		}
		BeginDashActorForward(1, Dash_spd, DashDistance, 0, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		StopEffect(FxLoopA);
		BeginAttack(2, Dash_Combo);
		BeginDashActorForward(2, Dash_Spd_B, Dash_Dis_B, 0, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		Skill_CommonDash_Hardcore skill_CommonDash_Hardcore3 = this;
		Skill_CommonDash_Hardcore skill_CommonDash_Hardcore4 = this;
		position = GetPosition();
		rotation = GetRotation();
		skill_CommonDash_Hardcore3.FxLoopB = skill_CommonDash_Hardcore4.PlayEffect("DashEnd", 1f, default, position, rotation);
		yield return WaitDashFinish();
		StopEffect(FxLoopB);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (SkillMode == 1)
		{
			yield return BeginRotateAngle(180, 150);
		}
	}
}
