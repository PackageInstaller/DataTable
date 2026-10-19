using System;
using System.Linq.Expressions;
using System.Reflection;

namespace Unity.VisualScripting;

public class StaticPropertyAccessor<TProperty> : IOptimizedAccessor
{
	private readonly PropertyInfo propertyInfo;

	private Func<TProperty> getter;

	private Action<TProperty> setter;

	private Type targetType;

	public StaticPropertyAccessor(PropertyInfo propertyInfo)
	{
		if (OptimizedReflection.safeMode)
		{
			if (propertyInfo == null)
			{
				throw new ArgumentNullException("propertyInfo");
			}
			if (propertyInfo.PropertyType != typeof(TProperty))
			{
				throw new ArgumentException("The property type of the property info doesn't match the generic type.", "propertyInfo");
			}
			if (!propertyInfo.IsStatic())
			{
				throw new ArgumentException("The property isn't static.", "propertyInfo");
			}
		}
		this.propertyInfo = propertyInfo;
		targetType = propertyInfo.DeclaringType;
	}

	public void Compile()
	{
		MethodInfo getMethod = propertyInfo.GetGetMethod(nonPublic: true);
		MethodInfo setMethod = propertyInfo.GetSetMethod(nonPublic: true);
		if (OptimizedReflection.useJit)
		{
			if (getMethod != null)
			{
				MemberExpression body = Expression.Property(null, propertyInfo);
				getter = Expression.Lambda<Func<TProperty>>(body, Array.Empty<ParameterExpression>()).Compile();
			}
			if (setMethod != null)
			{
				setter = (Action<TProperty>)setMethod.CreateDelegate(typeof(Action<TProperty>));
			}
		}
		else
		{
			if (getMethod != null)
			{
				getter = (Func<TProperty>)getMethod.CreateDelegate(typeof(Func<TProperty>));
			}
			if (setMethod != null)
			{
				setter = (Action<TProperty>)setMethod.CreateDelegate(typeof(Action<TProperty>));
			}
		}
	}

	public object GetValue(object target)
	{
		if (OptimizedReflection.safeMode)
		{
			OptimizedReflection.VerifyStaticTarget(targetType, target);
			if (getter == null)
			{
				throw new TargetException($"The property '{targetType}.{propertyInfo.Name}' has no get accessor.");
			}
			try
			{
				return GetValueUnsafe(target);
			}
			catch (TargetInvocationException)
			{
				throw;
			}
			catch (Exception inner)
			{
				throw new TargetInvocationException(inner);
			}
		}
		return GetValueUnsafe(target);
	}

	private object GetValueUnsafe(object target)
	{
		return getter();
	}

	public void SetValue(object target, object value)
	{
		if (OptimizedReflection.safeMode)
		{
			OptimizedReflection.VerifyStaticTarget(targetType, target);
			if (setter == null)
			{
				throw new TargetException($"The property '{targetType}.{propertyInfo.Name}' has no set accessor.");
			}
			if (!typeof(TProperty).IsAssignableFrom(value))
			{
				throw new ArgumentException(string.Format("The provided value for '{0}.{1}' does not match the property type.\nProvided: {2}\nExpected: {3}", targetType, propertyInfo.Name, value?.GetType()?.ToString() ?? "null", typeof(TProperty)));
			}
			try
			{
				SetValueUnsafe(target, value);
				return;
			}
			catch (TargetInvocationException)
			{
				throw;
			}
			catch (Exception inner)
			{
				throw new TargetInvocationException(inner);
			}
		}
		SetValueUnsafe(target, value);
	}

	private void SetValueUnsafe(object target, object value)
	{
		setter((TProperty)value);
	}
}
