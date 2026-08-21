using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("ListRemoveAtItem", 0)]
[Category("Common/Control")]
[Description("ListAddItem")]
public class ListRemoveAtItem<T> : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<T>> listInput = AddValueInput<List<T>>("列表");
		ValueInput<int> indexInput = AddValueInput<int>("索引");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (listInput.value.Count > indexInput.value)
			{
				listInput.value.RemoveAt(indexInput.value);
			}
			output.Call(f);
		});
	}
}
