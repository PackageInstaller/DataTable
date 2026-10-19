using System;

namespace Proxima;

public interface IPropertyOrValue
{
	object Get(Type type);
}
