using System.Collections.Generic;

namespace Bamboo.Command;

public abstract class ParallelAssignmentGroup : AssignmentGroup
{
	protected readonly List<BaseAssignment> _assignments = new List<BaseAssignment>();

	public override AssignmentGroup Add(BaseAssignment assignment)
	{
		_assignments.Add(assignment);
		return this;
	}

	internal override void Execute()
	{
		base.Execute();
		if (_assignments.Count == 0)
		{
			Release();
		}
	}

	internal override void Stop()
	{
		foreach (BaseAssignment assignment in _assignments)
		{
			if (assignment.State == AssignmentState.Executing || assignment.State == AssignmentState.Stopping)
			{
				assignment.Stop();
			}
		}
		_assignments.Clear();
		base.Stop();
	}
}
