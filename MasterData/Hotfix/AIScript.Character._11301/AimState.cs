namespace AIScript.Character._11301;

public class AimState : IState
{
	public override void Enter()
	{
		base.Enter();
		_aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
		Exit();
	}
}
