using System.Collections;
using TrueSync;

namespace AIScript.Monster._Boss._Dark._50251ShanDianLieQuan;

public class Shadow_Laser : SkillSimpleBase
{
	private readonly string Fire = "ShadowLaser_Fire";

	private FP WaitTime1;

	private string Charge;

	protected override void OnSkillEnable()
	{
		WaitTime1 = 0;
		if (GetTargetByDataID(95025105).Count != 0)
		{
			Charge = "ShadowLaser_Charge";
		}
		else
		{
			Charge = "ShadowLaser_Charge_L";
		}
	}

	protected override void OnSkillDisable()
	{
		_actor.DestroySelf();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Charge, flushInputedKeys: true, forceInterruptAttack: true);
		AimAtMonsterTarget(90);
		while (WaitTime1 <= 15 && GetBuffNum(_actor, 502510013) != 1)
		{
			WaitTime1 += (FP)0.03;
			yield return WaitFrame(1);
		}
		CancelAim();
		yield return WaitTime(0.5);
		BeginAttack(2, Fire, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("FireEnd");
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
