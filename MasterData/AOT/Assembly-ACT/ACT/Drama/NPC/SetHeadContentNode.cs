using XNode;

namespace ACT.Drama.NPC;

public class SetHeadContentNode : BaseNode
{
	[Input(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Enter;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Exit;

	public int contentId;

	public float showTime;

	public override void EnterNode()
	{
		behaviourTree.behaviour.headContentId = contentId;
		behaviourTree.behaviour.showTime = showTime;
		ExitNode();
	}

	public override void ExitNode()
	{
		base.ExitNode();
	}
}
