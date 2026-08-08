using System;

namespace T0World;

[Serializable]
public class T0InterationCloseExcuteTimeline : T0InterationBaseData
{
	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Animation;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		if (!(behaviour == null))
		{
			behaviour.CloseExcutePlayable();
			base.IsFinish = true;
		}
	}
}
