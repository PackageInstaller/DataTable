using NodeCanvas.Framework;
using ParadoxNotion;

namespace NodeCanvas.BehaviourTrees;

public abstract class BTDecorator : BTNode
{
	public sealed override int maxOutConnections => 1;

	public sealed override Alignment2x2 commentsAlignment => Alignment2x2.Right;

	protected Connection decoratedConnection
	{
		get
		{
			if (base.outConnections.Count <= 0)
			{
				return null;
			}
			return base.outConnections[0];
		}
	}

	protected Node decoratedNode => decoratedConnection?.targetNode;
}
