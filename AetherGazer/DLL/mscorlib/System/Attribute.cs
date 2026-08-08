using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using Unity;

namespace System;

[Serializable]
[AttributeUsage(AttributeTargets.All, Inherited = true, AllowMultiple = false)]
public abstract class Attribute : _Attribute
{
	public virtual object TypeId => GetType();

	private static Attribute[] InternalGetCustomAttributes(PropertyInfo element, Type type, bool inherit)
	{
		return (Attribute[])MonoCustomAttrs.GetCustomAttributes(element, type, inherit);
	}

	private static Attribute[] InternalGetCustomAttributes(EventInfo element, Type type, bool inherit)
	{
		return (Attribute[])MonoCustomAttrs.GetCustomAttributes(element, type, inherit);
	}

	private static Attribute[] InternalParamGetCustomAttributes(ParameterInfo parameter, Type attributeType, bool inherit)
	{
		if (parameter.Member.MemberType != MemberTypes.Method)
		{
			return null;
		}
		MethodInfo methodInfo = (MethodInfo)parameter.Member;
		MethodInfo baseDefinition = methodInfo.GetBaseDefinition();
		if (attributeType == null)
		{
			attributeType = typeof(Attribute);
		}
		if (methodInfo == baseDefinition)
		{
			return (Attribute[])parameter.GetCustomAttributes(attributeType, inherit);
		}
		List<Type> list = new List<Type>();
		List<Attribute> list2 = new List<Attribute>();
		while (true)
		{
			Attribute[] array = (Attribute[])methodInfo.GetParametersInternal()[parameter.Position].GetCustomAttributes(attributeType, inherit: false);
			foreach (Attribute attribute in array)
			{
				Type type = attribute.GetType();
				if (!list.Contains(type))
				{
					list.Add(type);
					list2.Add(attribute);
				}
			}
			MethodInfo baseMethod = ((RuntimeMethodInfo)methodInfo).GetBaseMethod();
			if (baseMethod == methodInfo)
			{
				break;
			}
			methodInfo = baseMethod;
		}
		Attribute[] array2 = (Attribute[])Array.CreateInstance(attributeType, list2.Count);
		list2.CopyTo(array2, 0);
		return array2;
	}

	private static bool InternalIsDefined(PropertyInfo element, Type attributeType, bool inherit)
	{
		return MonoCustomAttrs.IsDefined(element, attributeType, inherit);
	}

	private static bool InternalIsDefined(EventInfo element, Type attributeType, bool inherit)
	{
		return MonoCustomAttrs.IsDefined(element, attributeType, inherit);
	}

	private static bool InternalParamIsDefined(ParameterInfo parameter, Type attributeType, bool inherit)
	{
		if (parameter.IsDefined(attributeType, inherit))
		{
			return true;
		}
		if (!inherit)
		{
			return false;
		}
		MemberInfo member = parameter.Member;
		if (member.MemberType != MemberTypes.Method)
		{
			return false;
		}
		MethodInfo methodInfo = ((RuntimeMethodInfo)(MethodInfo)member).GetBaseMethod();
		while (true)
		{
			ParameterInfo[] parametersInternal = methodInfo.GetParametersInternal();
			if ((parametersInternal != null && parametersInternal.Length == 0) || parameter.Position < 0)
			{
				return false;
			}
			if (parametersInternal[parameter.Position].IsDefined(attributeType, inherit: false))
			{
				return true;
			}
			MethodInfo baseMethod = ((RuntimeMethodInfo)methodInfo).GetBaseMethod();
			if (baseMethod == methodInfo)
			{
				break;
			}
			methodInfo = baseMethod;
		}
		return false;
	}

	public static Attribute[] GetCustomAttributes(MemberInfo element, Type type)
	{
		return GetCustomAttributes(element, type, inherit: true);
	}

	public static Attribute[] GetCustomAttributes(MemberInfo element, Type type, bool inherit)
	{
		if (element == null)
		{
			throw new ArgumentNullException("element");
		}
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (!type.IsSubclassOf(typeof(Attribute)) && type != typeof(Attribute))
		{
			throw new ArgumentException(Environment.GetResourceString("Type passed in must be derived from System.Attribute or System.Attribute itself."));
		}
		return element.MemberType switch
		{
			MemberTypes.Property => InternalGetCustomAttributes((PropertyInfo)element, type, inherit), 
			MemberTypes.Event => InternalGetCustomAttributes((EventInfo)element, type, inherit), 
			_ => element.GetCustomAttributes(type, inherit) as Attribute[], 
		};
	}

	public static Attribute[] GetCustomAttributes(MemberInfo element)
	{
		return GetCustomAttributes(element, inherit: true);
	}

	public static Attribute[] GetCustomAttributes(MemberInfo element, bool inherit)
	{
		if (element == null)
		{
			throw new ArgumentNullException("element");
		}
		return element.MemberType switch
		{
			MemberTypes.Property => InternalGetCustomAttributes((PropertyInfo)element, typeof(Attribute), inherit), 
			MemberTypes.Event => InternalGetCustomAttributes((EventInfo)element, typeof(Attribute), inherit), 
			_ => element.GetCustomAttributes(typeof(Attribute), inherit) as Attribute[], 
		};
	}

	public static bool IsDefined(MemberInfo element, Type attributeType)
	{
		return IsDefined(element, attributeType, inherit: true);
	}

	public static bool IsDefined(MemberInfo element, Type attributeType, bool inherit)
	{
		if (element == null)
		{
			throw new ArgumentNullException("element");
		}
		if (attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		if (!attributeType.IsSubclassOf(typeof(Attribute)) && attributeType != typeof(Attribute))
		{
			throw new ArgumentException(Environment.GetResourceString("Type passed in must be derived from System.Attribute or System.Attribute itself."));
		}
		return element.MemberType switch
		{
			MemberTypes.Property => InternalIsDefined((PropertyInfo)element, attributeType, inherit), 
			MemberTypes.Event => InternalIsDefined((EventInfo)element, attributeType, inherit), 
			_ => element.IsDefined(attributeType, inherit), 
		};
	}

	public static Attribute GetCustomAttribute(MemberInfo element, Type attributeType)
	{
		return GetCustomAttribute(element, attributeType, inherit: true);
	}

	public static Attribute GetCustomAttribute(MemberInfo element, Type attributeType, bool inherit)
	{
		Attribute[] customAttributes = GetCustomAttributes(element, attributeType, inherit);
		if (customAttributes == null || customAttributes.Length == 0)
		{
			return null;
		}
		if (customAttributes.Length == 1)
		{
			return customAttributes[0];
		}
		throw new AmbiguousMatchException(Environment.GetResourceString("Multiple custom attributes of the same type found."));
	}

	public static Attribute[] GetCustomAttributes(ParameterInfo element)
	{
		return GetCustomAttributes(element, inherit: true);
	}

	public static Attribute[] GetCustomAttributes(ParameterInfo element, Type attributeType)
	{
		return GetCustomAttributes(element, attributeType, inherit: true);
	}

	public static Attribute[] GetCustomAttributes(ParameterInfo element, Type attributeType, bool inherit)
	{
		if (element == null)
		{
			throw new ArgumentNullException("element");
		}
		if (attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		if (!attributeType.IsSubclassOf(typeof(Attribute)) && attributeType != typeof(Attribute))
		{
			throw new ArgumentException(Environment.GetResourceString("Type passed in must be derived from System.Attribute or System.Attribute itself."));
		}
		if (element.Member == null)
		{
			throw new ArgumentException(Environment.GetResourceString("The ParameterInfo object is not valid."), "element");
		}
		if ((element.Member.MemberType == MemberTypes.Method) & inherit)
		{
			return InternalParamGetCustomAttributes(element, attributeType, inherit);
		}
		return element.GetCustomAttributes(attributeType, inherit) as Attribute[];
	}

	public static Attribute[] GetCustomAttributes(ParameterInfo element, bool inherit)
	{
		if (element == null)
		{
			throw new ArgumentNullException("element");
		}
		if (element.Member == null)
		{
			throw new ArgumentException(Environment.GetResourceString("The ParameterInfo object is not valid."), "element");
		}
		if ((element.Member.MemberType == MemberTypes.Method) & inherit)
		{
			return InternalParamGetCustomAttributes(element, null, inherit);
		}
		return element.GetCustomAttributes(typeof(Attribute), inherit) as Attribute[];
	}

	public static bool IsDefined(ParameterInfo element, Type attributeType)
	{
		return IsDefined(element, attributeType, inherit: true);
	}

	public static bool IsDefined(ParameterInfo element, Type attributeType, bool inherit)
	{
		if (element == null)
		{
			throw new ArgumentNullException("element");
		}
		if (attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		if (!attributeType.IsSubclassOf(typeof(Attribute)) && attributeType != typeof(Attribute))
		{
			throw new ArgumentException(Environment.GetResourceString("Type passed in must be derived from System.Attribute or System.Attribute itself."));
		}
		return element.Member.MemberType switch
		{
			MemberTypes.Method => InternalParamIsDefined(element, attributeType, inherit), 
			MemberTypes.Constructor => element.IsDefined(attributeType, inherit: false), 
			MemberTypes.Property => element.IsDefined(attributeType, inherit: false), 
			_ => throw new ArgumentException(Environment.GetResourceString("Invalid type for ParameterInfo member in Attribute class.")), 
		};
	}

	public static Attribute GetCustomAttribute(ParameterInfo element, Type attributeType)
	{
		return GetCustomAttribute(element, attributeType, inherit: true);
	}

	public static Attribute GetCustomAttribute(ParameterInfo element, Type attributeType, bool inherit)
	{
		Attribute[] customAttributes = GetCustomAttributes(element, attributeType, inherit);
		if (customAttributes == null || customAttributes.Length == 0)
		{
			return null;
		}
		if (customAttributes.Length == 0)
		{
			return null;
		}
		if (customAttributes.Length == 1)
		{
			return customAttributes[0];
		}
		throw new AmbiguousMatchException(Environment.GetResourceString("Multiple custom attributes of the same type found."));
	}

	public static Attribute[] GetCustomAttributes(Module element, Type attributeType)
	{
		return GetCustomAttributes(element, attributeType, inherit: true);
	}

	public static Attribute[] GetCustomAttributes(Module element)
	{
		return GetCustomAttributes(element, inherit: true);
	}

	public static Attribute[] GetCustomAttributes(Module element, bool inherit)
	{
		if (element == null)
		{
			throw new ArgumentNullException("element");
		}
		return (Attribute[])element.GetCustomAttributes(typeof(Attribute), inherit);
	}

	public static Attribute[] GetCustomAttributes(Module element, Type attributeType, bool inherit)
	{
		if (element == null)
		{
			throw new ArgumentNullException("element");
		}
		if (attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		if (!attributeType.IsSubclassOf(typeof(Attribute)) && attributeType != typeof(Attribute))
		{
			throw new ArgumentException(Environment.GetResourceString("Type passed in must be derived from System.Attribute or System.Attribute itself."));
		}
		return (Attribute[])element.GetCustomAttributes(attributeType, inherit);
	}

	public static bool IsDefined(Module element, Type attributeType)
	{
		return IsDefined(element, attributeType, inherit: false);
	}

	public static bool IsDefined(Module element, Type attributeType, bool inherit)
	{
		if (element == null)
		{
			throw new ArgumentNullException("element");
		}
		if (attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		if (!attributeType.IsSubclassOf(typeof(Attribute)) && attributeType != typeof(Attribute))
		{
			throw new ArgumentException(Environment.GetResourceString("Type passed in must be derived from System.Attribute or System.Attribute itself."));
		}
		return element.IsDefined(attributeType, inherit: false);
	}

	public static Attribute GetCustomAttribute(Module element, Type attributeType)
	{
		return GetCustomAttribute(element, attributeType, inherit: true);
	}

	public static Attribute GetCustomAttribute(Module element, Type attributeType, bool inherit)
	{
		Attribute[] customAttributes = GetCustomAttributes(element, attributeType, inherit);
		if (customAttributes == null || customAttributes.Length == 0)
		{
			return null;
		}
		if (customAttributes.Length == 1)
		{
			return customAttributes[0];
		}
		throw new AmbiguousMatchException(Environment.GetResourceString("Multiple custom attributes of the same type found."));
	}

	public static Attribute[] GetCustomAttributes(Assembly element, Type attributeType)
	{
		return GetCustomAttributes(element, attributeType, inherit: true);
	}

	public static Attribute[] GetCustomAttributes(Assembly element, Type attributeType, bool inherit)
	{
		if (element == null)
		{
			throw new ArgumentNullException("element");
		}
		if (attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		if (!attributeType.IsSubclassOf(typeof(Attribute)) && attributeType != typeof(Attribute))
		{
			throw new ArgumentException(Environment.GetResourceString("Type passed in must be derived from System.Attribute or System.Attribute itself."));
		}
		return (Attribute[])element.GetCustomAttributes(attributeType, inherit);
	}

	public static Attribute[] GetCustomAttributes(Assembly element)
	{
		return GetCustomAttributes(element, inherit: true);
	}

	public static Attribute[] GetCustomAttributes(Assembly element, bool inherit)
	{
		if (element == null)
		{
			throw new ArgumentNullException("element");
		}
		return (Attribute[])element.GetCustomAttributes(typeof(Attribute), inherit);
	}

	public static bool IsDefined(Assembly element, Type attributeType)
	{
		return IsDefined(element, attributeType, inherit: true);
	}

	public static bool IsDefined(Assembly element, Type attributeType, bool inherit)
	{
		if (element == null)
		{
			throw new ArgumentNullException("element");
		}
		if (attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		if (!attributeType.IsSubclassOf(typeof(Attribute)) && attributeType != typeof(Attribute))
		{
			throw new ArgumentException(Environment.GetResourceString("Type passed in must be derived from System.Attribute or System.Attribute itself."));
		}
		return element.IsDefined(attributeType, inherit: false);
	}

	public static Attribute GetCustomAttribute(Assembly element, Type attributeType)
	{
		return GetCustomAttribute(element, attributeType, inherit: true);
	}

	public static Attribute GetCustomAttribute(Assembly element, Type attributeType, bool inherit)
	{
		Attribute[] customAttributes = GetCustomAttributes(element, attributeType, inherit);
		if (customAttributes == null || customAttributes.Length == 0)
		{
			return null;
		}
		if (customAttributes.Length == 1)
		{
			return customAttributes[0];
		}
		throw new AmbiguousMatchException(Environment.GetResourceString("Multiple custom attributes of the same type found."));
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		RuntimeType runtimeType = (RuntimeType)GetType();
		if ((RuntimeType)obj.GetType() != runtimeType)
		{
			return false;
		}
		FieldInfo[] fields = runtimeType.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		for (int i = 0; i < fields.Length; i++)
		{
			object thisValue = ((RtFieldInfo)fields[i]).UnsafeGetValue(this);
			object thatValue = ((RtFieldInfo)fields[i]).UnsafeGetValue(obj);
			if (!AreFieldValuesEqual(thisValue, thatValue))
			{
				return false;
			}
		}
		return true;
	}

	private static bool AreFieldValuesEqual(object thisValue, object thatValue)
	{
		if (thisValue == null && thatValue == null)
		{
			return true;
		}
		if (thisValue == null || thatValue == null)
		{
			return false;
		}
		if (thisValue.GetType().IsArray)
		{
			if (!thisValue.GetType().Equals(thatValue.GetType()))
			{
				return false;
			}
			Array array = thisValue as Array;
			Array array2 = thatValue as Array;
			if (array.Length != array2.Length)
			{
				return false;
			}
			for (int i = 0; i < array.Length; i++)
			{
				if (!AreFieldValuesEqual(array.GetValue(i), array2.GetValue(i)))
				{
					return false;
				}
			}
		}
		else if (!thisValue.Equals(thatValue))
		{
			return false;
		}
		return true;
	}

	public override int GetHashCode()
	{
		Type type = GetType();
		FieldInfo[] fields = type.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		object obj = null;
		for (int i = 0; i < fields.Length; i++)
		{
			object obj2 = ((RtFieldInfo)fields[i]).UnsafeGetValue(this);
			if (obj2 != null && !obj2.GetType().IsArray)
			{
				obj = obj2;
			}
			if (obj != null)
			{
				break;
			}
		}
		return obj?.GetHashCode() ?? type.GetHashCode();
	}

	public virtual bool Match(object obj)
	{
		return Equals(obj);
	}

	public virtual bool IsDefaultAttribute()
	{
		return false;
	}

	void _Attribute.GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _Attribute.GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _Attribute.GetTypeInfoCount(out uint pcTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _Attribute.Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr)
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
