using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("左侧目标-副标题", 0)]
[Category("Render/UI")]
[Description("左侧目标-副标题, 和之前的显示左侧目标不是同一个")]
public class LeftMapTargetContentSubTitle : FlowNode
{
	private MapTargetContentSubTitle com;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		com = null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> parentPathInput = AddValueInput<string>("父节点路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/LeftTop/Target/content");
		ValueInput<string> instNameInput = AddValueInput<string>("实例名").SetDefaultAndSerializedValue("SubTitle");
		ValueInput<string> prefabPathInput = AddValueInput<string>("预制体路径").SetDefaultAndSerializedValue("UI/BattleTips/Target_UI_Content_SubTitle");
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
						com = transform2.gameObject.GetComponent<MapTargetContentSubTitle>();
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
				LayoutRebuilder.ForceRebuildLayoutImmediate(com.transform.parent as RectTransform);
				LayoutRebuilder.ForceRebuildLayoutImmediate(com.transform.parent as RectTransform);
				output.Call(f);
			}
		});
		ValueInput<string> contentInput = AddValueInput<string>("标题");
		AddFlowInput("设置标题", delegate(Flow f)
		{
			if (com == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				com.SetContent(contentInput.value);
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
				LayoutRebuilder.ForceRebuildLayoutImmediate(com.transform.parent as RectTransform);
				LayoutRebuilder.ForceRebuildLayoutImmediate(com.transform.parent as RectTransform);
				output.Call(f);
			}
		});
	}
}
