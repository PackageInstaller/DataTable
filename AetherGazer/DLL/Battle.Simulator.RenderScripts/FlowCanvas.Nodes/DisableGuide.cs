using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("隐藏指引", 0)]
[Category("Render/UI")]
[Description("显示新手指引定制节点")]
public class DisableGuide : FlowNode
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
				value.transform.Find("TextPanel").gameObject.SetActive(value: false);
				value.transform.Find("mask (1)").gameObject.SetActive(value: false);
				value.transform.Find("mask").gameObject.SetActive(value: false);
				value.transform.Find("buttonMask").gameObject.SetActive(value: false);
				Transform transform = value.transform.Find("动效");
				if (transform != null)
				{
					transform.gameObject.SetActive(value: false);
				}
				if (!GamepadManager.Instance.IsRuntime())
				{
					GamepadManager.Instance.SetIsRuntime(flag: true);
				}
			}
			output.Call(f);
		});
	}
}
