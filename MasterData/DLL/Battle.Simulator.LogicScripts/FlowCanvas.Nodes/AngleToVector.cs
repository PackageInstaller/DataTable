using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("角度转向量", 0)]
[Description("向量角度, 角度在平面的映射")]
[Category("Logic/Control")]
public class AngleToVector : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int> angleInput = AddValueInput<Int>("角度");
		AddValueOutput("向量", () => IntMath.VectorOfAngle(angleInput.value));
	}
}
