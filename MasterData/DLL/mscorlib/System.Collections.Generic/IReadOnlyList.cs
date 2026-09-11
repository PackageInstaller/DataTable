namespace System.Collections.Generic;

public interface IReadOnlyList<out T> : IReadOnlyCollection<T>, IEnumerable<T>, IEnumerable
{
	T this[int index] { get; }
}
