using System;
using System.Collections;
using System.Reflection;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public class UniversalNodeProxyFactory : INodeProxyFactory
{
	public ISourceProxy Create(object source, PathToken token)
	{
		IPathNode current = token.Current;
		if (source == null && !current.IsStatic)
		{
			return null;
		}
		if (current.IsStatic)
		{
			return CreateStaticProxy(current);
		}
		return CreateProxy(source, current);
	}

	protected virtual ISourceProxy CreateProxy(object source, IPathNode node)
	{
		IProxyType proxyType = source.GetType().AsProxy();
		if (node is IndexedNode)
		{
			if (!(source is ICollection))
			{
				throw new ProxyException("Type \"{0}\" is not a collection and cannot be accessed by index \"{1}\".", proxyType.Type.Name, node.ToString());
			}
			IProxyItemInfo item = proxyType.GetItem();
			if (item == null)
			{
				throw new MissingMemberException(proxyType.Type.FullName, "Item");
			}
			if (node is IntegerIndexedNode integerIndexedNode)
			{
				return new IntItemNodeProxy((ICollection)source, integerIndexedNode.Value, item);
			}
			if (node is StringIndexedNode stringIndexedNode)
			{
				return new StringItemNodeProxy((ICollection)source, stringIndexedNode.Value, item);
			}
			return null;
		}
		if (!(node is MemberNode { MemberInfo: var memberInfo } memberNode))
		{
			return null;
		}
		if (memberInfo != null && !memberInfo.DeclaringType.IsAssignableFrom(source.GetType()))
		{
			return null;
		}
		if (memberInfo == null)
		{
			memberInfo = source.GetType().FindFirstMemberInfo(memberNode.Name);
		}
		if (memberInfo == null || memberInfo.IsStatic())
		{
			throw new MissingMemberException(proxyType.Type.FullName, memberNode.Name);
		}
		PropertyInfo propertyInfo = memberInfo as PropertyInfo;
		if (propertyInfo != null)
		{
			IProxyPropertyInfo proxyPropertyInfo = propertyInfo.AsProxy();
			Type valueType = proxyPropertyInfo.ValueType;
			if (typeof(IObservableProperty).IsAssignableFrom(valueType))
			{
				object value = proxyPropertyInfo.GetValue(source);
				if (value == null)
				{
					return null;
				}
				return new ObservableNodeProxy(source, (IObservableProperty)value);
			}
			if (typeof(IInteractionRequest).IsAssignableFrom(valueType))
			{
				object value2 = proxyPropertyInfo.GetValue(source);
				if (value2 == null)
				{
					return null;
				}
				return new InteractionNodeProxy(source, (IInteractionRequest)value2);
			}
			return new PropertyNodeProxy(source, proxyPropertyInfo);
		}
		FieldInfo fieldInfo = memberInfo as FieldInfo;
		if (fieldInfo != null)
		{
			IProxyFieldInfo proxyFieldInfo = fieldInfo.AsProxy();
			Type valueType2 = proxyFieldInfo.ValueType;
			if (typeof(IObservableProperty).IsAssignableFrom(valueType2))
			{
				object value3 = proxyFieldInfo.GetValue(source);
				if (value3 == null)
				{
					return null;
				}
				return new ObservableNodeProxy(source, (IObservableProperty)value3);
			}
			if (typeof(IInteractionRequest).IsAssignableFrom(valueType2))
			{
				object value4 = proxyFieldInfo.GetValue(source);
				if (value4 == null)
				{
					return null;
				}
				return new InteractionNodeProxy(source, (IInteractionRequest)value4);
			}
			return new FieldNodeProxy(source, proxyFieldInfo);
		}
		MethodInfo methodInfo = memberInfo as MethodInfo;
		if (methodInfo != null && methodInfo.ReturnType.Equals(typeof(void)))
		{
			return new MethodNodeProxy(source, methodInfo.AsProxy());
		}
		EventInfo eventInfo = memberInfo as EventInfo;
		if (eventInfo != null)
		{
			return new EventNodeProxy(source, eventInfo.AsProxy());
		}
		return null;
	}

	protected virtual ISourceProxy CreateStaticProxy(IPathNode node)
	{
		if (!(node is MemberNode { Type: var type, MemberInfo: var memberInfo } memberNode))
		{
			return null;
		}
		if (memberInfo == null)
		{
			memberInfo = type.FindFirstMemberInfo(memberNode.Name, BindingFlags.Static | BindingFlags.Public);
		}
		if (memberInfo == null)
		{
			throw new MissingMemberException(type.FullName, memberNode.Name);
		}
		PropertyInfo propertyInfo = memberInfo as PropertyInfo;
		if (propertyInfo != null)
		{
			IProxyPropertyInfo proxyPropertyInfo = propertyInfo.AsProxy();
			Type valueType = proxyPropertyInfo.ValueType;
			if (typeof(IObservableProperty).IsAssignableFrom(valueType))
			{
				object value = proxyPropertyInfo.GetValue(null);
				if (value == null)
				{
					throw new NullReferenceException($"The \"{propertyInfo.Name}\" property is null in class \"{type.Name}\".");
				}
				return new ObservableNodeProxy((IObservableProperty)value);
			}
			if (typeof(IInteractionRequest).IsAssignableFrom(valueType))
			{
				object value2 = proxyPropertyInfo.GetValue(null);
				if (value2 == null)
				{
					throw new NullReferenceException($"The \"{propertyInfo.Name}\" property is null in class \"{type.Name}\".");
				}
				return new InteractionNodeProxy((IInteractionRequest)value2);
			}
			return new PropertyNodeProxy(proxyPropertyInfo);
		}
		FieldInfo fieldInfo = memberInfo as FieldInfo;
		if (fieldInfo != null)
		{
			IProxyFieldInfo proxyFieldInfo = fieldInfo.AsProxy();
			Type valueType2 = proxyFieldInfo.ValueType;
			if (typeof(IObservableProperty).IsAssignableFrom(valueType2))
			{
				object value3 = proxyFieldInfo.GetValue(null);
				if (value3 == null)
				{
					throw new NullReferenceException($"The \"{fieldInfo.Name}\" property is null in class \"{type.Name}\".");
				}
				return new ObservableNodeProxy((IObservableProperty)value3);
			}
			if (typeof(IInteractionRequest).IsAssignableFrom(valueType2))
			{
				object value4 = proxyFieldInfo.GetValue(null);
				if (value4 == null)
				{
					throw new NullReferenceException($"The \"{fieldInfo.Name}\" property is null in class \"{type.Name}\".");
				}
				return new InteractionNodeProxy((IInteractionRequest)value4);
			}
			return new FieldNodeProxy(proxyFieldInfo);
		}
		MethodInfo methodInfo = memberInfo as MethodInfo;
		if (methodInfo != null && methodInfo.ReturnType.Equals(typeof(void)))
		{
			return new MethodNodeProxy(methodInfo.AsProxy());
		}
		EventInfo eventInfo = memberInfo as EventInfo;
		if (eventInfo != null)
		{
			return new EventNodeProxy(eventInfo.AsProxy());
		}
		return null;
	}
}
