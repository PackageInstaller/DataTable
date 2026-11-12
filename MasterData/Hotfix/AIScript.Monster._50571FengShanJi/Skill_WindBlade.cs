using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Skill_WindBlade : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] WindBlade_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.J };

	private static readonly List<TSVector2> BalloonPositionOffset = new List<TSVector2>
	{
		new TSVector2(2.5, 4),
		new TSVector2(1.25, 4),
		new TSVector2(0, 4),
		new TSVector2(-1.25, 4),
		new TSVector2(-2.5, 4)
	};

	private FP Difficulty;

	protected override void OnSkillEnable()
	{
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAt(GetAttackTarget(), 0, 200);
		BeginAttack(1, WindBlade_Combo, flushInputedKeys: true);
		if (Difficulty == 3)
		{
			foreach (TSVector2 item in BalloonPositionOffset)
			{
				TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetForward(), item);
				if (QueryPositionReachable(_actor, tSVector))
				{
					SummonTeammate(2, tSVector, tSVector - GetPosition());
				}
			}
		}
		if (Difficulty != 3)
		{
			WaitLookAt_NoWait(GetAttackTarget(), 999, 50);
		}
		yield return WaitCustomEvent("StopTurn");
		Skill_WindBlade skill_WindBlade = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_WindBlade.PlayEarlyWarningEffect("CrushWarningLine2", 0.76f, default, position, rotation, 0.75f);
		StopWaitLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
