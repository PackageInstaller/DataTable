using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("ListContains", 0)]
[Category("Common/Control")]
[Description("ListContains")]
public class ListContains<T> : FlowNode
{
	private int _firstIndex = -1;

	protected override void RegisterPorts()
	{
		ValueInput<List<T>> listInput = AddValueInput<List<T>>("列表");
		ValueInput<T> itemInput = AddValueInput<T>("Item");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			_firstIndex = -1;
			if (listInput.value.Contains(itemInput.value))
			{
				_firstIndex = listInput.value.IndexOf(itemInput.value);
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddValueOutput("索引", "firstIndex", () => _firstIndex);
	}
}
