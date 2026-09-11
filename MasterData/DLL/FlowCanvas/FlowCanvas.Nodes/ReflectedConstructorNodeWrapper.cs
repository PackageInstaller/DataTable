using System.Reflection;
using MessagePack;
using MessagePack.Formatters;
using ParadoxNotion;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace FlowCanvas.Nodes;

public class ReflectedConstructorNodeWrapper : ReflectedMethodBaseNodeWrapper
{
	[SerializeField]
	private SerializedConstructorInfo _constructor;

	protected override SerializedMethodBaseInfo serializedMethodBase => _constructor;

	private BaseReflectedConstructorNode reflectedConstructorNode { get; set; }

	private ConstructorInfo constructor
	{
		get
		{
			if (_constructor == null)
			{
				return null;
			}
			return _constructor.Get();
		}
	}

	public override string name
	{
		get
		{
			if (constructor != null)
			{
				return $"New {constructor.DeclaringType.FriendlyName()} ()";
			}
			if (_constructor != null)
			{
				return $"<color=#ff6457>* Missing Function *\n{_constructor.GetMethodString()}</color>";
			}
			return "NOT SET";
		}
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		base.OnSerializeHandler(ref writer, options);
		options.Resolver.GetFormatterWithVerify<SerializedConstructorInfo>().Serialize(ref writer, _constructor, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		base.OnDeserializeHandler(ref reader, options);
		IMessagePackFormatter<SerializedConstructorInfo> formatterWithVerify = options.Resolver.GetFormatterWithVerify<SerializedConstructorInfo>();
		_constructor = formatterWithVerify.Deserialize(ref reader, options);
	}

	public override void SetMethodBase(MethodBase newMethod, object instance = null)
	{
		if (newMethod is ConstructorInfo)
		{
			SetConstructor((ConstructorInfo)newMethod);
		}
	}

	private void SetConstructor(ConstructorInfo newConstructor)
	{
		_constructor = new SerializedConstructorInfo(newConstructor);
		GatherPorts();
		SetDefaultParameterValues(newConstructor);
	}

	protected override void RegisterPorts()
	{
		if (!(constructor == null))
		{
			ReflectedMethodRegistrationOptions options = new ReflectedMethodRegistrationOptions
			{
				callable = base.callable,
				exposeParams = base.exposeParams,
				exposedParamsCount = base.exposedParamsCount
			};
			reflectedConstructorNode = BaseReflectedConstructorNode.GetConstructorNode(constructor, options);
			if (reflectedConstructorNode != null)
			{
				reflectedConstructorNode.RegisterPorts(this, options);
			}
		}
	}
}
