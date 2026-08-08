using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers")]
[Color("c0c0c0")]
[ContextDefinedInputs(new Type[] { typeof(Flow) })]
[ContextDefinedOutputs(new Type[] { typeof(Flow) })]
public abstract class FlowControlNodeOfCommon : FlowNode
{
}
