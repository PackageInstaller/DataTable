using System;

namespace Sirenix.Serialization;

public interface IFormatterLocator
{
	bool TryGetFormatter(Type type, FormatterLocationStep step, ISerializationPolicy policy, bool allowWeakFallbackFormatters, out IFormatter formatter);
}
