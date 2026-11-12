using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Smash_Phase_1 : SkillSimpleBase
{
	private string key_smash = "Stage1_Skill01_1";

	private string key_sweep_right = "Stage1_Skill01_2";

	private string key_sweep_left = "Stage1_Skill01_3";

	private string areaEffect_Smash = "Area_70001_Skill01";

	private TSVector2 center = new TSVector2(0, 0);

	private TSVector2 pos;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key_smash);
		yield return WaitFrame(39);
		GetEnemy();
		pos = Targetenemy.tsTransform.Position;
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_Smash, Targetenemy.tsTransform.Position);
		yield return WaitFrame(16);
		CancelAttack();
		yield return WaitTime(1);
		if (pos.x < center.x)
		{
			BeginAttack(2, key_sweep_right, flushInputedKeys: true, forceInterruptAttack: true);
			PlayAreaEffect("Area_70001_Skill01_Wave", pos, -90);
			Shoot("Bullet_70001_Skill01_1", pos, 0, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, TransLocalPosToWorldPos(pos, GetForward(), new TSVector2(-1, 0)));
			yield return WaitFrame(45);
			CancelAttack();
		}
		else
		{
			BeginAttack(2, key_sweep_left, flushInputedKeys: true, forceInterruptAttack: true);
			PlayAreaEffect("Area_70001_Skill01_Wave", pos, 90);
			Shoot("Bullet_70001_Skill01_1", pos, 0, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, TransLocalPosToWorldPos(pos, GetForward(), new TSVector2(1, 0)));
			yield return WaitFrame(45);
			CancelAttack();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
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
