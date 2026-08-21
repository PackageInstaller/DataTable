using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("GetItem", 0)]
[Category("Common/Control")]
[Description("GetItem")]
public class ListGetItem<T> : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<T>> listInput = AddValueInput<List<T>>("列表");
		ValueInput<int> indexInput = AddValueInput<int>("Index");
		AddValueOutput("", () => listInput.value[indexInput.value]);
	}
}
