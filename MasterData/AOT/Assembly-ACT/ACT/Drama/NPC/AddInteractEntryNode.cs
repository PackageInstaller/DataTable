using XNode;

namespace ACT.Drama.NPC;

public class AddInteractEntryNode : BaseNode
{
	[Input(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Enter;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int Exit;

	public InteractEvent interactEvent = new InteractEvent();

	public override void EnterNode()
	{
		behaviourTree.behaviour.AddInteractEvent(interactEvent);
		ExitNode();
	}

	public override void ExitNode()
	{
		base.ExitNode();
	}
}
