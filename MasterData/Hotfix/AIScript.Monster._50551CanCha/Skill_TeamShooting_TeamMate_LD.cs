#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50551CanCha;

public class Skill_TeamShooting_TeamMate_LD : SkillSimpleBase
{
	private long warningFxID;

	private List<LogicEntity> mateList = new List<LogicEntity>();

	private readonly int actionIndex;

	private readonly string actionKey = "ChargeAttack";

	protected override void OnSkillEnable()
	{
		mateList.Clear();
		SetSearchedImmunityEnable();
		SetLogicTagToggleValue(_actor, "ATKOrder", value: false);
		NovaLogger.Debug("餐叉猪召唤物.射击矩阵技能.开始");
	}

	protected override void OnSkillDisable()
	{
		StopEffect(warningFxID);
		NovaLogger.Debug("餐叉猪召唤物.射击矩阵技能.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		for (int i = 0; i < 10000; i++)
		{
			if (GetLogicTagToggleValue(_actor, "ATKOrder"))
			{
				NovaLogger.Debug("餐叉猪召唤物.射击矩阵技能.检测自身攻击标签.开始攻击");
				yield return BeginLookAtByDir(TSVector2.down, 0.1, 9999);
				BeginAttack(actionIndex, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
				warningFxID = PlayEffect("fx_m50551_loop_ChargeAttack_warning_miniboss", 0.5f, default, GetPosition(), GetTSVectToAngle(GetForward(), 0));
				yield return WaitTime(1.8);
				CancelAttack();
				StopEffect(warningFxID);
				yield return WaitCombo(ComboAttackType.isComboFinish);
				InterruptSkill();
			}
			if (GetLogicTagToggleValue(_actor, "MoveToPOS"))
			{
				MoveToPosition(new TSVector2(GetPosition().x, 7), 0, AdventureActor.MovementMode.Run, default, _stopDisIgnoreRadius: false);
				yield return WaitMoveStatus();
			}
			mateList.AddRange(GetTargetByTeammateIndex(0));
			if (mateList.Count > 0 && mateList.get_Item(0).IsDead())
			{
				InterruptSkill();
			}
			yield return WaitTime(0.05);
		}
	}
}
