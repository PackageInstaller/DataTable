using System;
using System.Linq.Expressions;
using System.Reflection;

namespace Unity.VisualScripting;

public class StaticFieldAccessor<TField> : IOptimizedAccessor
{
	private readonly FieldInfo fieldInfo;

	private Func<TField> getter;

	private Action<TField> setter;

	private Type targetType;

	public StaticFieldAccessor(FieldInfo fieldInfo)
	{
		if (OptimizedReflection.safeMode)
		{
			if (fieldInfo == null)
			{
				throw new ArgumentNullException("fieldInfo");
			}
			if (fieldInfo.FieldType != typeof(TField))
			{
				throw new ArgumentException("Field type of field info doesn't match generic type.", "fieldInfo");
			}
			if (!fieldInfo.IsStatic)
			{
				throw new ArgumentException("The field isn't static.", "fieldInfo");
			}
		}
		this.fieldInfo = fieldInfo;
		targetType = fieldInfo.DeclaringType;
	}

	public void Compile()
	{
		if (fieldInfo.IsLiteral)
		{
			TField constant = (TField)fieldInfo.GetValue(null);
			getter = () => constant;
			return;
		}
		if (OptimizedReflection.useJit)
		{
			MemberExpression memberExpression = Expression.Field(null, fieldInfo);
			getter = Expression.Lambda<Func<TField>>(memberExpression, Array.Empty<ParameterExpression>()).Compile();
			if (fieldInfo.CanWrite())
			{
				ParameterExpression parameterExpression = Expression.Parameter(typeof(TField));
				BinaryExpression body = Expression.Assign(memberExpression, parameterExpression);
				setter = Expression.Lambda<Action<TField>>(body, new ParameterExpression[1] { parameterExpression }).Compile();
			}
			return;
		}
		getter = () => (TField)fieldInfo.GetValue(null);
		if (fieldInfo.CanWrite())
		{
			setter = (TField value) =>
			{
				fieldInfo.SetValue(null, value);
			};
		}
	}

	public object GetValue(object target)
	{
		if (OptimizedReflection.safeMode)
		{
			OptimizedReflection.VerifyStaticTarget(targetType, target);
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
				throw new TargetException($"The field '{targetType}.{fieldInfo.Name}' cannot be assigned.");
			}
			if (!typeof(TField).IsAssignableFrom(value))
			{
				throw new ArgumentException(string.Format("The provided value for '{0}.{1}' does not match the field type.\nProvided: {2}\nExpected: {3}", targetType, fieldInfo.Name, value?.GetType()?.ToString() ?? "null", typeof(TField)));
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
		setter((TField)value);
	}
}
