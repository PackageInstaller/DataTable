using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("隐藏Tips2(已过时)", 0)]
[Category("Render/UI")]
[Description("隐藏Tips")]
public class HideTups : FlowNode
{
	private GameObject uiMain;

	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("路径").SetDefaultAndSerializedValue("BattlePop/Text2");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (uiMain == null)
			{
				uiMain = GameObject.Find("UICamera/Canvas/UIMain");
			}
			if (!(uiMain == null))
			{
				Transform transform = uiMain.transform.Find("BattlePanel");
				if (!(transform == null))
				{
					transform.Find(pathInput.value).GetComponent<Text>().text = "";
					f.Call(output);
				}
			}
		});
	}
}
