using System.Collections;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._FanRong_None._10012FanRongZhiShiTi;

public class FanRong_None_Attack_05 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01;

	private readonly ComboInputBuffer.ActionKey[] FireAttack02;

	private readonly ComboInputBuffer.ActionKey[] FireAttack03;

	private readonly string FX_Effect;

	private readonly string Area_Effect;

	private readonly string BulletName;

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
			yield return WaitFrame(65);
			StartCor(AttackCombo());
			yield return WaitFrame(65);
			StartCor(AttackCombo());
			yield return WaitFrame(65);
			StartCor(AttackCombo());
			yield return WaitFrame(65);
			StartCor(AttackCombo());
			yield return WaitFrame(65);
			CancelAttack();
			BeginAttack(3, FireAttack03, flushInputedKeys: true, forceInterruptAttack: true);
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
			yield return WaitFrame(65);
			StartCor(AttackCombo());
			yield return WaitFrame(65);
			StartCor(AttackCombo());
			yield return WaitFrame(65);
			StartCor(AttackCombo());
			yield return WaitFrame(65);
			StartCor(AttackCombo());
			yield return WaitFrame(65);
			CancelAttack();
			BeginAttack(3, FireAttack03, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(70);
			RemoveBuffFromTarget(_actor, 990020140);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private IEnumerator AttackCombo()
	{
		FP fP = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) - 30;
		SelfPos = GetPosition() + TSVector2.Rotate(new TSVector2(0, 2.5f), _actor.tsTransform.Rotation);
		Angle = fP;
		SelfRot = fP;
		DoWave();
		yield return WaitFrame(1);
		DoDot();
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 10, HomeDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void DoWave()
	{
		TSVector2 multiShootDirection = RotateTo(GetForward(), Angle);
		CircleMultipleShoot(FX_Effect, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 6, 0, SelfPos, 0.5, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0);
	}

	private void DoShoot()
	{
		TSVector2 multiShootDirection = RotateTo(GetForward(), Angle);
		CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, SelfPos, 0.5, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0);
	}

	private void DoDot()
	{
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 30 + SelfRot);
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 90 + SelfRot);
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 150 + SelfRot);
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 210 + SelfRot);
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 270 + SelfRot);
		PlayAreaEffect(Area_Effect, SelfPos, GetRotation() + 330 + SelfRot);
	}

	public FanRong_None_Attack_05()
	{
		//IL_000d: Field data (rva=0x760) could not be found in any section!
		//IL_000d: Field data (rva=0x760) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._3674AB67A65B0A39F6C5E5F65978996A628AD0C143004B386031B0B4E6F594CD));
		FireAttack01 = array;
		FireAttack02 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1852399976,
			(ComboInputBuffer.ActionKey)7562030,
			(ComboInputBuffer.ActionKey)65536
		};
		FireAttack03 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1850695534,
			(ComboInputBuffer.ActionKey)1635021889,
			(ComboInputBuffer.ActionKey)1281321827
		};
		FX_Effect = "FanRong_None_Skill05_Wave";
		Area_Effect = "FanRong_None_Skill05_Ground";
		BulletName = "AreaEffect_Dark_Attack05_Bullet";
		base._002Ector();
	}
}
