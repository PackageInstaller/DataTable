using System;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer;

public class fsMetaType
{
	private delegate object ObjectGenerator();

	private static Dictionary<Type, fsMetaType> _metaTypes = new Dictionary<Type, fsMetaType>();

	private static Dictionary<Type, object> _defaultInstances = new Dictionary<Type, object>();

	private ObjectGenerator generator;

	public Type reflectedType { get; private set; }

	public fsMetaProperty[] Properties { get; private set; }

	public bool DeserializeOverwriteRequest { get; private set; }

	public static fsMetaType Get(Type type)
	{
		if (!_metaTypes.TryGetValue(type, out var value))
		{
			value = new fsMetaType(type);
			_metaTypes[type] = value;
		}
		return value;
	}

	public static void FlushMem()
	{
		_metaTypes = new Dictionary<Type, fsMetaType>();
		_defaultInstances = new Dictionary<Type, object>();
	}

	private fsMetaType(Type reflectedType)
	{
		this.reflectedType = reflectedType;
		generator = GetGenerator(reflectedType);
		List<fsMetaProperty> list = new List<fsMetaProperty>();
		CollectProperties(list, reflectedType);
		Properties = list.ToArray();
	}

	private static void CollectProperties(List<fsMetaProperty> properties, Type reflectedType)
	{
		FieldInfo[] array = reflectedType.RTGetFields();
		foreach (FieldInfo fieldInfo in array)
		{
			if (!(fieldInfo.DeclaringType != reflectedType) && CanSerializeField(fieldInfo))
			{
				properties.Add(new fsMetaProperty(fieldInfo));
			}
		}
		if (reflectedType.BaseType != null)
		{
			CollectProperties(properties, reflectedType.BaseType);
		}
	}

	public static bool CanSerializeField(FieldInfo field)
	{
		if (field.IsStatic)
		{
			return false;
		}
		if (typeof(Delegate).IsAssignableFrom(field.FieldType))
		{
			return false;
		}
		if (field.RTIsDefined<fsIgnoreInBuildAttribute>(inherited: true))
		{
			return false;
		}
		if (field.RTIsDefined<CompilerGeneratedAttribute>(inherited: true))
		{
			return false;
		}
		for (int i = 0; i < fsGlobalConfig.IgnoreSerializeAttributes.Length; i++)
		{
			if (field.RTIsDefined(fsGlobalConfig.IgnoreSerializeAttributes[i], inherited: true))
			{
				return false;
			}
		}
		if (field.IsPublic)
		{
			return true;
		}
		for (int j = 0; j < fsGlobalConfig.SerializeAttributes.Length; j++)
		{
			if (field.RTIsDefined(fsGlobalConfig.SerializeAttributes[j], inherited: true))
			{
				return true;
			}
		}
		return false;
	}

	private static ObjectGenerator GetGenerator(Type reflectedType)
	{
		if (reflectedType.IsInterface || reflectedType.IsAbstract)
		{
			return null;
		}
		if (typeof(ScriptableObject).IsAssignableFrom(reflectedType))
		{
			return () => ScriptableObject.CreateInstance(reflectedType);
		}
		if (reflectedType.IsArray)
		{
			return () => Array.CreateInstance(reflectedType.GetElementType(), 0);
		}
		if (reflectedType == typeof(string))
		{
			return () => string.Empty;
		}
		if (reflectedType.IsValueType || reflectedType.RTIsDefined<fsUninitialized>(inherited: true) || !HasDefaultConstructor(reflectedType))
		{
			return () => FormatterServices.GetSafeUninitializedObject(reflectedType);
		}
		return delegate
		{
			try
			{
				return Activator.CreateInstance(reflectedType, nonPublic: true);
			}
			catch
			{
				return (object)null;
			}
		};
	}

	private static bool HasDefaultConstructor(Type reflectedType)
	{
		if (reflectedType.IsArray)
		{
			return true;
		}
		if (reflectedType.IsValueType)
		{
			return true;
		}
		return reflectedType.RTGetDefaultConstructor() != null;
	}

	public object GetDefaultInstance()
	{
		object value = null;
		if (_defaultInstances.TryGetValue(reflectedType, out value))
		{
			return value;
		}
		return _defaultInstances[reflectedType] = CreateInstance();
	}

	public object CreateInstance()
	{
		if (generator != null)
		{
			return generator();
		}
		throw new Exception("Cant create instance generator for " + reflectedType);
	}
}
