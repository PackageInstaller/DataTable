using System.Collections.Generic;

namespace System.Collections.Concurrent;

public interface IProducerConsumerCollection<T> : IEnumerable<T>, IEnumerable, ICollection
{
	bool TryAdd(T item);

	bool TryTake(out T item);
}
