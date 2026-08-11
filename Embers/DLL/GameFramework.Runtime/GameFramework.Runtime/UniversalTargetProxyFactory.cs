using System;
using System.Reflection;

namespace GameFramework.Runtime;

public class UniversalTargetProxyFactory : ITargetProxyFactory
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
		if (member is IProxyPropertyInfo { ValueType: var valueType } proxyPropertyInfo)
		{
			if (typeof(IObservableProperty).IsAssignableFrom(valueType))
			{
				object value = proxyPropertyInfo.GetValue(target);
				if (value == null)
				{
					throw new NullReferenceException($"The \"{proxyPropertyInfo.Name}\" property is null in class \"{proxyPropertyInfo.DeclaringType.Name}\".");
				}
				return new ObservableTargetProxy(target, (IObservableProperty)value);
			}
			if (typeof(IInteractionAction).IsAssignableFrom(valueType))
			{
				object value2 = proxyPropertyInfo.GetValue(target);
				if (value2 == null)
				{
					return null;
				}
				return new InteractionTargetProxy(target, (IInteractionAction)value2);
			}
			return new PropertyTargetProxy(target, proxyPropertyInfo);
		}
		if (member is IProxyFieldInfo { ValueType: var valueType2 } proxyFieldInfo)
		{
			if (typeof(IObservableProperty).IsAssignableFrom(valueType2))
			{
				object value3 = proxyFieldInfo.GetValue(target);
				if (value3 == null)
				{
					throw new NullReferenceException($"The \"{proxyFieldInfo.Name}\" field is null in class \"{proxyFieldInfo.DeclaringType.Name}\".");
				}
				return new ObservableTargetProxy(target, (IObservableProperty)value3);
			}
			if (typeof(IInteractionAction).IsAssignableFrom(valueType2))
			{
				object value4 = proxyFieldInfo.GetValue(target);
				if (value4 == null)
				{
					return null;
				}
				return new InteractionTargetProxy(target, (IInteractionAction)value4);
			}
			return new FieldTargetProxy(target, proxyFieldInfo);
		}
		if (member is IProxyEventInfo eventInfo)
		{
			return new EventTargetProxy(target, eventInfo);
		}
		if (member is IProxyMethodInfo methodInfo)
		{
			return new MethodTargetProxy(target, methodInfo);
		}
		return null;
	}
}
