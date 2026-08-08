using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("添加特效(慎用)", 0)]
[Category("Render/函数")]
[Description("添加特效")]
public class AddEffect : CallableActionNode<int, GameObject, Dictionary<int, List<GameObject>>>
{
	public override void Invoke(int buffID, GameObject effect, Dictionary<int, List<GameObject>> buffCollection)
	{
		if (!buffCollection.ContainsKey(buffID))
		{
			buffCollection[buffID] = new List<GameObject>();
		}
		buffCollection[buffID].Add(effect);
	}
}
