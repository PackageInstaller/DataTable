using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("收展左边的指引", 0)]
[Category("Render/UI")]
[Description("收展左边的指引，效果等同于按下按钮")]
public class PutAwayLeftGuideTips : FlowNode
{
	private BattleGuide battleGuideComponent;

	public string path = "UI/BattleGuideLeftUI";

	public string uiGoName = "BattleGuideLeftUI";

	private GameObject goGuide;

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
		FlowOutput output = AddFlowOutput("True", "true");
		AddFlowInput("In", "in", delegate(Flow f)
		{
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
					battleGuideComponent.ChangeHideState();
				}
				output.Call(f);
			}
		});
	}
}
