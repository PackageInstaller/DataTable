using System;
using System.Runtime.Serialization;

namespace Sirenix.Serialization;

internal class ISerializableFormatterLocator : IFormatterLocator
{
	public bool TryGetFormatter(Type type, FormatterLocationStep step, ISerializationPolicy policy, bool allowWeakFallbackFormatters, out IFormatter formatter)
	{
		if (step != FormatterLocationStep.AfterRegisteredFormatters || !typeof(ISerializable).IsAssignableFrom(type))
		{
			formatter = null;
			return false;
		}
		try
		{
			formatter = (IFormatter)Activator.CreateInstance(typeof(SerializableFormatter<>).MakeGenericType(type));
		}
		catch (Exception ex)
		{
			if (!allowWeakFallbackFormatters || (!(ex is ExecutionEngineException) && !(ex.GetBaseException() is ExecutionEngineException)))
			{
				throw;
			}
			formatter = new WeakSerializableFormatter(type);
		}
		return true;
	}
}
