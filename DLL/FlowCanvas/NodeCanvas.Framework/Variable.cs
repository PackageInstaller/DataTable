using System;
using System.Reflection;
using MessagePack;
using MessagePack.Formatters;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Framework;

[Serializable]
[SpoofAOT]
public abstract class Variable
{
	[SerializeField]
	private string _name;

	[SerializeField]
	private string _id;

	[SerializeField]
	private bool _protected;

	public string name
	{
		get
		{
			return _name;
		}
		set
		{
			if (_name != value)
			{
				_name = value;
				if (onNameChanged != null)
				{
					onNameChanged(value);
				}
			}
		}
	}

	public string ID
	{
		get
		{
			if (string.IsNullOrEmpty(_id))
			{
				_id = Guid.NewGuid().ToString();
			}
			return _id;
		}
	}

	public object value
	{
		get
		{
			return objectValue;
		}
		set
		{
			objectValue = value;
		}
	}

	public bool isProtected
	{
		get
		{
			return _protected;
		}
		set
		{
			_protected = value;
		}
	}

	protected abstract object objectValue { get; set; }

	public abstract Type varType { get; }

	public abstract bool hasBinding { get; }

	public abstract string propertyPath { get; set; }

	public event Action<string> onNameChanged;

	public event Action<string, object> onValueChanged;

	protected bool HasValueChangeEvent()
	{
		return onValueChanged != null;
	}

	protected void OnValueChanged(string name, object value)
	{
		onValueChanged(name, value);
	}

	public Variable()
	{
	}

	public abstract void BindProperty(MemberInfo prop, GameObject target = null);

	public abstract void UnBindProperty();

	public abstract void InitializePropertyBinding(GameObject go, bool callSetter = false);

	public virtual void Serialize(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(_name);
		writer.Write(_id);
		writer.Write(_protected);
	}

	public virtual void Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_name = reader.ReadString();
		_id = reader.ReadString();
		_protected = reader.ReadBoolean();
	}

	public bool CanConvertTo(Type toType)
	{
		return GetGetConverter(toType) != null;
	}

	public Func<object> GetGetConverter(Type toType)
	{
		if (toType.RTIsAssignableFrom(varType))
		{
			return () => value;
		}
		Func<object, object> converter = TypeConverter.Get(varType, toType);
		if (converter != null)
		{
			return () => converter(value);
		}
		return null;
	}

	public bool CanConvertFrom(Type fromType)
	{
		return GetSetConverter(fromType) != null;
	}

	public Action<object> GetSetConverter(Type fromType)
	{
		if (varType.RTIsAssignableFrom(fromType))
		{
			return delegate(object x)
			{
				value = x;
			};
		}
		Func<object, object> converter = TypeConverter.Get(fromType, varType);
		if (converter != null)
		{
			return delegate(object x)
			{
				value = converter(x);
			};
		}
		return null;
	}

	public override string ToString()
	{
		return name;
	}
}
[Serializable]
public class Variable<T> : Variable
{
	[SerializeField]
	private T _value;

	[SerializeField]
	private string _propertyPath;

	private Func<T> getter;

	private Action<T> setter;

	public override string propertyPath
	{
		get
		{
			return _propertyPath;
		}
		set
		{
			_propertyPath = value;
		}
	}

	public override bool hasBinding => !string.IsNullOrEmpty(_propertyPath);

	protected override object objectValue
	{
		get
		{
			return value;
		}
		set
		{
			this.value = (T)value;
		}
	}

	public override Type varType => typeof(T);

	public new T value
	{
		get
		{
			if (getter == null)
			{
				return _value;
			}
			return getter();
		}
		set
		{
			if (HasValueChangeEvent())
			{
				if (!object.Equals(_value, value))
				{
					_value = value;
					if (setter != null)
					{
						setter(value);
					}
					OnValueChanged(base.name, value);
				}
			}
			else if (setter != null)
			{
				setter(value);
			}
			else
			{
				_value = value;
			}
		}
	}

	public T GetValue()
	{
		return value;
	}

	public void SetValue(T newValue)
	{
		value = newValue;
	}

	public override void BindProperty(MemberInfo prop, GameObject target = null)
	{
		if (prop is PropertyInfo || prop is FieldInfo)
		{
			_propertyPath = $"{prop.RTReflectedType().FullName}.{prop.Name}";
			if (target != null)
			{
				InitializePropertyBinding(target);
			}
		}
	}

	public override void UnBindProperty()
	{
		_propertyPath = null;
		getter = null;
		setter = null;
	}

	public override void InitializePropertyBinding(GameObject go, bool callSetter = false)
	{
		if (!hasBinding || !Application.isPlaying)
		{
			return;
		}
		getter = null;
		setter = null;
		int num = _propertyPath.LastIndexOf('.');
		string text = _propertyPath.Substring(0, num);
		string arg = _propertyPath.Substring(num + 1);
		Type type = ReflectionTools.GetType(text, fallbackNoNamespace: true);
		if (type == null)
		{
			Debug.LogError($"Type '{text}' not found for Blackboard Variable '{base.name}' Binding.", go);
			return;
		}
		PropertyInfo propertyInfo = type.RTGetProperty(arg);
		if (propertyInfo != null)
		{
			MethodInfo getMethod = propertyInfo.RTGetGetMethod();
			MethodInfo setMethod = propertyInfo.RTGetSetMethod();
			bool flag = (getMethod != null && getMethod.IsStatic) || (setMethod != null && setMethod.IsStatic);
			Component instance = (flag ? null : go.GetComponent(type));
			if (instance == null && !flag)
			{
				Debug.LogError($"A Blackboard Variable '{base.name}' is due to bind to a Component type that is missing '{text}'. Binding ignored.", go);
				return;
			}
			if (propertyInfo.CanRead)
			{
				try
				{
					getter = getMethod.RTCreateDelegate<Func<T>>(instance);
				}
				catch
				{
					getter = () => (T)getMethod.Invoke(instance, null);
				}
			}
			else
			{
				getter = delegate
				{
					Debug.LogError($"You tried to Get a Property Bound Variable '{base.name}', but the Bound Property '{_propertyPath}' is Write Only!", go);
					return default(T);
				};
			}
			if (propertyInfo.CanWrite)
			{
				try
				{
					setter = setMethod.RTCreateDelegate<Action<T>>(instance);
				}
				catch
				{
					setter = delegate(T o)
					{
						setMethod.Invoke(instance, new object[1] { o });
					};
				}
				if (callSetter)
				{
					setter(_value);
				}
			}
			else
			{
				setter = delegate
				{
					Debug.LogError($"You tried to Set a Property Bound Variable '{base.name}', but the Bound Property '{_propertyPath}' is Read Only!", go);
				};
			}
			return;
		}
		FieldInfo field = type.RTGetField(arg);
		if (field != null)
		{
			Component instance2 = (field.IsStatic ? null : go.GetComponent(type));
			if (instance2 == null && !field.IsStatic)
			{
				Debug.LogError($"A Blackboard Variable '{base.name}' is due to bind to a Component type that is missing '{text}'. Binding ignored", go);
				return;
			}
			if (field.IsConstant())
			{
				T value = (T)field.GetValue(instance2);
				getter = () => value;
				return;
			}
			getter = () => (T)field.GetValue(instance2);
			setter = delegate(T o)
			{
				field.SetValue(instance2, o);
			};
		}
		else
		{
			Debug.LogError($"A Blackboard Variable '{base.name}' is due to bind to a property/field named '{arg}' that does not exist on type '{type.FullName}'. Binding ignored", go);
		}
	}

	public override void Serialize(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		base.Serialize(ref writer, options);
		writer.Write(_propertyPath);
		if (typeof(T).IsClass && value == null)
		{
			writer.Write(value: false);
			return;
		}
		writer.Write(value: true);
		if (value is UnityEngine.Object)
		{
			options.Resolver.GetFormatterWithVerify<UnityEngine.Object>().Serialize(ref writer, (UnityEngine.Object)(object)value, options);
			return;
		}
		try
		{
			options.Resolver.GetFormatterWithVerify<T>().Serialize(ref writer, value, options);
		}
		catch (Exception ex)
		{
			Debug.LogError(ex.Message + " type: " + _propertyPath);
		}
	}

	public override void Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		base.Deserialize(ref reader, options);
		_propertyPath = reader.ReadString();
		if (!reader.ReadBoolean())
		{
			return;
		}
		if (typeof(UnityEngine.Object).IsAssignableFrom(typeof(T)))
		{
			UnityEngine.Object obj = options.Resolver.GetFormatterWithVerify<UnityEngine.Object>().Deserialize(ref reader, options);
			if (obj == null)
			{
				_value = default(T);
			}
			else
			{
				_value = (T)(object)obj;
			}
		}
		else
		{
			IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
			_value = formatterWithVerify.Deserialize(ref reader, options);
		}
	}
}
