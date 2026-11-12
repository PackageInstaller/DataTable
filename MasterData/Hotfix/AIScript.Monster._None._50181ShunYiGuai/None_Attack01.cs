using System.Collections;
using TrueSync;

namespace AIScript.Monster._None._50181ShunYiGuai;

public class None_Attack01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1];

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		Teleport(GetEntityPosition(GetCurrentPlayer()), checkPositionReachable: false);
		yield return WaitTime(0.8);
		StartCor(LeftAttack());
		yield return WaitTime(1);
		StartCor(RightAttack());
		yield return WaitTime(1);
		StartCor(TailAttack());
		yield return WaitTime(1.8);
	}

	protected IEnumerator LeftAttack()
	{
		GetEnemy();
		LogicEntity targetenemy = Targetenemy;
		TSVector2 EffectPos = GetEntityPosition(targetenemy) + TSVector2.Rotate(new TSVector2(2, 0f), targetenemy.tsTransform.Rotation);
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
		TSVector2 EffectPos = GetEntityPosition(targetenemy) + TSVector2.Rotate(new TSVector2(-2, 0f), targetenemy.tsTransform.Rotation);
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
		TSVector2 EffectPos = GetEntityPosition(targetenemy) + TSVector2.Rotate(new TSVector2(0, 2f), targetenemy.tsTransform.Rotation);
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
