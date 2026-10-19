using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.Localization.Metadata;
using UnityEngine.Localization.Pseudo;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.SmartFormat;
using UnityEngine.Localization.SmartFormat.Core.Formatting;

namespace UnityEngine.Localization.Tables;

public class StringTableEntry : TableEntry
{
	private FormatCache m_FormatCache;

	public FormatCache FormatCache
	{
		get
		{
			return m_FormatCache;
		}
		set
		{
			m_FormatCache = value;
		}
	}

	public string Value
	{
		get
		{
			return Data.Localized;
		}
		set
		{
			Data.Localized = value;
			if (m_FormatCache != null)
			{
				FormatCachePool.Release(m_FormatCache);
				m_FormatCache = null;
			}
		}
	}

	public bool IsSmart
	{
		get
		{
			return Data.Metadata.GetMetadata<SmartFormatTag>() != null;
		}
		set
		{
			if (value)
			{
				if (m_FormatCache != null)
				{
					FormatCachePool.Release(m_FormatCache);
					m_FormatCache = null;
				}
				AddTagMetadata<SmartFormatTag>();
			}
			else
			{
				RemoveTagMetadata<SmartFormatTag>();
			}
		}
	}

	internal StringTableEntry()
	{
	}

	public void RemoveFromTable()
	{
		StringTable stringTable = Table as StringTable;
		if (stringTable == null)
		{
			Debug.LogWarning(string.Format("Failed to remove {0} with id {1} and value `{2}` as it does not belong to a table.", "StringTableEntry", KeyId, Value));
		}
		else
		{
			stringTable.Remove(KeyId);
		}
	}

	internal FormatCache GetOrCreateFormatCache()
	{
		if (m_FormatCache == null && !string.IsNullOrEmpty(Data.Localized))
		{
			m_FormatCache = FormatCachePool.Get(LocalizationSettings.StringDatabase.SmartFormatter.Parser.ParseFormat(Data.Localized, LocalizationSettings.StringDatabase.SmartFormatter.GetNotEmptyFormatterExtensionNames()));
			m_FormatCache.Table = Table;
		}
		return m_FormatCache;
	}

	public string GetLocalizedString()
	{
		return GetLocalizedString(null, null, LocalizationSettings.SelectedLocaleAsync.Result as PseudoLocale);
	}

	public string GetLocalizedString(params object[] args)
	{
		return GetLocalizedString(null, args, LocalizationSettings.SelectedLocaleAsync.Result as PseudoLocale);
	}

	public string GetLocalizedString(IList<object> args)
	{
		return GetLocalizedString(null, args, LocalizationSettings.SelectedLocaleAsync.Result as PseudoLocale);
	}

	public string GetLocalizedString(IFormatProvider formatProvider, IList<object> args)
	{
		return GetLocalizedString(formatProvider, args, LocalizationSettings.SelectedLocaleAsync.Result as PseudoLocale);
	}

	public string GetLocalizedString(IFormatProvider formatProvider, IList<object> args, PseudoLocale pseudoLocale)
	{
		if (formatProvider == null)
		{
			formatProvider = LocalizationSettings.AvailableLocales?.GetLocale(Table.LocaleIdentifier)?.Formatter;
		}
		string text = null;
		if (IsSmart)
		{
			if (m_FormatCache == null)
			{
				m_FormatCache = GetOrCreateFormatCache();
			}
			text = LocalizationSettings.StringDatabase.SmartFormatter.FormatWithCache(ref m_FormatCache, Data.Localized, formatProvider, args);
		}
		else if (!string.IsNullOrEmpty(Data.Localized))
		{
			if (args != null && args.Count > 0)
			{
				try
				{
					text = ((formatProvider == null) ? string.Format(Data.Localized, (args as object[]) ?? args.ToArray()) : string.Format(formatProvider, Data.Localized, (args as object[]) ?? args.ToArray()));
				}
				catch (FormatException ex)
				{
					throw new FormatException($"Input string was not in the correct format for String.Format. Ensure that the string is marked as Smart if you intended to use Smart Format.\n`{Data.Localized}`\n{ex}", ex);
				}
			}
			else
			{
				text = Data.Localized;
			}
		}
		if (pseudoLocale != null && !string.IsNullOrEmpty(text))
		{
			text = pseudoLocale.GetPseudoString(text);
		}
		return text;
	}
}
