using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置Transform的位置和朝向", 0)]
[Category("Render/Agent")]
[Description("获取进修正模式时的队长和镜头前的怪的transform")]
public class SetTransformPOsitionAndForward : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Transform> transInput = AddValueInput<Transform>("transform");
		Transform t = null;
		AddValueOutput("transform", () => t);
		ValueInput<Int3> posInput = AddValueInput<Int3>("位置");
		ValueInput<Int3> fwdInput = AddValueInput<Int3>("朝向");
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("False");
		AddFlowInput("", delegate(Flow f)
		{
			t = transInput.value;
			if (t == null)
			{
				falseOut.Call(f);
			}
			t.position = (Vector3)posInput.value;
			t.forward = (Vector3)fwdInput.value;
			trueOut.Call(f);
		});
	}
}
