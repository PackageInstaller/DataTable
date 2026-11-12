using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._10301;

public class IdleState : IState
{
	public override void Enter()
	{
		base.Enter();
	}

	public override void Update()
	{
		base.Update();
		if ((_actor.attackTarget == null || _actor.DistanceWithRadius(_actor.attackTarget) > CommonUtils.GetAimRange(_actor)) && _actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget && ILRuntimeAPI.IsObstacleBetweenActorAndTargetAndPreventNormalAttack(_actor))
		{
			_aimTarget.Cancel();
		}
		if (_actor.attackTarget != null)
		{
			Exit();
		}
	}
}
