using TrueSync;

public class ActionCondition
{
	public bool CanCast;

	public FP HoldTime;

	public ActionCondition(bool canCast, FP holdTime)
	{
		CanCast = canCast;
		HoldTime = holdTime;
	}
}
