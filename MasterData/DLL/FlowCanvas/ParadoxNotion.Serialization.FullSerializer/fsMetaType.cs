using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;
using ParadoxNotion.Serialization.FullSerializer.Internal;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer;

public class fsMetaType
{
	private static Dictionary<fsConfig, Dictionary<Type, fsMetaType>> _configMetaTypes = new Dictionary<fsConfig, Dictionary<Type, fsMetaType>>();

	private Func<object> Generator;

	public Type ReflectedType;

	public static Dictionary<Type, MemberInfo[]> types = new Dictionary<Type, MemberInfo[]>();

	public static Dictionary<Type, PropertyInfo[]> typePropertyInfo2 = new Dictionary<Type, PropertyInfo[]>();

	public static Dictionary<Type, FieldInfo[]> typeFieldInfo2 = new Dictionary<Type, FieldInfo[]>();

	public static Dictionary<Type, bool[]> isAutoProperty = new Dictionary<Type, bool[]>();

	private bool _hasEmittedAotData;

	private bool? _hasDefaultConstructorCache;

	private bool _isDefaultConstructorPublic;

	public fsMetaProperty[] Properties { get; private set; }

	public bool HasDefaultConstructor
	{
		get
		{
			if (!_hasDefaultConstructorCache.HasValue)
			{
				if (ReflectedType.Resolve().IsArray)
				{
					_hasDefaultConstructorCache = true;
					_isDefaultConstructorPublic = true;
				}
				else if (ReflectedType.Resolve().IsValueType)
				{
					_hasDefaultConstructorCache = true;
					_isDefaultConstructorPublic = true;
				}
				else
				{
					ConstructorInfo declaredConstructor = ReflectedType.GetDeclaredConstructor(fsPortableReflection.EmptyTypes);
					_hasDefaultConstructorCache = declaredConstructor != null;
					if (declaredConstructor != null)
					{
						_isDefaultConstructorPublic = declaredConstructor.IsPublic;
					}
				}
			}
			return _hasDefaultConstructorCache.Value;
		}
	}

	public static fsMetaType Get(fsConfig config, Type type)
	{
		if (!_configMetaTypes.TryGetValue(config, out var value))
		{
			Dictionary<Type, fsMetaType> dictionary = (_configMetaTypes[config] = new Dictionary<Type, fsMetaType>());
			value = dictionary;
		}
		if (!value.TryGetValue(type, out var value2))
		{
			value2 = (value[type] = new fsMetaType(config, type));
		}
		return value2;
	}

	public static void ClearCache()
	{
		_configMetaTypes = new Dictionary<fsConfig, Dictionary<Type, fsMetaType>>();
		types.Clear();
		typePropertyInfo2.Clear();
		typeFieldInfo2.Clear();
		isAutoProperty.Clear();
	}

	private fsMetaType(fsConfig config, Type reflectedType)
	{
		ReflectedType = reflectedType;
		List<fsMetaProperty> list = new List<fsMetaProperty>();
		CollectProperties(config, list, reflectedType);
		Properties = list.ToArray();
		try
		{
			if (!ReflectedType.Resolve().IsValueType && ReflectedType.GetDeclaredConstructor(fsPortableReflection.EmptyTypes) != null)
			{
				Generator = Expression.Lambda<Func<object>>(Expression.New(reflectedType), Array.Empty<ParameterExpression>()).Compile();
			}
		}
		catch
		{
			Generator = null;
		}
	}

	private static void CollectProperties(fsConfig config, List<fsMetaProperty> properties, Type reflectedType)
	{
		bool flag = config.DefaultMemberSerialization == fsMemberSerialization.OptIn;
		bool flag2 = config.DefaultMemberSerialization == fsMemberSerialization.OptOut;
		fsObjectAttribute attribute = fsPortableReflection.GetAttribute<fsObjectAttribute>(reflectedType);
		if (attribute != null)
		{
			flag = attribute.MemberSerialization == fsMemberSerialization.OptIn;
			flag2 = attribute.MemberSerialization == fsMemberSerialization.OptOut;
		}
		if (!types.TryGetValue(reflectedType, out var members))
		{
			members = reflectedType.GetDeclaredMembers();
			types.Add(reflectedType, members);
			PropertyInfo[] array = new PropertyInfo[members.Length];
			FieldInfo[] array2 = new FieldInfo[members.Length];
			bool[] array3 = new bool[members.Length];
			for (int i = 0; i < members.Length; i++)
			{
				try
				{
					array[i] = members[i] as PropertyInfo;
					array2[i] = members[i] as FieldInfo;
					if (array[i] != null)
					{
						array3[i] = IsAutoProperty(array[i], members);
					}
				}
				catch (Exception ex)
				{
					Debug.Log("异常" + ex.Message);
					Debug.Log("类型名字" + reflectedType.FullName);
					Debug.Log("类型ID" + reflectedType.GUID.ToString());
					Debug.Log("类型" + reflectedType);
				}
			}
			typePropertyInfo2.Add(reflectedType, array);
			typeFieldInfo2.Add(reflectedType, array2);
			isAutoProperty.Add(reflectedType, array3);
		}
		int j;
		for (j = 0; j < members.Length; j++)
		{
			if (config.IgnoreSerializeAttributes.Any((Type t) => fsPortableReflection.HasAttribute(members[j], t)))
			{
				continue;
			}
			PropertyInfo propertyInfo = null;
			FieldInfo fieldInfo = null;
			try
			{
				propertyInfo = typePropertyInfo2[reflectedType][j];
				fieldInfo = typeFieldInfo2[reflectedType][j];
			}
			catch (Exception)
			{
				Debug.Log("类型名字" + reflectedType.FullName);
				Debug.Log("类型ID" + reflectedType.GUID.ToString());
				Debug.Log("类型" + reflectedType);
			}
			if ((propertyInfo == null && fieldInfo == null) || (flag && !config.SerializeAttributes.Any((Type t) => fsPortableReflection.HasAttribute(members[j], t))) || (flag2 && config.IgnoreSerializeAttributes.Any((Type t) => fsPortableReflection.HasAttribute(members[j], t))))
			{
				continue;
			}
			if (propertyInfo != null)
			{
				if (CanSerializeProperty(config, propertyInfo, members, flag2, j, reflectedType))
				{
					properties.Add(new fsMetaProperty(config, propertyInfo));
				}
			}
			else if (fieldInfo != null && CanSerializeField(config, fieldInfo, flag2))
			{
				properties.Add(new fsMetaProperty(config, fieldInfo));
			}
		}
		Type baseType = reflectedType.Resolve().BaseType;
		if (baseType != null)
		{
			fsMetaType fsMetaType2 = Get(config, baseType);
			for (int num = 0; num < fsMetaType2.Properties.Length; num++)
			{
				properties.Add(fsMetaType2.Properties[num]);
			}
		}
	}

	private static bool IsAutoProperty(PropertyInfo property, MemberInfo[] members)
	{
		if (!property.CanWrite || !property.CanRead)
		{
			return false;
		}
		string text = "<" + property.Name + ">k__BackingField";
		for (int i = 0; i < members.Length; i++)
		{
			if (members[i].Name == text)
			{
				return true;
			}
		}
		return false;
	}

	private static bool IsAutoProperty(int index, Type type)
	{
		try
		{
			return isAutoProperty[type][index];
		}
		catch
		{
			return false;
		}
	}

	private static bool CanSerializeProperty(fsConfig config, PropertyInfo property, MemberInfo[] members, bool annotationFreeValue, int index, Type reflectedType)
	{
		if (typeof(Delegate).IsAssignableFrom(property.PropertyType))
		{
			return false;
		}
		MethodInfo getMethod = property.GetGetMethod(nonPublic: false);
		MethodInfo setMethod = property.GetSetMethod(nonPublic: false);
		if ((getMethod != null && getMethod.IsStatic) || (setMethod != null && setMethod.IsStatic))
		{
			return false;
		}
		if (property.GetIndexParameters().Length != 0)
		{
			return false;
		}
		if (config.SerializeAttributes.Any((Type t) => fsPortableReflection.HasAttribute(property, t)))
		{
			return true;
		}
		if (!property.CanRead || !property.CanWrite)
		{
			return false;
		}
		if ((config.SerializeNonAutoProperties || IsAutoProperty(index, reflectedType)) && getMethod != null && (config.SerializeNonPublicSetProperties || setMethod != null))
		{
			return true;
		}
		return annotationFreeValue;
	}

	private static bool CanSerializeField(fsConfig config, FieldInfo field, bool annotationFreeValue)
	{
		if (typeof(Delegate).IsAssignableFrom(field.FieldType))
		{
			return false;
		}
		if (field.IsDefined(typeof(CompilerGeneratedAttribute), inherit: false))
		{
			return false;
		}
		if (field.IsStatic)
		{
			return false;
		}
		if (config.SerializeAttributes.Any((Type t) => fsPortableReflection.HasAttribute(field, t)))
		{
			return true;
		}
		if (!annotationFreeValue && !field.IsPublic)
		{
			return false;
		}
		return true;
	}

	public bool EmitAotData()
	{
		if (!_hasEmittedAotData)
		{
			_hasEmittedAotData = true;
			for (int i = 0; i < Properties.Length; i++)
			{
				if (!Properties[i].IsPublic)
				{
					return false;
				}
			}
			if (!HasDefaultConstructor)
			{
				return false;
			}
			fsAotCompilationManager.AddAotCompilation(ReflectedType, Properties, _isDefaultConstructorPublic);
			return true;
		}
		return false;
	}

	public object CreateInstance()
	{
		if (ReflectedType.Resolve().IsInterface || ReflectedType.Resolve().IsAbstract)
		{
			throw new Exception("Cannot create an instance of an interface or abstract type for " + ReflectedType);
		}
		if (typeof(ScriptableObject).IsAssignableFrom(ReflectedType))
		{
			return ScriptableObject.CreateInstance(ReflectedType);
		}
		if (typeof(string) == ReflectedType)
		{
			return string.Empty;
		}
		if (!HasDefaultConstructor)
		{
			return FormatterServices.GetSafeUninitializedObject(ReflectedType);
		}
		if (ReflectedType.Resolve().IsArray)
		{
			return Array.CreateInstance(ReflectedType.GetElementType(), 0);
		}
		try
		{
			if (Generator != null)
			{
				return Generator();
			}
			return Activator.CreateInstance(ReflectedType, nonPublic: true);
		}
		catch (MissingMethodException innerException)
		{
			throw new InvalidOperationException("Unable to create instance of " + ReflectedType?.ToString() + "; there is no default constructor", innerException);
		}
		catch (TargetInvocationException innerException2)
		{
			throw new InvalidOperationException("Constructor of " + ReflectedType?.ToString() + " threw an exception when creating an instance", innerException2);
		}
		catch (MemberAccessException innerException3)
		{
			throw new InvalidOperationException("Unable to access constructor of " + ReflectedType, innerException3);
		}
	}
}
