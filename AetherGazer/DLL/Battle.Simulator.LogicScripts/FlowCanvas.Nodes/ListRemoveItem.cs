using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("ListRemoveItem", 0)]
[Category("Common/Control")]
[Description("ListAddItem")]
public class ListRemoveItem<T> : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<T>> listInput = AddValueInput<List<T>>("列表");
		ValueInput<T> itemInput = AddValueInput<T>("Item");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			listInput.value.Remove(itemInput.value);
			output.Call(f);
		});
	}
}
