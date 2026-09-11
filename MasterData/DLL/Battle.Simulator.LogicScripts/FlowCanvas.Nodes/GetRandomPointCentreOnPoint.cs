using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获得指定位置随机点", 0)]
[Category("Logic/Random")]
[Description("在指定点一定范围内随机点位置")]
[ExposeAsDefinition]
public class GetRandomPointCentreOnPoint : PureFunctionNode<Int3, Int3, Int3>
{
	public override Int3 Invoke(Int3 position, Int3 size)
	{
		return position + new Int3((int)DRandom.Random((uint)size.x) - size.x / 2, 0, (int)DRandom.Random((uint)size.z) - size.z / 2);
	}
}
