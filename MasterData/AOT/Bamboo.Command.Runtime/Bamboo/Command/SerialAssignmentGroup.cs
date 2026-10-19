using System.Collections.Generic;

namespace Bamboo.Command;

public sealed class SerialAssignmentGroup : AssignmentGroup
{
	private const int MAX_STEP = 16;

	private readonly Queue<BaseAssignment> _assignmentQueue = new Queue<BaseAssignment>();

	private BaseAssignment _executingAssignment;

	public override AssignmentGroup Add(BaseAssignment assignment)
	{
		_assignmentQueue.Enqueue(assignment);
		return this;
	}

	internal override void Execute()
	{
		base.Execute();
		if (_assignmentQueue == null || _assignmentQueue.Count == 0)
		{
			Release();
		}
		else
		{
			_executingAssignment = _assignmentQueue.Dequeue();
		}
	}

	public void ForceNewMessageShow()
	{
		if (_executingAssignment != null)
		{
			_executingAssignment.ForceExecute();
		}
	}

	internal override void Update(int delta)
	{
		for (int i = 0; i < 16; i++)
		{
			if (_executingAssignment.State == AssignmentState.Unexecute)
			{
				_executingAssignment.Execute();
			}
			if (_executingAssignment.State == AssignmentState.Executing)
			{
				_executingAssignment.Update(delta);
				if (_executingAssignment.State == AssignmentState.Executing)
				{
					break;
				}
			}
			if (_executingAssignment.State == AssignmentState.Stopping)
			{
				_executingAssignment.Stop();
				if (_assignmentQueue.Count == 0)
				{
					_executingAssignment = null;
					Release();
					break;
				}
				_executingAssignment = _assignmentQueue.Dequeue();
			}
		}
	}

	internal override void Stop()
	{
		if (_executingAssignment != null)
		{
			if (_executingAssignment.State == AssignmentState.Executing || _executingAssignment.State == AssignmentState.Stopping)
			{
				_executingAssignment.Stop();
			}
			_executingAssignment = null;
		}
		_assignmentQueue.Clear();
		base.Stop();
	}
}
