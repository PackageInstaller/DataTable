using System;
using Unity.VisualScripting.FullSerializer.Internal;

namespace Unity.VisualScripting.FullSerializer;

public static class fsReflectionUtility
{
	public static Type GetInterface(Type type, Type interfaceType)
	{
		if (interfaceType.Resolve().IsGenericType && !interfaceType.Resolve().IsGenericTypeDefinition)
		{
			throw new ArgumentException("GetInterface requires that if the interface type is generic, then it must be the generic type definition, not a specific generic type instantiation");
		}
		while (type != null)
		{
			Type[] interfaces = type.GetInterfaces();
			foreach (Type type2 in interfaces)
			{
				if (type2.Resolve().IsGenericType)
				{
					if (interfaceType == type2.GetGenericTypeDefinition())
					{
						return type2;
					}
				}
				else if (interfaceType == type2)
				{
					return type2;
				}
			}
			type = type.Resolve().BaseType;
		}
		return null;
	}
}
