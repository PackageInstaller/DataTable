using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("格式化文本", 0)]
[Category("Common/Control")]
[Description("格式化文本")]
[ExposeAsDefinition]
public class FormatString<T> : CallableFunctionNode<string, string, T, T>
{
	public override string Invoke(string format, T a, T b)
	{
		return string.Format(format, a, b);
	}
}
