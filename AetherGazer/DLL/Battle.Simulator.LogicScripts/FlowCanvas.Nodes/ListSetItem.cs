using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("ListSetItem", 0)]
[Category("Common/Control")]
[Description("ListSetItem")]
public class ListSetItem<T> : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<T>> listInput = AddValueInput<List<T>>("列表");
		ValueInput<T> itemInput = AddValueInput<T>("Item");
		ValueInput<int> indexInput = AddValueInput<int>("Index");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			listInput.value[indexInput.value] = itemInput.value;
			output.Call(f);
		});
	}
}
