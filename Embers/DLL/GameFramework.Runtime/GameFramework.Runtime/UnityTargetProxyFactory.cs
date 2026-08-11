using System;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine.Events;

namespace GameFramework.Runtime;

public class UnityTargetProxyFactory : ITargetProxyFactory
{
	public ITargetProxy CreateProxy(object target, BindingDescription description)
	{
		IProxyType proxyType = ((description.TargetType != null) ? description.TargetType.AsProxy() : target.GetType().AsProxy());
		IProxyMemberInfo member = proxyType.GetMember(description.TargetName);
		if (member == null)
		{
			member = proxyType.GetMember(description.TargetName, BindingFlags.Instance | BindingFlags.NonPublic);
		}
		if (member == null)
		{
			throw new MissingMemberException(proxyType.Type.FullName, description.TargetName);
		}
		UnityEventBase unityEventBase = null;
		if (!string.IsNullOrEmpty(description.UpdateTrigger))
		{
			IProxyPropertyInfo property = proxyType.GetProperty(description.UpdateTrigger);
			IProxyFieldInfo proxyFieldInfo = ((property == null) ? proxyType.GetField(description.UpdateTrigger) : null);
			if (property != null)
			{
				unityEventBase = property.GetValue(target) as UnityEventBase;
			}
			if (proxyFieldInfo != null)
			{
				unityEventBase = proxyFieldInfo.GetValue(target) as UnityEventBase;
			}
			if (property == null && proxyFieldInfo == null)
			{
				throw new MissingMemberException(proxyType.Type.FullName, description.UpdateTrigger);
			}
			if (unityEventBase == null)
			{
				return null;
			}
		}
		if (member is IProxyPropertyInfo proxyPropertyInfo)
		{
			if (typeof(IObservableProperty).IsAssignableFrom(proxyPropertyInfo.ValueType))
			{
				return null;
			}
			if (typeof(UnityEventBase).IsAssignableFrom(proxyPropertyInfo.ValueType))
			{
				object value = proxyPropertyInfo.GetValue(target);
				Type[] unityEventParametersType = GetUnityEventParametersType(proxyPropertyInfo.ValueType);
				return CreateUnityEventProxy(target, (UnityEventBase)value, unityEventParametersType);
			}
			if (unityEventBase == null)
			{
				return null;
			}
			return CreateUnityPropertyProxy(target, proxyPropertyInfo, unityEventBase);
		}
		if (member is IProxyFieldInfo proxyFieldInfo2)
		{
			if (typeof(IObservableProperty).IsAssignableFrom(proxyFieldInfo2.ValueType))
			{
				return null;
			}
			if (typeof(UnityEventBase).IsAssignableFrom(proxyFieldInfo2.ValueType))
			{
				object value2 = proxyFieldInfo2.GetValue(target);
				Type[] unityEventParametersType2 = GetUnityEventParametersType(proxyFieldInfo2.ValueType);
				return CreateUnityEventProxy(target, (UnityEventBase)value2, unityEventParametersType2);
			}
			if (unityEventBase == null)
			{
				return null;
			}
			return CreateUnityFieldProxy(target, proxyFieldInfo2, unityEventBase);
		}
		return null;
	}

	protected virtual ITargetProxy CreateUnityPropertyProxy(object target, IProxyPropertyInfo propertyInfo, UnityEventBase updateTrigger)
	{
		Type valueType = propertyInfo.ValueType;
		switch (propertyInfo.ValueTypeCode)
		{
		case TypeCode.String:
			return new UnityPropertyProxy<string>(target, propertyInfo, (UnityEvent<string>)updateTrigger);
		case TypeCode.Boolean:
			return new UnityPropertyProxy<bool>(target, propertyInfo, (UnityEvent<bool>)updateTrigger);
		case TypeCode.SByte:
			return new UnityPropertyProxy<sbyte>(target, propertyInfo, (UnityEvent<sbyte>)updateTrigger);
		case TypeCode.Byte:
			return new UnityPropertyProxy<byte>(target, propertyInfo, (UnityEvent<byte>)updateTrigger);
		case TypeCode.Int16:
			return new UnityPropertyProxy<short>(target, propertyInfo, (UnityEvent<short>)updateTrigger);
		case TypeCode.UInt16:
			return new UnityPropertyProxy<ushort>(target, propertyInfo, (UnityEvent<ushort>)updateTrigger);
		case TypeCode.Int32:
			return new UnityPropertyProxy<int>(target, propertyInfo, (UnityEvent<int>)updateTrigger);
		case TypeCode.UInt32:
			return new UnityPropertyProxy<uint>(target, propertyInfo, (UnityEvent<uint>)updateTrigger);
		case TypeCode.Int64:
			return new UnityPropertyProxy<long>(target, propertyInfo, (UnityEvent<long>)updateTrigger);
		case TypeCode.UInt64:
			return new UnityPropertyProxy<ulong>(target, propertyInfo, (UnityEvent<ulong>)updateTrigger);
		case TypeCode.Char:
			return new UnityPropertyProxy<char>(target, propertyInfo, (UnityEvent<char>)updateTrigger);
		case TypeCode.Single:
			return new UnityPropertyProxy<float>(target, propertyInfo, (UnityEvent<float>)updateTrigger);
		case TypeCode.Double:
			return new UnityPropertyProxy<double>(target, propertyInfo, (UnityEvent<double>)updateTrigger);
		case TypeCode.Decimal:
			return new UnityPropertyProxy<decimal>(target, propertyInfo, (UnityEvent<decimal>)updateTrigger);
		case TypeCode.DateTime:
			return new UnityPropertyProxy<DateTime>(target, propertyInfo, (UnityEvent<DateTime>)updateTrigger);
		default:
			try
			{
				return (ITargetProxy)Activator.CreateInstance(typeof(UnityPropertyProxy<>).MakeGenericType(propertyInfo.ValueType), target, propertyInfo, updateTrigger);
			}
			catch (Exception innerException)
			{
				throw new NotSupportedException("", innerException);
			}
		}
	}

	protected virtual ITargetProxy CreateUnityFieldProxy(object target, IProxyFieldInfo fieldInfo, UnityEventBase updateTrigger)
	{
		Type valueType = fieldInfo.ValueType;
		switch (fieldInfo.ValueTypeCode)
		{
		case TypeCode.String:
			return new UnityFieldProxy<string>(target, fieldInfo, (UnityEvent<string>)updateTrigger);
		case TypeCode.Boolean:
			return new UnityFieldProxy<bool>(target, fieldInfo, (UnityEvent<bool>)updateTrigger);
		case TypeCode.SByte:
			return new UnityFieldProxy<sbyte>(target, fieldInfo, (UnityEvent<sbyte>)updateTrigger);
		case TypeCode.Byte:
			return new UnityFieldProxy<byte>(target, fieldInfo, (UnityEvent<byte>)updateTrigger);
		case TypeCode.Int16:
			return new UnityFieldProxy<short>(target, fieldInfo, (UnityEvent<short>)updateTrigger);
		case TypeCode.UInt16:
			return new UnityFieldProxy<ushort>(target, fieldInfo, (UnityEvent<ushort>)updateTrigger);
		case TypeCode.Int32:
			return new UnityFieldProxy<int>(target, fieldInfo, (UnityEvent<int>)updateTrigger);
		case TypeCode.UInt32:
			return new UnityFieldProxy<uint>(target, fieldInfo, (UnityEvent<uint>)updateTrigger);
		case TypeCode.Int64:
			return new UnityFieldProxy<long>(target, fieldInfo, (UnityEvent<long>)updateTrigger);
		case TypeCode.UInt64:
			return new UnityFieldProxy<ulong>(target, fieldInfo, (UnityEvent<ulong>)updateTrigger);
		case TypeCode.Char:
			return new UnityFieldProxy<char>(target, fieldInfo, (UnityEvent<char>)updateTrigger);
		case TypeCode.Single:
			return new UnityFieldProxy<float>(target, fieldInfo, (UnityEvent<float>)updateTrigger);
		case TypeCode.Double:
			return new UnityFieldProxy<double>(target, fieldInfo, (UnityEvent<double>)updateTrigger);
		case TypeCode.Decimal:
			return new UnityFieldProxy<decimal>(target, fieldInfo, (UnityEvent<decimal>)updateTrigger);
		case TypeCode.DateTime:
			return new UnityFieldProxy<DateTime>(target, fieldInfo, (UnityEvent<DateTime>)updateTrigger);
		default:
			try
			{
				return (ITargetProxy)Activator.CreateInstance(typeof(UnityFieldProxy<>).MakeGenericType(fieldInfo.ValueType), target, fieldInfo, updateTrigger);
			}
			catch (Exception innerException)
			{
				throw new NotSupportedException("", innerException);
			}
		}
	}

	protected virtual ITargetProxy CreateUnityEventProxy(object target, UnityEventBase unityEvent, Type[] paramTypes)
	{
		switch (paramTypes.Length)
		{
		case 0:
			return new UnityEventProxy(target, (UnityEvent)unityEvent);
		case 1:
			switch (Type.GetTypeCode(paramTypes[0]))
			{
			case TypeCode.String:
				return new UnityEventProxy<string>(target, (UnityEvent<string>)unityEvent);
			case TypeCode.Boolean:
				return new UnityEventProxy<bool>(target, (UnityEvent<bool>)unityEvent);
			case TypeCode.SByte:
				return new UnityEventProxy<sbyte>(target, (UnityEvent<sbyte>)unityEvent);
			case TypeCode.Byte:
				return new UnityEventProxy<byte>(target, (UnityEvent<byte>)unityEvent);
			case TypeCode.Int16:
				return new UnityEventProxy<short>(target, (UnityEvent<short>)unityEvent);
			case TypeCode.UInt16:
				return new UnityEventProxy<ushort>(target, (UnityEvent<ushort>)unityEvent);
			case TypeCode.Int32:
				return new UnityEventProxy<int>(target, (UnityEvent<int>)unityEvent);
			case TypeCode.UInt32:
				return new UnityEventProxy<uint>(target, (UnityEvent<uint>)unityEvent);
			case TypeCode.Int64:
				return new UnityEventProxy<long>(target, (UnityEvent<long>)unityEvent);
			case TypeCode.UInt64:
				return new UnityEventProxy<ulong>(target, (UnityEvent<ulong>)unityEvent);
			case TypeCode.Char:
				return new UnityEventProxy<char>(target, (UnityEvent<char>)unityEvent);
			case TypeCode.Single:
				return new UnityEventProxy<float>(target, (UnityEvent<float>)unityEvent);
			case TypeCode.Double:
				return new UnityEventProxy<double>(target, (UnityEvent<double>)unityEvent);
			case TypeCode.Decimal:
				return new UnityEventProxy<decimal>(target, (UnityEvent<decimal>)unityEvent);
			case TypeCode.DateTime:
				return new UnityEventProxy<DateTime>(target, (UnityEvent<DateTime>)unityEvent);
			default:
				try
				{
					return (ITargetProxy)Activator.CreateInstance(typeof(UnityEventProxy<>).MakeGenericType(paramTypes[0]), target, unityEvent);
				}
				catch (Exception innerException)
				{
					throw new NotSupportedException("", innerException);
				}
			}
		default:
			throw new NotSupportedException("Too many parameters");
		}
	}

	protected Type[] GetUnityEventParametersType(Type type)
	{
		MethodInfo method = type.GetMethod("Invoke");
		if (method == null)
		{
			return new Type[0];
		}
		ParameterInfo[] parameters = method.GetParameters();
		if (parameters == null || parameters.Length == 0)
		{
			return new Type[0];
		}
		List<Type> list = new List<Type>();
		ParameterInfo[] array = parameters;
		foreach (ParameterInfo parameterInfo in array)
		{
			if (!list.Contains(parameterInfo.ParameterType))
			{
				list.Add(parameterInfo.ParameterType);
			}
		}
		return list.ToArray();
	}
}
