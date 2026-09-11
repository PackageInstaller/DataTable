using System;
using MessagePack;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace FlowCanvas.Nodes;

[ExposeAsDefinition]
[ContextDefinedInputs(new Type[]
{
	typeof(Wild),
	typeof(Enum)
})]
[ContextDefinedOutputs(new Type[] { typeof(Wild) })]
[Category("Flow Controllers/Selectors")]
[Description("Select a Result value out of the input cases provided, based on an Enum")]
public class SelectOnEnum<T> : FlowControlNode
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
			ValueInput<T>[] cases = new ValueInput<T>[names.Length];
			for (int i = 0; i < names.Length; i++)
			{
				cases[i] = AddValueInput<T>("Is " + names[i], names[i]);
			}
			AddValueOutput("Result", "Value", (ValueHandler<T>)delegate
			{
				object value = selector.value;
				int num = (int)Enum.Parse(value.GetType(), value.ToString());
				return cases[num].value;
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
