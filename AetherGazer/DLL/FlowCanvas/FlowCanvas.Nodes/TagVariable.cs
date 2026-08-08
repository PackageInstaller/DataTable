using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[DoNotList]
[Name("Tag", 0)]
[Description("An easy way to get a Tag name")]
public class TagVariable : VariableNode
{
	[TagField]
	public BBParameter<string> tagName = new BBParameter<string>("Untagged");

	public override string name => tagName.value;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<BBParameter<string>>().Serialize(ref writer, tagName, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		tagName = options.Resolver.GetFormatterWithVerify<BBParameter<string>>().Deserialize(ref reader, options);
	}

	protected override void RegisterPorts()
	{
		AddValueOutput("Tag", () => tagName.value);
	}

	public override void SetVariable(object o)
	{
		if (o is string)
		{
			tagName.value = (string)o;
		}
	}
}
