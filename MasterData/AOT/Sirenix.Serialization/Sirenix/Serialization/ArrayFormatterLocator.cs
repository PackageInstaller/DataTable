using System;

namespace Sirenix.Serialization;

internal class ArrayFormatterLocator : IFormatterLocator
{
	public bool TryGetFormatter(Type type, FormatterLocationStep step, ISerializationPolicy policy, bool allowWeakFallbackFormatters, out IFormatter formatter)
	{
		if (!type.IsArray)
		{
			formatter = null;
			return false;
		}
		Type elementType = type.GetElementType();
		if (type.GetArrayRank() == 1)
		{
			if (FormatterUtilities.IsPrimitiveArrayType(elementType))
			{
				try
				{
					formatter = (IFormatter)Activator.CreateInstance(typeof(PrimitiveArrayFormatter<>).MakeGenericType(elementType));
				}
				catch (Exception ex)
				{
					if (!allowWeakFallbackFormatters || (!(ex is ExecutionEngineException) && !(ex.GetBaseException() is ExecutionEngineException)))
					{
						throw;
					}
					formatter = new WeakPrimitiveArrayFormatter(type, elementType);
				}
			}
			else
			{
				try
				{
					formatter = (IFormatter)Activator.CreateInstance(typeof(ArrayFormatter<>).MakeGenericType(elementType));
				}
				catch (Exception ex2)
				{
					if (!allowWeakFallbackFormatters || (!(ex2 is ExecutionEngineException) && !(ex2.GetBaseException() is ExecutionEngineException)))
					{
						throw;
					}
					formatter = new WeakArrayFormatter(type, elementType);
				}
			}
		}
		else
		{
			try
			{
				formatter = (IFormatter)Activator.CreateInstance(typeof(MultiDimensionalArrayFormatter<, >).MakeGenericType(type, type.GetElementType()));
			}
			catch (Exception ex3)
			{
				if (!allowWeakFallbackFormatters || (!(ex3 is ExecutionEngineException) && !(ex3.GetBaseException() is ExecutionEngineException)))
				{
					throw;
				}
				formatter = new WeakMultiDimensionalArrayFormatter(type, elementType);
			}
		}
		return true;
	}
}
