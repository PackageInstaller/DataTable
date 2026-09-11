using System.Collections.Concurrent;

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class NameCache
{
	private static ConcurrentDictionary<string, object> ht = new ConcurrentDictionary<string, object>();

	private string name;

	internal object GetCachedValue(string name)
	{
		this.name = name;
		if (!ht.TryGetValue(name, out var value))
		{
			return null;
		}
		return value;
	}

	internal void SetCachedValue(object value)
	{
		ht[name] = value;
	}
}
