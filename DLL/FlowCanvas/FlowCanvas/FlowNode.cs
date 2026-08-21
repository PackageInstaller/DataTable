using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas;

public abstract class FlowNode : Node, ISerializationCallbackReceiver
{
	[AttributeUsage(AttributeTargets.Class)]
	public class ContextDefinedInputsAttribute : Attribute
	{
		public readonly Type[] types;

		public ContextDefinedInputsAttribute(params Type[] types)
		{
			this.types = types;
		}
	}

	[AttributeUsage(AttributeTargets.Class)]
	public class ContextDefinedOutputsAttribute : Attribute
	{
		public readonly Type[] types;

		public ContextDefinedOutputsAttribute(params Type[] types)
		{
			this.types = types;
		}
	}

	[AttributeUsage(AttributeTargets.Class)]
	public class HasRefreshButtonAttribute : Attribute
	{
	}

	[AttributeUsage(AttributeTargets.Field)]
	public class GatherPortsCallbackAttribute : CallbackAttribute
	{
		public GatherPortsCallbackAttribute()
			: base("GatherPorts")
		{
		}
	}

	[SerializeField]
	private Dictionary<string, object> _inputPortValues;

	[NonSerialized]
	private Dictionary<string, Port> _inputPorts;

	[NonSerialized]
	private Dictionary<string, Port> inputPorts;

	[NonSerialized]
	private Dictionary<string, Port> outputPorts;

	public sealed override int maxInConnections => -1;

	public sealed override int maxOutConnections => -1;

	public sealed override bool allowAsPrime => false;

	public sealed override Type outConnectionType => typeof(BinderConnection);

	public sealed override Alignment2x2 commentsAlignment => Alignment2x2.Bottom;

	public override Alignment2x2 iconAlignment => Alignment2x2.Left;

	public FlowGraph flowGraph => (FlowGraph)base.graph;

	public override void OnDestroy()
	{
		base.OnDestroy();
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (inputPorts == null)
		{
			return;
		}
		ValueInput[] array = inputPorts.Values.OfType<ValueInput>().ToArray();
		if (array.Length == 0)
		{
			return;
		}
		_inputPortValues = new Dictionary<string, object>(StringComparer.Ordinal);
		ValueInput[] array2 = array;
		foreach (ValueInput valueInput in array2)
		{
			if (!valueInput.isConnected && !valueInput.isDefaultValue)
			{
				_inputPortValues[valueInput.ID] = valueInput.serializedValue;
			}
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
	}

	public sealed override void OnValidate(Graph flowGraph)
	{
		GatherPorts();
	}

	public sealed override void OnParentConnected(int i)
	{
	}

	public sealed override void OnChildConnected(int i)
	{
	}

	public sealed override void OnParentDisconnected(int i)
	{
	}

	public sealed override void OnChildDisconnected(int i)
	{
	}

	public virtual void OnPortConnected(Port port, Port otherPort)
	{
		TryHandleWildPortConnection(port.type, otherPort.type);
	}

	public virtual void OnPortDisconnected(Port port, Port otherPort)
	{
	}

	public void BindPorts()
	{
		for (int i = 0; i < base.outConnections.Count; i++)
		{
			(base.outConnections[i] as BinderConnection).Bind();
		}
	}

	public void UnBindPorts()
	{
		for (int i = 0; i < base.outConnections.Count; i++)
		{
			(base.outConnections[i] as BinderConnection).UnBind();
		}
	}

	public Port GetInputPort(string ID)
	{
		Port value = null;
		if (inputPorts != null && !inputPorts.TryGetValue(ID, out value))
		{
			value = inputPorts.Values.FirstOrDefault((Port p) => CheckReverseIDEquality(p, ID));
		}
		return value;
	}

	public Port GetOutputPort(string ID)
	{
		Port value = null;
		if (outputPorts != null && !outputPorts.TryGetValue(ID, out value))
		{
			value = outputPorts.Values.FirstOrDefault((Port p) => CheckReverseIDEquality(p, ID));
		}
		return value;
	}

	public Dictionary<string, Port> GetInputPorts()
	{
		return inputPorts;
	}

	public void SetDeserializeInputPorts(Dictionary<string, Port> ports)
	{
		_inputPorts = ports;
	}

	public FlowOutput[] GetOutputFlowPorts()
	{
		return outputPorts.Values.OfType<FlowOutput>().ToArray();
	}

	public ValueOutput[] GetOutputValuePorts()
	{
		return outputPorts.Values.OfType<ValueOutput>().ToArray();
	}

	public FlowInput[] GetInputFlowPorts()
	{
		return inputPorts.Values.OfType<FlowInput>().ToArray();
	}

	public ValueInput[] GetInputValuePorts()
	{
		return inputPorts.Values.OfType<ValueInput>().ToArray();
	}

	public Port GetFirstInputOfType(Type type)
	{
		return inputPorts.Values.OrderBy((Port p) => (!(p is FlowInput)) ? 1 : 0).FirstOrDefault((Port p) => p.type.RTIsAssignableFrom(type));
	}

	public Port GetFirstOutputOfType(Type type)
	{
		return outputPorts.Values.OrderBy((Port p) => (!(p is FlowInput)) ? 1 : 0).FirstOrDefault((Port p) => type.RTIsAssignableFrom(p.type));
	}

	public void AssignSelfInstancePort()
	{
		ValueInput valueInput = inputPorts.Values.OfType<ValueInput>().FirstOrDefault();
		if (valueInput != null && !valueInput.isConnected && valueInput.isDefaultValue)
		{
			UnityEngine.Object agentComponent = flowGraph.GetAgentComponent(valueInput.type);
			if (agentComponent != null)
			{
				valueInput.serializedValue = agentComponent;
			}
		}
	}

	public void GatherPorts()
	{
		inputPorts = new Dictionary<string, Port>(StringComparer.Ordinal);
		outputPorts = new Dictionary<string, Port>(StringComparer.Ordinal);
		RegisterPorts();
		DeserializeInputPortValues();
	}

	protected abstract void RegisterPorts();

	private void DeserializeInputPortValues()
	{
		if (_inputPortValues == null)
		{
			return;
		}
		foreach (KeyValuePair<string, object> pair in _inputPortValues)
		{
			Port value = null;
			if (!inputPorts.TryGetValue(pair.Key, out value))
			{
				value = inputPorts.Values.FirstOrDefault((Port p) => CheckReverseIDEquality(p, pair.Key));
			}
			if (value is ValueInput && pair.Value != null && value.type.RTIsAssignableFrom(pair.Value.GetType()))
			{
				(value as ValueInput).serializedValue = pair.Value;
			}
			else if (value is ValueInput && pair.Value != null && TypeConverter.HasConvertion(pair.Value.GetType(), value.type))
			{
				ValueHandler<object> converterFuncFromTo = TypeConverter.GetConverterFuncFromTo<object>(pair.Value.GetType(), value.type, () => pair.Value);
				(value as ValueInput).serializedValue = converterFuncFromTo();
			}
			else if (value is ValueInput && pair.Value != null)
			{
				Debug.LogError("没有处理, 节点上的值丢了 " + name);
			}
		}
	}

	private void ValidateConnections()
	{
		Connection[] array = base.outConnections.ToArray();
		foreach (Connection connection in array)
		{
			if (connection is BinderConnection)
			{
				(connection as BinderConnection).GatherAndValidateSourcePort();
			}
		}
		array = base.inConnections.ToArray();
		foreach (Connection connection2 in array)
		{
			if (connection2 is BinderConnection)
			{
				(connection2 as BinderConnection).GatherAndValidateTargetPort();
			}
		}
	}

	public FlowInput AddFlowInput(string name, string ID, FlowHandler pointer)
	{
		return AddFlowInput(name, pointer, ID);
	}

	public FlowInput AddFlowInput(string name, FlowHandler pointer, string ID = "")
	{
		QualifyPortNameAndID(ref name, ref ID, inputPorts);
		Port port = (inputPorts[ID] = new FlowInput(this, name, ID, pointer));
		return (FlowInput)port;
	}

	public FlowOutput AddFlowOutput(string name, string ID = "")
	{
		QualifyPortNameAndID(ref name, ref ID, outputPorts);
		Port port = (outputPorts[ID] = new FlowOutput(this, name, ID));
		return (FlowOutput)port;
	}

	public ValueInput<T> AddValueInput<T>(string name, string ID = "")
	{
		QualifyPortNameAndID(ref name, ref ID, inputPorts);
		Port port;
		if (_inputPorts != null && _inputPorts.ContainsKey(ID))
		{
			if (_inputPorts[ID] == null)
			{
				Debug.LogError("ID : " + ID + " is empty");
			}
			_inputPorts[ID].ID = ID;
			_inputPorts[ID].name = name;
			_inputPorts[ID].parent = this;
			port = (inputPorts[ID] = _inputPorts[ID]);
			return (ValueInput<T>)port;
		}
		port = (inputPorts[ID] = new ValueInput<T>(this, name, ID));
		return (ValueInput<T>)port;
	}

	public ValueOutput<T> AddValueOutput<T>(string name, string ID, ValueHandler<T> getter)
	{
		return AddValueOutput(name, getter, ID);
	}

	public ValueOutput<T> AddValueOutput<T>(string name, ValueHandler<T> getter, string ID = "")
	{
		QualifyPortNameAndID(ref name, ref ID, outputPorts);
		Port port = (outputPorts[ID] = new ValueOutput<T>(this, name, ID, getter));
		return (ValueOutput<T>)port;
	}

	public ValueOutput<T, Owner> AddValueOutput<T, Owner>(string name, Owner o, ValueHandler<T, Owner> getter, string ID = "")
	{
		QualifyPortNameAndID(ref name, ref ID, outputPorts);
		Port port = (outputPorts[ID] = new ValueOutput<T, Owner>(this, name, ID, getter, o));
		return (ValueOutput<T, Owner>)port;
	}

	public ValueInput AddValueInput(string name, string ID, Type type)
	{
		return AddValueInput(name, type, ID);
	}

	public ValueInput AddValueInput(string name, Type type, string ID = "")
	{
		QualifyPortNameAndID(ref name, ref ID, inputPorts);
		Port port;
		if (_inputPorts != null && _inputPorts.ContainsKey(ID))
		{
			_inputPorts[ID].ID = ID;
			_inputPorts[ID].name = name;
			port = (inputPorts[ID] = _inputPorts[ID]);
			return (ValueInput)port;
		}
		port = (inputPorts[ID] = ValueInput.CreateInstance(type, this, name, ID));
		return (ValueInput)port;
	}

	public ValueOutput AddValueOutput(string name, string ID, Type type, ValueHandlerObject getter)
	{
		return AddValueOutput(name, type, getter, ID);
	}

	public ValueOutput AddValueOutput(string name, Type type, ValueHandlerObject getter, string ID = "")
	{
		QualifyPortNameAndID(ref name, ref ID, outputPorts);
		Port port = (outputPorts[ID] = ValueOutput.CreateInstance(type, this, name, ID, getter));
		return (ValueOutput)port;
	}

	private void QualifyPortNameAndID(ref string name, ref string ID, IDictionary dict)
	{
		if (string.IsNullOrEmpty(ID))
		{
			ID = name;
		}
		if (string.IsNullOrEmpty(ID))
		{
			ID = " ";
			while (dict.Contains(ID))
			{
				ID += " ";
			}
		}
	}

	private bool CheckReverseIDEquality(Port port, string requestedID)
	{
		if (port.ID.Trim() == requestedID.Trim())
		{
			return true;
		}
		if (port.name.Trim() == requestedID.Trim())
		{
			return true;
		}
		if (port.name.SplitCamelCase().Trim() == requestedID.Trim())
		{
			return true;
		}
		return false;
	}

	private void TryAddReflectionBasedRegistrationForObject(object instance)
	{
		MethodInfo[] methods = instance.GetType().GetMethods(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public);
		foreach (MethodInfo method in methods)
		{
			TryAddMethodFlowInput(method, instance);
		}
		PropertyInfo[] properties = instance.GetType().GetProperties(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public);
		foreach (PropertyInfo prop in properties)
		{
			TryAddPropertyValueOutput(prop, instance);
		}
		FieldInfo[] fields = instance.GetType().GetFields(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public);
		foreach (FieldInfo field in fields)
		{
			TryAddFieldDelegateFlowOutput(field, instance);
			TryAddFieldDelegateValueInput(field, instance);
		}
	}

	public FlowInput TryAddMethodFlowInput(MethodInfo method, object instance)
	{
		ParameterInfo[] parameters = method.GetParameters();
		if (method.ReturnType == typeof(void) && parameters.Length == 1 && parameters[0].ParameterType == typeof(Flow))
		{
			NameAttribute nameAttribute = method.RTGetAttribute<NameAttribute>(inherited: false);
			string text = ((nameAttribute != null) ? nameAttribute.name : method.Name);
			FlowHandler pointer = method.RTCreateDelegate<FlowHandler>(instance);
			return AddFlowInput(text, pointer);
		}
		return null;
	}

	public FlowOutput TryAddFieldDelegateFlowOutput(FieldInfo field, object instance)
	{
		if (field.FieldType == typeof(FlowHandler))
		{
			NameAttribute nameAttribute = field.RTGetAttribute<NameAttribute>(inherited: false);
			string text = ((nameAttribute != null) ? nameAttribute.name : field.Name);
			FlowOutput flowOutput = AddFlowOutput(text);
			field.SetValue(instance, new FlowHandler(flowOutput.Call));
			return flowOutput;
		}
		return null;
	}

	public ValueInput TryAddFieldDelegateValueInput(FieldInfo field, object instance)
	{
		if (typeof(Delegate).RTIsAssignableFrom(field.FieldType))
		{
			MethodInfo method = field.FieldType.GetMethod("Invoke");
			ParameterInfo[] parameters = method.GetParameters();
			if (method.ReturnType != typeof(void) && parameters.Length == 0)
			{
				NameAttribute nameAttribute = field.RTGetAttribute<NameAttribute>(inherited: false);
				string text = ((nameAttribute != null) ? nameAttribute.name : field.Name);
				Type returnType = method.ReturnType;
				ValueInput valueInput = (ValueInput)Activator.CreateInstance(typeof(ValueInput<>).RTMakeGenericType(returnType), instance, text, text);
				Type type = typeof(ValueHandler<>).RTMakeGenericType(returnType);
				Delegate value = valueInput.GetType().GetMethod("get_value").RTCreateDelegate(type, valueInput);
				field.SetValue(instance, value);
				inputPorts[text] = valueInput;
				return valueInput;
			}
		}
		return null;
	}

	public ValueOutput TryAddPropertyValueOutput(PropertyInfo prop, object instance)
	{
		if (prop.CanRead)
		{
			NameAttribute nameAttribute = prop.RTGetAttribute<NameAttribute>(inherited: false);
			string text = ((nameAttribute != null) ? nameAttribute.name : prop.Name);
			Type type = typeof(ValueHandler<>).RTMakeGenericType(prop.PropertyType);
			Delegate obj = prop.RTGetGetMethod().RTCreateDelegate(type, instance);
			ValueOutput valueOutput = (ValueOutput)Activator.CreateInstance(typeof(ValueOutput<>).RTMakeGenericType(prop.PropertyType), this, text, text, obj);
			Port port = (outputPorts[text] = valueOutput);
			return (ValueOutput)port;
		}
		return null;
	}

	public FlowNode ReplaceWith(Type t)
	{
		if (!(base.graph.AddNode(t, Vector3.zero) is FlowNode flowNode))
		{
			return null;
		}
		Connection[] array = base.inConnections.ToArray();
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetTarget(flowNode);
		}
		array = base.outConnections.ToArray();
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetSource(flowNode);
		}
		if (_inputPortValues != null)
		{
			flowNode._inputPortValues = _inputPortValues.ToDictionary((KeyValuePair<string, object> k) => k.Key, (KeyValuePair<string, object> v) => v.Value);
		}
		base.graph.RemoveNode(this);
		flowNode.GatherPorts();
		return flowNode;
	}

	public virtual Type GetNodeWildDefinitionType()
	{
		return GetType().GetFirstGenericParameterConstraintType();
	}

	private void TryHandleWildPortConnection(Type currentType, Type targetType)
	{
		Type nodeWildDefinitionType = GetNodeWildDefinitionType();
		Type type = GetType();
		Type type2 = TryGetNewGenericTypeForWild(nodeWildDefinitionType, currentType, targetType, type, null);
		if (type2 != null)
		{
			ReplaceWith(type2);
		}
	}

	public static Type TryGetNewGenericTypeForWild(Type wildType, Type currentType, Type targetType, Type content, Type context)
	{
		if (wildType == null || !content.IsGenericType)
		{
			return null;
		}
		Type[] genericArguments = content.GetGenericArguments();
		Type type = genericArguments.FirstOrDefault();
		if (type != wildType && type.IsGenericType)
		{
			return TryGetNewGenericTypeForWild(wildType, currentType, targetType, type, content);
		}
		Type enumerableElementType;
		int num;
		Type type2;
		if (genericArguments.Length == 1 && type == wildType)
		{
			enumerableElementType = targetType.GetEnumerableElementType();
			Type enumerableElementType2 = currentType.GetEnumerableElementType();
			if (enumerableElementType != null)
			{
				num = ((enumerableElementType2 != null) ? 1 : 0);
				if (num != 0)
				{
					type2 = enumerableElementType2;
					goto IL_007a;
				}
			}
			else
			{
				num = 0;
			}
			type2 = currentType;
			goto IL_007a;
		}
		goto IL_00f4;
		IL_007a:
		currentType = type2;
		targetType = ((num != 0) ? enumerableElementType : targetType);
		if (currentType == wildType && targetType != currentType)
		{
			content = content.GetGenericTypeDefinition();
			type = content.GetGenericArguments().First();
			if (targetType.IsAllowedByGenericArgument(type))
			{
				Type type3 = content.MakeGenericType(targetType);
				if (context != null && context.IsGenericType)
				{
					type3 = context.GetGenericTypeDefinition().MakeGenericType(type3);
				}
				return type3;
			}
		}
		goto IL_00f4;
		IL_00f4:
		return null;
	}

	public static MethodInfo TryGetNewGenericMethodForWild(Type wildType, Type currentType, Type targetType, MethodInfo content)
	{
		if (wildType == null || !content.IsGenericMethod)
		{
			return null;
		}
		Type[] genericArguments = content.GetGenericArguments();
		Type type = genericArguments.FirstOrDefault();
		Type enumerableElementType;
		int num;
		Type type2;
		if (genericArguments.Length == 1 && type == wildType)
		{
			enumerableElementType = targetType.GetEnumerableElementType();
			Type enumerableElementType2 = currentType.GetEnumerableElementType();
			if (enumerableElementType != null)
			{
				num = ((enumerableElementType2 != null) ? 1 : 0);
				if (num != 0)
				{
					type2 = enumerableElementType2;
					goto IL_0056;
				}
			}
			else
			{
				num = 0;
			}
			type2 = currentType;
			goto IL_0056;
		}
		goto IL_00a0;
		IL_00a0:
		return null;
		IL_0056:
		currentType = type2;
		targetType = ((num != 0) ? enumerableElementType : targetType);
		if (currentType == wildType && targetType != currentType)
		{
			content = content.GetGenericMethodDefinition();
			type = content.GetGenericArguments().First();
			if (targetType.IsAllowedByGenericArgument(type))
			{
				return content.MakeGenericMethod(targetType);
			}
		}
		goto IL_00a0;
	}
}
