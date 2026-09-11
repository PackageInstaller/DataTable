using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("ListCountItemBool", 0)]
[Category("Common/Control")]
[Description("得到列表中某一元素的数量")]
public class ListCountItemBool : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<List<bool>> listInput = AddValueInput<List<bool>>("列表");
		ValueInput<bool> valueInput = AddValueInput<bool>("要查找的值");
		AddValueOutput("Count", delegate
		{
			int num = 0;
			List<bool> value = listInput.value;
			bool value2 = valueInput.value;
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
