using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("ListCountItemInt3", 0)]
[Category("Common/Control")]
[Description("得到列表中某一元素的数量")]
public class ListCountItemInt3 : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<Int3>> listInput = AddValueInput<List<Int3>>("列表");
		ValueInput<Int3> valueInput = AddValueInput<Int3>("要查找的值");
		AddValueOutput("Count", delegate
		{
			int num = 0;
			List<Int3> value = listInput.value;
			Int3 value2 = valueInput.value;
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
