using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[ExposeAsDefinition]
[ContextDefinedInputs(new Type[]
{
	typeof(Wild),
	typeof(bool)
})]
[ContextDefinedOutputs(new Type[] { typeof(Wild) })]
[Category("Flow Controllers/Selectors")]
[Description("Select a Result value out of the two input cases provided, based on a boolean Condition")]
public class SelectOnBool<T> : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> condition = AddValueInput<bool>("Condition");
		ValueInput<T> isTrue = AddValueInput<T>("Is True", "True");
		ValueInput<T> isFalse = AddValueInput<T>("Is False", "False");
		AddValueOutput("Result", "Value", () => (!condition.value) ? isFalse.value : isTrue.value);
	}
}
