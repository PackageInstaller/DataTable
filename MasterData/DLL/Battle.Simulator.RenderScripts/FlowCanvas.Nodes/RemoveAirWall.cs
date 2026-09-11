using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除空气墙", 0)]
[Category("Render/Asset")]
[Description("记录空气墙数据")]
[ExposeAsDefinition]
public class RemoveAirWall : CallableActionNode<List<AirWallInfo>, int>
{
	public override void Invoke(List<AirWallInfo> airWalls, int id)
	{
		for (int i = 0; i < airWalls.Count; i++)
		{
			if (airWalls[i].ID == id)
			{
				airWalls.RemoveAt(i);
				break;
			}
		}
	}
}
