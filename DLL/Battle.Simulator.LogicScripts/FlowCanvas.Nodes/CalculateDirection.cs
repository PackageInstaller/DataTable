using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("计算朝向", 0)]
[Category("Logic/Math")]
[Description("结果为 start 指向 end 的单位长度向量")]
public class CalculateDirection : PureFunctionNode<Int3, Int3, Int3>
{
	public override Int3 Invoke(Int3 start, Int3 end)
	{
		return (end - start).NormalizeTo(1000);
	}
}
