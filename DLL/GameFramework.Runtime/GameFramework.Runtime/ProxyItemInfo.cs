using System;
using System.Collections;
using System.Reflection;

namespace GameFramework.Runtime;

public class ProxyItemInfo : IProxyItemInfo, IProxyMemberInfo
{
	private readonly bool isValueType;

	private TypeCode typeCode;

	protected PropertyInfo propertyInfo;

	protected MethodInfo getMethod;

	protected MethodInfo setMethod;

	public bool IsValueType => isValueType;

	public Type ValueType => propertyInfo.PropertyType;

	public TypeCode ValueTypeCode
	{
		get
		{
			if (typeCode == TypeCode.Empty)
			{
				typeCode = Type.GetTypeCode(ValueType);
			}
			return typeCode;
		}
	}

	public Type DeclaringType => propertyInfo.DeclaringType;

	public string Name => propertyInfo.Name;

	public bool IsStatic => propertyInfo.IsStatic();

	public ProxyItemInfo(PropertyInfo propertyInfo)
	{
		if (propertyInfo == null)
		{
			throw new ArgumentNullException("propertyInfo");
		}
		if (!propertyInfo.Name.Equals("Item"))
		{
			throw new ArgumentException("The property types do not match!");
		}
		if (!typeof(ICollection).IsAssignableFrom(propertyInfo.DeclaringType))
		{
			throw new ArgumentException("The property types do not match!");
		}
		this.propertyInfo = propertyInfo;
		isValueType = this.propertyInfo.DeclaringType.IsValueType;
		if (this.propertyInfo.CanRead)
		{
			getMethod = propertyInfo.GetGetMethod();
		}
		if (this.propertyInfo.CanWrite)
		{
			setMethod = propertyInfo.GetSetMethod();
		}
	}

	public object GetValue(object target, object key)
	{
		if (target is IList)
		{
			int num = (int)key;
			IList list = target as IList;
			if (num < 0 || num >= list.Count)
			{
				throw new ArgumentOutOfRangeException("key", $"The index is out of range, the key value is {num}, it is not between 0 and {list.Count}");
			}
			return list[num];
		}
		if (target is IDictionary)
		{
			IDictionary dictionary = target as IDictionary;
			if (!dictionary.Contains(key))
			{
				return null;
			}
			return dictionary[key];
		}
		if (getMethod == null)
		{
			throw new MemberAccessException();
		}
		return getMethod.Invoke(target, new object[1] { key });
	}

	public void SetValue(object target, object key, object value)
	{
		if (target is IList)
		{
			int num = (int)key;
			IList list = target as IList;
			if (num < 0 || num >= list.Count)
			{
				throw new ArgumentOutOfRangeException("key", $"The index is out of range, the key value is {num}, it is not between 0 and {list.Count}");
			}
			list[num] = value;
		}
		else if (target is IDictionary)
		{
			((IDictionary)target)[key] = value;
		}
		else
		{
			if (setMethod == null)
			{
				throw new MemberAccessException();
			}
			setMethod.Invoke(target, new object[2] { key, value });
		}
	}
}
