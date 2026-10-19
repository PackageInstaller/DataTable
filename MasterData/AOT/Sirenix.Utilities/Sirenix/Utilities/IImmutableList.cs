using System.Collections;
using System.Collections.Generic;

namespace Sirenix.Utilities;

public interface IImmutableList : IList, ICollection, IEnumerable
{
}
public interface IImmutableList<T> : IImmutableList, IList, ICollection, IEnumerable, IList<T>, ICollection<T>, IEnumerable<T>
{
	new T this[int index] { get; }
}
