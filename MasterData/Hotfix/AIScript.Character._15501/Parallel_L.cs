namespace AIScript.Character._15501;

public class Parallel_L : AIBase
{
	public void OnEnable()
	{
		_actor.ignoreDeterministicCollision = true;
		_actor.EnableCloseBlock();
		_actor.EnableImmuneControl();
	}

	public void OnDisable()
	{
	}
}
