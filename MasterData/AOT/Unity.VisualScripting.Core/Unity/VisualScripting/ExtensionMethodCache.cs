using System;
using System.Linq;
using System.Reflection;

namespace Unity.VisualScripting;

internal class ExtensionMethodCache
{
	internal readonly MethodInfo[] Cache;

	internal ExtensionMethodCache()
	{
		Cache = (from method in RuntimeCodebase.types.Where((Type type) => type.IsStatic() && !type.IsGenericType && !type.IsNested).SelectMany((Type type) => type.GetMethods())
			where method.IsExtension()
			select method).ToArray();
	}
}
