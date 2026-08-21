using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("ListCountItemString", 0)]
[Category("Common/Control")]
[Description("得到列表中某一元素的数量")]
public class ListCountItemString : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<string>> listInput = AddValueInput<List<string>>("列表");
		ValueInput<string> valueInput = AddValueInput<string>("要查找的值");
		AddValueOutput("Count", delegate
		{
			int num = 0;
			List<string> value = listInput.value;
			string value2 = valueInput.value;
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
