namespace Bamboo.Command;

public sealed class BothParallelAssignmentGroup : ParallelAssignmentGroup
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
			}
		}
		_assignments.RemoveAll(PredicateStoped);
		if (_assignments.Count == 0)
		{
			Release();
		}
	}

	private bool PredicateStoped(BaseAssignment assignment)
	{
		return assignment.State == AssignmentState.Stoped;
	}
}
