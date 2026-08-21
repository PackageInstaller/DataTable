using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("显示空气墙(过时)", 0)]
[Category("Render/Asset")]
[Description("记录空气墙数据")]
[ExposeAsDefinition]
public class ShowAirWall : CallableActionNode<AirWallInfo, int>
{
	public override void Invoke(AirWallInfo airWalls, int playerID)
	{
		bool flag = true;
		NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(airWalls.ID);
		List<int> list = FrameListPool<int>.Claim();
		SimPhysics.OverlapBox(airWalls.Position, airWalls.Forward, airWalls.Position, airWalls.Size, list, 1u);
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i] == playerID && null != agent)
			{
				agent.gameObject.SetActive(value: true);
				flag = true;
			}
		}
		if (!flag && null != agent)
		{
			agent.gameObject.SetActive(value: false);
		}
		FrameListPool<int>.Release(list);
	}
}
