using System;
using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers/Switchers")]
[Description("Branch the Flow based on a string value. The Default output is called if there is no other matching output same as the input value")]
[ContextDefinedInputs(new Type[] { typeof(string) })]
[HasRefreshButton]
public class SwitchString : FlowControlNode
{
	[Name("Cases", 0)]
	public List<string> comparisonOutputs = new List<string>();

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<List<string>>().Serialize(ref writer, comparisonOutputs, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		comparisonOutputs = options.Resolver.GetFormatterWithVerify<List<string>>().Deserialize(ref reader, options);
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> selector = AddValueInput<string>("Value");
		FlowOutput[] cases = new FlowOutput[comparisonOutputs.Count];
		for (int i = 0; i < cases.Length; i++)
		{
			cases[i] = AddFlowOutput($"\"{comparisonOutputs[i]}\"", i.ToString());
		}
		FlowOutput defaultCase = AddFlowOutput("Default");
		AddFlowInput("In", delegate(Flow f)
		{
			string value = selector.value;
			bool flag = false;
			if (value != null)
			{
				for (int j = 0; j < comparisonOutputs.Count; j++)
				{
					if (value.Equals(comparisonOutputs[j], StringComparison.OrdinalIgnoreCase))
					{
						flag = true;
						cases[j].Call(f);
					}
				}
			}
			if (!flag)
			{
				defaultCase.Call(f);
			}
		});
	}
}
