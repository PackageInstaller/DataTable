using System.Collections.Concurrent;

namespace System.Runtime.Serialization;

internal static class SerializationEventsCache
{
	private static readonly ConcurrentDictionary<Type, SerializationEvents> s_cache = new ConcurrentDictionary<Type, SerializationEvents>();

	internal static SerializationEvents GetSerializationEventsForType(Type t)
	{
		return s_cache.GetOrAdd(t, (Type type) => new SerializationEvents(type));
	}
}
