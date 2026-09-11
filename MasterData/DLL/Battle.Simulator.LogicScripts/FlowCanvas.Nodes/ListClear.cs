using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("ListClear", 0)]
[Category("Common/Control")]
[Description("ListClear")]
public class ListClear<T> : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<T>> listInput = AddValueInput<List<T>>("列表");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			listInput.value.Clear();
			output.Call(f);
		});
	}
}
