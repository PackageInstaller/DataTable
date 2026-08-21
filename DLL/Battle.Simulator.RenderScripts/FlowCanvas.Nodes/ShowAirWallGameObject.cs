using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("判断显示空气墙(过时)", 0)]
[Category("Render/Asset")]
[Description("记录空气墙数据")]
[ExposeAsDefinition]
public class ShowAirWallGameObject : CallableActionNode<GameObject, int, Int3, Int3, Int3>
{
	public override void Invoke(GameObject airWalls, int playerID, Int3 Pos, Int3 forward, Int3 size)
	{
		bool flag = false;
		List<int> list = FrameListPool<int>.Claim();
		SimPhysics.OverlapBox(Pos, forward, default(Int3), size, list, 1u);
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i] == playerID)
			{
				airWalls.SetActive(value: true);
				flag = true;
			}
		}
		if (!flag && null != airWalls)
		{
			airWalls.SetActive(value: false);
		}
		FrameListPool<int>.Release(list);
	}
}
