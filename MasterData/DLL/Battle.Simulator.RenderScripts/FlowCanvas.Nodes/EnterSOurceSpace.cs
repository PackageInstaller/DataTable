using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("进入修正模式场景(渲染)", 0)]
[Category("Render/Effect")]
[Description("")]
public class EnterSOurceSpace : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Vector3> positionInput = AddValueInput<Vector3>("生成坐标", "EnterSourceSpaceEffectWithPosition_positionVar").SetDefaultAndSerializedValue(Vector3.zero);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				error.Call(f);
			}
			else if (battleScene.sceneSetting == null)
			{
				error.Call(f);
			}
			else
			{
				battleScene.InnerSceneSettingOnSourceSpaceAsset.splitSetting.progress = 1f;
				battleScene.sceneSetting.gameObject.SetActive(value: true);
				battleScene.InnerSceneSettingOnSourceSpaceAsset.gameObject.SetActive(value: true);
				battleScene.InnerSceneSettingOnSourceSpaceAsset.gameObject.transform.position = positionInput.GetValue();
				battleScene.sceneSetting.gameObject.SetActive(value: false);
				output.Call(f);
			}
		});
	}
}
