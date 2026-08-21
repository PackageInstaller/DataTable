using System;
using UnityEngine.Playables;

namespace T0World;

[Serializable]
public class T0InterationCheckTimelineFinish : T0InterationBaseData
{
	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Animation;
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
		if (behaviour.executePlayable != null && behaviour.executePlayable.state != PlayState.Playing)
		{
			base.IsFinish = true;
		}
	}
}
