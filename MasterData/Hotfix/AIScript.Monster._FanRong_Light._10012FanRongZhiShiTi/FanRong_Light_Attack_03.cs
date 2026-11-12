using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._FanRong_Light._10012FanRongZhiShiTi;

public class FanRong_Light_Attack_03 : SkillSimpleBase
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

	public FanRong_Light_Attack_03()
	{
		//IL_000d: Field data (rva=0x678) could not be found in any section!
		//IL_000d: Field data (rva=0x678) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._291F8E50FBD783B2E79C62EBCF558FEB3C6AA873DC0ED0A6D156675648515C9B));
		Attack01 = array;
		T1 = "Turn1";
		T2 = "Turn2";
		T3 = "Turn3";
		T4 = "Turn4";
		base._002Ector();
	}
}
