using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers")]
[Color("03fc4e")]
[ContextDefinedInputs(new Type[] { typeof(Flow) })]
[ContextDefinedOutputs(new Type[] { typeof(Flow) })]
public abstract class FlowControlNodeOfLogic : FlowNode
{
}
