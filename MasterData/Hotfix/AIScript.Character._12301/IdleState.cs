namespace AIScript.Character._12301;

public class IdleState : IState
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
