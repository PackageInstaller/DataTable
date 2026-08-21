using System;
using System.Collections.Generic;
using MessagePack.Formatters;

namespace MessagePack.Resolvers;

internal static class GeneratedResolverGetFormatterHelper
{
	private static readonly Dictionary<Type, int> lookup;

	static GeneratedResolverGetFormatterHelper()
	{
		lookup = new Dictionary<Type, int>(10)
		{
			{
				typeof(Dictionary<string, AssetName>),
				0
			},
			{
				typeof(Dictionary<string, int>),
				1
			},
			{
				typeof(List<int[]>),
				2
			},
			{
				typeof(AAAAA),
				3
			},
			{
				typeof(AssetName),
				4
			},
			{
				typeof(AssetNameList),
				5
			},
			{
				typeof(BBBBB),
				6
			},
			{
				typeof(CCCCC),
				7
			},
			{
				typeof(DDDDD),
				8
			},
			{
				typeof(P08AssetManifest),
				9
			}
		};
	}

	internal static object GetFormatter(Type t)
	{
		if (!lookup.TryGetValue(t, out var value))
		{
			return null;
		}
		return value switch
		{
			0 => new DictionaryFormatter<string, AssetName>(), 
			1 => new DictionaryFormatter<string, int>(), 
			2 => new ListFormatter<int[]>(), 
			3 => new AAAAAFormatter(), 
			4 => new AssetNameFormatter(), 
			5 => new AssetNameListFormatter(), 
			6 => new BBBBBFormatter(), 
			7 => new CCCCCFormatter(), 
			8 => new DDDDDFormatter(), 
			9 => new P08AssetManifestFormatter(), 
			_ => null, 
		};
	}
}
