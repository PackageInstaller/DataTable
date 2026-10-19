using System;

namespace Sirenix.Serialization;

internal class DelegateFormatterLocator : IFormatterLocator
{
	public bool TryGetFormatter(Type type, FormatterLocationStep step, ISerializationPolicy policy, bool allowWeakFallbackFormatters, out IFormatter formatter)
	{
		if (!typeof(Delegate).IsAssignableFrom(type))
		{
			formatter = null;
			return false;
		}
		try
		{
			formatter = (IFormatter)Activator.CreateInstance(typeof(DelegateFormatter<>).MakeGenericType(type));
		}
		catch (Exception ex)
		{
			if (!allowWeakFallbackFormatters || (!(ex is ExecutionEngineException) && !(ex.GetBaseException() is ExecutionEngineException)))
			{
				throw;
			}
			formatter = new WeakDelegateFormatter(type);
		}
		return true;
	}
}
