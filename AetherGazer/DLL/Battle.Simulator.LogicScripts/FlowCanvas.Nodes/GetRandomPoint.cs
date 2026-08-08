using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获得随机点", 0)]
[Category("Logic/Random")]
[Description("随机点位置")]
[ExposeAsDefinition]
public class GetRandomPoint : PureFunctionNode<Int3, uint>
{
	public override Int3 Invoke(uint range)
	{
		return CommonProcessor.GetRandomPoint(range);
	}
}
