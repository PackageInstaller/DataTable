using XNode;

namespace ACT.Drama.NPC;

public class SetNpcInitStateNode : BaseNode
{
	[Input(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Enter;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Exit;

	public int contentId;

	public override void EnterNode()
	{
		behaviourTree.behaviour.contentId = contentId;
		ExitNode();
	}

	public override void ExitNode()
	{
		base.ExitNode();
	}
}
