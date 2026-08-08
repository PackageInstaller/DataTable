using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("相等", 0)]
[Category("Render/Helper")]
[Description("相等")]
public class Equality : PureFunctionNode<bool, int, int>
{
	public override bool Invoke(int x, int y)
	{
		return x == y;
	}
}
