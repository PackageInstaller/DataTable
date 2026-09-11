using System;
using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[ExposeAsDefinition]
[ContextDefinedInputs(new Type[]
{
	typeof(Wild),
	typeof(string)
})]
[ContextDefinedOutputs(new Type[] { typeof(Wild) })]
[Category("Flow Controllers/Selectors")]
[Description("Select a Result value out of the input cases provided, based on a String")]
[HasRefreshButton]
public class SelectOnString<T> : FlowControlNode
{
	[Name("Cases", 0)]
	public List<string> stringCases = new List<string>();

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<List<string>>().Serialize(ref writer, stringCases, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		stringCases = options.Resolver.GetFormatterWithVerify<List<string>>().Deserialize(ref reader, options);
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> selector = AddValueInput<string>("Value");
		ValueInput<T>[] cases = new ValueInput<T>[stringCases.Count];
		for (int i = 0; i < stringCases.Count; i++)
		{
			cases[i] = AddValueInput<T>($"Is \"{stringCases[i].ToString()}\"", i.ToString());
		}
		ValueInput<T> defaultCase = AddValueInput<T>("Default");
		AddValueOutput("Result", "Value", (ValueHandler<T>)delegate
		{
			string value = selector.value;
			if (value != null)
			{
				for (int j = 0; j < cases.Length; j++)
				{
					if (value.Equals(stringCases[j], StringComparison.OrdinalIgnoreCase))
					{
						return cases[j].value;
					}
				}
			}
			return defaultCase.value;
		});
	}
}
