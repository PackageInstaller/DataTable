using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("DictionaryRemove", 0)]
[Category("Common/Control")]
[Description("DictionaryRemove")]
[ExposeAsDefinition]
public class DictionaryRemove<T> : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<IDictionary<int, T>> dictInput = AddValueInput<IDictionary<int, T>>("字典");
		ValueInput<int> keyInput = AddValueInput<int>("Key");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			dictInput.value.Remove(keyInput.value);
			output.Call(f);
		});
	}
}
