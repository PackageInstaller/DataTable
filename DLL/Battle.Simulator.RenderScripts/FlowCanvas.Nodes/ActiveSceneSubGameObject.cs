using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("开关场景物件", 0)]
[Category("Render/UI")]
[Description("开关场景物件")]
public class ActiveSceneSubGameObject : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<string> pathInput = AddValueInput<string>("相对路径");
		ValueInput<bool> activeInput = AddValueInput<bool>("开关");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null && battleScene.sceneSetting != null)
			{
				Transform transform = battleScene.sceneSetting.transform.Find(pathInput.value);
				if (transform != null)
				{
					transform.gameObject.SetActive(activeInput.value);
				}
			}
			f.Call(output);
		});
	}
}
