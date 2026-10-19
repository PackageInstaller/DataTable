using XNode;

namespace ACT.Drama.NPC;

public class HideNpcButtonNode : BaseNode
{
	[Input(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Enter;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Exit;

	public override void EnterNode()
	{
		behaviourTree.behaviour.hideButton = true;
		ExitNode();
	}

	public override void ExitNode()
	{
		base.ExitNode();
	}
}
