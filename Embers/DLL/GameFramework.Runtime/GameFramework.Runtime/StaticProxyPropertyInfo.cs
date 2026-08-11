#define ENABLE_DEBUG_AND_ABOVE_LOG
using System;
using System.Reflection;

namespace GameFramework.Runtime;

public class StaticProxyPropertyInfo<T, TValue> : ProxyPropertyInfo, IProxyPropertyInfo<T, TValue>, IProxyPropertyInfo<TValue>, IProxyPropertyInfo, IProxyMemberInfo
{
	private Func<TValue> getter;

	private Action<TValue> setter;

	public override Type DeclaringType => typeof(T);

	public StaticProxyPropertyInfo(string propertyName)
		: this(typeof(T).GetProperty(propertyName))
	{
	}

	public StaticProxyPropertyInfo(PropertyInfo propertyInfo)
		: base(propertyInfo)
	{
		if (!typeof(TValue).Equals(base.propertyInfo.PropertyType) || !propertyInfo.DeclaringType.IsAssignableFrom(typeof(T)))
		{
			throw new ArgumentException("The property types do not match!");
		}
		if (!IsStatic)
		{
			throw new ArgumentException("The property isn't static!");
		}
		getter = MakeGetter(propertyInfo);
		setter = MakeSetter(propertyInfo);
	}

	public StaticProxyPropertyInfo(string propertyName, Func<TValue> getter, Action<TValue> setter)
		: this(typeof(T).GetProperty(propertyName), getter, setter)
	{
	}

	public StaticProxyPropertyInfo(PropertyInfo propertyInfo, Func<TValue> getter, Action<TValue> setter)
		: base(propertyInfo)
	{
		if (!typeof(TValue).Equals(base.propertyInfo.PropertyType) || !propertyInfo.DeclaringType.IsAssignableFrom(typeof(T)))
		{
			throw new ArgumentException("The property types do not match!");
		}
		if (!IsStatic)
		{
			throw new ArgumentException("The property isn't static!");
		}
		this.getter = getter;
		this.setter = setter;
	}

	private Action<TValue> MakeSetter(PropertyInfo propertyInfo)
	{
		try
		{
			if (IsValueType)
			{
				return null;
			}
			MethodInfo methodInfo = propertyInfo.GetSetMethod();
			if (methodInfo == null)
			{
				return null;
			}
			return (Action<TValue>)methodInfo.CreateDelegate(typeof(Action<TValue>));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	private Func<TValue> MakeGetter(PropertyInfo propertyInfo)
	{
		try
		{
			if (IsValueType)
			{
				return null;
			}
			MethodInfo methodInfo = propertyInfo.GetGetMethod();
			if (methodInfo == null)
			{
				return null;
			}
			return (Func<TValue>)methodInfo.CreateDelegate(typeof(Func<TValue>));
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	public TValue GetValue(T target)
	{
		if (getter != null)
		{
			return getter();
		}
		return (TValue)base.GetValue(null);
	}

	TValue IProxyPropertyInfo<TValue>.GetValue(object target)
	{
		return GetValue((T)target);
	}

	public override object GetValue(object target)
	{
		if (getter != null)
		{
			return getter();
		}
		return base.GetValue(target);
	}

	public void SetValue(T target, TValue value)
	{
		if (setter != null)
		{
			setter(value);
		}
		else
		{
			base.SetValue(null, value);
		}
	}

	public void SetValue(object target, TValue value)
	{
		SetValue((T)target, value);
	}

	public override void SetValue(object target, object value)
	{
		if (setter != null)
		{
			setter((TValue)value);
		}
		else
		{
			base.SetValue(null, value);
		}
	}
}
