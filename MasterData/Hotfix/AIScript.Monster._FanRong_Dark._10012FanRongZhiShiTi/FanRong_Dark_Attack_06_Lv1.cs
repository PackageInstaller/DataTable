using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._FanRong_Dark._10012FanRongZhiShiTi;

public class FanRong_Dark_Attack_06_Lv1 : SkillSimpleBase
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
		(ComboInputBuffer.ActionKey)2020173428,
		(ComboInputBuffer.ActionKey)1769100380,
		(ComboInputBuffer.ActionKey)1919248231
	};

	private readonly ComboInputBuffer.ActionKey[] Attack04;

	private readonly string Combo01;

	private readonly string Combo02;

	private readonly string Combo03;

	private readonly string Combo04;

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
		yield return WaitCustomEvent(Combo03);
		BeginAttack(4, Attack04, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo04);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
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

	public FanRong_Dark_Attack_06_Lv1()
	{
		//IL_0052: Field data (rva=0x4c8) could not be found in any section!
		//IL_0052: Field data (rva=0x4c8) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._03676B87ABE63955927B1D86351F0AF1EAFC9706CA388761801475EBA2839CF1));
		Attack04 = array;
		Combo01 = "C1";
		Combo02 = "C2";
		Combo03 = "C3";
		Combo04 = "C4";
		base._002Ector();
	}
}
