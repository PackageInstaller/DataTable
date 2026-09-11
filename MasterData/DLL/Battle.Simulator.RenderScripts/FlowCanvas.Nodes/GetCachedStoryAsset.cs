using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取缓存资源剧情预制体(过时)", 0)]
[Category("Render/Asset")]
[Description("如题")]
public class GetCachedStoryAsset : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueInput<string>("路径");
		GameObject res = null;
		AddValueOutput("GameObject", () => res);
		AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			falseOut.Call(f);
		});
	}
}
