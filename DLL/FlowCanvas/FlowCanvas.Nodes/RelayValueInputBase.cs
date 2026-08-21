using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Set Internal Var", 0)]
[Description("Can be used to set an internal variable, to later be retrieved with a 'Get Internal Var' node.")]
[Category("Variables/Internal")]
[Color("866693")]
[ContextDefinedInputs(new Type[] { typeof(Wild) })]
[ExposeAsDefinition]
public abstract class RelayValueInputBase : FlowNode
{
	public abstract Type relayType { get; }
}
