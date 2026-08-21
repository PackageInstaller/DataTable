using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("隐藏所有新手指引", 0)]
[Category("Render/UI")]
[Description("显示新手指引定制节点")]
public class DisableAllGuideWindow : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> guideLeftPathInput = AddValueInput<string>("左边指引的路径").SetDefaultAndSerializedValue("BattleGuideLeftUI");
		ValueInput<string> guidePathInput = AddValueInput<string>("指引的路径").SetDefaultAndSerializedValue("GuideUI");
		ValueInput<string> guideButtonUIPathInput = AddValueInput<string>("按键指引的路径").SetDefaultAndSerializedValue("FightGuideUI");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			GameObject battlePanelGameObject = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject;
			if (battlePanelGameObject == null)
			{
				output.Call(f);
			}
			else
			{
				Transform transform = battlePanelGameObject.transform.Find(guideLeftPathInput.value);
				if (transform != null)
				{
					transform.gameObject.SetActive(value: false);
				}
				transform = battlePanelGameObject.transform.Find(guidePathInput.value);
				if (transform != null)
				{
					transform.gameObject.SetActive(value: false);
				}
				transform = battlePanelGameObject.transform.Find(guideButtonUIPathInput.value);
				if (transform != null)
				{
					transform.gameObject.SetActive(value: false);
				}
				output.Call(f);
			}
		});
	}
}
