using System.Collections;
using TrueSync;

namespace AIScript.Monster._10007KuangFengQingXiao;

public class Skill4_Hurricane : SkillSimpleBase
{
	private readonly FP _rotateSpeed = 300;

	private readonly FP _duration = 0.8;

	private readonly FP _waitSeconds = 0;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private readonly ComboInputBuffer.ActionKey[] _actionKeys2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private readonly string bullet1 = "Weapon_10007KuangFengQingXiao_Hurricane";

	private readonly string bullet2 = "Weapon_10007KuangFengQingXiao_GuideShootPlus";

	private readonly string bullet3 = "Weapon_10007KuangFengQingXiao_GuideShootPlus2";

	private TSVector2 Shootdir;

	private long area1;

	protected override void OnSkillDisable()
	{
		if (area1 != 0L)
		{
			StopAreaEffect(area1);
			area1 = 0L;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCustomEvent("TP_Start");
		HideSelf();
		Teleport(new TSVector2(0, 0));
		yield return WaitTime(0.2);
		CancelAttack();
		yield return WaitTime(0.1);
		ShowSelf();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginLookAtCameraDir(DirectionType.Down, default, 800);
		yield return WaitTime(0.1);
		BeginAttack(2, _actionKeys2);
		yield return WaitCustomEvent("Area_Start");
		area1 = PlayAreaEffect("AreaEffect_Skill4_Hurricane2", GetPosition());
		FP t = 8;
		Shootdir = GetForward();
		for (; t >= 0; t -= (FP)0.15)
		{
			DoShoot(Shootdir);
			yield return WaitTime(0.15);
			Shootdir = RotateTo(Shootdir, 8);
		}
		yield return WaitTime(0);
		CancelAttack();
		StopAreaEffect(area1);
		area1 = 0L;
		yield return WaitTime(2);
	}

	private void DoShoot(TSVector2 Shootdir)
	{
		TSVector2 shootPosition = GetPosition() + TSVector2.Rotate(new TSVector2(0, 0f), _actor.tsTransform.Rotation);
		GetAttackTarget(isUpToDate: true);
		FanMultipleShoot(bullet1, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 5, 0, shootPosition, 1.8, Shootdir, 0, AimType.Default, BulletDirectionType.ActorToBullet, 360, 10, 1.5f);
	}
}
