using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("显示左边的指引", 0)]
[Category("Render/UI")]
[Description("显示左边的指引, 定制节点, 内容不能超过5个")]
public class ShowBattleLeftGuide : FlowNode
{
	private BattleGuide battleGuideComponent;

	public string path = "UI/BattleGuideLeftUI";

	public string uiGoName = "BattleGuideLeftUI";

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
		ValueInput<List<string>> contentInput = AddValueInput<List<string>>("内容");
		ValueInput<List<string>> titlesInput = AddValueInput<List<string>>("标题(要用多个标题时使用)");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			goGuide = goGuideInput.value;
			if (goGuide == null)
			{
				GameObject battlePanelGameObject = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject;
				Transform transform = battlePanelGameObject.transform.Find(uiGoName);
				if (transform == null)
				{
					goGuide = Asset.InstantiateWithoutCache(path, battlePanelGameObject.transform);
					goGuide.name = uiGoName;
				}
				else
				{
					goGuide = transform.gameObject;
				}
			}
			if (goGuide != null)
			{
				if (battleGuideComponent == null)
				{
					battleGuideComponent = goGuide.transform.Find("bg").GetComponent<BattleGuide>();
				}
				goGuide.SetActive(value: true);
				for (int i = 0; i < goGuide.transform.childCount; i++)
				{
					goGuide.transform.GetChild(i).gameObject.SetActive(value: true);
				}
				if (battleGuideComponent != null)
				{
					battleGuideComponent.SetContent(contentInput.value, titleInput.value, titlesInput.value);
				}
				output.Call(f);
			}
		});
	}
}
