using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("在战斗界面下实例化UI预制体", 0)]
[Category("Render/UI")]
[Description("实例化UI预制体")]
public class InstanceUIPrefabInBattlepanel : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> prefabPathInput = AddValueInput<string>("预制体路径");
		ValueInput<string> parentPathInput = AddValueInput<string>("父节点路径");
		ValueInput<string> instNameInput = AddValueInput<string>("实例名");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		GameObject go = null;
		AddValueOutput("实例", () => go);
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null && battleScene.battlePanelGameObject != null)
			{
				Transform transform = battleScene.battlePanelGameObject.transform;
				GameObject gameObject = Asset.InstantiateWithoutCache(prefabPathInput.value, transform.Find(parentPathInput.value));
				if (gameObject != null)
				{
					gameObject.name = instNameInput.value;
					go = gameObject;
					output.Call(f);
				}
				else
				{
					errorOut.Call(f);
				}
			}
			else
			{
				errorOut.Call(f);
			}
		});
	}
}
