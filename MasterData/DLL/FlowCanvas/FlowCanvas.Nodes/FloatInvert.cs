using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Floats")]
[Name("Invert", 0)]
[Description("Float Invert the input ( value = value * -1 )")]
public class FloatInvert : PureFunctionNode<float, float>
{
	public override float Invoke(float value)
	{
		return value * -1f;
	}
}
