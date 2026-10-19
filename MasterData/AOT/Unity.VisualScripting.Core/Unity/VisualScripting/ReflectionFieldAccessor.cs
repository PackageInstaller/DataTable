using System.Reflection;

namespace Unity.VisualScripting;

public sealed class ReflectionFieldAccessor : IOptimizedAccessor
{
	private readonly FieldInfo fieldInfo;

	public ReflectionFieldAccessor(FieldInfo fieldInfo)
	{
		if (OptimizedReflection.safeMode)
		{
			Ensure.That("fieldInfo").IsNotNull(fieldInfo);
		}
		this.fieldInfo = fieldInfo;
	}

	public void Compile()
	{
	}

	public object GetValue(object target)
	{
		return fieldInfo.GetValue(target);
	}

	public void SetValue(object target, object value)
	{
		fieldInfo.SetValue(target, value);
	}
}
