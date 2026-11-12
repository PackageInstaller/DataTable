#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50551CanCha;

public class Skill_UltimateShoot : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKey_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] _actionKey_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	private FP ShootPoint_y = 10;

	private FP ChargeTime = 2;

	private FP PerChargeTime = 0.2;

	private TSVector2 AimPoint;

	private TSVector2 KillPos = new TSVector2(0, 30);

	private LogicEntity target;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("MiniBoss餐叉猪.UltimateShoot.开始");
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetLogicTagToggleValue(_actor, "TeamShooting"))
		{
			InterruptSkill();
			yield break;
		}
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			target = GetAttackTarget();
		}
		else
		{
			target = GetCurrentPlayer();
		}
		BeginAttack(1, _actionKey_1, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StartCor(SpanSPMonster());
		yield return BeginLookAt(target, 2, GetRotSpdInSkill() * 0.2);
		TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1));
		yield return WaitLookAt(GetAttackTarget(), 0.25, GetRotSpdInSkill() * 0.2);
		StopWaitLookAt();
		Skill_UltimateShoot skill_UltimateShoot = this;
		TSVector2 position = GetPosition();
		FP entityAngle = GetEntityAngle(_actor);
		skill_UltimateShoot.PlayEffect("fx_warning_square_3side_2_8x35", 1f, default, position, entityAngle);
		yield return WaitTime(0.75);
		PlayEffect("AttackHint", 1f, 0.68, GetPosition(), default, 3f);
		yield return WaitTime(0.25);
		BeginAttack(1, _actionKey_2);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator SpanSPMonster()
	{
		List<TSVector2> list = new List<TSVector2>
		{
			new TSVector2(7.5, -12.5),
			new TSVector2(-7.5, -12.5),
			new TSVector2(7.5, 0),
			new TSVector2(-7.5, 0)
		};
		new List<LogicEntity>();
		int index = 1;
		int index2 = 2;
		int count = list.Count;
		for (int i = 0; i < count; i++)
		{
			if (i < 2)
			{
				SummonTeammate(index2, list.get_Item(i), GetPosition());
			}
			else
			{
				SummonTeammate(index, list.get_Item(i), GetPosition());
			}
		}
		yield return null;
	}
}
