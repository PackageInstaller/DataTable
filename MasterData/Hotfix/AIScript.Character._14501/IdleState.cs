using AIScript.Utils;

namespace AIScript.Character._14501;

public class IdleState : IState
{
	public override void Enter()
	{
		base.Enter();
	}

	public override void Update()
	{
		base.Update();
		LogicEntity attackTarget = GetAttackTarget();
		if ((_actor.attackTarget == null || _actor.DistanceWithRadius(_actor.attackTarget) > CommonUtils.GetAimRange(_actor)) && _actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
		{
			_aimTarget.Cancel();
		}
		if (attackTarget != null)
		{
			Exit();
		}
	}
}
