using System.Collections.Generic;
using XNode;

namespace ACT.Drama.NPC;

public class ConditionsNode : BaseNode
{
	[Input(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Enter;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int TrueExit;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int FalseExit;

	public List<BaseCondition> conditions = new List<BaseCondition>();

	public override void EnterNode()
	{
		for (int i = 0; i < conditions.Count; i++)
		{
			if (!conditions[i].Check())
			{
				TypeExitNode("FalseExit");
				return;
			}
		}
		ExitNode();
	}

	public override void ExitNode()
	{
		TypeExitNode("TrueExit");
	}

	private void TypeExitNode(string nodeType)
	{
		List<NodePort> connections = GetOutputPort(nodeType).GetConnections();
		if (connections != null)
		{
			for (int i = 0; i < connections.Count; i++)
			{
				(connections[i].node as BaseNode).EnterNode();
			}
		}
	}
}
