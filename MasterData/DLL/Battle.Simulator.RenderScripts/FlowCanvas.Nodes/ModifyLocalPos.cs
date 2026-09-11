using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("修改localPosition", 0)]
[Category("Render/UI")]
[Description("修改localPosition")]
public class ModifyLocalPos : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Transform> transInput = AddValueInput<Transform>("transform");
		ValueInput<Vector3> posInput = AddValueInput<Vector3>("位置");
		ValueInput<Vector3> scaleInput = AddValueInput<Vector3>("缩放");
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("False");
		AddFlowInput("", delegate(Flow f)
		{
			Transform value = transInput.value;
			if (value == null)
			{
				falseOut.Call(f);
			}
			else
			{
				value.localPosition = posInput.value;
				value.localScale = scaleInput.value;
				trueOut.Call(f);
			}
		});
	}
}
