using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[DoNotList]
[Name("Get Internal Var", 0)]
[Description("Returns the selected and previously set Internal Variable's input value.")]
[Category("Variables/Internal")]
[Color("866693")]
[ContextDefinedOutputs(new Type[] { typeof(Wild) })]
[ExposeAsDefinition]
public abstract class RelayValueOutputBase : FlowNode
{
	public abstract void SetSource(RelayValueInputBase source);
}
