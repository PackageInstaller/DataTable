using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("退出修正模式效果(渲染)", 0)]
[Category("Render/Effect")]
[Description("退出修正模式时候,控制修正模式环境效果的关闭")]
[ExposeAsDefinition]
public class ExitSourceSpaceEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out", "ExitSourceSpaceEffect_Out_Out");
		AddFlowInput("In", "ExitSourceSpaceEffect_In_In", delegate(Flow f)
		{
			BattleScene obj = NScene.GetCurrentScene() as BattleScene;
			obj.InnerSceneSettingOnSourceSpaceAsset.splitSetting.progress = 0f;
			obj.InnerSceneSettingOnSourceSpaceAsset.gameObject.SetActive(value: false);
			obj.sceneSetting.gameObject.SetActive(value: true);
			output.Call(f);
		});
	}
}
