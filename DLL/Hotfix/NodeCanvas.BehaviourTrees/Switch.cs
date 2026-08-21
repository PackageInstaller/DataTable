using System;
using System.Collections.Generic;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Category("Composites")]
[Description("Executes one child based on the provided int or enum case and returns its status.")]
[Icon("IndexSwitcher", false, "")]
[Color("b3ff7f")]
public class Switch : BTComposite
{
	public enum CaseSelectionMode
	{
		IndexBased,
		EnumBased
	}

	public enum OutOfRangeMode
	{
		ReturnFailure,
		LoopIndex
	}

	[Tooltip("If true and the 'case' change while a child is running, that child will immediately be interrupted and the new child will be executed.")]
	public bool dynamic;

	[Tooltip("The selection mode used.")]
	public CaseSelectionMode selectionMode;

	[ShowIf("selectionMode", 0)]
	public BBParameter<int> intCase;

	[ShowIf("selectionMode", 0)]
	public OutOfRangeMode outOfRangeMode = OutOfRangeMode.LoopIndex;

	[ShowIf("selectionMode", 1)]
	[BlackboardOnly]
	public BBObjectParameter enumCase = new BBObjectParameter(typeof(Enum));

	private Dictionary<int, int> enumCasePairing;

	private int current;

	private int runningIndex;

	public override void OnGraphStarted()
	{
		if (selectionMode != CaseSelectionMode.EnumBased)
		{
			return;
		}
		object value = enumCase.value;
		if (value != null)
		{
			enumCasePairing = new Dictionary<int, int>();
			Array values = Enum.GetValues(value.GetType());
			for (int i = 0; i < values.Length; i++)
			{
				enumCasePairing[(int)values.GetValue(i)] = i;
			}
		}
	}

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		_ = selectionMode;
		if (base.outConnections.Count == 0)
		{
			return Status.Optional;
		}
		if (base.status == Status.Resting || dynamic)
		{
			if (selectionMode == CaseSelectionMode.IndexBased)
			{
				current = intCase.value;
				if (outOfRangeMode == OutOfRangeMode.LoopIndex)
				{
					current = Mathf.Abs(current) % base.outConnections.Count;
				}
			}
			else
			{
				current = enumCasePairing[(int)enumCase.value];
			}
			if (runningIndex != current)
			{
				base.outConnections[runningIndex].Reset();
			}
			if (current < 0 || current >= base.outConnections.Count)
			{
				return Status.Failure;
			}
		}
		base.status = base.outConnections[current].Execute(agent, blackboard);
		if (base.status == Status.Running)
		{
			runningIndex = current;
		}
		return base.status;
	}
}
[Category("Composites")]
[Description("Executes one child based on the provided int or enum case and returns its status.")]
[Icon("IndexSwitcher", false, "")]
[Color("b3ff7f")]
public class Switch<T> : BTComposite
{
	public enum CaseSelectionMode
	{
		IndexBased,
		EnumBased
	}

	public enum OutOfRangeMode
	{
		ReturnFailure,
		LoopIndex
	}

	[Tooltip("If true and the 'case' change while a child is running, that child will immediately be interrupted and the new child will be executed.")]
	public bool dynamic;

	[Tooltip("The selection mode used.")]
	public CaseSelectionMode selectionMode;

	[ShowIf("selectionMode", 0)]
	public BBParameter<int> intCase;

	[ShowIf("selectionMode", 0)]
	public OutOfRangeMode outOfRangeMode = OutOfRangeMode.LoopIndex;

	[ShowIf("selectionMode", 1)]
	[BlackboardOnly]
	public BBParameter<T> enumCase;

	private Dictionary<int, int> _intsCasePairing;

	private Array _enumArray;

	private int _current;

	private int _runningIndex;

	public override void OnGraphStarted()
	{
		if (selectionMode == CaseSelectionMode.EnumBased && enumCase.value != null)
		{
			if (_intsCasePairing == null)
			{
				_intsCasePairing = new Dictionary<int, int>();
			}
			else
			{
				_intsCasePairing.Clear();
			}
			_enumArray = Enum.GetValues(typeof(T));
			for (int i = 0; i < _enumArray.Length; i++)
			{
				_intsCasePairing[(int)_enumArray.GetValue(i)] = i;
			}
		}
	}

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.outConnections.Count == 0)
		{
			return Status.Optional;
		}
		if (base.status == Status.Resting || dynamic)
		{
			if (selectionMode == CaseSelectionMode.IndexBased)
			{
				_current = intCase.value;
				if (outOfRangeMode == OutOfRangeMode.LoopIndex)
				{
					_current = Mathf.Abs(_current) % base.outConnections.Count;
				}
			}
			else
			{
				int key = Convert.ToInt32(enumCase.value);
				_current = _intsCasePairing[key];
			}
			if (_runningIndex != _current)
			{
				base.outConnections[_runningIndex].Reset();
			}
			if (_current < 0 || _current >= base.outConnections.Count)
			{
				return Status.Failure;
			}
		}
		base.status = base.outConnections[_current].Execute(agent, blackboard);
		if (base.status == Status.Running)
		{
			_runningIndex = _current;
		}
		return base.status;
	}
}
