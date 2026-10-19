using System;
using System.Linq.Expressions;
using System.Reflection;
using UnityEngine;

namespace Unity.VisualScripting;

public class InstanceFieldAccessor<TTarget, TField> : IOptimizedAccessor
{
	private readonly FieldInfo fieldInfo;

	private Func<TTarget, TField> getter;

	private Action<TTarget, TField> setter;

	public InstanceFieldAccessor(FieldInfo fieldInfo)
	{
		if (OptimizedReflection.safeMode)
		{
			Ensure.That("fieldInfo").IsNotNull(fieldInfo);
			if (fieldInfo.DeclaringType != typeof(TTarget))
			{
				throw new ArgumentException("Declaring type of field info doesn't match generic type.", "fieldInfo");
			}
			if (fieldInfo.FieldType != typeof(TField))
			{
				throw new ArgumentException("Field type of field info doesn't match generic type.", "fieldInfo");
			}
			if (fieldInfo.IsStatic)
			{
				throw new ArgumentException("The field is static.", "fieldInfo");
			}
		}
		this.fieldInfo = fieldInfo;
	}

	public void Compile()
	{
		if (OptimizedReflection.useJit)
		{
			ParameterExpression parameterExpression = Expression.Parameter(typeof(TTarget), "target");
			MemberExpression memberExpression = Expression.Field(parameterExpression, fieldInfo);
			getter = Expression.Lambda<Func<TTarget, TField>>(memberExpression, new ParameterExpression[1] { parameterExpression }).Compile();
			if (fieldInfo.CanWrite())
			{
				try
				{
					ParameterExpression parameterExpression2 = Expression.Parameter(typeof(TField));
					BinaryExpression body = Expression.Assign(memberExpression, parameterExpression2);
					setter = Expression.Lambda<Action<TTarget, TField>>(body, new ParameterExpression[2] { parameterExpression, parameterExpression2 }).Compile();
					return;
				}
				catch
				{
					Debug.Log("Failed instance field: " + fieldInfo);
					throw;
				}
			}
			return;
		}
		getter = (TTarget instance) => (TField)fieldInfo.GetValue(instance);
		if (fieldInfo.CanWrite())
		{
			setter = (TTarget instance, TField value) =>
			{
				fieldInfo.SetValue(instance, value);
			};
		}
	}

	public object GetValue(object target)
	{
		if (OptimizedReflection.safeMode)
		{
			OptimizedReflection.VerifyInstanceTarget<TTarget>(target);
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
				throw new TargetException($"The field '{typeof(TTarget)}.{fieldInfo.Name}' cannot be assigned.");
			}
			if (!typeof(TField).IsAssignableFrom(value))
			{
				throw new ArgumentException(string.Format("The provided value for '{0}.{1}' does not match the field type.\nProvided: {2}\nExpected: {3}", typeof(TTarget), fieldInfo.Name, value?.GetType()?.ToString() ?? "null", typeof(TField)));
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
		setter((TTarget)target, (TField)value);
	}
}
