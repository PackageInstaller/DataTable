namespace T0World;

public class T0FurnitureAgent : T0WorldAgent
{
	public override T0AgentLayer GetAgentLayer()
	{
		return T0AgentLayer.Furniture;
	}

	public override void UpdateAgent()
	{
		base.UpdateAgent();
	}

	public void UpdateEvent()
	{
		if (!base.Blackboard.EventContext.IsHaveEvent())
		{
			TriggerInteraction();
		}
	}
}
