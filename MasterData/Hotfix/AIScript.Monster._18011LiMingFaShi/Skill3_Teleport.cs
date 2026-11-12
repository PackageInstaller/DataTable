using System.Collections;
using TrueSync;

namespace AIScript.Monster._18011LiMingFaShi;

public class Skill3_Teleport : SkillSimpleBase
{
	private readonly string Skill3 = "Skill3_Teleport";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Skill3, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Teleport_Start");
		SetHideModelEnable();
		SetUnparalleledEnable();
		SetCloseBlockEnable();
		FP distanceWithTarget = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		TSVector2 position = GetPosition();
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		TSVector2 normalized = (position - entityPosition).normalized;
		TSVector2 targetPosition;
		if (distanceWithTarget <= 5)
		{
			targetPosition = position + normalized * 5;
		}
		else if (distanceWithTarget >= 10)
		{
			targetPosition = entityPosition + normalized * 7;
		}
		else
		{
			FP angle = TSRandom.value * 360;
			FP fP = 5 + TSRandom.value * 5;
			TSVector2 tSVector = RotateTo(new TSVector2(1, 0), angle);
			targetPosition = entityPosition + tSVector * fP;
		}
		Teleport(targetPosition);
		yield return WaitCustomEvent("Teleport_End");
		SetHideModelDisable();
		SetUnparalleledDisable();
		SetCloseBlockDisable();
		BeginLookAt_NotWait(GetAttackTarget(), 0.4, 400);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
