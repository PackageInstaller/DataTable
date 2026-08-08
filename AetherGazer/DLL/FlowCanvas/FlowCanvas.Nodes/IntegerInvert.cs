using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Integers")]
[Name("Invert", 0)]
[Description("Integer Invert the input ( value = value * -1 )")]
public class IntegerInvert : PureFunctionNode<int, int>
{
	public override int Invoke(int value)
	{
		return value * -1;
	}
}
