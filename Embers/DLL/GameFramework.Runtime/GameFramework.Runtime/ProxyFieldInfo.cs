#define ENABLE_DEBUG_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using System.Reflection;

namespace GameFramework.Runtime;

public class ProxyFieldInfo : IProxyFieldInfo, IProxyMemberInfo
{
	private readonly bool isValueType;

	private TypeCode typeCode;

	protected FieldInfo fieldInfo;

	public virtual bool IsValueType => isValueType;

	public virtual Type ValueType => fieldInfo.FieldType;

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

	public virtual Type DeclaringType => fieldInfo.DeclaringType;

	public virtual string Name => fieldInfo.Name;

	public virtual bool IsStatic => fieldInfo.IsStatic();

	public ProxyFieldInfo(FieldInfo fieldInfo)
	{
		if (fieldInfo == null)
		{
			throw new ArgumentNullException("fieldInfo");
		}
		this.fieldInfo = fieldInfo;
		isValueType = this.fieldInfo.DeclaringType.IsValueType;
	}

	public virtual object GetValue(object target)
	{
		return fieldInfo.GetValue(target);
	}

	public virtual void SetValue(object target, object value)
	{
		if (fieldInfo.IsInitOnly)
		{
			throw new MemberAccessException("The value is read-only.");
		}
		if (IsValueType)
		{
			throw new NotSupportedException("Assignments of Value type are not supported.");
		}
		fieldInfo.SetValue(target, value);
	}
}
public class ProxyFieldInfo<T, TValue> : ProxyFieldInfo, IProxyFieldInfo<T, TValue>, IProxyFieldInfo<TValue>, IProxyFieldInfo, IProxyMemberInfo
{
	private Func<T, TValue> getter;

	private Action<T, TValue> setter;

	public override Type DeclaringType => typeof(T);

	public ProxyFieldInfo(string fieldName)
		: this(typeof(T).GetField(fieldName))
	{
	}

	public ProxyFieldInfo(FieldInfo fieldInfo)
		: base(fieldInfo)
	{
		if (!typeof(TValue).Equals(base.fieldInfo.FieldType) || !DeclaringType.IsAssignableFrom(typeof(T)))
		{
			throw new ArgumentException("The field types do not match!");
		}
		getter = MakeGetter(fieldInfo);
		setter = MakeSetter(fieldInfo);
	}

	public ProxyFieldInfo(string fieldName, Func<T, TValue> getter, Action<T, TValue> setter)
		: this(typeof(T).GetField(fieldName), getter, setter)
	{
	}

	public ProxyFieldInfo(FieldInfo fieldInfo, Func<T, TValue> getter, Action<T, TValue> setter)
		: base(fieldInfo)
	{
		if (!typeof(TValue).Equals(base.fieldInfo.FieldType) || !DeclaringType.IsAssignableFrom(typeof(T)))
		{
			throw new ArgumentException("The field types do not match!");
		}
		this.getter = getter;
		this.setter = setter;
	}

	private Action<T, TValue> MakeSetter(FieldInfo fieldInfo)
	{
		if (IsValueType)
		{
			return null;
		}
		if (fieldInfo.IsInitOnly)
		{
			return null;
		}
		try
		{
			bool flag = false;
			if (1 == 0 || (!typeof(T).IsValueType && !typeof(TValue).IsValueType))
			{
				ParameterExpression parameterExpression = Expression.Parameter(typeof(T), "target");
				ParameterExpression parameterExpression2 = Expression.Parameter(typeof(TValue), "value");
				MemberExpression left = Expression.Field(fieldInfo.IsStatic ? null : parameterExpression, fieldInfo);
				BinaryExpression body = Expression.Assign(left, parameterExpression2);
				Expression<Action<T, TValue>> expression = Expression.Lambda<Action<T, TValue>>(body, new ParameterExpression[2] { parameterExpression, parameterExpression2 });
				return expression.Compile();
			}
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		return null;
	}

	private Func<T, TValue> MakeGetter(FieldInfo fieldInfo)
	{
		try
		{
			bool flag = false;
			if (1 == 0 || (!typeof(T).IsValueType && !typeof(TValue).IsValueType))
			{
				ParameterExpression parameterExpression = Expression.Parameter(typeof(T), "target");
				MemberExpression body = Expression.Field(fieldInfo.IsStatic ? null : parameterExpression, fieldInfo);
				Expression<Func<T, TValue>> expression = Expression.Lambda<Func<T, TValue>>(body, new ParameterExpression[1] { parameterExpression });
				return expression.Compile();
			}
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
			return getter(target);
		}
		return (TValue)fieldInfo.GetValue(target);
	}

	public override object GetValue(object target)
	{
		if (getter != null)
		{
			return getter((T)target);
		}
		return fieldInfo.GetValue(target);
	}

	TValue IProxyFieldInfo<TValue>.GetValue(object target)
	{
		return GetValue((T)target);
	}

	public void SetValue(T target, TValue value)
	{
		if (fieldInfo.IsInitOnly)
		{
			throw new MemberAccessException("The value is read-only.");
		}
		if (IsValueType)
		{
			throw new NotSupportedException("Assignments of Value type are not supported.");
		}
		if (setter != null)
		{
			setter(target, value);
		}
		else
		{
			fieldInfo.SetValue(target, value);
		}
	}

	public override void SetValue(object target, object value)
	{
		if (fieldInfo.IsInitOnly)
		{
			throw new MemberAccessException("The value is read-only.");
		}
		if (IsValueType)
		{
			throw new NotSupportedException("Assignments of Value type are not supported.");
		}
		if (setter != null)
		{
			setter((T)target, (TValue)value);
		}
		else
		{
			fieldInfo.SetValue(target, value);
		}
	}

	public void SetValue(object target, TValue value)
	{
		SetValue((T)target, value);
	}
}
