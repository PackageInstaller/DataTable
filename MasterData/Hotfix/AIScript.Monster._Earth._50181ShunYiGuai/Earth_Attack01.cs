using System.Collections;
using TrueSync;

namespace AIScript.Monster._Earth._50181ShunYiGuai;

public class Earth_Attack01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1];

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.3, 260);
		yield return WaitCustomEvent("L");
		StartCor(LeftAttack());
		yield return WaitCustomEvent("R");
		StartCor(RightAttack());
		yield return WaitCustomEvent("T");
		StartCor(TailAttack());
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 2, 200);
		yield return WaitCustomEvent("TurnE");
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator LeftAttack()
	{
		GetEnemy();
		LogicEntity targetenemy = Targetenemy;
		TSVector2 EffectPos = GetEntityPositionObsoleted(targetenemy) + TSVector2.Rotate(new TSVector2(2, 0f), targetenemy.tsTransform.Rotation);
		FP EffectRot = GetEntityAngle(targetenemy) + 90;
		PlayEffect("Door_Start_Exit", 1f, 1.5, EffectPos, EffectRot, 2f);
		PlayAreaEffect("Area_50181_ShunYiGuai_Earth_Skill01_Wave01", EffectPos, EffectRot);
		long Effect02 = PlayEffect("Teleportgate_shadow", 1f, 0, EffectPos, EffectRot);
		yield return WaitFrame(15);
		long Effect3 = PlayEffect("Door_Loop_Exit", 1f, 1.5, EffectPos, EffectRot, 2f);
		PlayAreaEffect("Area_50181_ShunYiGuai_Earth_Skill01_L", EffectPos, EffectRot);
		yield return WaitFrame(15);
		StopEffect(Effect3);
		StopEffect(Effect02);
	}

	protected IEnumerator RightAttack()
	{
		GetEnemy();
		LogicEntity targetenemy = Targetenemy;
		TSVector2 EffectPos = GetEntityPositionObsoleted(targetenemy) + TSVector2.Rotate(new TSVector2(-2, 0f), targetenemy.tsTransform.Rotation);
		FP EffectRot = GetEntityAngle(targetenemy) - 90;
		PlayEffect("Door_Start_Exit", 1f, 1.5, EffectPos, EffectRot, 2f);
		PlayAreaEffect("Area_50181_ShunYiGuai_Earth_Skill01_Wave01", EffectPos, EffectRot);
		long Effect02 = PlayEffect("Teleportgate_shadow", 1f, 0, EffectPos, EffectRot);
		yield return WaitFrame(15);
		long Effect3 = PlayEffect("Door_Loop_Exit", 1f, 1.5, EffectPos, EffectRot, 2f);
		PlayAreaEffect("Area_50181_ShunYiGuai_Earth_Skill01_R", EffectPos, EffectRot);
		yield return WaitFrame(15);
		StopEffect(Effect3);
		StopEffect(Effect02);
	}

	protected IEnumerator TailAttack()
	{
		GetEnemy();
		LogicEntity targetenemy = Targetenemy;
		TSVector2 EffectPos = GetEntityPositionObsoleted(targetenemy) + TSVector2.Rotate(new TSVector2(0, 2f), targetenemy.tsTransform.Rotation);
		FP EffectRot = GetEntityAngle(targetenemy) - 180;
		PlayEffect("Door_Start_Exit", 1f, 1.5, EffectPos, EffectRot, 2f);
		PlayAreaEffect("Area_50181_ShunYiGuai_Earth_Skill01_Wave02", EffectPos, EffectRot);
		long Effect01 = PlayEffect("Teleportgate_shadow", 1f, 0, EffectPos, EffectRot);
		yield return WaitFrame(15);
		PlayAreaEffect("Area_50181_ShunYiGuai_Earth_Skill01_TMod", EffectPos, EffectRot);
		yield return WaitFrame(5);
		PlayAreaEffect("Area_50181_ShunYiGuai_Earth_Skill01_T", EffectPos, EffectRot);
		StopEffect(Effect01);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
