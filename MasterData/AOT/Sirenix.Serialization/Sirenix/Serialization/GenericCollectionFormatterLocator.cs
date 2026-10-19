using System;

namespace Sirenix.Serialization;

internal class GenericCollectionFormatterLocator : IFormatterLocator
{
	public bool TryGetFormatter(Type type, FormatterLocationStep step, ISerializationPolicy policy, bool allowWeakFallbackFormatters, out IFormatter formatter)
	{
		if (step != FormatterLocationStep.AfterRegisteredFormatters || !GenericCollectionFormatter.CanFormat(type, out var elementType))
		{
			formatter = null;
			return false;
		}
		try
		{
			formatter = (IFormatter)Activator.CreateInstance(typeof(GenericCollectionFormatter<, >).MakeGenericType(type, elementType));
		}
		catch (Exception ex)
		{
			if (!allowWeakFallbackFormatters || (!(ex is ExecutionEngineException) && !(ex.GetBaseException() is ExecutionEngineException)))
			{
				throw;
			}
			formatter = new WeakGenericCollectionFormatter(type, elementType);
		}
		return true;
	}
}
