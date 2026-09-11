using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Floats")]
[Name("≥", 0)]
[Description("Float Greater Or Equal Than")]
public class FloatGreaterEqualThan : PureFunctionNode<bool, float, float>
{
	public override bool Invoke(float a, float b)
	{
		return a >= b;
	}
}
