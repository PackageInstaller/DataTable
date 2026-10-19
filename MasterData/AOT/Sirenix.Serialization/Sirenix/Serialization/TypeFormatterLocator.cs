using System;

namespace Sirenix.Serialization;

internal class TypeFormatterLocator : IFormatterLocator
{
	public bool TryGetFormatter(Type type, FormatterLocationStep step, ISerializationPolicy policy, bool allowWeakFallbackFormatters, out IFormatter formatter)
	{
		if (!typeof(Type).IsAssignableFrom(type))
		{
			formatter = null;
			return false;
		}
		formatter = new TypeFormatter();
		return true;
	}
}
