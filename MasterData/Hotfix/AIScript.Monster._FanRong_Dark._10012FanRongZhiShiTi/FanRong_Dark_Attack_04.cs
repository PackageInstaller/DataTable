using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._FanRong_Dark._10012FanRongZhiShiTi;

public class FanRong_Dark_Attack_04 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01;

	private readonly string TurnToTarget;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.7, 130);
		yield return WaitCustomEvent(TurnToTarget);
		yield return WaitTime(1.5);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	public FanRong_Dark_Attack_04()
	{
		//IL_000d: Field data (rva=0x628) could not be found in any section!
		//IL_000d: Field data (rva=0x628) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._1D624F842EA26DD40E456D899D9D434952F9D753E9277DE063E7227048AA86D4));
		FireAttack01 = array;
		TurnToTarget = "TurnTo";
		base._002Ector();
	}
}
