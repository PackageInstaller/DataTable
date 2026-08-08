using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[新多维额外按钮]设置图标", 0)]
[Category("Render/UI")]
[Description("设置图标")]
public class NewMatrixButtonSetIcon : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> go = AddValueInput<GameObject>("按钮预制体");
		ValueInput<string> pathInput = AddValueInput<string>("相对路径");
		ValueInput<string> atlasNameInput = AddValueInput<string>("图集名");
		ValueInput<string> imageNameInput = AddValueInput<string>("图片名");
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
					NewMatrixExButton component = gameObject.GetComponent<NewMatrixExButton>();
					if (component == null)
					{
						errorOutput.Call(f);
					}
					else
					{
						component.SetIcon(atlasNameInput.value, imageNameInput.value);
						outPut.Call(f);
					}
				}
			}
		});
	}
}
