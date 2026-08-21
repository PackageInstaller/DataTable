using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("显示左侧目标背景", 0)]
[Category("Render/UI")]
[Description("显示左侧目标背景, 和之前的显示左侧目标不是同一个")]
public class ShowLeftMapTargetBg : FlowNode
{
	private MapTargetBGUI com;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		com = null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> parentPathInput = AddValueInput<string>("父节点路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/LeftTop");
		ValueInput<string> instNameInput = AddValueInput<string>("实例名").SetDefaultAndSerializedValue("Target");
		ValueInput<string> prefabPathInput = AddValueInput<string>("预制体路径").SetDefaultAndSerializedValue("UI/BattleTips/Target_UI_Bg");
		ValueInput<string> titleInput = AddValueInput<string>("标题");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("Init", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null && battleScene.battlePanelGameObject != null)
			{
				Transform transform = battleScene.battlePanelGameObject.transform.Find(parentPathInput.value);
				if (transform != null)
				{
					Transform transform2 = transform.Find(instNameInput.value);
					if (transform2 == null)
					{
						GameObject gameObject = Asset.InstantiateWithoutCache(prefabPathInput.value, transform);
						if (gameObject != null)
						{
							transform2 = gameObject.transform;
							gameObject.name = instNameInput.value;
						}
					}
					if (transform2 != null)
					{
						com = transform2.gameObject.GetComponent<MapTargetBGUI>();
					}
				}
			}
			if (com == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				com.gameObject.SetActive(value: true);
				output.Call(f);
			}
		});
		AddFlowInput("设置标题", delegate(Flow f)
		{
			if (com == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				com.SetTitle(titleInput.value);
				output.Call(f);
			}
		});
		AddFlowInput("关闭", delegate(Flow f)
		{
			if (com == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				com.gameObject.SetActive(value: false);
				output.Call(f);
			}
		});
	}
}
