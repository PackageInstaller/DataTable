using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("复制SceneSettingFogConfig(渲染)", 0)]
[Category("Render/Buff/Buff特效")]
[Description("只能跟着场景走, 不能在角色和怪物机制里用;\n 从场景里带的隐藏的SceneSettingFogConfig里拷贝参数到外面激活的组件里\n 会设置3个参数, 具体有哪些去参考SceneSettingFogConfig组件\n 路径是相对路径, 从外面生效的SceneSettingFogConfig开始\n 每次调用都会有GetComponent的消耗")]
public class BuffCopySceneSettingFogConfig : FlowNode
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
					SceneSettingFogConfig component = transform.GetComponent<SceneSettingFogConfig>();
					if (component == null)
					{
						errorOut.Call(f);
					}
					else
					{
						SceneSettingFogConfig component2 = battleScene.sceneSetting.GetComponent<SceneSettingFogConfig>();
						if (component2 == null)
						{
							errorOut.Call(f);
						}
						else
						{
							component2.EnterTime = component.EnterTime;
							component2.ExitTime = component.ExitTime;
							component2.ColorOfUltimateAvoid = component.ColorOfUltimateAvoid;
							component2.ColorOfSourceSpace = component.ColorOfSourceSpace;
							component2.TintColorOfUltimateAvoid = component.TintColorOfUltimateAvoid;
							component2.TintColorOfSourceSpace = component.TintColorOfSourceSpace;
							output.Call(f);
						}
					}
				}
			}
		});
	}
}
