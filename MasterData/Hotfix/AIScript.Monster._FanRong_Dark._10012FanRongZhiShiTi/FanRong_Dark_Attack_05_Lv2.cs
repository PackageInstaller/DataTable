using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_Dark._10012FanRongZhiShiTi;

public class FanRong_Dark_Attack_05_Lv2 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._0
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._1
	};

	private readonly string TurnToTarget = "TurnTo";

	private readonly string FX_Effect = "AreaEffect_Dark_Attack05_Bullet_Wave";

	private readonly string Area_Effect = "AreaEffect_Dark_Attack05_Ground";

	private readonly string BulletName = "AreaEffect_Dark_Attack05_Bullet";

	private FP HomeDistance;

	private FP Angle;

	private TSVector2 SelfPos;

	private FP SelfRot;

	protected override void OnSkillEnable()
	{
		HomeDistance = Distance(GetPosition(), new TSVector2(0, 0));
	}

	protected override void OnInterrupt(int comboIndex)
	{
		RemoveBuffFromTarget(_actor, 990020140);
		if (!ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.FanRonShiTi_003))
		{
			ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.FanRonShiTi_003);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 990020140);
		if (HomeDistance >= 4)
		{
			SetCloseBlockEnable();
			BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(10);
			BeginLookAtByPos(new TSVector2(0, 0), 0.5, 360, 0);
			yield return WaitFrame(15);
			DoDash();
			yield return WaitDashFinish();
			CancelAttack();
			SetCloseBlockDisable();
			yield return WaitFrame(10);
			BeginAttack(2, FireAttack02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(10);
			BeginLookAtCameraDir_NotWait(DirectionType.Down, 0.5, 360);
			yield return WaitFrame(30);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			CancelAttack();
			yield return WaitFrame(70);
			RemoveBuffFromTarget(_actor, 990020140);
		}
		else
		{
			BeginAttack(2, FireAttack02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(10);
			BeginLookAtCameraDir_NotWait(DirectionType.Down, 0.5, 360);
			yield return WaitFrame(30);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			StartCor(AttackCombo());
			yield return WaitFrame(50);
			CancelAttack();
			yield return WaitFrame(70);
			RemoveBuffFromTarget(_actor, 990020140);
		}
	}

	private IEnumerator AttackCombo()
	{
		FP fP = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) + 25;
		SelfPos = GetPosition();
		Angle = fP;
		SelfRot = fP;
		DoWave();
		yield return WaitFrame(15);
		DoShoot();
		DoDot();
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 10, HomeDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void DoWave()
	{
		TSVector2 multiShootDirection = RotateTo(GetForward(), Angle);
		CircleMultipleShoot(FX_Effect, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 8, 0, SelfPos, 0.5, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 1);
	}

	private void DoShoot()
	{
		TSVector2 multiShootDirection = RotateTo(GetForward(), Angle);
		CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 8, 0, SelfPos, 0.5, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0);
	}

	private void DoDot()
	{
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 22 + SelfRot);
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 67 + SelfRot);
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 112 + SelfRot);
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 157 + SelfRot);
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 202 + SelfRot);
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 247 + SelfRot);
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 292 + SelfRot);
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 337 + SelfRot);
	}
}
