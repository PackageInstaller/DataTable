using System.Collections;
using TrueSync;

namespace AIScript.Monster._Boss._Dark._50251ShanDianLieQuan;

public class Shadow_Die : SkillSimpleBase
{
	private static readonly string Die = "ShadowDie";

	protected override IEnumerator DoMainLogic()
	{
		Shadow_Die shadow_Die = this;
		TSVector2 position = GetPosition();
		FP tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
		shadow_Die.PlayEffect("fx_m50251_base_Dark_Atk04_Disappear", 1f, default, position, tSVectToAngle, 1f, actorScale: true);
		BeginAttack(1, Die, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
