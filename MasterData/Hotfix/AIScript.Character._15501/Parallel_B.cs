namespace AIScript.Character._15501;

public class Parallel_B : AIBase
{
	public void OnEnable()
	{
		_actor.ignoreDeterministicCollision = true;
		_actor.DisableMovementAgent();
		_actor.EnableImmuneControl();
	}

	public void OnDisable()
	{
	}
}
