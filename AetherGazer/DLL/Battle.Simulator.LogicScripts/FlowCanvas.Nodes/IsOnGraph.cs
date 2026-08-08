using ParadoxNotion.Design;
using Pathfinding;

namespace FlowCanvas.Nodes;

[Name("判断是否在地图内", 0)]
[Category("Logic/PosAndRot")]
[Description("判断是否在地图内")]
public class IsOnGraph : CallableFunctionNode<bool, Int3>
{
	public override bool Invoke(Int3 pos)
	{
		return PathUtilities.IsOnGraph(pos);
	}
}
