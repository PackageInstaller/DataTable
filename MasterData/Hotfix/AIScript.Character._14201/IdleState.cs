namespace AIScript.Character._14201;

public class IdleState : IState
{
	public override void Enter()
	{
		base.Enter();
	}

	public override void Update()
	{
		base.Update();
		if (GetAttackTarget() != null)
		{
			Exit();
		}
	}
}
