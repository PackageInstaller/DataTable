using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Floats")]
[Name("≤", 0)]
[Description("Float Less Or Equal Than")]
public class FloatLessEqualThan : PureFunctionNode<bool, float, float>
{
	public override bool Invoke(float a, float b)
	{
		return a <= b;
	}
}
