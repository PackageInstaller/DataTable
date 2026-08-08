using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取SceneSetting", 0)]
[Category("Render/Timeline")]
[Description("获取SceneSetting")]
public class GetSceneSetting : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("", delegate
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			return (battleScene != null && battleScene.sceneSetting != null) ? battleScene.sceneSetting : Object.FindObjectOfType<SceneSetting>();
		});
	}
}
