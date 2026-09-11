using System;
using Config;
using MessagePack;
using MessagePack.Formatters;
using ParadoxNotion;
using UnityEngine;

namespace FlowCanvas;

public abstract class ValueInput : Port
{
	public object value => GetObjectValue();

	public abstract object defaultValue { get; set; }

	public abstract object serializedValue { get; set; }

	public abstract bool isDefaultValue { get; }

	public abstract override Type type { get; }

	public ValueInput()
	{
	}

	public ValueInput(FlowNode parent, string name, string ID)
		: base(parent, name, ID)
	{
	}

	public static ValueInput<T> CreateInstance<T>(FlowNode parent, string name, string ID)
	{
		return new ValueInput<T>(parent, name, ID);
	}

	public static ValueInput CreateInstance(Type t, FlowNode parent, string name, string ID)
	{
		return (ValueInput)Activator.CreateInstance(typeof(ValueInput<>).RTMakeGenericType(t), parent, name, ID);
	}

	public ValueInput SetDefaultAndSerializedValue(object v)
	{
		defaultValue = v;
		serializedValue = v;
		return this;
	}

	public abstract void BindTo(ValueOutput target);

	public abstract void UnBind();

	public abstract object GetObjectValue();

	public abstract void Serialize(ref MessagePackWriter writer, MessagePackSerializerOptions options);

	public abstract void Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options);
}
public class ValueInput<T> : ValueInput
{
	private T _value;

	private T _defaultValue;

	private bool isInit;

	public ValueHandler<T> getter { get; private set; }

	public new T value
	{
		get
		{
			if (getter != null)
			{
				return getter();
			}
			return _value;
		}
	}

	public override object defaultValue
	{
		get
		{
			return _defaultValue;
		}
		set
		{
			_defaultValue = (T)value;
		}
	}

	public override object serializedValue
	{
		get
		{
			return _value;
		}
		set
		{
			_value = (T)value;
		}
	}

	public override bool isDefaultValue => object.Equals(_value, defaultValue);

	public override Type type => typeof(T);

	public ValueInput()
	{
	}

	public ValueInput(FlowNode parent, string name, string ID)
		: base(parent, name, ID)
	{
	}

	public ValueInput<T> SetDefaultAndSerializedValue(T v)
	{
		_defaultValue = v;
		if (isInit)
		{
			return this;
		}
		_value = v;
		return this;
	}

	public T GetValue()
	{
		return value;
	}

	public override object GetObjectValue()
	{
		return value;
	}

	public override void BindTo(ValueOutput source)
	{
		if (source == null)
		{
			Debug.LogError("Source Is Nil " + base.name + " " + base.parent.name + " " + base.ID + " " + base.parent.graph.name);
		}
		if (source is ValueOutput<T>)
		{
			getter = (source as ValueOutput<T>).getter;
			return;
		}
		if (typeof(T) == typeof(int))
		{
			if (source is ValueOutput<BuffClass>)
			{
				ValueHandler<int> valueHandler = () => (int)(source as ValueOutput<BuffClass>).getter();
				getter = valueHandler as ValueHandler<T>;
				return;
			}
			if (source is ValueOutput<EntityVarName>)
			{
				ValueHandler<int> valueHandler2 = () => (int)(source as ValueOutput<EntityVarName>).getter();
				getter = valueHandler2 as ValueHandler<T>;
				return;
			}
			if (source is ValueOutput<SimVar>)
			{
				ValueHandler<int> valueHandler3 = () => (source as ValueOutput<SimVar>).getter();
				getter = valueHandler3 as ValueHandler<T>;
				return;
			}
		}
		getter = TypeConverter.GetConverterFuncFromTo<T>(source.type, typeof(T), source.GetObjectValue);
	}

	public void BindTo(ValueHandler<T> getter)
	{
		this.getter = getter;
	}

	public override void UnBind()
	{
		getter = null;
	}

	public override void Serialize(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		if (typeof(T).IsClass && value == null)
		{
			writer.Write(value: false);
			return;
		}
		writer.Write(value: true);
		if (value is UnityEngine.Object)
		{
			options.Resolver.GetFormatterWithVerify<UnityEngine.Object>().Serialize(ref writer, (UnityEngine.Object)(object)value, options);
		}
		else
		{
			options.Resolver.GetFormatterWithVerify<T>().Serialize(ref writer, value, options);
		}
	}

	public override void Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.ReadBoolean())
		{
			if (typeof(UnityEngine.Object).IsAssignableFrom(typeof(T)))
			{
				IMessagePackFormatter<UnityEngine.Object> formatterWithVerify = options.Resolver.GetFormatterWithVerify<UnityEngine.Object>();
				_value = (T)(object)formatterWithVerify.Deserialize(ref reader, options);
			}
			else
			{
				IMessagePackFormatter<T> formatterWithVerify2 = options.Resolver.GetFormatterWithVerify<T>();
				_value = formatterWithVerify2.Deserialize(ref reader, options);
			}
			isInit = true;
		}
	}

	public static explicit operator T(ValueInput<T> port)
	{
		return port.value;
	}
}
