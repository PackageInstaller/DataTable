using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._13041MiNieWa;

public class Skill_Sweep : SkillSimpleBase
{
	protected readonly int startKeyIndex1 = 1;

	protected readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected readonly string TurnAround02 = "TurnAround02";

	protected readonly FP durationT = 99;

	protected readonly FP rotateSpeed = 0;

	protected readonly string StopTurn02 = "StopTurn02";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int keyIndex, string eventName)
	{
		if (eventName.Equals(TurnAround02))
		{
			LogicEntity monsterTarget = _actor.monsterTarget;
			if (CommonUtils.CheckTargetIsValid(monsterTarget, 0L))
			{
				BeginLookAt_NotWait(monsterTarget, durationT, rotateSpeed);
			}
		}
		else if (eventName.Equals(StopTurn02))
		{
			StopLookAt();
		}
	}
}
