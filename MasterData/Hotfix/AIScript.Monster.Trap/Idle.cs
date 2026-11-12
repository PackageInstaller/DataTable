namespace AIScript.Monster.Trap;

public class Idle : AIBase
{
	public void OnEnable()
	{
		_actor.Action();
	}

	public void OnDisable()
	{
	}

	public void OnUpdate()
	{
	}
}
