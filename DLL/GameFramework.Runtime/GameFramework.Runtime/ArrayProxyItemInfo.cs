using System;
using System.Collections.Generic;

namespace GameFramework.Runtime;

public class ArrayProxyItemInfo : IProxyItemInfo, IProxyMemberInfo
{
	private TypeCode typeCode;

	protected readonly Type type;

	public Type ValueType => type.HasElementType ? type.GetElementType() : typeof(object);

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

	public Type DeclaringType => type;

	public string Name => "Item";

	public bool IsStatic => false;

	public ArrayProxyItemInfo(Type type)
	{
		this.type = type;
		if (this.type == null || !this.type.IsArray)
		{
			throw new ArgumentException();
		}
	}

	public virtual object GetValue(object target, object key)
	{
		int num = (int)key;
		Array array = target as Array;
		if (num < 0 || num >= array.Length)
		{
			throw new ArgumentOutOfRangeException("key", $"The index is out of range, the key value is {num}, it is not between 0 and {array.Length}");
		}
		return array.GetValue(num);
	}

	public virtual void SetValue(object target, object key, object value)
	{
		int num = (int)key;
		Array array = target as Array;
		if (num < 0 || num >= array.Length)
		{
			throw new ArgumentOutOfRangeException("key", $"The index is out of range, the key value is {num}, it is not between 0 and {array.Length}");
		}
		array.SetValue(value, num);
	}
}
public class ArrayProxyItemInfo<T, TValue> : ArrayProxyItemInfo, IProxyItemInfo<T, int, TValue>, IProxyItemInfo<int, TValue>, IProxyItemInfo, IProxyMemberInfo where T : IList<TValue>
{
	public ArrayProxyItemInfo()
		: base(typeof(T))
	{
	}

	public TValue GetValue(T target, int key)
	{
		if (key < 0 || key >= target.Count)
		{
			throw new ArgumentOutOfRangeException("key", $"The index is out of range, the key value is {key}, it is not between 0 and {target.Count}");
		}
		return target[key];
	}

	public TValue GetValue(object target, int key)
	{
		return GetValue((T)target, key);
	}

	public void SetValue(T target, int key, TValue value)
	{
		if (key < 0 || key >= target.Count)
		{
			throw new ArgumentOutOfRangeException("key", $"The index is out of range, the key value is {key}, it is not between 0 and {target.Count}");
		}
		target[key] = value;
	}

	public void SetValue(object target, int key, TValue value)
	{
		SetValue((T)target, key, value);
	}
}
