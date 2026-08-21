using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("隐藏左边的指引", 0)]
[Category("Render/UI")]
[Description("左边的指引, 定制节点, 内容不能超过5个")]
public class DisableBattleLeftGuide : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goGuideInput = AddValueInput<GameObject>("指引预制体");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			GameObject value = goGuideInput.value;
			if (value != null)
			{
				for (int i = 0; i < value.transform.childCount; i++)
				{
					value.transform.GetChild(i).gameObject.SetActive(value: false);
				}
			}
			output.Call(f);
		});
	}
}
