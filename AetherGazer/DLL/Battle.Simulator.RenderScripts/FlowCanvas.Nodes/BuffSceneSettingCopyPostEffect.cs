using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("复制场景PostEffect参数(渲染)", 0)]
[Category("Render/Buff/Buff特效")]
[Description("只能跟着场景走, 不能在角色和怪物机制里用;\n 从场景里带的隐藏的SceneSetting里拷贝参数到外面激活的组件里\n 只会设置前4个参数, tonemapping, exposure, contrast, threshold\n 路径是相对路径, 从外面生效的SceneSetting开始\n 每次调用都会有GetComponent的消耗")]
public class BuffSceneSettingCopyPostEffect : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		ValueInput<string> targetPathInput = AddValueInput<string>("路径");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.sceneSetting == null)
			{
				errorOut.Call(f);
			}
			else
			{
				Transform transform = battleScene.sceneSetting.transform.Find(targetPathInput.value);
				if (transform == null)
				{
					errorOut.Call(f);
				}
				else
				{
					SceneSetting component = transform.GetComponent<SceneSetting>();
					if (component == null)
					{
						errorOut.Call(f);
					}
					else
					{
						battleScene.sceneSetting.tonemapping = component.tonemapping;
						battleScene.sceneSetting.exposure = component.exposure;
						battleScene.sceneSetting.contrast = component.contrast;
						battleScene.sceneSetting.threshold = component.threshold;
						output.Call(f);
					}
				}
			}
		});
	}
}
