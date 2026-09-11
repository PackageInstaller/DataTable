using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/String")]
[Name("Concat", 0)]
[Description("Int3 Concat")]
public class StringConcat : PureFunctionNode<string, string, string>
{
	public override string Invoke(string a, string b)
	{
		return a + b;
	}
}
