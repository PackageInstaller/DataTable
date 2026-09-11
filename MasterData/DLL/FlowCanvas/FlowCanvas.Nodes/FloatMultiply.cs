using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Floats")]
[Name("×", 0)]
[Description("Float Mutliply")]
public class FloatMultiply : PureFunctionNode<float, float, float>
{
	public override float Invoke(float a, float b)
	{
		return a * b;
	}
}
