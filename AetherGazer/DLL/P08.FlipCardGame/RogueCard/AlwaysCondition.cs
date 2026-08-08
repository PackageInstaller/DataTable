namespace RogueCard;

public class AlwaysCondition : BaseCondition
{
	public override bool Check(TriggerMoment moment)
	{
		return true;
	}
}
