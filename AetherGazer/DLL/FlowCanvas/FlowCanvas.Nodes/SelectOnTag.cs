using System;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[ExposeAsDefinition]
[ContextDefinedInputs(new Type[]
{
	typeof(Wild),
	typeof(GameObject)
})]
[ContextDefinedOutputs(new Type[] { typeof(Wild) })]
[Category("Flow Controllers/Selectors")]
[Description("Select a Result value out of the input cases provided, based on a GameObject's Tag")]
[HasRefreshButton]
public class SelectOnTag<T> : FlowControlNode
{
	[SerializeField]
	private string[] _tagNames;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<string[]>().Serialize(ref writer, _tagNames, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_tagNames = options.Resolver.GetFormatterWithVerify<string[]>().Deserialize(ref reader, options);
	}

	protected override void RegisterPorts()
	{
		ValueInput<GameObject> selector = AddValueInput<GameObject>("Value");
		ValueInput<T>[] cases = new ValueInput<T>[_tagNames.Length];
		for (int i = 0; i < cases.Length; i++)
		{
			cases[i] = AddValueInput<T>("Is " + _tagNames[i], i.ToString());
		}
		AddValueOutput("Result", "Value", (ValueHandler<T>)delegate
		{
			string tag = selector.value.tag;
			for (int j = 0; j < _tagNames.Length; j++)
			{
				if (_tagNames[j] == tag)
				{
					return cases[j].value;
				}
			}
			return default(T);
		});
	}
}
