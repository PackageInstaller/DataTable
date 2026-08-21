using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;

namespace GameFramework.Runtime;

public class ProxyType : IProxyType
{
	private static readonly BindingFlags DEFAULT_LOOKUP = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;

	private readonly Dictionary<string, IProxyEventInfo> events = new Dictionary<string, IProxyEventInfo>();

	private readonly Dictionary<string, IProxyFieldInfo> fields = new Dictionary<string, IProxyFieldInfo>();

	private readonly Dictionary<string, IProxyPropertyInfo> properties = new Dictionary<string, IProxyPropertyInfo>();

	private readonly Dictionary<string, List<IProxyMethodInfo>> methods = new Dictionary<string, List<IProxyMethodInfo>>();

	private IProxyItemInfo itemInfo;

	private readonly object _lock = new object();

	private readonly ProxyFactory factory;

	private readonly Type type;

	private ProxyType baseType;

	public Type Type => type;

	public ProxyType(Type type, ProxyFactory factory)
	{
		this.factory = factory;
		this.type = type;
	}

	protected void AddMethodInfo(IProxyMethodInfo methodInfo)
	{
		lock (_lock)
		{
			string name = methodInfo.Name;
			if (!methods.TryGetValue(name, out var value))
			{
				value = new List<IProxyMethodInfo>();
				methods.Add(name, value);
			}
			value.Add(methodInfo);
		}
	}

	protected void RemoveMethodInfo(IProxyMethodInfo methodInfo)
	{
		lock (_lock)
		{
			string name = methodInfo.Name;
			if (methods.TryGetValue(name, out var value))
			{
				value.Remove(methodInfo);
			}
		}
	}

	protected IProxyMethodInfo GetMethodInfo(string name, Type[] parameterTypes)
	{
		lock (_lock)
		{
			if (!methods.ContainsKey(name))
			{
				return null;
			}
			List<IProxyMethodInfo> list = methods[name];
			foreach (IProxyMethodInfo item in list)
			{
				if (IsParameterMatch(item, parameterTypes))
				{
					return item;
				}
			}
			return null;
		}
	}

	protected bool IsParameterMatch(IProxyMethodInfo proxyMethodInfo, Type[] parameterTypes)
	{
		ParameterInfo[] parameters = proxyMethodInfo.Parameters;
		if ((parameters == null || parameters.Length == 0) && (parameterTypes == null || parameterTypes.Length == 0))
		{
			return true;
		}
		if (parameters != null && parameterTypes != null && parameters.Length == parameterTypes.Length)
		{
			for (int i = 0; i < parameters.Length; i++)
			{
				if (parameters[i].ParameterType != parameterTypes[i])
				{
					return false;
				}
			}
			return true;
		}
		return false;
	}

	public void Register(IProxyMemberInfo memberInfo)
	{
		if (!memberInfo.DeclaringType.Equals(type))
		{
			throw new ArgumentException();
		}
		string name = memberInfo.Name;
		if (memberInfo is IProxyPropertyInfo)
		{
			properties.Add(name, (IProxyPropertyInfo)memberInfo);
		}
		else if (memberInfo is IProxyMethodInfo)
		{
			AddMethodInfo((IProxyMethodInfo)memberInfo);
		}
		else if (memberInfo is IProxyFieldInfo)
		{
			fields.Add(name, (IProxyFieldInfo)memberInfo);
		}
		else if (memberInfo is IProxyEventInfo)
		{
			events.Add(name, (IProxyEventInfo)memberInfo);
		}
		else if (memberInfo is IProxyItemInfo)
		{
			itemInfo = (IProxyItemInfo)memberInfo;
		}
	}

	public void Unregister(IProxyMemberInfo memberInfo)
	{
		if (!memberInfo.DeclaringType.Equals(type))
		{
			throw new ArgumentException();
		}
		string name = memberInfo.Name;
		if (memberInfo is IProxyPropertyInfo)
		{
			properties.Remove(name);
		}
		else if (memberInfo is IProxyMethodInfo)
		{
			RemoveMethodInfo((IProxyMethodInfo)memberInfo);
		}
		else if (memberInfo is IProxyFieldInfo)
		{
			fields.Remove(name);
		}
		else if (memberInfo is IProxyEventInfo)
		{
			events.Remove(name);
		}
		else if (memberInfo is IProxyItemInfo && itemInfo == memberInfo)
		{
			itemInfo = null;
		}
	}

	private IProxyType GetBase()
	{
		if (baseType != null)
		{
			return baseType;
		}
		Type type = this.type.BaseType;
		if (type == null)
		{
			return null;
		}
		baseType = factory.GetType(type);
		return baseType;
	}

	public IProxyMemberInfo GetMember(string name)
	{
		if (name.Equals("Item") && typeof(ICollection).IsAssignableFrom(type))
		{
			return GetItem();
		}
		IProxyMemberInfo property = GetProperty(name);
		if (property != null)
		{
			return property;
		}
		property = GetMethod(name);
		if (property != null)
		{
			return property;
		}
		property = GetField(name);
		if (property != null)
		{
			return property;
		}
		property = GetEvent(name);
		if (property != null)
		{
			return property;
		}
		return null;
	}

	public IProxyMemberInfo GetMember(string name, BindingFlags flags)
	{
		if (name.Equals("Item") && typeof(ICollection).IsAssignableFrom(type))
		{
			return GetItem();
		}
		IProxyMemberInfo property = GetProperty(name, flags);
		if (property != null)
		{
			return property;
		}
		property = GetMethod(name, flags);
		if (property != null)
		{
			return property;
		}
		property = GetField(name, flags);
		if (property != null)
		{
			return property;
		}
		property = GetEvent(name);
		if (property != null)
		{
			return property;
		}
		return null;
	}

	public IProxyEventInfo GetEvent(string name)
	{
		if (events.TryGetValue(name, out var value))
		{
			return value;
		}
		return FindEventInfo(name, DEFAULT_LOOKUP, includeInterface: true);
	}

	private IProxyEventInfo FindEventInfo(string name, BindingFlags flags, bool includeInterface)
	{
		IProxyEventInfo value = null;
		EventInfo eventInfo = this.type.GetEvent(name, flags | BindingFlags.DeclaredOnly);
		if (eventInfo != null)
		{
			if (events.TryGetValue(eventInfo.Name, out value))
			{
				return value;
			}
			return CreateProxyEventInfo(eventInfo);
		}
		if (this.type.BaseType != null && !this.type.BaseType.Equals(typeof(object)))
		{
			if (baseType != null)
			{
				value = baseType.FindEventInfo(name, flags, includeInterface: false);
			}
			else if (this.type.BaseType.GetEvent(name, flags & ~BindingFlags.DeclaredOnly) != null)
			{
				baseType = factory.GetType(this.type.BaseType);
				value = baseType.FindEventInfo(name, flags, includeInterface: false);
			}
			if (value != null)
			{
				return value;
			}
		}
		if (includeInterface)
		{
			Type[] interfaces = this.type.GetInterfaces();
			Type[] array = interfaces;
			foreach (Type type in array)
			{
				ProxyType proxyType = factory.GetType(type, create: false);
				if (proxyType == null && type.GetEvent(name, flags | BindingFlags.DeclaredOnly) != null)
				{
					proxyType = factory.GetType(type);
				}
				if (proxyType != null)
				{
					value = proxyType.FindEventInfo(name, flags, includeInterface: false);
					if (value != null)
					{
						return value;
					}
				}
			}
		}
		return null;
	}

	public IProxyFieldInfo GetField(string name)
	{
		if (fields.TryGetValue(name, out var value))
		{
			return value;
		}
		return FindFieldInfo(name, DEFAULT_LOOKUP, includeInterface: true);
	}

	public IProxyFieldInfo GetField(string name, BindingFlags flags)
	{
		return FindFieldInfo(name, flags, includeInterface: true);
	}

	private IProxyFieldInfo FindFieldInfo(string name, BindingFlags flags, bool includeInterface)
	{
		IProxyFieldInfo value = null;
		FieldInfo field = this.type.GetField(name, flags | BindingFlags.DeclaredOnly);
		if (field != null)
		{
			if (fields.TryGetValue(field.Name, out value))
			{
				return value;
			}
			return CreateProxyFieldInfo(field);
		}
		if (this.type.BaseType != null && !this.type.BaseType.Equals(typeof(object)))
		{
			if (baseType != null)
			{
				value = baseType.FindFieldInfo(name, flags, includeInterface: false);
			}
			else if (this.type.BaseType.GetField(name, flags & ~BindingFlags.DeclaredOnly) != null)
			{
				baseType = factory.GetType(this.type.BaseType);
				value = baseType.FindFieldInfo(name, flags, includeInterface: false);
			}
			if (value != null)
			{
				return value;
			}
		}
		if (includeInterface)
		{
			Type[] interfaces = this.type.GetInterfaces();
			Type[] array = interfaces;
			foreach (Type type in array)
			{
				ProxyType proxyType = factory.GetType(type, create: false);
				if (proxyType == null && type.GetField(name, flags | BindingFlags.DeclaredOnly) != null)
				{
					proxyType = factory.GetType(type);
				}
				if (proxyType != null)
				{
					value = proxyType.FindFieldInfo(name, flags, includeInterface: false);
					if (value != null)
					{
						return value;
					}
				}
			}
		}
		return null;
	}

	public IProxyPropertyInfo GetProperty(string name)
	{
		if (properties.TryGetValue(name, out var value))
		{
			return value;
		}
		return FindPropertyInfo(name, DEFAULT_LOOKUP, includeInterface: true);
	}

	public IProxyPropertyInfo GetProperty(string name, BindingFlags flags)
	{
		return FindPropertyInfo(name, flags, includeInterface: true);
	}

	private IProxyPropertyInfo FindPropertyInfo(string name, BindingFlags flags, bool includeInterface)
	{
		IProxyPropertyInfo value = null;
		PropertyInfo property = this.type.GetProperty(name, flags | BindingFlags.DeclaredOnly);
		if (property != null)
		{
			if (properties.TryGetValue(property.Name, out value))
			{
				return value;
			}
			return CreateProxyPropertyInfo(property);
		}
		if (this.type.BaseType != null && !this.type.BaseType.Equals(typeof(object)))
		{
			if (baseType != null)
			{
				value = baseType.FindPropertyInfo(name, flags, includeInterface: false);
			}
			else if (this.type.BaseType.GetProperty(name, flags & ~BindingFlags.DeclaredOnly) != null)
			{
				baseType = factory.GetType(this.type.BaseType);
				value = baseType.FindPropertyInfo(name, flags, includeInterface: false);
			}
			if (value != null)
			{
				return value;
			}
		}
		if (includeInterface)
		{
			Type[] interfaces = this.type.GetInterfaces();
			Type[] array = interfaces;
			foreach (Type type in array)
			{
				ProxyType proxyType = factory.GetType(type, create: false);
				if (proxyType == null && type.GetProperty(name, flags | BindingFlags.DeclaredOnly) != null)
				{
					proxyType = factory.GetType(type);
				}
				if (proxyType != null)
				{
					value = proxyType.FindPropertyInfo(name, flags, includeInterface: false);
					if (value != null)
					{
						return value;
					}
				}
			}
		}
		return null;
	}

	public IProxyItemInfo GetItem()
	{
		if (itemInfo != null)
		{
			return itemInfo;
		}
		if (type.IsArray)
		{
			return CreateArrayProxyItemInfo(type);
		}
		PropertyInfo property = type.GetProperty("Item", BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public);
		if (property != null)
		{
			return CreateProxyItemInfo(property);
		}
		return GetBase()?.GetItem();
	}

	public IProxyMethodInfo GetMethod(string name)
	{
		MethodInfo method = type.GetMethod(name);
		if (method == null)
		{
			return null;
		}
		return GetMethod(name, method.GetParameterTypes().ToArray());
	}

	public virtual IProxyMethodInfo GetMethod(string name, Type[] parameterTypes)
	{
		IProxyMethodInfo methodInfo = GetMethodInfo(name, parameterTypes);
		if (methodInfo != null)
		{
			return methodInfo;
		}
		return FindMethodInfo(name, parameterTypes, DEFAULT_LOOKUP, includeInterface: true);
	}

	public IProxyMethodInfo GetMethod(string name, BindingFlags flags)
	{
		MethodInfo method = type.GetMethod(name, flags);
		if (method == null)
		{
			return null;
		}
		return GetMethod(name, method.GetParameterTypes().ToArray(), flags);
	}

	public IProxyMethodInfo GetMethod(string name, Type[] parameterTypes, BindingFlags flags)
	{
		return FindMethodInfo(name, parameterTypes, flags, includeInterface: true);
	}

	private IProxyMethodInfo FindMethodInfo(string name, Type[] parameterTypes, BindingFlags flags, bool includeInterface)
	{
		IProxyMethodInfo proxyMethodInfo = null;
		MethodInfo method = this.type.GetMethod(name, flags | BindingFlags.DeclaredOnly, null, parameterTypes, null);
		if (method != null)
		{
			proxyMethodInfo = GetMethodInfo(name, parameterTypes);
			if (proxyMethodInfo != null)
			{
				return proxyMethodInfo;
			}
			return CreateProxyMethodInfo(method);
		}
		if (this.type.BaseType != null)
		{
			if (baseType != null)
			{
				proxyMethodInfo = baseType.FindMethodInfo(name, parameterTypes, flags, includeInterface: false);
			}
			else if (this.type.BaseType.GetMethod(name, flags & ~BindingFlags.DeclaredOnly) != null)
			{
				baseType = factory.GetType(this.type.BaseType);
				proxyMethodInfo = baseType.FindMethodInfo(name, parameterTypes, flags, includeInterface: false);
			}
			if (proxyMethodInfo != null)
			{
				return proxyMethodInfo;
			}
		}
		if (includeInterface)
		{
			Type[] interfaces = this.type.GetInterfaces();
			Type[] array = interfaces;
			foreach (Type type in array)
			{
				ProxyType proxyType = factory.GetType(type, create: false);
				if (proxyType == null && type.GetMethod(name, flags | BindingFlags.DeclaredOnly, null, parameterTypes, null) != null)
				{
					proxyType = factory.GetType(type);
				}
				if (proxyType != null)
				{
					proxyMethodInfo = proxyType.FindMethodInfo(name, parameterTypes, flags, includeInterface: false);
					if (proxyMethodInfo != null)
					{
						return proxyMethodInfo;
					}
				}
			}
		}
		return null;
	}

	protected IProxyEventInfo CreateProxyEventInfo(EventInfo eventInfo)
	{
		ProxyEventInfo proxyEventInfo = new ProxyEventInfo(eventInfo);
		events.Add(proxyEventInfo.Name, proxyEventInfo);
		return proxyEventInfo;
	}

	protected IProxyFieldInfo CreateProxyFieldInfo(FieldInfo fieldInfo)
	{
		IProxyFieldInfo proxyFieldInfo = null;
		try
		{
			proxyFieldInfo = (IProxyFieldInfo)Activator.CreateInstance(typeof(ProxyFieldInfo<, >).MakeGenericType(fieldInfo.DeclaringType, fieldInfo.FieldType), fieldInfo);
		}
		catch (Exception)
		{
			proxyFieldInfo = new ProxyFieldInfo(fieldInfo);
		}
		if (proxyFieldInfo != null)
		{
			fields.Add(proxyFieldInfo.Name, proxyFieldInfo);
		}
		return proxyFieldInfo;
	}

	internal IProxyPropertyInfo CreateProxyPropertyInfo(PropertyInfo propertyInfo)
	{
		IProxyPropertyInfo proxyPropertyInfo = null;
		try
		{
			Type declaringType = propertyInfo.DeclaringType;
			if (propertyInfo.IsStatic())
			{
				ParameterInfo[] indexParameters = propertyInfo.GetIndexParameters();
				if (indexParameters != null && indexParameters.Length != 0)
				{
					throw new ParameterMismatchException();
				}
				proxyPropertyInfo = (IProxyPropertyInfo)Activator.CreateInstance(typeof(StaticProxyPropertyInfo<, >).MakeGenericType(declaringType, propertyInfo.PropertyType), propertyInfo);
			}
			else
			{
				ParameterInfo[] indexParameters2 = propertyInfo.GetIndexParameters();
				if (indexParameters2 != null && indexParameters2.Length == 1)
				{
					throw new ParameterMismatchException();
				}
				proxyPropertyInfo = (IProxyPropertyInfo)Activator.CreateInstance(typeof(ProxyPropertyInfo<, >).MakeGenericType(declaringType, propertyInfo.PropertyType), propertyInfo);
			}
		}
		catch (ParameterMismatchException ex)
		{
			throw ex;
		}
		catch (Exception)
		{
			proxyPropertyInfo = new ProxyPropertyInfo(propertyInfo);
		}
		if (proxyPropertyInfo != null)
		{
			properties.Add(proxyPropertyInfo.Name, proxyPropertyInfo);
		}
		return proxyPropertyInfo;
	}

	protected IProxyMethodInfo CreateProxyMethodInfo(MethodInfo methodInfo)
	{
		IProxyMethodInfo proxyMethodInfo = null;
		try
		{
			Type returnType = methodInfo.ReturnType;
			ParameterInfo[] parameters = methodInfo.GetParameters();
			Type declaringType = methodInfo.DeclaringType;
			proxyMethodInfo = (typeof(void).Equals(returnType) ? (methodInfo.IsStatic ? ((parameters != null && parameters.Length != 0) ? ((parameters.Length == 1) ? ((IProxyMethodInfo)Activator.CreateInstance(typeof(StaticProxyActionInfo<, >).MakeGenericType(declaringType, parameters[0].ParameterType), methodInfo)) : ((parameters.Length == 2) ? ((IProxyMethodInfo)Activator.CreateInstance(typeof(StaticProxyActionInfo<, , >).MakeGenericType(declaringType, parameters[0].ParameterType, parameters[1].ParameterType), methodInfo)) : ((parameters.Length != 3) ? new ProxyMethodInfo(methodInfo) : ((IProxyMethodInfo)Activator.CreateInstance(typeof(StaticProxyActionInfo<, , , >).MakeGenericType(declaringType, parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType), methodInfo))))) : ((IProxyMethodInfo)Activator.CreateInstance(typeof(StaticProxyActionInfo<>).MakeGenericType(declaringType), methodInfo))) : ((parameters != null && parameters.Length != 0) ? ((parameters.Length == 1) ? ((IProxyMethodInfo)Activator.CreateInstance(typeof(ProxyActionInfo<, >).MakeGenericType(declaringType, parameters[0].ParameterType), methodInfo)) : ((parameters.Length == 2) ? ((IProxyMethodInfo)Activator.CreateInstance(typeof(ProxyActionInfo<, , >).MakeGenericType(declaringType, parameters[0].ParameterType, parameters[1].ParameterType), methodInfo)) : ((parameters.Length != 3) ? new ProxyMethodInfo(methodInfo) : ((IProxyMethodInfo)Activator.CreateInstance(typeof(ProxyActionInfo<, , , >).MakeGenericType(declaringType, parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType), methodInfo))))) : ((IProxyMethodInfo)Activator.CreateInstance(typeof(ProxyActionInfo<>).MakeGenericType(declaringType), methodInfo)))) : (methodInfo.IsStatic ? ((parameters != null && parameters.Length != 0) ? ((parameters.Length == 1) ? ((IProxyMethodInfo)Activator.CreateInstance(typeof(StaticProxyFuncInfo<, , >).MakeGenericType(declaringType, parameters[0].ParameterType, returnType), methodInfo)) : ((parameters.Length == 2) ? ((IProxyMethodInfo)Activator.CreateInstance(typeof(StaticProxyFuncInfo<, , , >).MakeGenericType(declaringType, parameters[0].ParameterType, parameters[1].ParameterType, returnType), methodInfo)) : ((parameters.Length != 3) ? new ProxyMethodInfo(methodInfo) : ((IProxyMethodInfo)Activator.CreateInstance(typeof(StaticProxyFuncInfo<, , , , >).MakeGenericType(declaringType, parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType, returnType), methodInfo))))) : ((IProxyMethodInfo)Activator.CreateInstance(typeof(StaticProxyFuncInfo<, >).MakeGenericType(declaringType, returnType), methodInfo))) : ((parameters != null && parameters.Length != 0) ? ((parameters.Length == 1) ? ((IProxyMethodInfo)Activator.CreateInstance(typeof(ProxyFuncInfo<, , >).MakeGenericType(declaringType, parameters[0].ParameterType, returnType), methodInfo)) : ((parameters.Length == 2) ? ((IProxyMethodInfo)Activator.CreateInstance(typeof(ProxyFuncInfo<, , , >).MakeGenericType(declaringType, parameters[0].ParameterType, parameters[1].ParameterType, returnType), methodInfo)) : ((parameters.Length != 3) ? new ProxyMethodInfo(methodInfo) : ((IProxyMethodInfo)Activator.CreateInstance(typeof(ProxyFuncInfo<, , , , >).MakeGenericType(declaringType, parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType, returnType), methodInfo))))) : ((IProxyMethodInfo)Activator.CreateInstance(typeof(ProxyFuncInfo<, >).MakeGenericType(declaringType, returnType), methodInfo)))));
		}
		catch (Exception)
		{
			proxyMethodInfo = new ProxyMethodInfo(methodInfo);
		}
		if (proxyMethodInfo != null)
		{
			AddMethodInfo(proxyMethodInfo);
		}
		return proxyMethodInfo;
	}

	protected IProxyItemInfo CreateArrayProxyItemInfo(Type type)
	{
		Type elementType = type.GetElementType();
		IProxyItemInfo proxyItemInfo = null;
		try
		{
			proxyItemInfo = (IProxyItemInfo)Activator.CreateInstance(typeof(ArrayProxyItemInfo<, >).MakeGenericType(type, elementType));
		}
		catch (Exception)
		{
			proxyItemInfo = Type.GetTypeCode(elementType) switch
			{
				TypeCode.Boolean => new ArrayProxyItemInfo<bool[], bool>(), 
				TypeCode.Byte => new ArrayProxyItemInfo<byte[], byte>(), 
				TypeCode.Char => new ArrayProxyItemInfo<char[], char>(), 
				TypeCode.DateTime => new ArrayProxyItemInfo<DateTime[], DateTime>(), 
				TypeCode.Decimal => new ArrayProxyItemInfo<decimal[], decimal>(), 
				TypeCode.Double => new ArrayProxyItemInfo<double[], double>(), 
				TypeCode.Int16 => new ArrayProxyItemInfo<short[], short>(), 
				TypeCode.Int32 => new ArrayProxyItemInfo<int[], int>(), 
				TypeCode.Int64 => new ArrayProxyItemInfo<long[], long>(), 
				TypeCode.SByte => new ArrayProxyItemInfo<sbyte[], sbyte>(), 
				TypeCode.Single => new ArrayProxyItemInfo<float[], float>(), 
				TypeCode.String => new ArrayProxyItemInfo<string[], string>(), 
				TypeCode.UInt16 => new ArrayProxyItemInfo<ushort[], ushort>(), 
				TypeCode.UInt32 => new ArrayProxyItemInfo<uint[], uint>(), 
				TypeCode.UInt64 => new ArrayProxyItemInfo<ulong[], ulong>(), 
				TypeCode.Object => (!type.Equals(typeof(Vector2))) ? ((!type.Equals(typeof(Vector3))) ? ((!type.Equals(typeof(Vector4))) ? ((!type.Equals(typeof(Color))) ? ((!type.Equals(typeof(Rect))) ? ((!type.Equals(typeof(Quaternion))) ? ((!type.Equals(typeof(Version))) ? new ArrayProxyItemInfo(type) : new ArrayProxyItemInfo<Version[], Version>()) : new ArrayProxyItemInfo<Quaternion[], Quaternion>()) : new ArrayProxyItemInfo<Rect[], Rect>()) : new ArrayProxyItemInfo<Color[], Color>()) : new ArrayProxyItemInfo<Vector4[], Vector4>()) : new ArrayProxyItemInfo<Vector3[], Vector3>()) : new ArrayProxyItemInfo<Vector2[], Vector2>(), 
				_ => new ArrayProxyItemInfo(type), 
			};
		}
		if (proxyItemInfo != null)
		{
			itemInfo = proxyItemInfo;
		}
		return proxyItemInfo;
	}

	protected IProxyItemInfo CreateProxyItemInfo(PropertyInfo propertyInfo)
	{
		Type declaringType = propertyInfo.DeclaringType;
		ParameterInfo[] indexParameters = propertyInfo.GetIndexParameters();
		if (indexParameters == null || indexParameters.Length != 1)
		{
			throw new NotSupportedException();
		}
		IProxyItemInfo proxyItemInfo = null;
		try
		{
			proxyItemInfo = (declaringType.IsSubclassOfGenericTypeDefinition(typeof(IDictionary<, >)) ? ((IProxyItemInfo)Activator.CreateInstance(typeof(DictionaryProxyItemInfo<, , >).MakeGenericType(declaringType, indexParameters[0].ParameterType, propertyInfo.PropertyType), propertyInfo)) : ((!declaringType.IsSubclassOfGenericTypeDefinition(typeof(IList<>))) ? new ProxyItemInfo(propertyInfo) : ((IProxyItemInfo)Activator.CreateInstance(typeof(ListProxyItemInfo<, >).MakeGenericType(declaringType, propertyInfo.PropertyType), propertyInfo))));
		}
		catch (Exception)
		{
			proxyItemInfo = (declaringType.IsSubclassOfGenericTypeDefinition(typeof(IDictionary<, >)) ? CreateDictionaryProxyItemInfo(propertyInfo) : ((!declaringType.IsSubclassOfGenericTypeDefinition(typeof(IList<>))) ? new ProxyItemInfo(propertyInfo) : CreateListProxyItemInfo(propertyInfo)));
		}
		if (proxyItemInfo != null)
		{
			itemInfo = proxyItemInfo;
		}
		return proxyItemInfo;
	}

	protected virtual IProxyItemInfo CreateListProxyItemInfo(PropertyInfo propertyInfo)
	{
		Type propertyType = propertyInfo.PropertyType;
		switch (Type.GetTypeCode(propertyType))
		{
		case TypeCode.Boolean:
			return new ListProxyItemInfo<IList<bool>, bool>(propertyInfo);
		case TypeCode.Byte:
			return new ListProxyItemInfo<IList<byte>, byte>(propertyInfo);
		case TypeCode.Char:
			return new ListProxyItemInfo<IList<char>, char>(propertyInfo);
		case TypeCode.DateTime:
			return new ListProxyItemInfo<IList<DateTime>, DateTime>(propertyInfo);
		case TypeCode.Decimal:
			return new ListProxyItemInfo<IList<decimal>, decimal>(propertyInfo);
		case TypeCode.Double:
			return new ListProxyItemInfo<IList<double>, double>(propertyInfo);
		case TypeCode.Int16:
			return new ListProxyItemInfo<IList<short>, short>(propertyInfo);
		case TypeCode.Int32:
			return new ListProxyItemInfo<IList<int>, int>(propertyInfo);
		case TypeCode.Int64:
			return new ListProxyItemInfo<IList<long>, long>(propertyInfo);
		case TypeCode.SByte:
			return new ListProxyItemInfo<IList<sbyte>, sbyte>(propertyInfo);
		case TypeCode.Single:
			return new ListProxyItemInfo<IList<float>, float>(propertyInfo);
		case TypeCode.String:
			return new ListProxyItemInfo<IList<string>, string>(propertyInfo);
		case TypeCode.UInt16:
			return new ListProxyItemInfo<IList<ushort>, ushort>(propertyInfo);
		case TypeCode.UInt32:
			return new ListProxyItemInfo<IList<uint>, uint>(propertyInfo);
		case TypeCode.UInt64:
			return new ListProxyItemInfo<IList<ulong>, ulong>(propertyInfo);
		case TypeCode.Object:
			if (propertyType.Equals(typeof(Vector2)))
			{
				return new ListProxyItemInfo<IList<Vector2>, Vector2>(propertyInfo);
			}
			if (propertyType.Equals(typeof(Vector3)))
			{
				return new ListProxyItemInfo<IList<Vector3>, Vector3>(propertyInfo);
			}
			if (propertyType.Equals(typeof(Vector4)))
			{
				return new ListProxyItemInfo<IList<Vector4>, Vector4>(propertyInfo);
			}
			if (propertyType.Equals(typeof(Color)))
			{
				return new ListProxyItemInfo<IList<Color>, Color>(propertyInfo);
			}
			if (propertyType.Equals(typeof(Rect)))
			{
				return new ListProxyItemInfo<IList<Rect>, Rect>(propertyInfo);
			}
			if (propertyType.Equals(typeof(Quaternion)))
			{
				return new ListProxyItemInfo<IList<Quaternion>, Quaternion>(propertyInfo);
			}
			if (propertyType.Equals(typeof(Version)))
			{
				return new ListProxyItemInfo<IList<Version>, Version>(propertyInfo);
			}
			return new ProxyItemInfo(propertyInfo);
		default:
			return new ProxyItemInfo(propertyInfo);
		}
	}

	protected virtual IProxyItemInfo CreateDictionaryProxyItemInfo(PropertyInfo propertyInfo)
	{
		ParameterInfo[] indexParameters = propertyInfo.GetIndexParameters();
		Type propertyType = propertyInfo.PropertyType;
		TypeCode typeCode = Type.GetTypeCode(propertyType);
		if (indexParameters[0].ParameterType.Equals(typeof(string)))
		{
			switch (typeCode)
			{
			case TypeCode.Boolean:
				return new DictionaryProxyItemInfo<IDictionary<string, bool>, string, bool>(propertyInfo);
			case TypeCode.Byte:
				return new DictionaryProxyItemInfo<IDictionary<string, byte>, string, byte>(propertyInfo);
			case TypeCode.Char:
				return new DictionaryProxyItemInfo<IDictionary<string, char>, string, char>(propertyInfo);
			case TypeCode.DateTime:
				return new DictionaryProxyItemInfo<IDictionary<string, DateTime>, string, DateTime>(propertyInfo);
			case TypeCode.Decimal:
				return new DictionaryProxyItemInfo<IDictionary<string, decimal>, string, decimal>(propertyInfo);
			case TypeCode.Double:
				return new DictionaryProxyItemInfo<IDictionary<string, double>, string, double>(propertyInfo);
			case TypeCode.Int16:
				return new DictionaryProxyItemInfo<IDictionary<string, short>, string, short>(propertyInfo);
			case TypeCode.Int32:
				return new DictionaryProxyItemInfo<IDictionary<string, int>, string, int>(propertyInfo);
			case TypeCode.Int64:
				return new DictionaryProxyItemInfo<IDictionary<string, long>, string, long>(propertyInfo);
			case TypeCode.SByte:
				return new DictionaryProxyItemInfo<IDictionary<string, sbyte>, string, sbyte>(propertyInfo);
			case TypeCode.Single:
				return new DictionaryProxyItemInfo<IDictionary<string, float>, string, float>(propertyInfo);
			case TypeCode.String:
				return new DictionaryProxyItemInfo<IDictionary<string, string>, string, string>(propertyInfo);
			case TypeCode.UInt16:
				return new DictionaryProxyItemInfo<IDictionary<string, ushort>, string, ushort>(propertyInfo);
			case TypeCode.UInt32:
				return new DictionaryProxyItemInfo<IDictionary<string, uint>, string, uint>(propertyInfo);
			case TypeCode.UInt64:
				return new DictionaryProxyItemInfo<IDictionary<string, ulong>, string, ulong>(propertyInfo);
			case TypeCode.Object:
				if (propertyType.Equals(typeof(Vector2)))
				{
					return new DictionaryProxyItemInfo<IDictionary<string, Vector2>, string, Vector2>(propertyInfo);
				}
				if (propertyType.Equals(typeof(Vector3)))
				{
					return new DictionaryProxyItemInfo<IDictionary<string, Vector3>, string, Vector3>(propertyInfo);
				}
				if (propertyType.Equals(typeof(Vector4)))
				{
					return new DictionaryProxyItemInfo<IDictionary<string, Vector4>, string, Vector4>(propertyInfo);
				}
				if (propertyType.Equals(typeof(Color)))
				{
					return new DictionaryProxyItemInfo<IDictionary<string, Color>, string, Color>(propertyInfo);
				}
				if (propertyType.Equals(typeof(Rect)))
				{
					return new DictionaryProxyItemInfo<IDictionary<string, Rect>, string, Rect>(propertyInfo);
				}
				if (propertyType.Equals(typeof(Quaternion)))
				{
					return new DictionaryProxyItemInfo<IDictionary<string, Quaternion>, string, Quaternion>(propertyInfo);
				}
				if (propertyType.Equals(typeof(Version)))
				{
					return new DictionaryProxyItemInfo<IDictionary<string, Version>, string, Version>(propertyInfo);
				}
				return new ProxyItemInfo(propertyInfo);
			default:
				return new ProxyItemInfo(propertyInfo);
			}
		}
		if (indexParameters[0].ParameterType.Equals(typeof(int)))
		{
			switch (typeCode)
			{
			case TypeCode.Boolean:
				return new DictionaryProxyItemInfo<IDictionary<int, bool>, int, bool>(propertyInfo);
			case TypeCode.Byte:
				return new DictionaryProxyItemInfo<IDictionary<int, byte>, int, byte>(propertyInfo);
			case TypeCode.Char:
				return new DictionaryProxyItemInfo<IDictionary<int, char>, int, char>(propertyInfo);
			case TypeCode.DateTime:
				return new DictionaryProxyItemInfo<IDictionary<int, DateTime>, int, DateTime>(propertyInfo);
			case TypeCode.Decimal:
				return new DictionaryProxyItemInfo<IDictionary<int, decimal>, int, decimal>(propertyInfo);
			case TypeCode.Double:
				return new DictionaryProxyItemInfo<IDictionary<int, double>, int, double>(propertyInfo);
			case TypeCode.Int16:
				return new DictionaryProxyItemInfo<IDictionary<int, short>, int, short>(propertyInfo);
			case TypeCode.Int32:
				return new DictionaryProxyItemInfo<IDictionary<int, int>, int, int>(propertyInfo);
			case TypeCode.Int64:
				return new DictionaryProxyItemInfo<IDictionary<int, long>, int, long>(propertyInfo);
			case TypeCode.SByte:
				return new DictionaryProxyItemInfo<IDictionary<int, sbyte>, int, sbyte>(propertyInfo);
			case TypeCode.Single:
				return new DictionaryProxyItemInfo<IDictionary<int, float>, int, float>(propertyInfo);
			case TypeCode.String:
				return new DictionaryProxyItemInfo<IDictionary<int, string>, int, string>(propertyInfo);
			case TypeCode.UInt16:
				return new DictionaryProxyItemInfo<IDictionary<int, ushort>, int, ushort>(propertyInfo);
			case TypeCode.UInt32:
				return new DictionaryProxyItemInfo<IDictionary<int, uint>, int, uint>(propertyInfo);
			case TypeCode.UInt64:
				return new DictionaryProxyItemInfo<IDictionary<int, ulong>, int, ulong>(propertyInfo);
			case TypeCode.Object:
				if (propertyType.Equals(typeof(Vector2)))
				{
					return new DictionaryProxyItemInfo<IDictionary<int, Vector2>, int, Vector2>(propertyInfo);
				}
				if (propertyType.Equals(typeof(Vector3)))
				{
					return new DictionaryProxyItemInfo<IDictionary<int, Vector3>, int, Vector3>(propertyInfo);
				}
				if (propertyType.Equals(typeof(Vector4)))
				{
					return new DictionaryProxyItemInfo<IDictionary<int, Vector4>, int, Vector4>(propertyInfo);
				}
				if (propertyType.Equals(typeof(Color)))
				{
					return new DictionaryProxyItemInfo<IDictionary<int, Color>, int, Color>(propertyInfo);
				}
				if (propertyType.Equals(typeof(Rect)))
				{
					return new DictionaryProxyItemInfo<IDictionary<int, Rect>, int, Rect>(propertyInfo);
				}
				if (propertyType.Equals(typeof(Quaternion)))
				{
					return new DictionaryProxyItemInfo<IDictionary<int, Quaternion>, int, Quaternion>(propertyInfo);
				}
				if (propertyType.Equals(typeof(Version)))
				{
					return new DictionaryProxyItemInfo<IDictionary<int, Version>, int, Version>(propertyInfo);
				}
				return new ProxyItemInfo(propertyInfo);
			default:
				return new ProxyItemInfo(propertyInfo);
			}
		}
		return new ProxyItemInfo(propertyInfo);
	}
}
