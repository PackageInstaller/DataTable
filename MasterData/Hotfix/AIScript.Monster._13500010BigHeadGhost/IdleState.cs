namespace AIScript.Monster._13500010BigHeadGhost;

public class IdleState : IState
{
	public override void Enter()
	{
		base.Enter();
	}

	public override void Update()
	{
		base.Update();
		if (_actor.monsterTarget != null)
		{
			Exit();
		}
	}
}
