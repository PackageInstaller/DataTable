using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("隐藏图文引导", 0)]
[Category("Render/UI")]
[Description("图文指引, 内容不能超过5个")]
public class DisableBattleExplainUI : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goExplainUIInput = AddValueInput<GameObject>("图文引导预制体", "goExplainUI");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			GameObject value = goExplainUIInput.value;
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
