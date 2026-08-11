using System;
using System.Reflection;
using UnityEngine.UIElements;

namespace GameFramework.Runtime;

public class VisualElementProxyFactory : ITargetProxyFactory
{
	public ITargetProxy CreateProxy(object target, BindingDescription description)
	{
		//IL_0130: Unknown result type (might be due to invalid IL or missing references)
		//IL_013a: Expected O, but got Unknown
		//IL_01e5: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ef: Expected O, but got Unknown
		if (!target.GetType().IsSubclassOfGenericTypeDefinition(typeof(INotifyValueChanged<>)))
		{
			return null;
		}
		if ("RegisterValueChangedCallback".Equals(description.TargetName))
		{
			return CreateValueChangedEventProxy(target);
		}
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
		if (member is IProxyPropertyInfo proxyPropertyInfo)
		{
			if (typeof(IObservableProperty).IsAssignableFrom(proxyPropertyInfo.ValueType))
			{
				return null;
			}
			if (typeof(Clickable).IsAssignableFrom(proxyPropertyInfo.ValueType))
			{
				object value = proxyPropertyInfo.GetValue(target);
				if (value == null)
				{
					throw new NullReferenceException(proxyPropertyInfo.Name);
				}
				return new ClickableEventProxy(target, (Clickable)value);
			}
			if (!"RegisterValueChangedCallback".Equals(description.UpdateTrigger))
			{
				return null;
			}
			return CreateVisualElementPropertyProxy(target, proxyPropertyInfo);
		}
		if (member is IProxyFieldInfo proxyFieldInfo)
		{
			if (typeof(IObservableProperty).IsAssignableFrom(proxyFieldInfo.ValueType))
			{
				return null;
			}
			if (typeof(Clickable).IsAssignableFrom(proxyFieldInfo.ValueType))
			{
				object value2 = proxyFieldInfo.GetValue(target);
				if (value2 == null)
				{
					throw new NullReferenceException(proxyFieldInfo.Name);
				}
				return new ClickableEventProxy(target, (Clickable)value2);
			}
			if (!"RegisterValueChangedCallback".Equals(description.UpdateTrigger))
			{
				return null;
			}
			return CreateVisualElementFieldProxy(target, proxyFieldInfo);
		}
		return null;
	}

	protected virtual ITargetProxy CreateValueChangedEventProxy(object target)
	{
		PropertyInfo property = target.GetType().GetProperty("value");
		Type propertyType = property.PropertyType;
		switch (Type.GetTypeCode(propertyType))
		{
		case TypeCode.String:
			return new ValueChangedEventProxy<string>((INotifyValueChanged<string>)target);
		case TypeCode.Boolean:
			return new ValueChangedEventProxy<bool>((INotifyValueChanged<bool>)target);
		case TypeCode.SByte:
			return new ValueChangedEventProxy<sbyte>((INotifyValueChanged<sbyte>)target);
		case TypeCode.Byte:
			return new ValueChangedEventProxy<byte>((INotifyValueChanged<byte>)target);
		case TypeCode.Int16:
			return new ValueChangedEventProxy<short>((INotifyValueChanged<short>)target);
		case TypeCode.UInt16:
			return new ValueChangedEventProxy<ushort>((INotifyValueChanged<ushort>)target);
		case TypeCode.Int32:
			return new ValueChangedEventProxy<int>((INotifyValueChanged<int>)target);
		case TypeCode.UInt32:
			return new ValueChangedEventProxy<uint>((INotifyValueChanged<uint>)target);
		case TypeCode.Int64:
			return new ValueChangedEventProxy<long>((INotifyValueChanged<long>)target);
		case TypeCode.UInt64:
			return new ValueChangedEventProxy<ulong>((INotifyValueChanged<ulong>)target);
		case TypeCode.Char:
			return new ValueChangedEventProxy<char>((INotifyValueChanged<char>)target);
		case TypeCode.Single:
			return new ValueChangedEventProxy<float>((INotifyValueChanged<float>)target);
		case TypeCode.Double:
			return new ValueChangedEventProxy<double>((INotifyValueChanged<double>)target);
		case TypeCode.Decimal:
			return new ValueChangedEventProxy<decimal>((INotifyValueChanged<decimal>)target);
		case TypeCode.DateTime:
			return new ValueChangedEventProxy<DateTime>((INotifyValueChanged<DateTime>)target);
		default:
			try
			{
				return (ITargetProxy)Activator.CreateInstance(typeof(ValueChangedEventProxy<>).MakeGenericType(propertyType), target);
			}
			catch (Exception innerException)
			{
				throw new NotSupportedException("", innerException);
			}
		}
	}

	protected virtual ITargetProxy CreateVisualElementPropertyProxy(object target, IProxyPropertyInfo propertyInfo)
	{
		Type valueType = propertyInfo.ValueType;
		switch (Type.GetTypeCode(valueType))
		{
		case TypeCode.String:
			return new VisualElementPropertyProxy<string>(target, propertyInfo);
		case TypeCode.Boolean:
			return new VisualElementPropertyProxy<bool>(target, propertyInfo);
		case TypeCode.SByte:
			return new VisualElementPropertyProxy<sbyte>(target, propertyInfo);
		case TypeCode.Byte:
			return new VisualElementPropertyProxy<byte>(target, propertyInfo);
		case TypeCode.Int16:
			return new VisualElementPropertyProxy<short>(target, propertyInfo);
		case TypeCode.UInt16:
			return new VisualElementPropertyProxy<ushort>(target, propertyInfo);
		case TypeCode.Int32:
			return new VisualElementPropertyProxy<int>(target, propertyInfo);
		case TypeCode.UInt32:
			return new VisualElementPropertyProxy<uint>(target, propertyInfo);
		case TypeCode.Int64:
			return new VisualElementPropertyProxy<long>(target, propertyInfo);
		case TypeCode.UInt64:
			return new VisualElementPropertyProxy<ulong>(target, propertyInfo);
		case TypeCode.Char:
			return new VisualElementPropertyProxy<char>(target, propertyInfo);
		case TypeCode.Single:
			return new VisualElementPropertyProxy<float>(target, propertyInfo);
		case TypeCode.Double:
			return new VisualElementPropertyProxy<double>(target, propertyInfo);
		case TypeCode.Decimal:
			return new VisualElementPropertyProxy<decimal>(target, propertyInfo);
		case TypeCode.DateTime:
			return new VisualElementPropertyProxy<DateTime>(target, propertyInfo);
		default:
			try
			{
				return (ITargetProxy)Activator.CreateInstance(typeof(VisualElementPropertyProxy<>).MakeGenericType(valueType), target, propertyInfo);
			}
			catch (Exception innerException)
			{
				throw new NotSupportedException("", innerException);
			}
		}
	}

	protected virtual ITargetProxy CreateVisualElementFieldProxy(object target, IProxyFieldInfo fieldInfo)
	{
		Type valueType = fieldInfo.ValueType;
		switch (Type.GetTypeCode(valueType))
		{
		case TypeCode.String:
			return new VisualElementFieldProxy<string>(target, fieldInfo);
		case TypeCode.Boolean:
			return new VisualElementFieldProxy<bool>(target, fieldInfo);
		case TypeCode.SByte:
			return new VisualElementFieldProxy<sbyte>(target, fieldInfo);
		case TypeCode.Byte:
			return new VisualElementFieldProxy<byte>(target, fieldInfo);
		case TypeCode.Int16:
			return new VisualElementFieldProxy<short>(target, fieldInfo);
		case TypeCode.UInt16:
			return new VisualElementFieldProxy<ushort>(target, fieldInfo);
		case TypeCode.Int32:
			return new VisualElementFieldProxy<int>(target, fieldInfo);
		case TypeCode.UInt32:
			return new VisualElementFieldProxy<uint>(target, fieldInfo);
		case TypeCode.Int64:
			return new VisualElementFieldProxy<long>(target, fieldInfo);
		case TypeCode.UInt64:
			return new VisualElementFieldProxy<ulong>(target, fieldInfo);
		case TypeCode.Char:
			return new VisualElementFieldProxy<char>(target, fieldInfo);
		case TypeCode.Single:
			return new VisualElementFieldProxy<float>(target, fieldInfo);
		case TypeCode.Double:
			return new VisualElementFieldProxy<double>(target, fieldInfo);
		case TypeCode.Decimal:
			return new VisualElementFieldProxy<decimal>(target, fieldInfo);
		case TypeCode.DateTime:
			return new VisualElementFieldProxy<DateTime>(target, fieldInfo);
		default:
			try
			{
				return (ITargetProxy)Activator.CreateInstance(typeof(VisualElementFieldProxy<>).MakeGenericType(valueType), target, fieldInfo);
			}
			catch (Exception innerException)
			{
				throw new NotSupportedException("", innerException);
			}
		}
	}
}
