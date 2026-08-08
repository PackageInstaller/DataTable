using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("ListCountItemInt", 0)]
[Category("Common/Control")]
[Description("得到列表中某一元素的数量")]
public class ListCountItemInt : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<int>> listInput = AddValueInput<List<int>>("列表");
		ValueInput<int> valueInput = AddValueInput<int>("要查找的值");
		AddValueOutput("Count", delegate
		{
			int num = 0;
			List<int> value = listInput.value;
			int value2 = valueInput.value;
			if (value == null)
			{
				return 0;
			}
			for (int i = 0; i < value.Count; i++)
			{
				if (value[i] == value2)
				{
					num++;
				}
			}
			return num;
		});
	}
}
