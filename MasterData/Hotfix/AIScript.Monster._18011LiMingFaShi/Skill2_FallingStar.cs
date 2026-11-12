using System.Collections;
using TrueSync;

namespace AIScript.Monster._18011LiMingFaShi;

public class Skill2_FallingStar : SkillSimpleBase
{
	private readonly string Skill2 = "Skill2_FallingStar";

	private readonly string area_star = "AreaEffect_18011_Skill2_FallingStar";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAt_NotWait(GetAttackTarget(), 2, 300);
		BeginAttack(1, Skill2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("AttackStart");
		FP time = 1.2;
		for (FP intervaltime = 0.4; time >= 0; time -= intervaltime)
		{
			TSVector2 entityPosition = GetEntityPosition(GetAttackTarget());
			PlayAreaEffect(area_star, entityPosition);
			FP angle = TSRandom.value * 360;
			FP fP = 3 + TSRandom.value * 3;
			TSVector2 tSVector = RotateTo(new TSVector2(1, 0), angle);
			TSVector2 position = entityPosition + tSVector * fP;
			PlayAreaEffect(area_star, position);
			yield return WaitTime(intervaltime);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
