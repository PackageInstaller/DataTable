using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("设置地图目标血条(过时)", 0)]
[Category("Render/UI")]
[Description("设置地图目标血条, 有数字转字符串")]
public class SetMapGoalHP : FlowNode
{
	private Text currentProgressText;

	private Text maxProgressText;

	protected override void RegisterPorts()
	{
		ValueInput<bool> showHPInput = AddValueInput<bool>("是否显示血量");
		ValueInput<int> agentIDInput = AddValueInput<int>("agentID");
		ValueInput<string> pathInput = AddValueInput<string>("血条相对路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/LeftTop/goal");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (showHPInput.value)
			{
				NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
				if (agent != null)
				{
					long hP = (agent.Blackboard as BBHumanoid).HP;
					long maxHP = (agent.Blackboard as BBHumanoid).MaxHP;
					if (currentProgressText == null || maxProgressText == null)
					{
						Transform transform = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject.transform.Find(pathInput.value);
						if (transform != null)
						{
							Transform transform2 = transform.Find("text_progress");
							Transform transform3 = transform.Find("text_progress_max");
							Transform transform4 = transform.Find("text_progress_split");
							transform2.gameObject.SetActive(value: true);
							transform3.gameObject.SetActive(value: true);
							transform4.gameObject.SetActive(value: true);
							currentProgressText = transform2.GetComponent<Text>();
							maxProgressText = transform3.GetComponent<Text>();
						}
					}
					if (currentProgressText != null || maxProgressText != null)
					{
						currentProgressText.text = hP.ToString();
						maxProgressText.text = maxHP.ToString();
					}
				}
			}
			output.Call(f);
		});
	}
}
