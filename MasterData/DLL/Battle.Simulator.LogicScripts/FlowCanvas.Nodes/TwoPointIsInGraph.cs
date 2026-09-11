using ParadoxNotion.Design;
using Pathfinding;

namespace FlowCanvas.Nodes;

[Name("判断两点是否在同一个区域内", 0)]
[Category("Logic/PosAndRot")]
[Description("判断两点是否在同一个区域内，有一个点不在地图内或者两个点不在同一个区域内输出false")]
public class TwoPointIsInGraph : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> position1 = AddValueInput<Int3>("坐标1");
		ValueInput<Int3> position2 = AddValueInput<Int3>("坐标2");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			PathUtilities.IsOnGraph(position1.value, out var area);
			PathUtilities.IsOnGraph(position2.value, out var area2);
			if (area != -1 && area == area2)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
