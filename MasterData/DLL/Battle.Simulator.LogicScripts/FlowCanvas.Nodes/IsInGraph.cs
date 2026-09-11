using ParadoxNotion.Design;
using Pathfinding;

namespace FlowCanvas.Nodes;

[Name("是否在地图内", 0)]
[Category("Logic/PosAndRot")]
[Description("判断是否在地图内")]
public class IsInGraph : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> position = AddValueInput<Int3>("坐标");
		FlowOutput trueOut = AddFlowOutput("在地图内");
		FlowOutput falseOut = AddFlowOutput("不在地图内");
		AddFlowInput("In", delegate(Flow f)
		{
			if (PathUtilities.IsOnGraph(position.value))
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
