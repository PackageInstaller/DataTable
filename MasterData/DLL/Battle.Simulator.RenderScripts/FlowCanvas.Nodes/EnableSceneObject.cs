using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("开关场景下某个物体", 0)]
[Category("Render/Scene")]
[Description("开关场景下某个天空盒，本质上是开关场景下某个物体")]
public class EnableSceneObject : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("场景下路径");
		ValueInput<bool> enableInput = AddValueInput<bool>("是否开启");
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("In", delegate(Flow f)
		{
			SceneSetting sceneSetting = (NScene.GetCurrentScene() as BattleScene).sceneSetting;
			if (sceneSetting == null)
			{
				errorOut.Call(f);
			}
			else
			{
				Transform transform = sceneSetting.transform.Find(pathInput.value);
				if (transform == null)
				{
					errorOut.Call(f);
				}
				else
				{
					transform.gameObject.SetActive(enableInput.value);
					output.Call(f);
				}
			}
		});
	}
}
