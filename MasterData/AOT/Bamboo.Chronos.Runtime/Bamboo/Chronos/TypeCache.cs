using System;

namespace Bamboo.Chronos;

internal static class TypeCache<T>
{
	public static readonly Type TYPE = typeof(T);
}
