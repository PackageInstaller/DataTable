using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("隐藏Tips", 0)]
[Category("Render/UI")]
[Description("隐藏Tips")]
public class HideTips : CallableActionNode
{
	private string targetPath = "BattlePop/Tips";

	private GameObject uiMain;

	public override void Invoke()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null && battleScene.battlePanelGameObject != null)
		{
			Transform transform = battleScene.battlePanelGameObject.transform.Find(targetPath);
			if (transform != null)
			{
				transform.gameObject.SetActive(value: false);
			}
		}
	}
}
