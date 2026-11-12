namespace AIScript.Character._13501;

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
