using System;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers/Switchers")]
[Description("Branch the Flow based on the tag of a GameObject value")]
[ContextDefinedInputs(new Type[] { typeof(GameObject) })]
[HasRefreshButton]
public class SwitchTag : FlowControlNode
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
		FlowOutput[] cases = new FlowOutput[_tagNames.Length];
		for (int i = 0; i < cases.Length; i++)
		{
			cases[i] = AddFlowOutput(_tagNames[i], i.ToString());
		}
		AddFlowInput("In", delegate(Flow f)
		{
			for (int j = 0; j < _tagNames.Length; j++)
			{
				if (_tagNames[j] == selector.value.tag)
				{
					cases[j].Call(f);
				}
			}
		});
	}
}
