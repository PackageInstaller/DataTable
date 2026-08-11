using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.StateMachines;

[Description("Execute a number of Actions when the FSM starts/enters, if Conditions are met. This is not a state.")]
[Color("ff64cb")]
[Icon("MacroIn", false, "")]
[Name("On FSM Enter", 0)]
public class OnFSMEnter : FSMNode, IUpdatable, IGraphElement
{
	[SerializeField]
	private ConditionList _conditionList;

	[SerializeField]
	private ActionList _actionList;

	public override string name => base.name.ToUpper();

	public override int maxInConnections => 0;

	public override int maxOutConnections => 0;

	public override bool allowAsPrime => false;

	public override void OnValidate(Graph assignedGraph)
	{
		if (_conditionList == null)
		{
			_conditionList = (ConditionList)Task.Create(typeof(ConditionList), assignedGraph);
			_conditionList.checkMode = ConditionList.ConditionsCheckMode.AllTrueRequired;
		}
		if (_actionList == null)
		{
			_actionList = (ActionList)Task.Create(typeof(ActionList), assignedGraph);
			_actionList.executionMode = ActionList.ActionsExecutionMode.ActionsRunInParallel;
		}
	}

	public override void OnGraphStarted()
	{
		_conditionList.Enable(base.graphAgent, base.graphBlackboard);
		if (_conditionList.Check(base.graphAgent, base.graphBlackboard))
		{
			base.status = _actionList.Execute(base.graphAgent, base.graphBlackboard);
		}
		else
		{
			base.status = Status.Failure;
		}
	}

	public override void OnGraphStoped()
	{
		_conditionList.Disable();
		_actionList.EndAction(null);
	}

	void IUpdatable.Update()
	{
		if (base.status == Status.Running)
		{
			base.status = _actionList.Execute(base.graphAgent, base.graphBlackboard);
		}
	}
}
