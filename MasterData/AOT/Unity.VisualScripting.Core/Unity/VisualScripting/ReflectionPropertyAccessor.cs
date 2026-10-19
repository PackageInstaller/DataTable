using System.Reflection;

namespace Unity.VisualScripting;

public sealed class ReflectionPropertyAccessor : IOptimizedAccessor
{
	private readonly PropertyInfo propertyInfo;

	public ReflectionPropertyAccessor(PropertyInfo propertyInfo)
	{
		if (OptimizedReflection.safeMode)
		{
			Ensure.That("propertyInfo").IsNotNull(propertyInfo);
		}
		this.propertyInfo = propertyInfo;
	}

	public void Compile()
	{
	}

	public object GetValue(object target)
	{
		return propertyInfo.GetValue(target, null);
	}

	public void SetValue(object target, object value)
	{
		propertyInfo.SetValue(target, value, null);
	}
}
