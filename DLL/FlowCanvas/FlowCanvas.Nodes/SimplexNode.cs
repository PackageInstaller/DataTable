using System;
using System.Reflection;
using MessagePack;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[SpoofAOT]
public abstract class SimplexNode
{
	[NonSerialized]
	private string _name;

	[NonSerialized]
	private string _description;

	private ParameterInfo[] _parameters;

	protected FlowNode parentNode { get; private set; }

	public virtual string name
	{
		get
		{
			if (string.IsNullOrEmpty(_name))
			{
				NameAttribute nameAttribute = GetType().RTGetAttribute<NameAttribute>(inherited: false);
				_name = ((nameAttribute != null) ? nameAttribute.name : GetType().FriendlyName().SplitCamelCase());
			}
			return _name;
		}
	}

	public virtual string description
	{
		get
		{
			if (string.IsNullOrEmpty(_description))
			{
				DescriptionAttribute descriptionAttribute = GetType().RTGetAttribute<DescriptionAttribute>(inherited: false);
				_description = ((descriptionAttribute != null) ? descriptionAttribute.description : "No Description");
			}
			return _description;
		}
	}

	public ParameterInfo[] parameters
	{
		get
		{
			if (_parameters != null)
			{
				return _parameters;
			}
			MethodInfo method = GetType().GetMethod("Invoke", BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public);
			return _parameters = ((method != null) ? method.GetParameters() : new ParameterInfo[0]);
		}
	}

	public void RegisterPorts(FlowNode node)
	{
		parentNode = node;
		OnRegisterPorts(node);
		PropertyInfo[] properties = GetType().GetProperties(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public);
		foreach (PropertyInfo propertyInfo in properties)
		{
			if (propertyInfo.CanRead && !propertyInfo.GetGetMethod().IsVirtual)
			{
				node.TryAddPropertyValueOutput(propertyInfo, this);
			}
		}
		OnRegisterExtraPorts(node);
	}

	public void SetDefaultParameters(FlowNode node)
	{
		if (parameters == null)
		{
			return;
		}
		for (int i = 0; i < parameters.Length; i++)
		{
			ParameterInfo parameterInfo = parameters[i];
			if (parameterInfo.IsOptional && parameterInfo.DefaultValue != null && node.GetInputPort(parameterInfo.Name) is ValueInput valueInput)
			{
				valueInput.serializedValue = parameterInfo.DefaultValue;
			}
		}
	}

	public virtual void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
	}

	public virtual void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
	}

	protected abstract void OnRegisterPorts(FlowNode node);

	protected virtual void OnRegisterExtraPorts(FlowNode node)
	{
	}

	public virtual void OnGraphStarted()
	{
	}

	public virtual void OnGraphPaused()
	{
	}

	public virtual void OnGraphUnpaused()
	{
	}

	public virtual void OnGraphStoped()
	{
	}
}
