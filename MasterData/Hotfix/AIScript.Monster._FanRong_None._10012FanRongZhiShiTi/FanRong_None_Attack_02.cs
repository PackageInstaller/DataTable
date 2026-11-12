using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._FanRong_None._10012FanRongZhiShiTi;

public class FanRong_None_Attack_02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01;

	private readonly string T1;

	private readonly string T2;

	private readonly string T3;

	private readonly string T4;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(T1);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 1, 120);
		yield return WaitCustomEvent(T2);
		StopWaitLookAt();
		yield return WaitCustomEvent(T3);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 1, 120);
		yield return WaitCustomEvent(T4);
		StopWaitLookAt();
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

	public FanRong_None_Attack_02()
	{
		//IL_000d: Field data (rva=0x740) could not be found in any section!
		//IL_000d: Field data (rva=0x740) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._326BDEC1E9B2516102A309A80336E11AD1C2BE8731440B66CC06D58A2273DAE4));
		Attack01 = array;
		T1 = "Turn1";
		T2 = "Turn2";
		T3 = "Turn3";
		T4 = "Turn4";
		base._002Ector();
	}
}
