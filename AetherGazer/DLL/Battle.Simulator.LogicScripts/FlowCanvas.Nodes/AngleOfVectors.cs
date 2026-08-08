using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("向量夹角", 0)]
[Description("向量夹角, 角度在平面的映射相减")]
[Category("Logic/Control")]
public class AngleOfVectors : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> v1Input = AddValueInput<Int3>("向量1");
		ValueInput<Int3> v2Input = AddValueInput<Int3>("向量2");
		AddValueOutput("夹角", () => IntMath.AngleOfVector(v1Input.value) - IntMath.AngleOfVector(v2Input.value));
	}
}
