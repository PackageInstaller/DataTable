using System;
using System.Reflection;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace FlowCanvas.Nodes;

[DoNotList]
[Icon("", false, "GetRuntimeIconType")]
public abstract class ReflectedMethodBaseNodeWrapper : FlowNode, IReflectedWrapper
{
	[SerializeField]
	protected bool _callable;

	[SerializeField]
	protected bool _exposeParams;

	[SerializeField]
	protected int _exposedParamsCount;

	protected abstract SerializedMethodBaseInfo serializedMethodBase { get; }

	private MethodBase method
	{
		get
		{
			if (serializedMethodBase == null)
			{
				return null;
			}
			return serializedMethodBase.GetBase();
		}
	}

	public bool callable
	{
		get
		{
			return _callable;
		}
		set
		{
			if (_callable != value)
			{
				_callable = value;
				GatherPorts();
			}
		}
	}

	public bool exposeParams
	{
		get
		{
			return _exposeParams;
		}
		set
		{
			if (_exposeParams != value)
			{
				_exposeParams = value;
				_exposedParamsCount = Mathf.Max(_exposedParamsCount, 1);
				GatherPorts();
			}
		}
	}

	public int exposedParamsCount
	{
		get
		{
			return _exposedParamsCount;
		}
		set
		{
			if (_exposedParamsCount != value)
			{
				_exposedParamsCount = value;
				if (_exposedParamsCount <= 0)
				{
					_exposeParams = false;
				}
				GatherPorts();
			}
		}
	}

	MemberInfo IReflectedWrapper.GetMemberInfo()
	{
		return method;
	}

	public Type GetRuntimeIconType()
	{
		if (!(method != null))
		{
			return null;
		}
		return method.DeclaringType;
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		base.OnSerializeHandler(ref writer, options);
		writer.Write(_callable);
		writer.Write(_exposeParams);
		writer.Write(_exposedParamsCount);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		base.OnDeserializeHandler(ref reader, options);
		_callable = reader.ReadBoolean();
		_exposeParams = reader.ReadBoolean();
		_exposedParamsCount = reader.ReadInt32();
	}

	public abstract void SetMethodBase(MethodBase newMethod, object instance = null);

	public void SetDefaultParameterValues(MethodBase newMethod)
	{
		ParameterInfo[] parameters = newMethod.GetParameters();
		for (int i = 0; i < parameters.Length; i++)
		{
			ParameterInfo parameterInfo = parameters[i];
			if (parameterInfo.IsOptional && parameterInfo.DefaultValue != null)
			{
				string iD = parameters[i].Name;
				if (GetInputPort(iD) is ValueInput valueInput)
				{
					valueInput.serializedValue = parameterInfo.DefaultValue;
				}
			}
		}
	}

	public void SetDropInstanceReference(MethodBase newMethod, object instance = null)
	{
		if (instance != null && !newMethod.IsStatic)
		{
			ValueInput valueInput = (ValueInput)GetFirstInputOfType(instance.GetType());
			if (valueInput != null)
			{
				valueInput.serializedValue = instance;
			}
		}
	}
}
