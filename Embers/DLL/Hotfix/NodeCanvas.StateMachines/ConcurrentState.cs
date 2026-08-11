using System;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.StateMachines;

[Name("Parallel", 0)]
[Description("Execute a number of Actions with optional conditional requirement and in parallel to any other state, as soon as the FSM is started. All actions will prematurely be stoped as soon as the FSM stops as well. This is not a state.")]
[Color("ff64cb")]
[Icon("Repeat", false, "")]
[Obsolete("Use On FSM Update node")]
public class ConcurrentState : FSMNode, IUpdatable, IGraphElement
{
	[SerializeField]
	private ConditionList _conditionList;

	[SerializeField]
	private ActionList _actionList;

	[SerializeField]
	private bool _repeatStateActions;

	private bool done;

	public ConditionList conditionList
	{
		get
		{
			return _conditionList;
		}
		set
		{
			_conditionList = value;
		}
	}

	public ActionList actionList
	{
		get
		{
			return _actionList;
		}
		set
		{
			_actionList = value;
		}
	}

	public bool repeatStateActions
	{
		get
		{
			return _repeatStateActions;
		}
		set
		{
			_repeatStateActions = value;
		}
	}

	public override string name => base.name.ToUpper();

	public override int maxInConnections => 0;

	public override int maxOutConnections => 0;

	public override bool allowAsPrime => false;

	public override void OnValidate(Graph assignedGraph)
	{
		if (conditionList == null)
		{
			conditionList = (ConditionList)Task.Create(typeof(ConditionList), assignedGraph);
			conditionList.checkMode = ConditionList.ConditionsCheckMode.AllTrueRequired;
		}
		if (actionList == null)
		{
			actionList = (ActionList)Task.Create(typeof(ActionList), assignedGraph);
			actionList.executionMode = ActionList.ActionsExecutionMode.ActionsRunInParallel;
		}
	}

	public override void OnGraphStarted()
	{
		conditionList.Enable(base.graphAgent, base.graphBlackboard);
		done = false;
	}

	public override void OnGraphStoped()
	{
		conditionList.Disable();
		actionList.EndAction(null);
		done = false;
	}

	public override void OnGraphPaused()
	{
		actionList.Pause();
	}

	void IUpdatable.Update()
	{
		if (done && !repeatStateActions)
		{
			return;
		}
		base.status = Status.Running;
		if (conditionList.Check(base.graphAgent, base.graphBlackboard))
		{
			if (actionList.Execute(base.graphAgent, base.graphBlackboard) != Status.Running)
			{
				if (!repeatStateActions)
				{
					base.status = Status.Success;
				}
				done = true;
			}
		}
		else
		{
			actionList.EndAction(null);
			base.status = Status.Failure;
		}
	}
}
