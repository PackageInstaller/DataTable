using System.Collections;
using System.Collections.Generic;

namespace Sirenix.Serialization.Utilities;

internal interface IImmutableList : IList, ICollection, IEnumerable
{
}
internal interface IImmutableList<T> : IImmutableList, IList, ICollection, IEnumerable, IList<T>, ICollection<T>, IEnumerable<T>
{
	new T this[int index] { get; }
}
