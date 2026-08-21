using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.DialogueTrees;

[Icon("Condition", false, "")]
[Name("Task Condition", 0)]
[Category("Branch")]
[Description("Execute the first child node if a Condition is true, or the second one if that Condition is false. The Actor selected is used for the Condition check")]
[Color("b3ff7f")]
public class ConditionNode : DTNode, ITaskAssignable<ConditionTask>, ITaskAssignable, IGraphElement
{
	[SerializeField]
	private ConditionTask _condition;

	public ConditionTask condition
	{
		get
		{
			return _condition;
		}
		set
		{
			_condition = value;
		}
	}

	public Task task
	{
		get
		{
			return condition;
		}
		set
		{
			condition = (ConditionTask)value;
		}
	}

	public override int maxOutConnections => 2;

	public override bool requireActorSelection => true;

	protected override Status OnExecute(Component agent, IBlackboard bb)
	{
		if (base.outConnections.Count == 0)
		{
			return Error("There are no connections on the Dialogue Condition Node");
		}
		if (condition == null)
		{
			return Error("There is no Conidition on the Dialoge Condition Node");
		}
		bool flag = condition.CheckOnce(base.finalActor.transform, base.graphBlackboard);
		base.status = (flag ? Status.Success : Status.Failure);
		base.DLGTree.Continue((!flag) ? 1 : 0);
		return base.status;
	}
}
