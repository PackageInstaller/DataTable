using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu.HorrorGhost;

public class Skill1_DoubleSlash : SkillSimpleBase
{
	private const string ComboKey = "Skill1_DoubleSlash";

	private const string SlashTurnEvent = "turnEvent";

	private static readonly FP TurnDuration = 0.2;

	private static readonly FP TurnSpeed = 250;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		if (target == null)
		{
			target = GetCurrentPlayer();
		}
		if (target != null)
		{
			BeginLookAt_NotWait(target, TurnDuration, TurnSpeed);
		}
		BeginAttack(0, "Skill1_DoubleSlash", flushInputedKeys: true, forceInterruptAttack: true);
		for (int i = 0; i < 2; i++)
		{
			yield return WaitCustomEvent("turnEvent");
			if (target != null)
			{
				BeginLookAt_NotWait(target, TurnDuration, TurnSpeed);
			}
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
