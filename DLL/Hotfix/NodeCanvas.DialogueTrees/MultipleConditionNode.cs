using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.DialogueTrees;

[Icon("Selector", false, "")]
[Name("Multiple Task Condition", 0)]
[Category("Branch")]
[Description("Will continue with the first child node which condition returns true. The Dialogue Actor selected will be used for the checks")]
[Color("b3ff7f")]
public class MultipleConditionNode : DTNode
{
	[SerializeField]
	[AutoSortWithChildrenConnections]
	private List<ConditionTask> conditions = new List<ConditionTask>();

	public override int maxOutConnections => -1;

	public override void OnChildConnected(int index)
	{
		if (conditions.Count < base.outConnections.Count)
		{
			conditions.Insert(index, null);
		}
	}

	public override void OnChildDisconnected(int index)
	{
		conditions.RemoveAt(index);
	}

	protected override Status OnExecute(Component agent, IBlackboard bb)
	{
		if (base.outConnections.Count == 0)
		{
			return Error("There are no connections on the Dialogue Condition Node");
		}
		for (int i = 0; i < base.outConnections.Count; i++)
		{
			if (conditions[i] == null || conditions[i].CheckOnce(base.finalActor.transform, base.graphBlackboard))
			{
				base.DLGTree.Continue(i);
				return Status.Success;
			}
		}
		base.DLGTree.Stop(success: false);
		return Status.Failure;
	}
}
