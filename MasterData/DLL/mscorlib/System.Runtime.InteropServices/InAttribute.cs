using System.Reflection;

namespace System.Runtime.InteropServices;

[AttributeUsage(AttributeTargets.Parameter, Inherited = false)]
[ComVisible(true)]
public sealed class InAttribute : Attribute
{
	internal static Attribute GetCustomAttribute(RuntimeParameterInfo parameter)
	{
		if (!parameter.IsIn)
		{
			return null;
		}
		return new InAttribute();
	}

	internal static bool IsDefined(RuntimeParameterInfo parameter)
	{
		return parameter.IsIn;
	}
}
