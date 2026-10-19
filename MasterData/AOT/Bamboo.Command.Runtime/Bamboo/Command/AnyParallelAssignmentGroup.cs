namespace Bamboo.Command;

public sealed class AnyParallelAssignmentGroup : ParallelAssignmentGroup
{
	internal override void Update(int delta)
	{
		foreach (BaseAssignment assignment in _assignments)
		{
			if (assignment.State == AssignmentState.Unexecute)
			{
				assignment.Execute();
			}
			if (assignment.State == AssignmentState.Executing)
			{
				assignment.Update(delta);
			}
			if (assignment.State == AssignmentState.Stopping)
			{
				assignment.Stop();
				Release();
				break;
			}
		}
	}
}
