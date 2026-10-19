namespace System.Reflection;

internal static class SignatureTypeExtensions
{
	public static bool MatchesParameterTypeExactly(this Type pattern, ParameterInfo parameter)
	{
		if (pattern is SignatureType pattern2)
		{
			return pattern2.MatchesExactly(parameter.ParameterType);
		}
		return (object)pattern == parameter.ParameterType;
	}

	internal static bool MatchesExactly(this SignatureType pattern, Type actual)
	{
		if (pattern.IsSZArray)
		{
			if (actual.IsSZArray)
			{
				return pattern.ElementType.MatchesExactly(actual.GetElementType());
			}
			return false;
		}
		if (pattern.IsVariableBoundArray)
		{
			if (actual.IsVariableBoundArray && pattern.GetArrayRank() == actual.GetArrayRank())
			{
				return pattern.ElementType.MatchesExactly(actual.GetElementType());
			}
			return false;
		}
		if (pattern.IsByRef)
		{
			if (actual.IsByRef)
			{
				return pattern.ElementType.MatchesExactly(actual.GetElementType());
			}
			return false;
		}
		if (pattern.IsPointer)
		{
			if (actual.IsPointer)
			{
				return pattern.ElementType.MatchesExactly(actual.GetElementType());
			}
			return false;
		}
		if (pattern.IsConstructedGenericType)
		{
			if (!actual.IsConstructedGenericType)
			{
				return false;
			}
			if (!(pattern.GetGenericTypeDefinition() == actual.GetGenericTypeDefinition()))
			{
				return false;
			}
			Type[] genericTypeArguments = pattern.GenericTypeArguments;
			Type[] genericTypeArguments2 = actual.GenericTypeArguments;
			int num = genericTypeArguments.Length;
			if (num != genericTypeArguments2.Length)
			{
				return false;
			}
			for (int i = 0; i < num; i++)
			{
				Type type = genericTypeArguments[i];
				if (type is SignatureType pattern2)
				{
					if (!pattern2.MatchesExactly(genericTypeArguments2[i]))
					{
						return false;
					}
				}
				else if (type != genericTypeArguments2[i])
				{
					return false;
				}
			}
			return true;
		}
		if (pattern.IsGenericMethodParameter)
		{
			if (!actual.IsGenericMethodParameter)
			{
				return false;
			}
			if (pattern.GenericParameterPosition != actual.GenericParameterPosition)
			{
				return false;
			}
			return true;
		}
		return false;
	}

	internal static Type TryResolveAgainstGenericMethod(this SignatureType signatureType, MethodInfo genericMethod)
	{
		return signatureType.TryResolve(genericMethod.GetGenericArguments());
	}

	private static Type TryResolve(this SignatureType signatureType, Type[] genericMethodParameters)
	{
		if (signatureType.IsSZArray)
		{
			Type type = signatureType.ElementType.TryResolve(genericMethodParameters);
			if ((object)type == null)
			{
				return null;
			}
			return type.TryMakeArrayType();
		}
		if (signatureType.IsVariableBoundArray)
		{
			Type type2 = signatureType.ElementType.TryResolve(genericMethodParameters);
			if ((object)type2 == null)
			{
				return null;
			}
			return type2.TryMakeArrayType(signatureType.GetArrayRank());
		}
		if (signatureType.IsByRef)
		{
			Type type3 = signatureType.ElementType.TryResolve(genericMethodParameters);
			if ((object)type3 == null)
			{
				return null;
			}
			return type3.TryMakeByRefType();
		}
		if (signatureType.IsPointer)
		{
			Type type4 = signatureType.ElementType.TryResolve(genericMethodParameters);
			if ((object)type4 == null)
			{
				return null;
			}
			return type4.TryMakePointerType();
		}
		if (signatureType.IsConstructedGenericType)
		{
			Type[] genericTypeArguments = signatureType.GenericTypeArguments;
			int num = genericTypeArguments.Length;
			Type[] array = new Type[num];
			for (int i = 0; i < num; i++)
			{
				Type type5 = genericTypeArguments[i];
				if (type5 is SignatureType signatureType2)
				{
					array[i] = signatureType2.TryResolve(genericMethodParameters);
					if (array[i] == null)
					{
						return null;
					}
				}
				else
				{
					array[i] = type5;
				}
			}
			return signatureType.GetGenericTypeDefinition().TryMakeGenericType(array);
		}
		if (signatureType.IsGenericMethodParameter)
		{
			int genericParameterPosition = signatureType.GenericParameterPosition;
			if (genericParameterPosition >= genericMethodParameters.Length)
			{
				return null;
			}
			return genericMethodParameters[genericParameterPosition];
		}
		return null;
	}

	private static Type TryMakeArrayType(this Type type)
	{
		try
		{
			return type.MakeArrayType();
		}
		catch
		{
			return null;
		}
	}

	private static Type TryMakeArrayType(this Type type, int rank)
	{
		try
		{
			return type.MakeArrayType(rank);
		}
		catch
		{
			return null;
		}
	}

	private static Type TryMakeByRefType(this Type type)
	{
		try
		{
			return type.MakeByRefType();
		}
		catch
		{
			return null;
		}
	}

	private static Type TryMakePointerType(this Type type)
	{
		try
		{
			return type.MakePointerType();
		}
		catch
		{
			return null;
		}
	}

	private static Type TryMakeGenericType(this Type type, Type[] instantiation)
	{
		try
		{
			return type.MakeGenericType(instantiation);
		}
		catch
		{
			return null;
		}
	}
}
