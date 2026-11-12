using System.Collections;
using TrueSync;

namespace AIScript.Monster._30281ShengDanTaLou;

public class Skill_09 : SkillSimpleBase
{
	private string Attack = "Skill09";

	private string Fly = "Skill04and05";

	private string Rest = "Skill07_Rest";

	private long AreaWind;

	private long AreaDot;

	private long WarningFX;

	private long DotArea1;

	private long DotArea2;

	private TSVector2 SpawnPos = new TSVector2(0, -15);

	private TSVector2 CenterPos = new TSVector2(0, 10);

	private TSVector2 LockPos = new TSVector2(0, 0);

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopAreaEffect(AreaDot);
		StopAreaEffect(AreaWind);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (Distance(GetPosition(), SpawnPos) > 3)
		{
			BeginAttack(1, Fly, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("StartDash");
			SetCloseBlockEnable();
			DotArea1 = PlayAreaEffect("Area_30281_Skill04_Dot", GetPosition());
			BeginLookAtByDir_NotWait(SpawnPos, 0.5, 360);
			yield return WaitTime(0.5);
			Dash();
			BeginLookAtByDir_NotWait(CenterPos, 5, 30);
			yield return WaitDashFinish();
			StopWaitLookAt();
			SetCloseBlockDisable();
			StopAreaEffect(DotArea1);
			WarningFX = PlayEarlyWarningEffect("Effect_Skill04_Warning", 1f, default, GetPosition());
			BeginLookAtByDir_NotWait(CenterPos, 0.5, 360);
			yield return WaitTime(0.65);
			CancelAttack();
			yield return WaitFrame(53);
		}
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtByDir_NotWait(CenterPos, 0.5, 360);
		DispatchCustomEvent("ShengDanTaLouSkill09", isSelfEvent: false);
		yield return WaitCustomEvent("LoopStart");
		AreaDot = PlayAreaEffect("Area_30281_Skill09_WindDot", LockPos, 0);
		if (GetMonsterTagValue(_actor, 1) == "Lv3")
		{
			AreaWind = PlayAreaEffect("Area_30281_Skill09_WindBuff", LockPos, 0);
			PlayAreaEffect("Area_30281_Skill09_GroundEffect", LockPos, 0);
			PlayAreaEffect("Area_30281_Skill09_GroundEffectDot_S", new TSVector2(0, 14), 0);
			PlayAreaEffect("Area_30281_Skill09_GroundEffectDot_S", new TSVector2(0, -14), 0);
			PlayAreaEffect("Area_30281_Skill09_GroundEffectDot_L", new TSVector2(9, 0), 0);
			PlayAreaEffect("Area_30281_Skill09_GroundEffectDot_L", new TSVector2(-9, 0), 0);
		}
		else
		{
			AreaWind = PlayAreaEffect("Area_30281_Skill09_Wind", LockPos, 0);
		}
		yield return WaitTime(6);
		CancelAttack();
		yield return WaitCustomEvent("Shoot");
		Shoot();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Shoot()
	{
		RectangleMultipleShoot("Bullet_30281_Skill09", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0.6, awaitShootCompletion: true, 10, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), default, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 20, 0);
	}

	private void Dash()
	{
		BeginDash(1, SpawnPos - GetPosition(), 8, Distance(GetPosition(), SpawnPos), 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.5);
	}
}
