using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("显示挑战倍数(过时)", 0)]
[Category("Render/UI")]
[Description("显示挑战倍数")]
public class ShowChallengeFactor : FlowNode
{
	private Text text1;

	private Text text2;

	private GameObject gameObject;

	protected override void RegisterPorts()
	{
		ValueInput<int> currentNumberInput = AddValueInput<int>("已经挑战的倍数");
		ValueInput<int> maxNumberInput = AddValueInput<int>("最大倍数");
		ValueInput<string> pathInput = AddValueInput<string>("相对路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/LeftTop/challenge");
		AddValueOutput("gameObject", () => gameObject);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (gameObject == null)
			{
				Transform transform = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject.transform.Find(pathInput.value);
				gameObject = transform.gameObject;
				if (transform != null)
				{
					transform.gameObject.SetActive(value: true);
					Transform transform2 = transform.Find("text_progress");
					Transform transform3 = transform.Find("text_progress_max");
					text1 = transform2.GetComponent<Text>();
					text2 = transform3.GetComponent<Text>();
				}
			}
			if (text1 != null && text2 != null)
			{
				text1.text = currentNumberInput.value.ToString();
				text2.text = maxNumberInput.value.ToString();
			}
			output.Call(f);
		});
	}
}
