using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class GenericSetFormatter<TSet, TElement> : GenericSetFormatterBase<TSet, TElement> where TSet : ISet<TElement?>, new()
{
	protected override TSet CreateSet()
	{
		return new TSet();
	}
}
