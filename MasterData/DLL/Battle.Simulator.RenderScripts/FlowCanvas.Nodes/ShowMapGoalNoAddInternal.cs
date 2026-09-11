using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("显示自己记的关卡目标(过时)", 0)]
[Category("Render/UI")]
[Description("显示关卡目标, 如果要显示进度, 需要输入当前进度和总进度, 会有int转string")]
public class ShowMapGoalNoAddInternal : FlowNode
{
	private Text goalText;

	private Text currentProgressText;

	private Text maxProgressText;

	protected override void RegisterPorts()
	{
		ValueInput<string> goalInput = AddValueInput<string>("目标");
		ValueInput<bool> showProgressInput = AddValueInput<bool>("显示进度");
		ValueInput<int> curProgressInput = AddValueInput<int>("当前进度");
		ValueInput<int> maxProgressInput = AddValueInput<int>("总进度");
		ValueInput<string> pathInput = AddValueInput<string>("ui相对路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/LeftTop/goal");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			bool value = showProgressInput.value;
			if (goalText == null)
			{
				Transform transform = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject.transform.Find(pathInput.value);
				if (transform != null)
				{
					Transform transform2 = transform.Find("text_goal");
					goalText = transform2.GetComponent<Text>();
					transform.gameObject.SetActive(value: true);
					if (value)
					{
						Transform transform3 = transform.Find("text_progress");
						Transform transform4 = transform.Find("text_progress_max");
						Transform transform5 = transform.Find("text_progress_split");
						transform3.gameObject.SetActive(value: true);
						transform4.gameObject.SetActive(value: true);
						transform5.gameObject.SetActive(value: true);
						currentProgressText = transform3.GetComponent<Text>();
						maxProgressText = transform4.GetComponent<Text>();
					}
				}
				if (goalText == null || (value && (currentProgressText == null || maxProgressText == null)))
				{
					return;
				}
			}
			int num = curProgressInput.value;
			int value2 = maxProgressInput.value;
			if (num > value2)
			{
				num = value2;
			}
			goalText.text = goalInput.value;
			if (value)
			{
				currentProgressText.text = num.ToString();
				maxProgressText.text = value2.ToString();
			}
			output.Call(f);
		});
	}
}
