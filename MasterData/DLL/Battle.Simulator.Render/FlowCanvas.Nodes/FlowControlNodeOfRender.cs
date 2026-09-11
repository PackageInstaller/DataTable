using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers")]
[Color("ffff00")]
[ContextDefinedInputs(new Type[] { typeof(Flow) })]
[ContextDefinedOutputs(new Type[] { typeof(Flow) })]
public abstract class FlowControlNodeOfRender : FlowNode
{
}
