using XNode;

namespace ACT.Drama.NPC;

public class SubTreeNode : BaseNode
{
	[Input(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Enter;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Exit;

	public NPCBehaviourTree subBehaviourTree;

	public override void EnterNode()
	{
		if (subBehaviourTree != null)
		{
			subBehaviourTree.behaviour = behaviourTree.behaviour;
			subBehaviourTree.baseNode.EnterNode();
		}
		ExitNode();
	}

	public override void ExitNode()
	{
		base.ExitNode();
	}
}
