using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[新多维额外按钮]设置充能", 0)]
[Category("Render/UI")]
[Description("设置CD")]
public class NewMatrixButtonEnergy : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> go = AddValueInput<GameObject>("按钮预制体");
		ValueInput<string> pathInput = AddValueInput<string>("相对路径");
		ValueInput<int> curInput = AddValueInput<int>("当前值");
		ValueInput<int> maxInput = AddValueInput<int>("最大值");
		FlowOutput outPut = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				GameObject gameObject = go.value;
				if (gameObject == null)
				{
					Transform transform = battleScene.battlePanelGameObject.transform.Find(pathInput.value);
					gameObject = ((transform != null) ? transform.gameObject : null);
				}
				if (gameObject == null)
				{
					errorOutput.Call(f);
				}
				else
				{
					NewMatrixExButton component = go.value.GetComponent<NewMatrixExButton>();
					if (component == null)
					{
						errorOutput.Call(f);
					}
					else
					{
						component.SetEnergyBar(curInput.value, maxInput.value);
						outPut.Call(f);
					}
				}
			}
		});
	}
}
