using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[庚辰]鱼机制分解(位)", 0)]
[Category("Common/角色定制/庚辰")]
[Description("庚辰特殊机制的解析卦象")]
public class AnalysisYu : FlowControlNodeOfCommon
{
	private int[] _yuArr = new int[4];

	protected override void RegisterPorts()
	{
		ValueInput<long> dataInput = AddValueInput<long>("鱼机制(位)", "yao");
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			uint num = (uint)dataInput.value;
			uint num2 = num >> 16;
			for (int i = 0; i < 4; i++)
			{
				if (i < num2)
				{
					_yuArr[i] = ((((num >> i) & 1) == 1) ? 1 : (-1));
				}
				else
				{
					_yuArr[i] = 0;
				}
			}
			output.Call(f);
		});
		AddValueOutput("鱼值1", "yaoValue1", () => _yuArr[0]);
		AddValueOutput("鱼值2", "yaoValue2", () => _yuArr[1]);
		AddValueOutput("鱼值3", "yaoValue3", () => _yuArr[2]);
		AddValueOutput("鱼值4", "yaoValue4", () => _yuArr[3]);
	}
}
