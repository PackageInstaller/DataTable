using System.Reflection;
using System.Threading;

namespace System;

internal sealed class TypeNameParser
{
	internal static Type GetType(string typeName, Func<AssemblyName, Assembly> assemblyResolver, Func<Assembly, string, bool, Type> typeResolver, bool throwOnError, bool ignoreCase, ref StackCrawlMark stackMark)
	{
		return TypeSpec.Parse(typeName).Resolve(assemblyResolver, typeResolver, throwOnError, ignoreCase, ref stackMark);
	}
}
