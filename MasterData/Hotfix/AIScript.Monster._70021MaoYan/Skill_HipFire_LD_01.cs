using System.Collections;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_HipFire_LD_01 : SkillBaseMaoYan
{
	private CoroutineNode shootCor;

	private LogicEntity target;

	private bool interrupt;

	protected override void OnSkillEnable()
	{
		interrupt = true;
	}

	protected override void OnSkillDisable()
	{
		if (interrupt && shootState)
		{
			StopCor(shootCor);
			shootState = false;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		BeginAttack(ShootIndex, ShootAction, flushInputedKeys: true, forceInterruptAttack: true);
		AimAtTarget(target, 180);
		AlertMovement(GetPosition(), GetEntityPosition(target), TSVector2.zero, target);
		yield return WaitTime(0.3);
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 1.25, GetPosition(), default, 3f);
		yield return WaitTime(0.3);
		shootCor = HipFire(12, E_TypeOfFire.Tree);
		yield return WaitMoveStatus();
		yield return WaitTime(0.2f);
		CancelAttack();
		if (shootState)
		{
			StopCor(shootCor);
			shootState = false;
		}
		interrupt = false;
		yield return StartCor(Reload());
		CancelAim();
	}
}
