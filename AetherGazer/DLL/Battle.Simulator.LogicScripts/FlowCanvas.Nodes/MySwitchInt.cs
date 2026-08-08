using System;
using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Switch Integer", 0)]
[Category("Common/Control")]
[Description("需要手动添加element")]
[ContextDefinedInputs(new Type[] { typeof(int) })]
public class MySwitchInt : FlowControlNode
{
	[SerializeField]
	[ExposeField]
	[GatherPortsCallback]
	[MinValue(2)]
	[DelayedField]
	private int _portCount = 4;

	[SerializeField]
	[ExposeField]
	[DelayedField]
	private List<int> list = new List<int>();

	[GatherPortsCallback]
	public bool refreshPorts;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		refreshPorts = reader.ReadBoolean();
		_portCount = reader.ReadInt32();
		list = options.Resolver.GetFormatter<List<int>>().Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(refreshPorts);
		writer.Write(_portCount);
		options.Resolver.GetFormatter<List<int>>().Serialize(ref writer, list, options);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> selector = AddValueInput<int>("Value", "Index");
		FlowOutput[] cases = new FlowOutput[_portCount];
		if (list.Count == _portCount)
		{
			for (int i = 0; i < cases.Length; i++)
			{
				try
				{
					cases[i] = AddFlowOutput(list[i].ToString());
				}
				catch (Exception)
				{
					cases[i] = AddFlowOutput(i.ToString());
				}
			}
		}
		FlowOutput defaultCase = AddFlowOutput("Default");
		AddFlowInput("In", delegate(Flow f)
		{
			int value = selector.value;
			for (int j = 0; j < list.Count; j++)
			{
				if (list[j] == value)
				{
					f.Call(cases[j]);
					return;
				}
			}
			f.Call(defaultCase);
		});
	}
}
