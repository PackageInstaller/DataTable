using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai.LDScripts;

public class Skill_Flap : SkillBase
{
	private readonly string atkFx = "fx_50171BingXiangGuai_base_Nattack_5_90";

	private readonly string hittedFx = "fx_50171BingXiangGuai_hit_Nattack";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		BeginAttack(flapIndex, flapKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 3, 140);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		yield return WaitFrame(13);
		StopLookAt();
		TSVector2 selfPOS = GetPosition();
		GetForward();
		FP selfAngle = GetEntityAngle(_actor);
		PlayEffect(warningFx_Ground_fan90c16r, 1.2f, default, selfPOS, selfAngle, 0.8f);
		yield return WaitTime(0.7);
		ATKAlertFx();
		yield return WaitTime(0.3);
		PlayEffect(atkFx, 1f, default, selfPOS, selfAngle);
		FanDamage(selfPOS, 12, 0, 90, selfAngle, 0, 50171011, hittedFx);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
