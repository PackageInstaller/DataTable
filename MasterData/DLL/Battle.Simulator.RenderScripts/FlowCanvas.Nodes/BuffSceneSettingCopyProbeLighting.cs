using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("复制场景ProbeLighting参数(渲染)", 0)]
[Category("Render/Buff/Buff特效")]
[Description("只能跟着场景走, 不能在角色和怪物机制里用;\n 从场景里带的隐藏的SceneSetting里拷贝参数到外面激活的组件里\n 会设置7个参数, 具体有哪些去参考SceneSetting组件\n 路径是相对路径, 从外面生效的SceneSetting开始\n 每次调用都会有GetComponent的消耗")]
public class BuffSceneSettingCopyProbeLighting : FlowNode
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
						battleScene.sceneSetting.probeLightingBase = component.probeLightingBase;
						battleScene.sceneSetting.probeLightingScale = component.probeLightingScale;
						battleScene.sceneSetting.sceneLightProbe = component.sceneLightProbe;
						battleScene.sceneSetting.setLightProbe = component.setLightProbe;
						battleScene.sceneSetting.skyColor = component.skyColor;
						battleScene.sceneSetting.equatorColor = component.equatorColor;
						battleScene.sceneSetting.groundColor = component.groundColor;
						output.Call(f);
					}
				}
			}
		});
	}
}
