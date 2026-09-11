using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace System.Runtime.CompilerServices;

internal sealed class TrueReadOnlyCollection<T> : ReadOnlyCollection<T>
{
	public TrueReadOnlyCollection(params T[] list)
		: base((IList<T>)list)
	{
	}
}
