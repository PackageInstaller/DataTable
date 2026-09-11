using System;
using System.Linq;
using System.Reflection;
using MessagePack;
using ParadoxNotion;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace FlowCanvas.Nodes;

public class ReflectedMethodNodeWrapper : ReflectedMethodBaseNodeWrapper
{
	[SerializeField]
	private SerializedMethodInfo _method;

	protected override SerializedMethodBaseInfo serializedMethodBase => _method;

	private BaseReflectedMethodNode reflectedMethodNode { get; set; }

	private MethodInfo method
	{
		get
		{
			if (_method == null)
			{
				return null;
			}
			return _method.Get();
		}
	}

	public override string name
	{
		get
		{
			if (method != null)
			{
				ReflectionTools.MethodType specialNameType = ReflectionTools.MethodType.Normal;
				string value = method.FriendlyName(out specialNameType);
				if (specialNameType == ReflectionTools.MethodType.Operator)
				{
					ReflectionTools.op_FriendlyNamesShort.TryGetValue(method.Name, out value);
					return value;
				}
				value = value.SplitCamelCase();
				if (method.IsGenericMethod)
				{
					value += $" ({method.GetGenericArguments().First().FriendlyName()})";
				}
				if (!method.IsStatic || method.IsExtensionMethod())
				{
					return value;
				}
				return $"{method.DeclaringType.FriendlyName()}.{value}";
			}
			if (_method != null)
			{
				return $"<color=#ff6457>* Missing Function *\n{_method.GetMethodString()}</color>";
			}
			return "NOT SET";
		}
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		base.OnSerializeHandler(ref writer, options);
		_method.Serialize(ref writer, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		base.OnDeserializeHandler(ref reader, options);
		_method = new SerializedMethodInfo();
		_method.Deserialize(ref reader, options);
	}

	public override void SetMethodBase(MethodBase newMethod, object instance = null)
	{
		if (newMethod is MethodInfo)
		{
			SetMethod((MethodInfo)newMethod, instance);
		}
	}

	private void SetMethod(MethodInfo newMethod, object instance = null)
	{
		if (newMethod.IsGenericMethodDefinition)
		{
			Type firstGenericParameterConstraintType = newMethod.GetFirstGenericParameterConstraintType();
			newMethod = newMethod.MakeGenericMethod(firstGenericParameterConstraintType);
		}
		newMethod = newMethod.GetBaseDefinition();
		_method = new SerializedMethodInfo(newMethod);
		_callable = newMethod.ReturnType == typeof(void);
		GatherPorts();
		SetDropInstanceReference(newMethod, instance);
		SetDefaultParameterValues(newMethod);
	}

	public override void OnPortConnected(Port port, Port otherPort)
	{
		if (method.IsGenericMethod)
		{
			MethodInfo methodInfo = FlowNode.TryGetNewGenericMethodForWild(method.GetFirstGenericParameterConstraintType(), port.type, otherPort.type, method);
			if (methodInfo != null)
			{
				_method = new SerializedMethodInfo(methodInfo);
				GatherPorts();
			}
		}
	}

	public override Type GetNodeWildDefinitionType()
	{
		return method.GetFirstGenericParameterConstraintType();
	}

	protected override void RegisterPorts()
	{
		if (!(method == null))
		{
			ReflectedMethodRegistrationOptions options = new ReflectedMethodRegistrationOptions
			{
				callable = base.callable,
				exposeParams = base.exposeParams,
				exposedParamsCount = base.exposedParamsCount
			};
			reflectedMethodNode = BaseReflectedMethodNode.GetMethodNode(method, options);
			if (reflectedMethodNode != null)
			{
				reflectedMethodNode.RegisterPorts(this, options);
			}
		}
	}
}
