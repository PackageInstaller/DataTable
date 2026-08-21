using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("向下取整", 0)]
[Category("Logic/Math")]
[Description("向下取整,参数为1, 就是1的倍数, 参数为5,就是5的倍数")]
public class FloatFloor : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<float> valueInput = AddValueInput<float>("值");
		ValueInput<int> paramInput = AddValueInput<int>("参数");
		AddValueOutput("结果", delegate
		{
			int num = paramInput.value;
			if (num == 0)
			{
				num = 1;
			}
			return (int)Math.Floor(valueInput.value) / num * num;
		});
	}
}
