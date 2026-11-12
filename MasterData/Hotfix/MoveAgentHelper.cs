using TrueSync;

public static class MoveAgentHelper
{
	public static FP GetMaxSpeed(this AdventureActor actor)
	{
		return actor.movAgent.maxSpeed;
	}

	public static void AgentMove(this AdventureActor actor, TSVector targetPos)
	{
		actor.movAgent.Move(targetPos);
	}
}
