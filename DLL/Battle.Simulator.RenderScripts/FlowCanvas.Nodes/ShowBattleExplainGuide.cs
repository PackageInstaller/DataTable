using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("显示图文引导", 0)]
[Category("Render/UI")]
[Description("显示图文指引, 内容不能超过5个，路径输入统一取AB之后的部分")]
public class ShowBattleExplainGuide : FlowNode
{
	private BattleExplainUI battleExplainUIComponent;

	public string path = "Widget/System/BattleExplain/BattleExplainUI";

	public string uiGoName = "BattleExplainUI";

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(path);
		writer.Write(uiGoName);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		path = reader.ReadString();
		uiGoName = reader.ReadString();
	}

	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goGuideInput = AddValueInput<GameObject>("指引预制体");
		GameObject goGuide = null;
		AddValueOutput("预制体", () => goGuide);
		ValueInput<string> titleInput = AddValueInput<string>("标题");
		ValueInput<Color> titleColorInput = AddValueInput<Color>("标题字体颜色", "titleColor").SetDefaultAndSerializedValue(Color.white);
		ValueInput<List<string>> imagesInput = AddValueInput<List<string>>("图片");
		ValueInput<List<string>> contentInput = AddValueInput<List<string>>("内容");
		ValueInput<Color> contentColorInput = AddValueInput<Color>("内容字体颜色", "contentColor").SetDefaultAndSerializedValue(Color.white);
		ValueInput<List<string>> titlesInput = AddValueInput<List<string>>("标题(要用多个标题时使用)");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			goGuide = goGuideInput.value;
			if (goGuide == null)
			{
				GameObject battlePanelGameObject = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject;
				if (battlePanelGameObject.transform.Find(uiGoName) == null)
				{
					goGuide = Asset.InstantiateWithoutCache(path, battlePanelGameObject.transform);
					goGuide.name = uiGoName;
				}
			}
			if (goGuide != null)
			{
				if (battleExplainUIComponent == null)
				{
					battleExplainUIComponent = goGuide.transform.Find("CompopUI08").GetComponent<BattleExplainUI>();
				}
				goGuide.SetActive(value: true);
				for (int i = 0; i < goGuide.transform.childCount; i++)
				{
					goGuide.transform.GetChild(i).gameObject.SetActive(value: true);
				}
				if (battleExplainUIComponent != null)
				{
					battleExplainUIComponent.SetContent(contentInput.value, titleInput.value, titlesInput.value, imagesInput.value, titleColorInput.value, contentColorInput.value);
				}
				output.Call(f);
			}
		});
	}
}
