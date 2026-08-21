using System;
using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("矩形区域搜索(Render)", 0)]
[Category("Render/PosAndRot")]
[Description("搜索所有进入矩形区域的单位")]
[ExposeAsDefinition]
public class OverlapBoxRender : CallableFunctionNode<List<int>, Int3, Int3, Int3, List<int>>
{
	public static List<int> GetAgentIDsInBox(Int3 pos, Int3 forward, Int3 size, List<int> list)
	{
		if (list == null)
		{
			list = new List<int>();
		}
		list.Clear();
		Matrix4x4 identity = Matrix4x4.identity;
		Quaternion q = Quaternion.FromToRotation(Vector3.forward, (Vector3)forward);
		identity.SetTRS((Vector3)pos, q, (Vector3)size);
		identity = identity.inverse;
		foreach (KeyValuePair<int, NAgent> item in (NScene.GetCurrentScene() as BattleScene).GetAgentManager().mAgentsCreatedThisFrame)
		{
			try
			{
				Vector4 vector = item.Value.Position;
				vector.w = 1f;
				vector = identity * vector;
				if ((double)vector.x > -0.5 && (double)vector.x < 0.5 && (((double)vector.z > -0.5) & ((double)vector.z < 0.5)))
				{
					list.Add(item.Key);
				}
			}
			catch (Exception ex)
			{
				Debug.Log(ex.StackTrace);
				Debug.Log(item.Key);
			}
		}
		return list;
	}

	public override List<int> Invoke(Int3 pos, Int3 forward, Int3 size, List<int> list)
	{
		return GetAgentIDsInBox(pos, forward, size, list);
	}
}
