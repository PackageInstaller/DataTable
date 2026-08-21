using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("ListGetCountOfDiff", 0)]
[Category("Common/Control")]
[Description("返回数组中不同数量的值")]
public class ListGetDiffCount<T> : FlowControlNodeOfCommon
{
	protected override void RegisterPorts()
	{
		ValueInput<List<T>> listInput = AddValueInput<List<T>>("列表");
		AddValueOutput("Count", () => new HashSet<T>(listInput.value).Count);
	}
}
