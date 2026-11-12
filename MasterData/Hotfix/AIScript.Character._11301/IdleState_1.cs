namespace AIScript.Character._11301;

public class IdleState_1 : IState
{
	public override void Enter()
	{
		base.Enter();
	}

	public override void Update()
	{
		base.Update();
		if (_actor.attackTarget != null)
		{
			Exit();
		}
	}
}
