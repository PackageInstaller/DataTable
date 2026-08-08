using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("中心偏移", 0)]
[Category("Logic/PosAndRot")]
[Description("IntMath.Transform;以 center 为中心,朝向 forward , 得到相对偏移 offset 后的坐标")]
public class IntMathTransform : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		ValueInput<Int3> centerVar = AddValueInput<Int3>("中心");
		ValueInput<Int3> forwardVar = AddValueInput<Int3>("朝向");
		ValueInput<Int3> offsetVar = AddValueInput<Int3>("相对偏移");
		Int3 resultCenter = centerVar.value;
		AddFlowInput("In", delegate(Flow f)
		{
			resultCenter = IntMath.Transform(offsetVar.value, forwardVar.value, centerVar.value);
			output.Call(f);
		});
		AddValueOutput("世界坐标", () => resultCenter);
	}
}
