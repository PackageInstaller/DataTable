namespace AIScript;

public class RequestBezierPathMove
{
	public int index;

	public BaseNormalStatus status;

	public void Reset(int index)
	{
		this.index = index;
		status = BaseNormalStatus.Running;
	}
}
