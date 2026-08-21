using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("修改场景雾效参数(渲染)", 0)]
[Category("Render/Buff/Buff特效")]
[Description("BUFF控制雾效, 自能跟着场景走, 不能在角色和怪物机制里用")]
public class ChangeSceneStaticFogEffect : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Color32> colorInput = AddValueInput<Color32>("Color");
		ValueInput<Color32> color2Input = AddValueInput<Color32>("Color2");
		ValueInput<FogMode> fogModeInput = AddValueInput<FogMode>("Mode");
		ValueInput<float> startInput = AddValueInput<float>("Start");
		ValueInput<float> endInput = AddValueInput<float>("End");
		ValueInput<float> heightInput = AddValueInput<float>("Height");
		ValueInput<float> heightGradientInput = AddValueInput<float>("HeightGradient");
		ValueInput<float> densityInput = AddValueInput<float>("Density");
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
				battleScene.sceneSetting.fogColor = colorInput.value;
				battleScene.sceneSetting.fogColor2 = color2Input.value;
				battleScene.sceneSetting.fogMode = fogModeInput.value;
				battleScene.sceneSetting.fogStart = startInput.value;
				battleScene.sceneSetting.fogEnd = endInput.value;
				battleScene.sceneSetting.fogHeight = heightInput.value;
				battleScene.sceneSetting.fogHeightGradient = heightGradientInput.value;
				battleScene.sceneSetting.fogDensity = densityInput.value;
				output.Call(f);
			}
		});
	}
}
