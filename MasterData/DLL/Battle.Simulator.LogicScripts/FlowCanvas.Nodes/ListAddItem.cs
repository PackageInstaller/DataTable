using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("ListAddItem", 0)]
[Category("Common/Control")]
[Description("ListAddItem")]
public class ListAddItem<T> : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<T>> listInput = AddValueInput<List<T>>("列表");
		ValueInput<T> itemInput = AddValueInput<T>("Item");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			listInput.value.Add(itemInput.value);
			output.Call(f);
		});
	}
}
