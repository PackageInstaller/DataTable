namespace BehaviorDesigner.Runtime.Tasks;

public class Decorator : ParentTask
{
	public override int MaxChildren()
	{
		return 1;
	}
}
