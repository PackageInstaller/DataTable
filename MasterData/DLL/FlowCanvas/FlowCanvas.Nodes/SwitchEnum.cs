using System;
using MessagePack;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers/Switchers")]
[Description("Branch the Flow based on an enum value.\nPlease connect an Enum first for the options to show, or directly select the enum type with the relevant button bellow.")]
[ContextDefinedInputs(new Type[] { typeof(Enum) })]
public class SwitchEnum : FlowControlNode
{
	[SerializeField]
	private SerializedTypeInfo _type;

	private Type type
	{
		get
		{
			if (_type == null)
			{
				return null;
			}
			return _type.Get();
		}
		set
		{
			if (_type == null || _type.Get() != value)
			{
				_type = new SerializedTypeInfo(value);
			}
		}
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(_type._baseInfo);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		string text = reader.ReadString();
		SerializedTypeInfo serializedTypeInfo = new SerializedTypeInfo();
		serializedTypeInfo._baseInfo = text;
		serializedTypeInfo.FindType(text);
		_type = serializedTypeInfo;
	}

	protected override void RegisterPorts()
	{
		if (type == null)
		{
			type = typeof(Enum);
		}
		ValueInput selector = AddValueInput(type.Name, type, "Enum");
		if (type != typeof(Enum))
		{
			string[] names = Enum.GetNames(type);
			FlowOutput[] cases = new FlowOutput[names.Length];
			for (int i = 0; i < cases.Length; i++)
			{
				cases[i] = AddFlowOutput(names[i]);
			}
			AddFlowInput("In", delegate(Flow f)
			{
				object value = selector.value;
				int num = (int)Enum.Parse(value.GetType(), value.ToString());
				cases[num].Call(f);
			});
		}
	}

	public override Type GetNodeWildDefinitionType()
	{
		return typeof(Enum);
	}

	public override void OnPortConnected(Port port, Port otherPort)
	{
		if (type == typeof(Enum) && typeof(Enum).RTIsAssignableFrom(otherPort.type))
		{
			type = otherPort.type;
			GatherPorts();
		}
	}
}
