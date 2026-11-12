namespace AIScript;

public class RequestDash
{
	public int dashIndex;

	public DashStatus dashStatus;

	public void Reset(int index)
	{
		dashIndex = index;
		dashStatus = DashStatus.Running;
	}
}
