using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("基于位置及朝向计算目标位置", 0)]
[Category("Logic/PosAndRot")]
[Description("基于位置和朝向计算目标位置")]
public class CalcTargetPosByFromAndDirection : PureFunctionNode<Int3, Int3, Int3, int>
{
	public override Int3 Invoke(Int3 from, Int3 direction, int distance)
	{
		return from + direction.NormalizeTo(distance);
	}
}
