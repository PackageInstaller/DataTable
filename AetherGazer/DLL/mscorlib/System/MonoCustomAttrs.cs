using System.Collections.Generic;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System;

internal static class MonoCustomAttrs
{
	private class AttributeInfo
	{
		private AttributeUsageAttribute _usage;

		private int _inheritanceLevel;

		public AttributeUsageAttribute Usage => _usage;

		public int InheritanceLevel => _inheritanceLevel;

		public AttributeInfo(AttributeUsageAttribute usage, int inheritanceLevel)
		{
			_usage = usage;
			_inheritanceLevel = inheritanceLevel;
		}
	}

	private static Assembly corlib;

	[ThreadStatic]
	private static Dictionary<Type, AttributeUsageAttribute> usage_cache;

	private static readonly AttributeUsageAttribute DefaultAttributeUsage = new AttributeUsageAttribute(AttributeTargets.All);

	private static bool IsUserCattrProvider(object obj)
	{
		if ((obj as Type) is RuntimeType)
		{
			return false;
		}
		if (obj is Type)
		{
			return true;
		}
		if (corlib == null)
		{
			corlib = typeof(int).Assembly;
		}
		return obj.GetType().Assembly != corlib;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern Attribute[] GetCustomAttributesInternal(ICustomAttributeProvider obj, Type attributeType, bool pseudoAttrs);

	internal static object[] GetPseudoCustomAttributes(ICustomAttributeProvider obj, Type attributeType)
	{
		object[] array = null;
		if (obj is RuntimeMethodInfo runtimeMethodInfo)
		{
			array = runtimeMethodInfo.GetPseudoCustomAttributes();
		}
		else if (obj is RuntimeFieldInfo runtimeFieldInfo)
		{
			array = runtimeFieldInfo.GetPseudoCustomAttributes();
		}
		else if (obj is RuntimeParameterInfo runtimeParameterInfo)
		{
			array = runtimeParameterInfo.GetPseudoCustomAttributes();
		}
		else if (obj is Type type)
		{
			array = GetPseudoCustomAttributes(type);
		}
		if (attributeType != null && array != null)
		{
			for (int i = 0; i < array.Length; i++)
			{
				if (attributeType.IsAssignableFrom(array[i].GetType()))
				{
					if (array.Length == 1)
					{
						return array;
					}
					return new object[1] { array[i] };
				}
			}
			return Array.Empty<object>();
		}
		return array;
	}

	private static object[] GetPseudoCustomAttributes(Type type)
	{
		int num = 0;
		TypeAttributes attributes = type.Attributes;
		if ((attributes & TypeAttributes.Serializable) != TypeAttributes.NotPublic)
		{
			num++;
		}
		if ((attributes & TypeAttributes.Import) != TypeAttributes.NotPublic)
		{
			num++;
		}
		if (num == 0)
		{
			return null;
		}
		object[] array = new object[num];
		num = 0;
		if ((attributes & TypeAttributes.Serializable) != TypeAttributes.NotPublic)
		{
			array[num++] = new SerializableAttribute();
		}
		if ((attributes & TypeAttributes.Import) != TypeAttributes.NotPublic)
		{
			array[num++] = new ComImportAttribute();
		}
		return array;
	}

	internal static object[] GetCustomAttributesBase(ICustomAttributeProvider obj, Type attributeType, bool inheritedOnly)
	{
		object[] array;
		if (IsUserCattrProvider(obj))
		{
			array = obj.GetCustomAttributes(attributeType, inherit: true);
		}
		else
		{
			object[] customAttributesInternal = GetCustomAttributesInternal(obj, attributeType, pseudoAttrs: false);
			array = customAttributesInternal;
		}
		if (!inheritedOnly)
		{
			object[] pseudoCustomAttributes = GetPseudoCustomAttributes(obj, attributeType);
			if (pseudoCustomAttributes != null)
			{
				object[] customAttributesInternal = new Attribute[array.Length + pseudoCustomAttributes.Length];
				object[] array2 = customAttributesInternal;
				Array.Copy(array, array2, array.Length);
				Array.Copy(pseudoCustomAttributes, 0, array2, array.Length, pseudoCustomAttributes.Length);
				return array2;
			}
		}
		return array;
	}

	internal static object[] GetCustomAttributes(ICustomAttributeProvider obj, Type attributeType, bool inherit)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		if (attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		if (attributeType == typeof(MonoCustomAttrs))
		{
			attributeType = null;
		}
		object[] customAttributesBase = GetCustomAttributesBase(obj, attributeType, inheritedOnly: false);
		if (!inherit && customAttributesBase.Length == 1)
		{
			if (customAttributesBase[0] == null)
			{
				throw new CustomAttributeFormatException("Invalid custom attribute format");
			}
			object[] array;
			if (attributeType != null)
			{
				if (attributeType.IsAssignableFrom(customAttributesBase[0].GetType()))
				{
					array = (object[])Array.CreateInstance(attributeType, 1);
					array[0] = customAttributesBase[0];
				}
				else
				{
					array = (object[])Array.CreateInstance(attributeType, 0);
				}
			}
			else
			{
				array = (object[])Array.CreateInstance(customAttributesBase[0].GetType(), 1);
				array[0] = customAttributesBase[0];
			}
			return array;
		}
		if (inherit && GetBase(obj) == null)
		{
			inherit = false;
		}
		if (((attributeType != null && attributeType.IsSealed) & inherit) && !RetrieveAttributeUsage(attributeType).Inherited)
		{
			inherit = false;
		}
		int capacity = Math.Max(customAttributesBase.Length, 16);
		List<object> list = null;
		ICustomAttributeProvider customAttributeProvider = obj;
		object[] array4;
		if (!inherit)
		{
			object[] array2;
			if (attributeType == null)
			{
				array2 = customAttributesBase;
				for (int i = 0; i < array2.Length; i++)
				{
					if (array2[i] == null)
					{
						throw new CustomAttributeFormatException("Invalid custom attribute format");
					}
				}
				Attribute[] array3 = new Attribute[customAttributesBase.Length];
				customAttributesBase.CopyTo(array3, 0);
				return array3;
			}
			list = new List<object>(capacity);
			array2 = customAttributesBase;
			foreach (object obj2 in array2)
			{
				if (obj2 == null)
				{
					throw new CustomAttributeFormatException("Invalid custom attribute format");
				}
				Type type = obj2.GetType();
				if (!(attributeType != null) || attributeType.IsAssignableFrom(type))
				{
					list.Add(obj2);
				}
			}
			if (attributeType == null || attributeType.IsValueType)
			{
				array2 = new Attribute[list.Count];
				array4 = array2;
			}
			else
			{
				array4 = Array.CreateInstance(attributeType, list.Count) as object[];
			}
			list.CopyTo(array4, 0);
			return array4;
		}
		Dictionary<Type, AttributeInfo> dictionary = new Dictionary<Type, AttributeInfo>(capacity);
		int num = 0;
		list = new List<object>(capacity);
		do
		{
			object[] array2 = customAttributesBase;
			foreach (object obj3 in array2)
			{
				if (obj3 == null)
				{
					throw new CustomAttributeFormatException("Invalid custom attribute format");
				}
				Type type2 = obj3.GetType();
				if (!(attributeType != null) || attributeType.IsAssignableFrom(type2))
				{
					AttributeUsageAttribute attributeUsageAttribute = ((!dictionary.TryGetValue(type2, out var value)) ? RetrieveAttributeUsage(type2) : value.Usage);
					if ((num == 0 || attributeUsageAttribute.Inherited) && (attributeUsageAttribute.AllowMultiple || value == null || (value != null && value.InheritanceLevel == num)))
					{
						list.Add(obj3);
					}
					if (value == null)
					{
						dictionary.Add(type2, new AttributeInfo(attributeUsageAttribute, num));
					}
				}
			}
			if ((customAttributeProvider = GetBase(customAttributeProvider)) != null)
			{
				num++;
				customAttributesBase = GetCustomAttributesBase(customAttributeProvider, attributeType, inheritedOnly: true);
			}
		}
		while (inherit && customAttributeProvider != null);
		if (attributeType == null || attributeType.IsValueType)
		{
			object[] array2 = new Attribute[list.Count];
			array4 = array2;
		}
		else
		{
			array4 = Array.CreateInstance(attributeType, list.Count) as object[];
		}
		list.CopyTo(array4, 0);
		return array4;
	}

	internal static object[] GetCustomAttributes(ICustomAttributeProvider obj, bool inherit)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		if (!inherit)
		{
			return (object[])GetCustomAttributesBase(obj, null, inheritedOnly: false).Clone();
		}
		return GetCustomAttributes(obj, typeof(MonoCustomAttrs), inherit);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern CustomAttributeData[] GetCustomAttributesDataInternal(ICustomAttributeProvider obj);

	internal static IList<CustomAttributeData> GetCustomAttributesData(ICustomAttributeProvider obj, bool inherit = false)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		if (!inherit)
		{
			return GetCustomAttributesDataBase(obj, null, inheritedOnly: false);
		}
		return GetCustomAttributesData(obj, typeof(MonoCustomAttrs), inherit);
	}

	internal static IList<CustomAttributeData> GetCustomAttributesData(ICustomAttributeProvider obj, Type attributeType, bool inherit)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		if (attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		if (attributeType == typeof(MonoCustomAttrs))
		{
			attributeType = null;
		}
		IList<CustomAttributeData> customAttributesDataBase = GetCustomAttributesDataBase(obj, attributeType, inheritedOnly: false);
		if (!inherit && customAttributesDataBase.Count == 1)
		{
			if (customAttributesDataBase[0] == null)
			{
				throw new CustomAttributeFormatException("Invalid custom attribute data format");
			}
			if (attributeType != null)
			{
				if (attributeType.IsAssignableFrom(customAttributesDataBase[0].AttributeType))
				{
					return new CustomAttributeData[1] { customAttributesDataBase[0] };
				}
				return Array.Empty<CustomAttributeData>();
			}
			return new CustomAttributeData[1] { customAttributesDataBase[0] };
		}
		if (inherit && GetBase(obj) == null)
		{
			inherit = false;
		}
		if (((attributeType != null && attributeType.IsSealed) & inherit) && !RetrieveAttributeUsage(attributeType).Inherited)
		{
			inherit = false;
		}
		int capacity = Math.Max(customAttributesDataBase.Count, 16);
		List<CustomAttributeData> list = null;
		ICustomAttributeProvider customAttributeProvider = obj;
		if (!inherit)
		{
			if (attributeType == null)
			{
				foreach (CustomAttributeData item in customAttributesDataBase)
				{
					if (item == null)
					{
						throw new CustomAttributeFormatException("Invalid custom attribute data format");
					}
				}
				CustomAttributeData[] array = new CustomAttributeData[customAttributesDataBase.Count];
				customAttributesDataBase.CopyTo(array, 0);
				return array;
			}
			list = new List<CustomAttributeData>(capacity);
			foreach (CustomAttributeData item2 in customAttributesDataBase)
			{
				if (item2 == null)
				{
					throw new CustomAttributeFormatException("Invalid custom attribute data format");
				}
				if (attributeType.IsAssignableFrom(item2.AttributeType))
				{
					list.Add(item2);
				}
			}
			return list.ToArray();
		}
		Dictionary<Type, AttributeInfo> dictionary = new Dictionary<Type, AttributeInfo>(capacity);
		int num = 0;
		list = new List<CustomAttributeData>(capacity);
		do
		{
			foreach (CustomAttributeData item3 in customAttributesDataBase)
			{
				if (item3 == null)
				{
					throw new CustomAttributeFormatException("Invalid custom attribute data format");
				}
				Type attributeType2 = item3.AttributeType;
				if (!(attributeType != null) || attributeType.IsAssignableFrom(attributeType2))
				{
					AttributeUsageAttribute attributeUsageAttribute = ((!dictionary.TryGetValue(attributeType2, out var value)) ? RetrieveAttributeUsage(attributeType2) : value.Usage);
					if ((num == 0 || attributeUsageAttribute.Inherited) && (attributeUsageAttribute.AllowMultiple || value == null || (value != null && value.InheritanceLevel == num)))
					{
						list.Add(item3);
					}
					if (value == null)
					{
						dictionary.Add(attributeType2, new AttributeInfo(attributeUsageAttribute, num));
					}
				}
			}
			if ((customAttributeProvider = GetBase(customAttributeProvider)) != null)
			{
				num++;
				customAttributesDataBase = GetCustomAttributesDataBase(customAttributeProvider, attributeType, inheritedOnly: true);
			}
		}
		while (inherit && customAttributeProvider != null);
		return list.ToArray();
	}

	internal static IList<CustomAttributeData> GetCustomAttributesDataBase(ICustomAttributeProvider obj, Type attributeType, bool inheritedOnly)
	{
		CustomAttributeData[] array = ((!IsUserCattrProvider(obj)) ? GetCustomAttributesDataInternal(obj) : Array.Empty<CustomAttributeData>());
		if (!inheritedOnly)
		{
			CustomAttributeData[] pseudoCustomAttributesData = GetPseudoCustomAttributesData(obj, attributeType);
			if (pseudoCustomAttributesData != null)
			{
				if (array.Length == 0)
				{
					return Array.AsReadOnly(pseudoCustomAttributesData);
				}
				CustomAttributeData[] array2 = new CustomAttributeData[array.Length + pseudoCustomAttributesData.Length];
				Array.Copy(array, array2, array.Length);
				Array.Copy(pseudoCustomAttributesData, 0, array2, array.Length, pseudoCustomAttributesData.Length);
				return Array.AsReadOnly(array2);
			}
		}
		return Array.AsReadOnly(array);
	}

	internal static CustomAttributeData[] GetPseudoCustomAttributesData(ICustomAttributeProvider obj, Type attributeType)
	{
		CustomAttributeData[] array = null;
		if (obj is RuntimeMethodInfo runtimeMethodInfo)
		{
			array = runtimeMethodInfo.GetPseudoCustomAttributesData();
		}
		else if (obj is RuntimeFieldInfo runtimeFieldInfo)
		{
			array = runtimeFieldInfo.GetPseudoCustomAttributesData();
		}
		else if (obj is RuntimeParameterInfo runtimeParameterInfo)
		{
			array = runtimeParameterInfo.GetPseudoCustomAttributesData();
		}
		else if (obj is Type type)
		{
			array = GetPseudoCustomAttributesData(type);
		}
		if (attributeType != null && array != null)
		{
			for (int i = 0; i < array.Length; i++)
			{
				if (attributeType.IsAssignableFrom(array[i].AttributeType))
				{
					if (array.Length == 1)
					{
						return array;
					}
					return new CustomAttributeData[1] { array[i] };
				}
			}
			return Array.Empty<CustomAttributeData>();
		}
		return array;
	}

	private static CustomAttributeData[] GetPseudoCustomAttributesData(Type type)
	{
		int num = 0;
		TypeAttributes attributes = type.Attributes;
		if ((attributes & TypeAttributes.Serializable) != TypeAttributes.NotPublic)
		{
			num++;
		}
		if ((attributes & TypeAttributes.Import) != TypeAttributes.NotPublic)
		{
			num++;
		}
		if (num == 0)
		{
			return null;
		}
		CustomAttributeData[] array = new CustomAttributeData[num];
		num = 0;
		if ((attributes & TypeAttributes.Serializable) != TypeAttributes.NotPublic)
		{
			array[num++] = new CustomAttributeData(typeof(SerializableAttribute).GetConstructor(Type.EmptyTypes));
		}
		if ((attributes & TypeAttributes.Import) != TypeAttributes.NotPublic)
		{
			array[num++] = new CustomAttributeData(typeof(ComImportAttribute).GetConstructor(Type.EmptyTypes));
		}
		return array;
	}

	internal static bool IsDefined(ICustomAttributeProvider obj, Type attributeType, bool inherit)
	{
		if (attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		AttributeUsageAttribute attributeUsageAttribute = null;
		do
		{
			if (IsUserCattrProvider(obj))
			{
				return obj.IsDefined(attributeType, inherit);
			}
			if (IsDefinedInternal(obj, attributeType))
			{
				return true;
			}
			object[] pseudoCustomAttributes = GetPseudoCustomAttributes(obj, attributeType);
			if (pseudoCustomAttributes != null)
			{
				for (int i = 0; i < pseudoCustomAttributes.Length; i++)
				{
					if (attributeType.IsAssignableFrom(pseudoCustomAttributes[i].GetType()))
					{
						return true;
					}
				}
			}
			if (attributeUsageAttribute == null)
			{
				if (!inherit)
				{
					return false;
				}
				attributeUsageAttribute = RetrieveAttributeUsage(attributeType);
				if (!attributeUsageAttribute.Inherited)
				{
					return false;
				}
			}
			obj = GetBase(obj);
		}
		while (obj != null);
		return false;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool IsDefinedInternal(ICustomAttributeProvider obj, Type AttributeType);

	private static PropertyInfo GetBasePropertyDefinition(RuntimePropertyInfo property)
	{
		MethodInfo methodInfo = property.GetGetMethod(nonPublic: true);
		if (methodInfo == null || !methodInfo.IsVirtual)
		{
			methodInfo = property.GetSetMethod(nonPublic: true);
		}
		if (methodInfo == null || !methodInfo.IsVirtual)
		{
			return null;
		}
		MethodInfo baseMethod = ((RuntimeMethodInfo)methodInfo).GetBaseMethod();
		if (baseMethod != null && baseMethod != methodInfo)
		{
			ParameterInfo[] indexParameters = property.GetIndexParameters();
			if (indexParameters != null && indexParameters.Length != 0)
			{
				Type[] array = new Type[indexParameters.Length];
				for (int i = 0; i < array.Length; i++)
				{
					array[i] = indexParameters[i].ParameterType;
				}
				return baseMethod.DeclaringType.GetProperty(property.Name, property.PropertyType, array);
			}
			return baseMethod.DeclaringType.GetProperty(property.Name, property.PropertyType);
		}
		return null;
	}

	private static EventInfo GetBaseEventDefinition(RuntimeEventInfo evt)
	{
		MethodInfo methodInfo = evt.GetAddMethod(nonPublic: true);
		if (methodInfo == null || !methodInfo.IsVirtual)
		{
			methodInfo = evt.GetRaiseMethod(nonPublic: true);
		}
		if (methodInfo == null || !methodInfo.IsVirtual)
		{
			methodInfo = evt.GetRemoveMethod(nonPublic: true);
		}
		if (methodInfo == null || !methodInfo.IsVirtual)
		{
			return null;
		}
		MethodInfo baseMethod = ((RuntimeMethodInfo)methodInfo).GetBaseMethod();
		if (baseMethod != null && baseMethod != methodInfo)
		{
			BindingFlags bindingFlags = (methodInfo.IsPublic ? BindingFlags.Public : BindingFlags.NonPublic);
			bindingFlags = (BindingFlags)((int)bindingFlags | (methodInfo.IsStatic ? 8 : 4));
			return baseMethod.DeclaringType.GetEvent(evt.Name, bindingFlags);
		}
		return null;
	}

	private static ICustomAttributeProvider GetBase(ICustomAttributeProvider obj)
	{
		if (obj == null)
		{
			return null;
		}
		if (obj is Type)
		{
			return ((Type)obj).BaseType;
		}
		MethodInfo methodInfo = null;
		if (obj is RuntimePropertyInfo)
		{
			return GetBasePropertyDefinition((RuntimePropertyInfo)obj);
		}
		if (obj is RuntimeEventInfo)
		{
			return GetBaseEventDefinition((RuntimeEventInfo)obj);
		}
		if (obj is RuntimeMethodInfo)
		{
			methodInfo = (MethodInfo)obj;
		}
		if (obj is RuntimeParameterInfo { Member: var member } runtimeParameterInfo && member is MethodInfo)
		{
			methodInfo = (MethodInfo)member;
			MethodInfo baseMethod = ((RuntimeMethodInfo)methodInfo).GetBaseMethod();
			if (baseMethod == methodInfo)
			{
				return null;
			}
			return baseMethod.GetParameters()[runtimeParameterInfo.Position];
		}
		if (methodInfo == null || !methodInfo.IsVirtual)
		{
			return null;
		}
		MethodInfo baseMethod2 = ((RuntimeMethodInfo)methodInfo).GetBaseMethod();
		if (baseMethod2 == methodInfo)
		{
			return null;
		}
		return baseMethod2;
	}

	private static AttributeUsageAttribute RetrieveAttributeUsageNoCache(Type attributeType)
	{
		if (attributeType == typeof(AttributeUsageAttribute))
		{
			return new AttributeUsageAttribute(AttributeTargets.Class);
		}
		AttributeUsageAttribute attributeUsageAttribute = null;
		object[] customAttributes = GetCustomAttributes(attributeType, typeof(AttributeUsageAttribute), inherit: false);
		if (customAttributes.Length == 0)
		{
			if (attributeType.BaseType != null)
			{
				attributeUsageAttribute = RetrieveAttributeUsage(attributeType.BaseType);
			}
			if (attributeUsageAttribute != null)
			{
				return attributeUsageAttribute;
			}
			return DefaultAttributeUsage;
		}
		if (customAttributes.Length > 1)
		{
			throw new FormatException("Duplicate AttributeUsageAttribute cannot be specified on an attribute type.");
		}
		return (AttributeUsageAttribute)customAttributes[0];
	}

	private static AttributeUsageAttribute RetrieveAttributeUsage(Type attributeType)
	{
		AttributeUsageAttribute value = null;
		if (usage_cache == null)
		{
			usage_cache = new Dictionary<Type, AttributeUsageAttribute>();
		}
		if (usage_cache.TryGetValue(attributeType, out value))
		{
			return value;
		}
		value = RetrieveAttributeUsageNoCache(attributeType);
		usage_cache[attributeType] = value;
		return value;
	}
}
