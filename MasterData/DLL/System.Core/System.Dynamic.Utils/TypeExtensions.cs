using System.Reflection;

namespace System.Dynamic.Utils;

internal static class TypeExtensions
{
	private static readonly CacheDict<MethodBase, ParameterInfo[]> s_paramInfoCache = new CacheDict<MethodBase, ParameterInfo[]>(75);

	public static MethodInfo GetAnyStaticMethodValidated(this Type type, string name, Type[] types)
	{
		MethodInfo method = type.GetMethod(name, BindingFlags.DeclaredOnly | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic, null, types, null);
		if (!method.MatchesArgumentTypes(types))
		{
			return null;
		}
		return method;
	}

	private static bool MatchesArgumentTypes(this MethodInfo mi, Type[] argTypes)
	{
		if (mi == null)
		{
			return false;
		}
		ParameterInfo[] parametersCached = mi.GetParametersCached();
		if (parametersCached.Length != argTypes.Length)
		{
			return false;
		}
		for (int i = 0; i < parametersCached.Length; i++)
		{
			if (!TypeUtils.AreReferenceAssignable(parametersCached[i].ParameterType, argTypes[i]))
			{
				return false;
			}
		}
		return true;
	}

	public static Type GetReturnType(this MethodBase mi)
	{
		if (!mi.IsConstructor)
		{
			return ((MethodInfo)mi).ReturnType;
		}
		return mi.DeclaringType;
	}

	public static TypeCode GetTypeCode(this Type type)
	{
		return Type.GetTypeCode(type);
	}

	internal static ParameterInfo[] GetParametersCached(this MethodBase method)
	{
		CacheDict<MethodBase, ParameterInfo[]> cacheDict = s_paramInfoCache;
		if (!cacheDict.TryGetValue(method, out var value))
		{
			value = method.GetParameters();
			Type declaringType = method.DeclaringType;
			if ((object)declaringType != null && !declaringType.IsCollectible)
			{
				cacheDict[method] = value;
			}
		}
		return value;
	}
}
