using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu.HorrorGhost;

public class Skill3_Crush : SkillSimpleBase
{
	private const string ComboKey = "Skill3_Crush";

	private static readonly FP TurnTime = 1;

	private static readonly FP TurnSpeed = 120;

	private static readonly FP ChargeTime = 2;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		if (logicEntity != null)
		{
			BeginLookAt_NotWait(logicEntity, TurnTime, TurnSpeed);
		}
		BeginAttack(0, "Skill3_Crush", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(ChargeTime);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
