using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._13041MiNieWa;

public class Skill_NormalAttack : SkillSimpleBase
{
	protected readonly int startKeyIndex1 = 1;

	protected readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	protected readonly string TurnAround01 = "TurnAround01";

	protected readonly FP durationT = 99;

	protected readonly FP rotateSpeed = 540;

	protected readonly string StopTurn01 = "StopTurn01";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int keyIndex, string eventName)
	{
		if (eventName.Equals(TurnAround01))
		{
			LogicEntity monsterTarget = _actor.monsterTarget;
			if (CommonUtils.CheckTargetIsValid(monsterTarget, 0L))
			{
				BeginLookAt_NotWait(monsterTarget, durationT, rotateSpeed);
			}
		}
		else if (eventName.Equals(StopTurn01))
		{
			StopLookAt();
		}
	}
}
