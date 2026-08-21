using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3")]
[Name("RotateY", 0)]
[Description("旋转指定向量，单位度")]
public class Int3RotateY : PureFunctionNode<Int3, Int3, int>
{
	public override Int3 Invoke(Int3 a, int b)
	{
		return a.RotateY(b);
	}
}
