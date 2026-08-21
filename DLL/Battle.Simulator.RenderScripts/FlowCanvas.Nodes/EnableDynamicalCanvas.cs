using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("显示DynamicalCanvas", 0)]
[Category("Render/UI")]
[Description("显示DynamicalCanvas")]
public class EnableDynamicalCanvas : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			GameObject gameObject = GameObject.Find("UICamera");
			if (gameObject != null)
			{
				gameObject = gameObject.transform.Find("DynamicalCanvas").gameObject;
				if (gameObject != null)
				{
					gameObject.SetActive(value: true);
				}
			}
			output.Call(f);
		});
	}
}
