using System;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

internal class SelfFormatterLocator : IFormatterLocator
{
	public bool TryGetFormatter(Type type, FormatterLocationStep step, ISerializationPolicy policy, bool allowWeakFallbackFormatters, out IFormatter formatter)
	{
		formatter = null;
		if (!typeof(ISelfFormatter).IsAssignableFrom(type))
		{
			return false;
		}
		if ((step == FormatterLocationStep.BeforeRegisteredFormatters && type.IsDefined<AlwaysFormatsSelfAttribute>()) || step == FormatterLocationStep.AfterRegisteredFormatters)
		{
			try
			{
				formatter = (IFormatter)Activator.CreateInstance(typeof(SelfFormatterFormatter<>).MakeGenericType(type));
			}
			catch (Exception ex)
			{
				if (!allowWeakFallbackFormatters || (!(ex is ExecutionEngineException) && !(ex.GetBaseException() is ExecutionEngineException)))
				{
					throw;
				}
				formatter = new WeakSelfFormatterFormatter(type);
			}
			return true;
		}
		return false;
	}
}
