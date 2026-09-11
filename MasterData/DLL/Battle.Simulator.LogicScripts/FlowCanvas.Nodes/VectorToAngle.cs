using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("向量转角度", 0)]
[Description("向量角度, 角度在平面的映射")]
[Category("Logic/Control")]
public class VectorToAngle : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> vectorInput = AddValueInput<Int3>("向量");
		AddValueOutput("角度", () => IntMath.AngleOfVector(vectorInput.value));
	}
}
