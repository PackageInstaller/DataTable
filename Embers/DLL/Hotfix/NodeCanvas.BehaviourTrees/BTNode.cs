using System;
using NodeCanvas.Framework;
using ParadoxNotion;

namespace NodeCanvas.BehaviourTrees;

public abstract class BTNode : Node
{
	public sealed override Type outConnectionType => typeof(BTConnection);

	public sealed override bool allowAsPrime => true;

	public sealed override bool canSelfConnect => false;

	public override Alignment2x2 commentsAlignment => Alignment2x2.Bottom;

	public override Alignment2x2 iconAlignment => Alignment2x2.Default;

	public override int maxInConnections => 1;

	public override int maxOutConnections => 0;

	public T AddChild<T>(int childIndex) where T : BTNode
	{
		if (base.outConnections.Count >= maxOutConnections && maxOutConnections != -1)
		{
			return null;
		}
		T val = base.graph.AddNode<T>();
		base.graph.ConnectNodes(this, val, childIndex);
		return val;
	}

	public T AddChild<T>() where T : BTNode
	{
		if (base.outConnections.Count >= maxOutConnections && maxOutConnections != -1)
		{
			return null;
		}
		T val = base.graph.AddNode<T>();
		base.graph.ConnectNodes(this, val);
		return val;
	}
}
