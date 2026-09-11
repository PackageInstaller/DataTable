using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("隐藏DynamicalCanvas", 0)]
[Category("Render/UI")]
[Description("隐藏DynamicalCanvas")]
public class DisableDynamicalCanvas : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			GameObject gameObject = GameObject.Find("UICamera/DynamicalCanvas");
			if (gameObject != null)
			{
				gameObject.SetActive(value: false);
			}
			output.Call(f);
		});
	}
}
