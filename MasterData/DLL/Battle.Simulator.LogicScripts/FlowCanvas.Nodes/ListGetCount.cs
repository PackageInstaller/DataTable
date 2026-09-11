using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("ListGetCount", 0)]
[Category("Common/Control")]
[Description("ListGetCount")]
public class ListGetCount<T> : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<T>> listInput = AddValueInput<List<T>>("列表");
		AddValueOutput("Count", () => listInput.value.Count);
	}
}
