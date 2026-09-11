using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("DictionaryAdd", 0)]
[Category("Common/Control")]
[Description("DictionaryAdd")]
[ExposeAsDefinition]
public class DictionaryAdd<T> : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<IDictionary<int, T>> dictInput = AddValueInput<IDictionary<int, T>>("字典");
		ValueInput<int> keyInput = AddValueInput<int>("Key");
		ValueInput<T> valueInput = AddValueInput<T>("value");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			dictInput.value[keyInput.value] = valueInput.value;
			output.Call(f);
		});
	}
}
