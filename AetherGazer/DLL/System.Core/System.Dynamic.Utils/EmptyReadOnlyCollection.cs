using System.Collections.ObjectModel;
using System.Runtime.CompilerServices;

namespace System.Dynamic.Utils;

internal static class EmptyReadOnlyCollection<T>
{
	public static readonly ReadOnlyCollection<T> Instance = new TrueReadOnlyCollection<T>();
}
