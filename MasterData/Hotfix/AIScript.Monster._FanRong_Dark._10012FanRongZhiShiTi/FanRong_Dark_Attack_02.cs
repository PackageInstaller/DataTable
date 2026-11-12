using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._FanRong_Dark._10012FanRongZhiShiTi;

public class FanRong_Dark_Attack_02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(33);
		CancelAttack();
		yield return WaitFrame(25);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.25, 240);
		yield return WaitFrame(10);
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

	public FanRong_Dark_Attack_02()
	{
		//IL_000d: Field data (rva=0x740) could not be found in any section!
		//IL_000d: Field data (rva=0x740) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._326BDEC1E9B2516102A309A80336E11AD1C2BE8731440B66CC06D58A2273DAE4));
		FireAttack01 = array;
		base._002Ector();
	}
}
