using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Floats")]
[Name("≠", 0)]
[Description("Float Not Equal To")]
public class FloatNotEqual : PureFunctionNode<bool, float, float>
{
	public override bool Invoke(float a, float b)
	{
		return a != b;
	}
}
