namespace AIScript.Character._14201;

public class AimState : IState
{
	public override void Enter()
	{
		base.Enter();
		LogicEntity attackTarget = GetAttackTarget();
		_aimTarget.Aim(_actor, attackTarget as AdventureActor);
		Exit();
	}

	public override void Update()
	{
		base.Update();
		if (_actor.aimMode != AdventureActor.AimMode.AimAtAttackTarget)
		{
			Exit();
		}
	}
}
