using System;

namespace T0World;

[Serializable]
public class T0InterationBedUpdateLike : T0InterationBaseData
{
	public int updateValue = 20;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		T0BedGame.bedGame.UpdateLikeProcess(updateValue);
		base.IsFinish = true;
	}
}
