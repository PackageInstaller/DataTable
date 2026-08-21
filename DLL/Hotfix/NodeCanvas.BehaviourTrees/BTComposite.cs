using ParadoxNotion;

namespace NodeCanvas.BehaviourTrees;

public abstract class BTComposite : BTNode
{
	public override string name => base.name.ToUpper();

	public sealed override int maxOutConnections => -1;

	public sealed override Alignment2x2 commentsAlignment => Alignment2x2.Right;
}
