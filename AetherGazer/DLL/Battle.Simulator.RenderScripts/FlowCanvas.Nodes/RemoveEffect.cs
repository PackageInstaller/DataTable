using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("移除特效(慎用)", 0)]
[Category("Render/函数")]
[Description("移除特效")]
public class RemoveEffect : CallableActionNode<int, Dictionary<int, List<GameObject>>>
{
	public override void Invoke(int buffID, Dictionary<int, List<GameObject>> buffCollection)
	{
		if (!buffCollection.TryGetValue(buffID, out var value))
		{
			Debug.Log("特效id对应的特效在字典里找不到 " + buffID);
			Debug.Log(base.parentNode.graph.name + ", " + name + ", " + base.parentNode.ID);
			return;
		}
		for (int i = 0; i < value.Count; i++)
		{
			if (value[i] == null)
			{
				Debug.LogError("buffID " + buffID + " 的 第" + i + "个特效为空, 移除失败");
			}
			else
			{
				PooledAsset.DestroyOrReturn(value[i]);
			}
		}
		value.Clear();
	}
}
