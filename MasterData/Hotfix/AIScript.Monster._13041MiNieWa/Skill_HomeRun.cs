using System.Collections;
using TrueSync;

namespace AIScript.Monster._13041MiNieWa;

public class Skill_HomeRun : SkillSimpleBase
{
	protected readonly int startKeyIndex1 = 1;

	protected readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	protected readonly string TurnAround05 = "TurnAround05";

	protected readonly FP durationT = 99;

	protected readonly FP rotateSpeed = 360;

	protected readonly string StopTurn05 = "StopTurn05";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int keyIndex, string eventName)
	{
		if (eventName.Equals(TurnAround05))
		{
			BeginLookAt_NotWait(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor, durationT, rotateSpeed);
		}
		else if (eventName.Equals(StopTurn05))
		{
			StopLookAt();
		}
	}
}
