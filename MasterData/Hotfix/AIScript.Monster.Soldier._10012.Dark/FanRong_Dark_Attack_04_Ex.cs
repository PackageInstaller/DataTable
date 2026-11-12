using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster.Soldier._10012.Dark;

public class FanRong_Dark_Attack_04_Ex : SkillSimpleBase
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

	public FanRong_Dark_Attack_04_Ex()
	{
		//IL_000d: Field data (rva=0x688) could not be found in any section!
		//IL_000d: Field data (rva=0x688) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._2A68422C71953191DE4EFD8C57619F106339EE731FF082C270BE3018FC01B5D7));
		FireAttack01 = array;
		TurnToTarget = "TurnTo";
		base._002Ector();
	}
}
