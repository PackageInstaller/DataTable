using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("复制场景雾效参数(渲染)", 0)]
[Category("Render/Buff/Buff特效")]
[Description("BUFF控制雾效, 只能跟着场景走, 不能在角色和怪物机制里用;\n 从场景里带的隐藏的SceneSetting里拷贝参数到外面激活的组件里\n 会设置八个参数, 具体有哪些去参考 <修改场景雾效参数> 节点\n 路径是相对路径, 从外面生效的SceneSetting开始\n 每次调用都会有GetComponent的消耗")]
public class CopySceneStaticFogEffect : FlowNode
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
						battleScene.sceneSetting.fogColor = component.fogColor;
						battleScene.sceneSetting.fogColor2 = component.fogColor2;
						battleScene.sceneSetting.fogMode = component.fogMode;
						battleScene.sceneSetting.fogStart = component.fogStart;
						battleScene.sceneSetting.fogEnd = component.fogEnd;
						battleScene.sceneSetting.fogHeight = component.fogHeight;
						battleScene.sceneSetting.fogHeightGradient = component.fogHeightGradient;
						battleScene.sceneSetting.fogDensity = component.fogDensity;
						output.Call(f);
					}
				}
			}
		});
	}
}
