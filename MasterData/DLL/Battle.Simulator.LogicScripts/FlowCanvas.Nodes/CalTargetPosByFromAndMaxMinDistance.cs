using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("基于位置及距离计算目标位置(最大最小)", 0)]
[Category("Logic/PosAndRot")]
[Description("基于位置及距离计算目标位置,活得连线上距离起点distance的一点,如果distance大于连线长度, 返回目标点to")]
public class CalTargetPosByFromAndMaxMinDistance : PureFunctionNode<Int3, Int3, Int3, int, int>
{
	public override Int3 Invoke(Int3 from, Int3 to, int max, int min)
	{
		Int3 @int = to - from;
		if (@int.sqrMagnitude > (float)(max * max))
		{
			return from + @int.NormalizeTo(max);
		}
		if (@int.sqrMagnitude < (float)(min * min))
		{
			return from + @int.NormalizeTo(min);
		}
		return to;
	}
}
