using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._FanRong_Fire._10012FanRongZhiShiTi;

public class FanRong_Fire_Attack_03 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01;

	private readonly ComboInputBuffer.ActionKey[] FireAttack02;

	private readonly string TurnToTarget;

	private readonly string ComboTo1;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(9);
		yield return WaitCustomEvent(ComboTo1);
		BeginAttack(3, FireAttack02, flushInputedKeys: true);
		yield return WaitCustomEvent(TurnToTarget);
		GetEnemy();
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.25, 200);
		yield return WaitTime(1);
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

	public FanRong_Fire_Attack_03()
	{
		//IL_0024: Field data (rva=0x780) could not be found in any section!
		//IL_0024: Field data (rva=0x780) could not be found in any section!
		//IL_000d: Field data (rva=0x678) could not be found in any section!
		//IL_000d: Field data (rva=0x678) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._291F8E50FBD783B2E79C62EBCF558FEB3C6AA873DC0ED0A6D156675648515C9B));
		FireAttack01 = array;
		ComboInputBuffer.ActionKey[] array2 = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array2, __ldtoken(_003CPrivateImplementationDetails_003E._3C48E4EA0267931F2C9FD5BF0F97BAB297CCB783D4F77D6AB5D7D6407BFDA6D3));
		FireAttack02 = array2;
		TurnToTarget = "TurnTo";
		ComboTo1 = "Combo1";
		base._002Ector();
	}
}
