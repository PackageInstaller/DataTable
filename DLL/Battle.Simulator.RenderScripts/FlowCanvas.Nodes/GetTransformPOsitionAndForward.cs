using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取Transform的位置和朝向", 0)]
[Category("Render/Agent")]
[Description("获取进修正模式时的队长和镜头前的怪的transform")]
public class GetTransformPOsitionAndForward : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Transform> transInput = AddValueInput<Transform>("transform");
		Int3 position = Int3.zero;
		Int3 forward = Int3.zero;
		Transform t = null;
		AddValueOutput("transform", () => t);
		AddValueOutput("位置", () => position);
		AddValueOutput("朝向", () => forward);
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("False");
		AddFlowInput("", delegate(Flow f)
		{
			t = transInput.value;
			if (t == null)
			{
				falseOut.Call(f);
			}
			position = (Int3)t.position;
			forward = (Int3)t.forward;
			trueOut.Call(f);
		});
	}
}
