using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.StateMachines;

[Description("Execute a number of Actions repeatedly and in parallel to any other FSM state while the FSM is running. Conditions are optional. This is not a state.")]
[Color("ff64cb")]
[Icon("Repeat", false, "")]
[Name("On FSM Update", 0)]
public class OnFSMUpdate : FSMNode, IUpdatable, IGraphElement
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
	}

	public override void OnGraphStoped()
	{
		_conditionList.Disable();
		_actionList.EndAction(null);
	}

	void IUpdatable.Update()
	{
		if (_conditionList.Check(base.graphAgent, base.graphBlackboard))
		{
			base.status = _actionList.Execute(base.graphAgent, base.graphBlackboard);
			return;
		}
		_actionList.EndAction(null);
		base.status = Status.Failure;
	}
}
