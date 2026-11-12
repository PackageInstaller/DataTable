using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._FanRong_Fire._10012FanRongZhiShiTi;

public class FanRong_Fire_Attack_04 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01;

	private readonly string Combo01;

	private readonly string Turn03;

	private readonly string Turn04;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo01);
		CancelAttack();
		yield return WaitCustomEvent(Turn03);
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 0)
		{
			LogicEntity logicEntity = GetAttackTarget();
			if (logicEntity == null)
			{
				logicEntity = GetCurrentPlayer();
			}
			BeginLookAt_NotWait(logicEntity, 0.25, 200);
		}
		else if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 0 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 90)
		{
			BeginRotateAngle(-1, 450);
		}
		else
		{
			BeginRotateAngle(-100, 450);
		}
		yield return WaitCustomEvent(Turn04);
		StopWaitLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	public FanRong_Fire_Attack_04()
	{
		//IL_000d: Field data (rva=0x628) could not be found in any section!
		//IL_000d: Field data (rva=0x628) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._1D624F842EA26DD40E456D899D9D434952F9D753E9277DE063E7227048AA86D4));
		FireAttack01 = array;
		Combo01 = "C1";
		Turn03 = "T3";
		Turn04 = "T4";
		base._002Ector();
	}
}
