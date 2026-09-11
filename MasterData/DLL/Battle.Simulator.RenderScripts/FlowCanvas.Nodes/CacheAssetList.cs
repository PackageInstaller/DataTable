using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("缓存资源（列表）", 0)]
[Category("Render/Asset")]
[Description("如题")]
public class CacheAssetList : CallableActionNode<List<string>>
{
	public override void Invoke(List<string> path)
	{
		for (int i = 0; i < path.Count; i++)
		{
			Asset.Cache(path[i]);
		}
	}
}
