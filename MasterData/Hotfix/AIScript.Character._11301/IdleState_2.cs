namespace AIScript.Character._11301;

public class IdleState_2 : IState
{
	public override void Enter()
	{
		base.Enter();
	}

	public override void Update()
	{
		base.Update();
		if (_actor.attackTarget == null && _actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
		{
			_aimTarget.Cancel();
		}
		if (_actor.attackTarget != null)
		{
			Exit();
		}
	}
}
