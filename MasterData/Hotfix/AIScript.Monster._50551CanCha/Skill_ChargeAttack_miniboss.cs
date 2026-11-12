#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50551CanCha;

public class Skill_ChargeAttack_miniboss : SkillSimpleBase
{
	private long linkFx;

	private bool linkState;

	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private int LoopCount;

	private readonly List<TSVector2> shapePos = new List<TSVector2>
	{
		new TSVector2(7.5, 12.5),
		new TSVector2(7.5, 0),
		new TSVector2(7.5, -10),
		new TSVector2(-7.5, 12.5),
		new TSVector2(-7.5, 0),
		new TSVector2(-7.5, -12.5)
	};

	private List<TSVector2> monsterPos;

	protected override void OnSkillEnable()
	{
		linkState = false;
	}

	protected override void OnSkillDisable()
	{
		if (linkState)
		{
			StopEffect(linkFx);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		NovaLogger.Debug("MiniBoss餐叉猪.ChargeAttack.开始");
		LoopCount = 0;
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		linkFx = Warningline();
		WaitLookAt(GetAttackTarget(), 4.5, GetRotSpdInSkill() * 0.3);
		yield return WaitTime(2);
		TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.2, 1.2));
		yield return WaitTime(0.6);
		PlayEffect("AttackHint", 1f, 0.68, GetPosition(), default, 3f);
		yield return WaitTime(0.3);
		StopEffect(linkFx);
		linkState = false;
		BeginAttack(2, _actionKeys);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == 2)
		{
			LoopCount++;
			if (LoopCount == 3)
			{
				CancelAttack();
			}
		}
	}

	public void SpwanSPMonster(int monsterID)
	{
		bool flag = false;
		if (monsterPos == null)
		{
			monsterPos = new List<TSVector2>();
		}
		else
		{
			monsterPos.Clear();
		}
		for (int i = 0; i < 6; i++)
		{
			TSVector2 position = shapePos.get_Item(i);
			FP width = 15;
			FP length = 15;
			FP rotation = 0;
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
			List<LogicEntity> targetsFromShape = GetTargetsFromShape(shapeData, null, includeSelf: true);
			if (targetsFromShape.Contains(GetAttackTarget()))
			{
				targetsFromShape.Remove(GetAttackTarget());
			}
			if (targetsFromShape.Contains(_actor))
			{
				if (!flag)
				{
					flag = true;
				}
				else
				{
					targetsFromShape.Remove(_actor);
				}
			}
			if (targetsFromShape.Count == 0)
			{
				monsterPos.Add(shapePos.get_Item(i));
			}
		}
		if (monsterPos.Count <= 0)
		{
			return;
		}
		TSVector2 position2 = GetAttackTarget().tsTransform.Position;
		TSVector2 spawnPosition = TSVector2.zero;
		FP fP = -1;
		for (int j = 0; j < monsterPos.Count; j++)
		{
			FP fP2 = Distance(monsterPos.get_Item(j), position2);
			if (fP < 0 || fP2 < fP)
			{
				fP = fP2;
				spawnPosition = monsterPos.get_Item(j);
			}
		}
		SummonTeammate(monsterID, spawnPosition, GetPosition());
	}

	private long Warningline()
	{
		long result = PlayEffect("fx_m50551cancha_loop_redline_common");
		linkState = true;
		return result;
	}
}
