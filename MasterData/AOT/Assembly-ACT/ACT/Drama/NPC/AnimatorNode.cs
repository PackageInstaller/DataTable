using XNode;

namespace ACT.Drama.NPC;

public class AnimatorNode : BaseNode
{
	[Input(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Enter;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Exit;

	public int animatorState;

	public override void EnterNode()
	{
		behaviourTree.behaviour.animatorState = animatorState;
		ExitNode();
	}

	public override void ExitNode()
	{
		base.ExitNode();
	}
}
