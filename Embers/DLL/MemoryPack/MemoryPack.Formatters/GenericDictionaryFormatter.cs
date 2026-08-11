using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class GenericDictionaryFormatter<TDictionary, TKey, TValue> : GenericDictionaryFormatterBase<TDictionary, TKey, TValue> where TDictionary : IDictionary<TKey, TValue?>, new() where TKey : notnull
{
	[Preserve]
	protected override TDictionary CreateDictionary()
	{
		return new TDictionary();
	}
}
