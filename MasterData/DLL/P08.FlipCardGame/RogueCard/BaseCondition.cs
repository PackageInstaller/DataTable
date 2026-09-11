namespace RogueCard;

public abstract class BaseCondition
{
	public IEffectEntity effectEntity;

	public ConditionType Type { get; protected set; }

	public abstract bool Check(TriggerMoment moment);

	public virtual object[] GetData()
	{
		return new object[0];
	}

	public virtual void SetData(object[] data)
	{
	}
}
