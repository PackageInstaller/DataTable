#define LOG_ERROR
using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_UltraBirdBomb : SimpleAPI_FengNiao
{
	private static readonly ComboInputBuffer.ActionKey[] UltraBirdBomb_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.J };

	private static readonly FP AreaMoveSpeedLv1_2 = 1.5;

	private static readonly FP AreaMoveSpeedLv3 = 2.5;

	private long AttackShapeAreaID;

	private FP Difficulty;

	private FP AreaMoveSpeed;

	private AreaEffectEntity AttackShapeArea;

	private CoroutineNode MoveAttackAreaCorNode;

	private CoroutineNode UpdateAreaPositionCorNode;

	private bool IsBossRush;

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "UltraSkillReady", value: false);
		SetLogicTagToggleValue(_actor, "InFlowerAwakenSkill", value: true);
		SetLogicTagToggleValue(_actor, "InterruptShootSkill", value: true);
		SetLogicTagToggleValue(_actor, "UltraSkillAchievementReady", value: false);
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
		IsBossRush = GetLogicTagToggleValue(_actor, "IsBossRush");
		if (!IsBossRush)
		{
			if (Difficulty == 3)
			{
				AreaMoveSpeed = AreaMoveSpeedLv3;
			}
			else
			{
				AreaMoveSpeed = AreaMoveSpeedLv1_2;
			}
		}
		else
		{
			AreaMoveSpeed = AreaMoveSpeedLv3;
		}
		(GetCurrentPlayer() as AdventureActor).InPerfectDodge = true;
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(_actor, "UltraSkillReady", value: false);
		SetLogicTagToggleValue(_actor, "FastRecoverFlower", value: false);
		SetLogicTagToggleValue(_actor, "UltraSkilling", value: false);
		SetLogicTagToggleValue(_actor, "InFlowerAwakenSkill", value: false);
		SetLogicTagToggleValue(_actor, "InterruptShootSkill", value: false);
		SetLogicTagToggleValue(_actor, "UltraSkillAchievementReady", value: false);
		RemoveBuffFromTarget(_actor, 990020140);
		ResetBlockPriority();
		StopAreaEffect(AttackShapeAreaID);
		(GetCurrentPlayer() as AdventureActor).InPerfectDodge = false;
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return StartCor(FlashBeforeAttackForFengNiaoToFixedPosition(TSVector2.zero));
		SetBlockPriorityToStatic();
		AddBuffToTarget(_actor, 990020140);
		yield return BeginLookAtByDir(TSVector2.down, 0.1, 1800);
		BeginAttack(1, UltraBirdBomb_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		SetLogicTagFpValue(_actor, "LightDistance", 99);
		SetLogicTagToggleValue(_actor, "FastRecoverFlower", value: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		SetLogicTagToggleValue(_actor, "UltraSkilling", value: true);
		SetLogicTagToggleValue(_actor, "FastRecoverFlower", value: false);
		yield return WaitTime(1.5);
		AttackShapeAreaID = PlayAreaEffect("AreaEffect_Bomb_Warning_L", GetEntityPositionObsoleted(GetAttackTarget(isUpToDate: true)));
		AttackShapeArea = GetAreaEffect(AttackShapeAreaID);
		if (AttackShapeArea == null)
		{
			NovaLogger.Error("蜂鸟大招的攻击区域创建失败，技能直接跳过");
			InterruptSkill();
			yield break;
		}
		StartCor(ref UpdateAreaPositionCorNode, UpdateAreaPosition());
		yield return WaitTime(1);
		SetLogicTagToggleValue(_actor, "UltraSkillReady", value: true);
		yield return WaitTime(2);
		SetLogicTagToggleValue(_actor, "UltraSkillAchievementReady", value: true);
		StartCor(ref MoveAttackAreaCorNode, MoveAttackAreaCor());
		yield return WaitTime(8);
		SetLogicTagToggleValue(_actor, "UltraSkillAchievementReady", value: false);
		StopCor(UpdateAreaPositionCorNode);
		StopCor(MoveAttackAreaCorNode);
		StopAreaEffect(AttackShapeAreaID);
		BeginAttack(2, UltraBirdBomb_Combo);
		SetLogicTagToggleValue(_actor, "UltraSkilling", value: false);
		SetLogicTagToggleValue(_actor, "InFlowerAwakenSkill", value: false);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
	}

	private IEnumerator MoveAttackAreaCor()
	{
		while (true)
		{
			if (Distance(AttackShapeArea.tsTransform.Position, GetEntityPositionObsoleted(GetAttackTarget(isUpToDate: true))) > 0.2)
			{
				AttackShapeArea.tsTransform.Position += (GetEntityPositionObsoleted(GetAttackTarget(isUpToDate: true)) - AttackShapeArea.tsTransform.Position).normalized * AreaMoveSpeed / 30;
			}
			yield return null;
		}
	}

	private IEnumerator UpdateAreaPosition()
	{
		while (true)
		{
			SetLogicTagFpValue(_actor, "UltraAreaX", AttackShapeArea.tsTransform.Position.x);
			SetLogicTagFpValue(_actor, "UltraAreaY", AttackShapeArea.tsTransform.Position.y);
			yield return null;
		}
	}
}
