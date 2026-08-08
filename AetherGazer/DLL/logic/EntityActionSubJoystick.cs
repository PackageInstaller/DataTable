using Entitas;

[Sim]
public class EntityActionSubJoystick : IComponent, IComponentReset
{
	public int CommandCode;

	public int TimelineID;

	public void Reset(Entity entity)
	{
		CommandCode = 0;
		TimelineID = 0;
	}
}
