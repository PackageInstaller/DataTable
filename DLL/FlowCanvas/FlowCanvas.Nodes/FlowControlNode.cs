using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers")]
[Color("bf7fff")]
[ContextDefinedInputs(new Type[] { typeof(Flow) })]
[ContextDefinedOutputs(new Type[] { typeof(Flow) })]
public abstract class FlowControlNode : FlowNode
{
}
