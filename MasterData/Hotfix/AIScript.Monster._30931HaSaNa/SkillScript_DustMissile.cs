using System.Collections;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_DustMissile : SkillScript_MagicBase
{
	private readonly string comboTag = "Skill_2";

	private readonly FP duration = 2;

	private readonly int defaultMissileCount = 4;

	private readonly string fx_Missile = "fx_m30931_base_Skill02_sandmissile";

	private readonly FP radius_Missile = 3;

	private readonly FP positionY_Missile = 1;

	private readonly int skillId_Missile = 3093107;

	private long StartFX;

	protected override IEnumerator SkillLogic()
	{
		SetBlockPriorityToStatic();
		AddBuffToTarget(_actor, 990020140);
		BeginAttack(1, comboTag, flushInputedKeys: true);
		yield return WaitCustomEvent("StartFX");
		SkillScript_DustMissile skillScript_DustMissile = this;
		SkillScript_DustMissile skillScript_DustMissile2 = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skillScript_DustMissile.StartFX = skillScript_DustMissile2.PlayEffect("fx_m30931_base_Skill02_sand_xuli", 1f, default, position, rotation);
		int num = defaultMissileCount + _chargeCount;
		SetLogicTagFpValue(_actor, "MissileCount", num);
		PlayMissileFx(num);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(duration);
		CancelAttack();
		UseMonsterCloneActorCastSkill(skillId_Missile);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
	}

	private void PlayMissileFx(int missileCount)
	{
		if (missileCount > 0)
		{
			int num = 360 / missileCount;
			TSVector2 tSVector = GetTSVector2(0, 1) * radius_Missile;
			for (int i = 0; i < missileCount; i++)
			{
				int num2 = -num * i;
				TSVector2 position = _actor.tsTransform.Position + RotateTo(tSVector, num2);
				PlayFx(fx_Missile, 1.25f, positionY_Missile, position, 0, null, 0.5f);
			}
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ResetBlockPriority();
		RemoveBuffFromTarget(_actor, 990020140);
		StopEffect(StartFX);
	}
}
