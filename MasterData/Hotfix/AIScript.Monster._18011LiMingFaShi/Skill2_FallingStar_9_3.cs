using System.Collections;
using TrueSync;

namespace AIScript.Monster._18011LiMingFaShi;

public class Skill2_FallingStar_9_3 : SkillSimpleBase
{
	private readonly string Skill2 = "Skill2_FallingStar";

	private string tag1 = "Biu";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetMonsterTagValue(_actor, 1) != tag1)
		{
			BeginLookAt_NotWait(GetAttackTarget(), 2, 300);
			BeginAttack(1, Skill2, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("AttackStart");
			FP time = 1.2;
			for (FP intervaltime = 0.4; time >= 0; time -= intervaltime)
			{
				TSVector2 entityPosition = GetEntityPosition(GetAttackTarget());
				StartCor(FallingStar(entityPosition));
				FP angle = TSRandom.value * 360;
				FP fP = 1.5 + TSRandom.value * 3;
				TSVector2 tSVector = RotateTo(new TSVector2(1, 0), angle);
				TSVector2 pos = entityPosition + tSVector * fP;
				StartCor(FallingStar(pos));
				yield return WaitTime(intervaltime);
			}
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(2);
		}
		else
		{
			BeginLookAt_NotWait(GetAttackTarget(), 2, 300);
			BeginAttack(1, Skill2, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("AttackStart");
			FP intervaltime = 1.2;
			for (FP time = 0.4; intervaltime >= 0; intervaltime -= time)
			{
				yield return WaitTime(time);
			}
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(2);
		}
	}

	private IEnumerator FallingStar(TSVector2 pos)
	{
		PlayEarlyWarningEffect("fx_common_base_Dark_YuJing_circular_2", 1f, -2.671, pos, 0, 0.75f);
		yield return WaitTime(1);
		PlayEffect("fx_m18011_base_skill02_star", 1f, -2.671, pos, 0, 0.75f);
		yield return WaitTime(0.35);
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, pos, default, default, 1.3);
		HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 2);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 18011041, 0.5, HitBox.HurtAnimType.Small, "fx_50271_hit_skill01");
	}
}
