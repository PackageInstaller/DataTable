using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_EnergyRay_Phase_1 : SkillSimpleBase
{
	private string key_Base1 = "Stage2_Skill12_1";

	private string key_Base2 = "Stage2_Skill12_2";

	private string key_Base3 = "Stage2_Skill12_3";

	private FP offset = 0;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key_Base1);
		StartCor(LineFx());
		StartCor(NormalFx());
		StartCor(LaserShoot());
		yield return WaitFrame(59);
		CancelAttack();
		yield return WaitFrame(19);
		BeginAttack(2, key_Base2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(9);
		BeginAttack(3, key_Base3, flushInputedKeys: true, forceInterruptAttack: true);
		StartCor(LineHit());
		yield return WaitFrame(88);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator LineFx()
	{
		yield return WaitFrame(26);
		Skill_EnergyRay_Phase_1 skill_EnergyRay_Phase_ = this;
		LogicEntity actor = _actor;
		skill_EnergyRay_Phase_.PlayLinkEffect("fx_m70001_base_skill12_1_lianxian_start", useCustomSource: false, null, default, default, actor);
		yield return WaitFrame(3);
		Skill_EnergyRay_Phase_1 skill_EnergyRay_Phase_2 = this;
		actor = _actor;
		long Link01 = skill_EnergyRay_Phase_2.PlayLinkEffect("fx_m70001_loop_skill12_1_lianxian", useCustomSource: false, null, default, default, actor);
		yield return WaitFrame(27);
		StopEffect(Link01);
	}

	protected IEnumerator NormalFx()
	{
		yield return WaitFrame(3);
		long Effect01 = PlayEffect("fx_m70001_loop_skill12_1R_collect", 1f, 0, default, 0, 1f, actorScale: true);
		yield return WaitFrame(13);
		long Effect2 = PlayEffect("fx_m70001_loop_skill12_1L_collect", 1f, 0, default, 0, 1f, actorScale: true);
		yield return WaitFrame(45);
		StopEffect(Effect01);
		StopEffect(Effect2);
		yield return WaitFrame(17);
		long Effect3 = PlayEffect("fx_m70001_loop_skill12_4R_collect", 1f, 0, default, 0, 1f, actorScale: true);
		long Effect4 = PlayEffect("fx_m70001_loop_skill12_4L_collect", 1f, 0, default, 0, 1f, actorScale: true);
		yield return WaitFrame(33);
		StopEffect(Effect3);
		StopEffect(Effect4);
	}

	protected IEnumerator LaserShoot()
	{
		yield return WaitFrame(49);
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 tSVector = new TSVector2(0, -12);
		if (GetEntityPosition(logicEntity).y < -4)
		{
			tSVector = GetEntityPosition(logicEntity);
		}
		TSVector2 tSVector2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 4));
		TSVector2 normalized = (tSVector - tSVector2).normalized;
		ILRuntimeAPI.PlayAreaEffect(_actor, "Area_70001_Skill12_Laser", tSVector2 + normalized * offset, normalized.GetAngle());
	}

	protected IEnumerator LineHit()
	{
		yield return WaitFrame(19);
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 TargetPos = GetEntityPosition(logicEntity);
		TSVector2 ShootPos1 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(3, 4));
		TSVector2 ShootPos2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-3, 4));
		ILRuntimeAPI.Shoot("Bullet_70001_Skill12_Lock", _actor, 0, ShootPos1, 0.1, TargetPos, null, AimType.Position, BulletDirectionType.BulletToTarget);
		ILRuntimeAPI.Shoot("Bullet_70001_Skill12_Lock", _actor, 0, ShootPos2, 0.1, TargetPos, null, AimType.Position, BulletDirectionType.BulletToTarget);
		yield return WaitFrame(15);
		AdventureBulletBase Bullet01 = ILRuntimeAPI.Shoot("Bullet_70001_Skill12_Line", _actor, 0, ShootPos1, 0.1, TargetPos, null, AimType.Position, BulletDirectionType.BulletToTarget);
		AdventureBulletBase Bullet2 = ILRuntimeAPI.Shoot("Bullet_70001_Skill12_Line", _actor, 0, ShootPos2, 0.1, TargetPos, null, AimType.Position, BulletDirectionType.BulletToTarget);
		long Link01 = PlayLinkEffect("fx_m70001_loop_skill12_6R", useCustomSource: false, null, default, default, Bullet01);
		long Link2 = PlayLinkEffect("fx_m70001_loop_skill12_6L", useCustomSource: false, null, default, default, Bullet2);
		yield return WaitFrame(51);
		StopEffect(Link01);
		StopEffect(Link2);
		PlayLinkEffect("fx_m70001_base_skill12_7L_end", useCustomSource: false, null, default, default, Bullet2);
		PlayLinkEffect("fx_m70001_base_skill12_7R_end", useCustomSource: false, null, default, default, Bullet01);
	}
}
