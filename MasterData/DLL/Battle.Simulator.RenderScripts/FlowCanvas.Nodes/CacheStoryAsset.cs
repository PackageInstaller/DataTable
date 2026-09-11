using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("缓存资源剧情预制体", 0)]
[Category("Render/Asset")]
[Description("如题")]
public class CacheStoryAsset : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("路径");
		GameObject res = null;
		AddValueOutput("GameObject", () => res);
		FlowOutput trueOut = AddFlowOutput("true");
		AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			Asset.Cache(pathInput.GetValue());
			f.Call(trueOut);
		});
	}
}
