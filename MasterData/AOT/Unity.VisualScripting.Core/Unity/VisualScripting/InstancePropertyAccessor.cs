using System;
using System.Linq.Expressions;
using System.Reflection;

namespace Unity.VisualScripting;

public class InstancePropertyAccessor<TTarget, TProperty> : IOptimizedAccessor
{
	private readonly PropertyInfo propertyInfo;

	private Func<TTarget, TProperty> getter;

	private Action<TTarget, TProperty> setter;

	public InstancePropertyAccessor(PropertyInfo propertyInfo)
	{
		if (OptimizedReflection.safeMode)
		{
			Ensure.That("propertyInfo").IsNotNull(propertyInfo);
			if (propertyInfo.DeclaringType != typeof(TTarget))
			{
				throw new ArgumentException("The declaring type of the property info doesn't match the generic type.", "propertyInfo");
			}
			if (propertyInfo.PropertyType != typeof(TProperty))
			{
				throw new ArgumentException("The property type of the property info doesn't match the generic type.", "propertyInfo");
			}
			if (propertyInfo.IsStatic())
			{
				throw new ArgumentException("The property is static.", "propertyInfo");
			}
		}
		this.propertyInfo = propertyInfo;
	}

	public void Compile()
	{
		MethodInfo getMethod = propertyInfo.GetGetMethod(nonPublic: true);
		MethodInfo setMethod = propertyInfo.GetSetMethod(nonPublic: true);
		if (OptimizedReflection.useJit)
		{
			ParameterExpression parameterExpression = Expression.Parameter(typeof(TTarget), "target");
			if (getMethod != null)
			{
				MemberExpression body = Expression.Property(parameterExpression, propertyInfo);
				getter = Expression.Lambda<Func<TTarget, TProperty>>(body, new ParameterExpression[1] { parameterExpression }).Compile();
			}
			if (setMethod != null)
			{
				setter = (Action<TTarget, TProperty>)setMethod.CreateDelegate(typeof(Action<TTarget, TProperty>));
			}
		}
		else
		{
			if (getMethod != null)
			{
				getter = (Func<TTarget, TProperty>)getMethod.CreateDelegate(typeof(Func<TTarget, TProperty>));
			}
			if (setMethod != null)
			{
				setter = (Action<TTarget, TProperty>)setMethod.CreateDelegate(typeof(Action<TTarget, TProperty>));
			}
		}
	}

	public object GetValue(object target)
	{
		if (OptimizedReflection.safeMode)
		{
			OptimizedReflection.VerifyInstanceTarget<TTarget>(target);
			if (getter == null)
			{
				throw new TargetException($"The property '{typeof(TTarget)}.{propertyInfo.Name}' has no get accessor.");
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
		return getter((TTarget)target);
	}

	public void SetValue(object target, object value)
	{
		if (OptimizedReflection.safeMode)
		{
			OptimizedReflection.VerifyInstanceTarget<TTarget>(target);
			if (setter == null)
			{
				throw new TargetException($"The property '{typeof(TTarget)}.{propertyInfo.Name}' has no set accessor.");
			}
			if (!typeof(TProperty).IsAssignableFrom(value))
			{
				throw new ArgumentException(string.Format("The provided value for '{0}.{1}' does not match the property type.\nProvided: {2}\nExpected: {3}", typeof(TTarget), propertyInfo.Name, value?.GetType()?.ToString() ?? "null", typeof(TProperty)));
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
		setter((TTarget)target, (TProperty)value);
	}
}
