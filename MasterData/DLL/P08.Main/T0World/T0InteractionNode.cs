using System;

namespace T0World;

[Serializable]
public class T0InteractionNode : T0InterationBaseData
{
	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public override void DisposeEvent()
	{
	}
}
