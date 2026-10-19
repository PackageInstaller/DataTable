using System.Collections;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public interface ISet<T> : ICollection<T>, IEnumerable<T>, IEnumerable
{
	new bool Add(T item);

	void UnionWith(IEnumerable<T> other);

	void IntersectWith(IEnumerable<T> other);

	void ExceptWith(IEnumerable<T> other);

	void SymmetricExceptWith(IEnumerable<T> other);

	bool IsSubsetOf(IEnumerable<T> other);

	bool IsSupersetOf(IEnumerable<T> other);

	bool IsProperSupersetOf(IEnumerable<T> other);

	bool IsProperSubsetOf(IEnumerable<T> other);

	bool Overlaps(IEnumerable<T> other);

	bool SetEquals(IEnumerable<T> other);
}
