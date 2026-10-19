using System;

namespace ACT.Config;

[Serializable]
public class RogueEvent
{
	public readonly int id;

	public readonly int eventGroup;

	public readonly int eventTextId;

	public readonly int eventExitCondition;

	public readonly float[] eventExitConditionParm = new float[0];

	public readonly int eventType;

	public RogueEvent(int id, int eventGroup, int eventTextId, int eventExitCondition, float[] eventExitConditionParm, int eventType)
	{
		this.id = id;
		this.eventGroup = eventGroup;
		this.eventTextId = eventTextId;
		this.eventExitCondition = eventExitCondition;
		this.eventExitConditionParm = eventExitConditionParm;
		this.eventType = eventType;
	}
}
