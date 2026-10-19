using XNode;

namespace ACT.Drama.NPC;

public class EnterGraphNode : BaseNode
{
	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Exit;

	protected override void Init()
	{
		base.Init();
		behaviourTree.baseNode = this;
	}

	public override void EnterNode()
	{
		ExitNode();
	}

	public override void ExitNode()
	{
		base.ExitNode();
	}
}
