using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_Dash : SimpleAPI_FengNiao
{
	private static readonly ComboInputBuffer.ActionKey[] Dash_Start_Combo = new ComboInputBuffer.ActionKey[2];

	private static readonly ComboInputBuffer.ActionKey[] Dash_Plus_Start_Combo = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey.B
	};

	private static readonly ComboInputBuffer.ActionKey[] Dash_Plus_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Dash_End_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly FP DashSpeed = 60;

	private static readonly FP DashDistance = 15;

	private LogicEntity AttackTarget;

	private FP Phase;

	private int BirdCount;

	private List<LogicEntity> Bird;

	private int BirdCountIndex;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
		Phase = GetLogicTagFpValue(_actor, "BattleStage");
		BirdCountIndex = 0;
		Bird = new List<LogicEntity>();
	}

	protected override void OnSkillDisable()
	{
		StopWaitLookAt();
		Bird.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitLookAt(AttackTarget, 0.25, 720);
		yield return StartCor(FlashBeforeAttackForFengNiao(9, 3, 30, 300, 6, 3));
		yield return WaitLookAt(AttackTarget, 0.1, 1800);
		if (Phase == 1)
		{
			yield return StartCor(DashAttackP1());
		}
		else
		{
			yield return StartCor(DashAttackP2());
		}
		yield return StartCor(WanderActForFengNiao());
	}

	private IEnumerator DashAttackP1()
	{
		BeginAttack(1, Dash_Start_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(AttackTarget, 999, 150);
		yield return WaitTime(0.3);
		StopWaitLookAt();
		Skill_Dash skill_Dash = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Dash.PlayEarlyWarningEffect("DashWarning", 0.75f, default, position, rotation);
		yield return WaitTime(0.7);
		BeginDashActorForward(1, DashSpeed, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator DashAttackP2()
	{
		yield return StartCor(SummonBeforeSkillForFengNiao("CastDashSkill"));
		Bird.AddRange(GetTargetByTeammateIndexes(new List<int> { 3, 4 }));
		BirdCount = Bird.Count;
		BeginAttack(1, Dash_Plus_Start_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(AttackTarget, 999, 150);
		yield return WaitTime(0.3);
		StopWaitLookAt();
		SmallBirdDashAttack();
		Skill_Dash skill_Dash = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Dash.PlayEarlyWarningEffect("DashWarning", 0.75f, default, position, rotation);
		yield return WaitTime(0.7);
		BeginDashActorForward(1, DashSpeed, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		BeginAttack(3, Dash_Plus_Combo);
		AttackTarget = GetAttackTarget(isUpToDate: true);
		BeginLookAt_NotWait(AttackTarget, 999, 1500);
		yield return WaitTime(0.3);
		StopWaitLookAt();
		Skill_Dash skill_Dash2 = this;
		position = GetPosition();
		rotation = GetRotation();
		skill_Dash2.PlayEarlyWarningEffect("DashWarning", 0.75f, default, position, rotation);
		yield return WaitTime(0.4);
		BeginDashActorForward(1, DashSpeed, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		CancelAttack();
		FlowerShootStart();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void SmallBirdDashAttack()
	{
		FP value = 0;
		while (BirdCountIndex < BirdCount)
		{
			SetLogicTagFpValue(Bird.get_Item(BirdCountIndex), "AttackTime", value);
			BirdCountIndex++;
			value += (FP)0.25;
		}
	}
}
