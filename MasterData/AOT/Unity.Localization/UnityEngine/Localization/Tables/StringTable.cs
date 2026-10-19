using System.Collections.Generic;
using System.Linq;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.SmartFormat;

namespace UnityEngine.Localization.Tables;

public class StringTable : DetailedLocalizationTable<StringTableEntry>
{
	public string GenerateCharacterSet()
	{
		return string.Concat(from c in CollectLiteralCharacters().Distinct()
			orderby c
			select c);
	}

	internal IEnumerable<char> CollectLiteralCharacters()
	{
		IEnumerable<char> enumerable = "";
		SmartFormatterLiteralCharacterExtractor smartFormatterLiteralCharacterExtractor = new SmartFormatterLiteralCharacterExtractor(LocalizationSettings.StringDatabase?.SmartFormatter);
		foreach (StringTableEntry value in Values)
		{
			enumerable = ((!value.IsSmart) ? enumerable.Concat(value.LocalizedValue.AsEnumerable()) : enumerable.Concat(smartFormatterLiteralCharacterExtractor.ExtractLiteralsCharacters(value.LocalizedValue)));
		}
		return enumerable;
	}

	public override StringTableEntry CreateTableEntry()
	{
		return new StringTableEntry
		{
			Table = this,
			Data = new TableEntryData()
		};
	}
}
