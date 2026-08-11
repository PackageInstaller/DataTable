using System.Collections.Generic;

namespace System.Linq.Expressions.Interpreter;

internal sealed class BranchLabel
{
	private int _targetIndex = int.MinValue;

	private int _stackDepth = int.MinValue;

	private int _continuationStackDepth = int.MinValue;

	private List<int> _forwardBranchFixups;

	internal int LabelIndex { get; set; } = int.MinValue;

	internal bool HasRuntimeLabel => LabelIndex != int.MinValue;

	internal int TargetIndex => _targetIndex;

	internal RuntimeLabel ToRuntimeLabel()
	{
		return new RuntimeLabel(_targetIndex, _continuationStackDepth, _stackDepth);
	}

	internal void Mark(InstructionList instructions)
	{
		_stackDepth = instructions.CurrentStackDepth;
		_continuationStackDepth = instructions.CurrentContinuationsDepth;
		_targetIndex = instructions.Count;
		if (_forwardBranchFixups == null)
		{
			return;
		}
		foreach (int forwardBranchFixup in _forwardBranchFixups)
		{
			FixupBranch(instructions, forwardBranchFixup);
		}
		_forwardBranchFixups = null;
	}

	internal void AddBranch(InstructionList instructions, int branchIndex)
	{
		if (_targetIndex == int.MinValue)
		{
			if (_forwardBranchFixups == null)
			{
				_forwardBranchFixups = new List<int>();
			}
			_forwardBranchFixups.Add(branchIndex);
		}
		else
		{
			FixupBranch(instructions, branchIndex);
		}
	}

	internal void FixupBranch(InstructionList instructions, int branchIndex)
	{
		instructions.FixupBranch(branchIndex, _targetIndex - branchIndex);
	}
}
