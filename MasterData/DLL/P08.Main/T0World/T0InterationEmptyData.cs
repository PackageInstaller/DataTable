using System;

namespace T0World;

[Serializable]
public class T0InterationEmptyData : T0InteractionNode
{
	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		base.IsFinish = true;
	}
}
