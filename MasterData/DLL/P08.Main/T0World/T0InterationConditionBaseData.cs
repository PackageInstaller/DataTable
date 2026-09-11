using System;

namespace T0World;

[Serializable]
public abstract class T0InterationConditionBaseData : T0InterationBaseData
{
	public bool isEnterTree;

	public T0InterationContitionTypeEnum condition_type;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		if (isEnterTree)
		{
			base.IsFinish = true;
		}
		else if (CheckIsArriveCondition())
		{
			base.IsFinish = true;
		}
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
		if (CheckIsArriveCondition())
		{
			base.IsFinish = true;
		}
	}

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Condition;
	}

	public abstract bool CheckIsArriveCondition();
}
