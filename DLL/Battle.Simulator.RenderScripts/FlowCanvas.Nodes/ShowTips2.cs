using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("显示Tips2(已过时)", 0)]
[Category("Render/UI")]
[Description("显示Tips")]
public class ShowTips2 : FlowNode
{
	private GameObject uiMain;

	private Text text;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<string> pathInput = AddValueInput<string>("路径").SetDefaultAndSerializedValue("BattlePop/Text2");
		ValueInput<string> tipsContentInput = AddValueInput<string>("内容");
		AddFlowInput("", delegate(Flow f)
		{
			if (uiMain == null)
			{
				uiMain = GameObject.Find("UICamera/Canvas/UIMain");
			}
			if (!(uiMain == null))
			{
				if (text == null)
				{
					Transform transform = uiMain.transform.Find("BattlePanel");
					if (transform == null)
					{
						return;
					}
					text = transform.Find(pathInput.value).GetComponent<Text>();
				}
				if (!(text == null))
				{
					text.text = tipsContentInput.value;
					f.Call(output);
				}
			}
		});
	}
}
