namespace AIScript.Monster.Trap;

public class Spawn : AIBase
{
	public void OnEnable()
	{
	}

	public void OnStart()
	{
		_actor.Idle();
	}
}
