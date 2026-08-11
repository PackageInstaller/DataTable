using System;
using NodeCanvas.Framework;
using ParadoxNotion;

namespace NodeCanvas.StateMachines;

public abstract class FSMNode : Node
{
	public override bool allowAsPrime => false;

	public override bool canSelfConnect => false;

	public override int maxInConnections => -1;

	public override int maxOutConnections => -1;

	public sealed override Type outConnectionType => typeof(FSMConnection);

	public sealed override Alignment2x2 commentsAlignment => Alignment2x2.Bottom;

	public sealed override Alignment2x2 iconAlignment => Alignment2x2.Bottom;

	public FSM FSM => (FSM)base.graph;
}
