using System.Collections.Generic;
using Config;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("移除多个指定buff类型", 0)]
[Category("Logic/Buff")]
[Description("移除多个指定buff")]
public class RemoveTargetBuffs : FlowNode
{
	[SerializeField]
	[ExposeField]
	[DelayedField]
	private List<BuffClass> list = new List<BuffClass>();

	[GatherPortsCallback]
	public bool refreshPorts;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		list = options.Resolver.GetFormatter<List<BuffClass>>().Deserialize(ref reader, options);
		refreshPorts = reader.ReadBoolean();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatter<List<BuffClass>>().Serialize(ref writer, list, options);
		writer.Write(refreshPorts);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = entityIDInput.value;
			for (int i = 0; i < list.Count; i++)
			{
				BuffProcessor.RemoveBuffClass(value, value, (int)list[i]);
			}
			output.Call(f);
		});
	}
}
