using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("ListCountItemLong", 0)]
[Category("Common/Control")]
[Description("得到列表中某一元素的数量")]
public class ListCountItemLong : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<long>> listInput = AddValueInput<List<long>>("列表");
		ValueInput<long> valueInput = AddValueInput<long>("要查找的值");
		AddValueOutput("Count", delegate
		{
			int num = 0;
			List<long> value = listInput.value;
			long value2 = valueInput.value;
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
