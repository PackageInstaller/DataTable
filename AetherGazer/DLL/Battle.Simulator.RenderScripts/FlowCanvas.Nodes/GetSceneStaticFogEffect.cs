using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取场景雾效参数(渲染)", 0)]
[Category("Render/Buff/Buff特效")]
[Description("BUFF控制雾效")]
public class GetSceneStaticFogEffect : FlowNode
{
	private SceneSetting sceneSetting;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		sceneSetting = null;
	}

	protected override void RegisterPorts()
	{
		AddValueOutput("Color", () => (sceneSetting != null) ? ((Color32)sceneSetting.fogColor) : ((Color32)Color.white));
		AddValueOutput("Color2", () => (sceneSetting != null) ? ((Color32)sceneSetting.fogColor2) : ((Color32)Color.white));
		AddValueOutput("Mode", () => (sceneSetting != null) ? sceneSetting.fogMode : FogMode.Exponential);
		AddValueOutput("Start", () => (sceneSetting != null) ? sceneSetting.fogStart : 0f);
		AddValueOutput("End", () => (sceneSetting != null) ? sceneSetting.fogEnd : 0f);
		AddValueOutput("Height", () => (sceneSetting != null) ? sceneSetting.fogHeight : 0f);
		AddValueOutput("HeightGradient", () => (sceneSetting != null) ? sceneSetting.fogHeightGradient : 0f);
		AddValueOutput("Density", () => (sceneSetting != null) ? sceneSetting.fogDensity : 0f);
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.sceneSetting == null)
			{
				errorOut.Call(f);
			}
			else
			{
				sceneSetting = battleScene.sceneSetting;
				output.Call(f);
			}
		});
	}
}
