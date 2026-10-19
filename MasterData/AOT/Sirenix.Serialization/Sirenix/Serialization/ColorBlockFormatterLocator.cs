using System;

namespace Sirenix.Serialization;

public class ColorBlockFormatterLocator : IFormatterLocator
{
	public bool TryGetFormatter(Type type, FormatterLocationStep step, ISerializationPolicy policy, bool allowWeakFallbackFormatters, out IFormatter formatter)
	{
		if (step == FormatterLocationStep.BeforeRegisteredFormatters && type.FullName == "UnityEngine.UI.ColorBlock")
		{
			try
			{
				formatter = (IFormatter)Activator.CreateInstance(typeof(ColorBlockFormatter<>).MakeGenericType(type));
			}
			catch (Exception ex)
			{
				if (!allowWeakFallbackFormatters || (!(ex is ExecutionEngineException) && !(ex.GetBaseException() is ExecutionEngineException)))
				{
					throw;
				}
				formatter = new WeakColorBlockFormatter(type);
			}
			return true;
		}
		formatter = null;
		return false;
	}
}
