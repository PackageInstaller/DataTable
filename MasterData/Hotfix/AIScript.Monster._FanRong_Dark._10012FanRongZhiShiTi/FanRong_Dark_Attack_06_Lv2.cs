using System.Collections;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._FanRong_Dark._10012FanRongZhiShiTi;

public class FanRong_Dark_Attack_06_Lv2 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1701336156,
		(ComboInputBuffer.ActionKey)1281320301,
		(ComboInputBuffer.ActionKey)1952999273
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1768846440,
		(ComboInputBuffer.ActionKey)1866622830,
		(ComboInputBuffer.ActionKey)1663988844
	};

	private readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1601466473,
		(ComboInputBuffer.ActionKey)1851877716,
		(ComboInputBuffer.ActionKey)1632859726
	};

	private readonly ComboInputBuffer.ActionKey[] Attack04;

	private readonly string Combo01;

	private readonly string Combo02;

	private readonly string Combo03;

	private readonly string Combo04;

	private readonly string BulletName;

	private readonly string Area_Effect;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("T1");
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.2, 180);
		yield return WaitCustomEvent(Combo01);
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo02);
		BeginAttack(3, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("T2");
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.1, 600);
		yield return WaitFrame(64);
		BeginAttack(4, Attack04, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Shoot");
		DoShoot();
		yield return WaitCustomEvent(Combo04);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void DoShoot()
	{
		TSVector2 tSVector = GetPosition() + TSVector2.Rotate(new TSVector2(0, 5f), _actor.tsTransform.Rotation);
		FanMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, tSVector, 0.5, default, 0, AimType.Default, BulletDirectionType.ActorToBullet, 60, 0, 0);
		PlayAreaEffect(Area_Effect, tSVector, GetRotation() + 30);
		PlayAreaEffect(Area_Effect, tSVector, GetRotation());
		PlayAreaEffect(Area_Effect, tSVector, GetRotation() - 30);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "TT")
		{
			Targetenemy = GetAttackTarget();
			if (Targetenemy == null)
			{
				Targetenemy = GetCurrentPlayer();
			}
			BeginLookAt_NotWait(Targetenemy, 0.3, 240);
		}
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	public FanRong_Dark_Attack_06_Lv2()
	{
		//IL_0052: Field data (rva=0x550) could not be found in any section!
		//IL_0052: Field data (rva=0x550) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._0C03B58948C783E2A9D120228E97043099EE9BC679CA708AAC210E68564E342B));
		Attack04 = array;
		Combo01 = "C1";
		Combo02 = "C2";
		Combo03 = "C3";
		Combo04 = "C4";
		BulletName = "Weapon_10012FanRongZhiShiTi_Flying_Dark02";
		Area_Effect = "AreaEffect_Dark_Attack04_Ground";
		base._002Ector();
	}
}
