namespace AIScript.Character._15901;

public class Parallel_Summon : AIBase
{
	public void OnEnable()
	{
		_actor.ignoreDeterministicCollision = true;
		_actor.EnableCloseBlock();
	}

	public void OnDisable()
	{
	}
}
