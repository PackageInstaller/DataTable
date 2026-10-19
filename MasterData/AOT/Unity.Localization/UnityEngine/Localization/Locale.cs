using System;
using System.Collections.Generic;
using System.Globalization;
using UnityEngine.Localization.Metadata;
using UnityEngine.Localization.Pseudo;
using UnityEngine.Localization.Settings;
using UnityEngine.Pool;

namespace UnityEngine.Localization;

public class Locale : ScriptableObject, IEquatable<Locale>, IComparable<Locale>, ISerializationCallbackReceiver
{
	[SerializeField]
	private LocaleIdentifier m_Identifier;

	[MetadataType(MetadataType.Locale)]
	[SerializeField]
	private MetadataCollection m_Metadata = new MetadataCollection();

	[SerializeField]
	private string m_LocaleName;

	[SerializeField]
	private string m_CustomFormatCultureCode;

	[SerializeField]
	private bool m_UseCustomFormatter;

	[SerializeField]
	private ushort m_SortOrder = 10000;

	private IFormatProvider m_Formatter;

	public LocaleIdentifier Identifier
	{
		get
		{
			return m_Identifier;
		}
		set
		{
			m_Identifier = value;
		}
	}

	public MetadataCollection Metadata
	{
		get
		{
			return m_Metadata;
		}
		set
		{
			m_Metadata = value;
		}
	}

	public ushort SortOrder
	{
		get
		{
			return m_SortOrder;
		}
		set
		{
			m_SortOrder = value;
		}
	}

	public string LocaleName
	{
		get
		{
			if (!string.IsNullOrEmpty(m_LocaleName))
			{
				return m_LocaleName;
			}
			if (Identifier.CultureInfo != null)
			{
				return Identifier.CultureInfo.EnglishName;
			}
			return name;
		}
		set
		{
			m_LocaleName = value;
		}
	}

	public bool UseCustomFormatter
	{
		get
		{
			return m_UseCustomFormatter;
		}
		set
		{
			m_UseCustomFormatter = value;
			m_Formatter = null;
		}
	}

	public string CustomFormatterCode
	{
		get
		{
			return m_CustomFormatCultureCode;
		}
		set
		{
			m_CustomFormatCultureCode = value;
			m_Formatter = null;
		}
	}

	public virtual IFormatProvider Formatter
	{
		get
		{
			if (m_Formatter == null)
			{
				m_Formatter = GetFormatter(UseCustomFormatter, Identifier, CustomFormatterCode);
			}
			return m_Formatter;
		}
		set
		{
			m_Formatter = value;
		}
	}

	[Obsolete("GetFallback is obsolete, please use GetFallbacks.")]
	public virtual Locale GetFallback()
	{
		return GetFallbacks().GetEnumerator().Current;
	}

	public IEnumerable<Locale> GetFallbacks()
	{
		if (Metadata == null)
		{
			yield break;
		}
		HashSet<Locale> processedLocales;
		using (CollectionPool<HashSet<Locale>, Locale>.Get(out processedLocales))
		{
			IList<IMetadata> entries = Metadata.MetadataEntries;
			int i = 0;
			while (i < entries.Count)
			{
				if (entries[i] is FallbackLocale fallbackLocale && fallbackLocale.Locale != null && !processedLocales.Contains(fallbackLocale.Locale))
				{
					processedLocales.Add(fallbackLocale.Locale);
					yield return fallbackLocale.Locale;
				}
				int num = i + 1;
				i = num;
			}
			if (processedLocales.Count != 0)
			{
				yield break;
			}
			Locale locale = null;
			CultureInfo cultureInfo = Identifier.CultureInfo;
			if (cultureInfo != null)
			{
				while (cultureInfo != CultureInfo.InvariantCulture && locale == null)
				{
					Locale locale2 = LocalizationSettings.AvailableLocales.GetLocale(cultureInfo);
					if (locale2 != this)
					{
						locale = locale2;
					}
					cultureInfo = cultureInfo.Parent;
				}
			}
			if (locale != null)
			{
				yield return locale;
			}
		}
	}

	internal static CultureInfo GetFormatter(bool useCustom, LocaleIdentifier localeIdentifier, string customCode)
	{
		CultureInfo cultureInfo = null;
		if (useCustom)
		{
			cultureInfo = (string.IsNullOrEmpty(customCode) ? CultureInfo.InvariantCulture : new LocaleIdentifier(customCode).CultureInfo);
		}
		if (cultureInfo == null)
		{
			cultureInfo = localeIdentifier.CultureInfo;
		}
		return cultureInfo;
	}

	public static Locale CreateLocale(string code)
	{
		Locale locale = ScriptableObject.CreateInstance<Locale>();
		locale.m_Identifier = new LocaleIdentifier(code);
		if (locale.m_Identifier.CultureInfo != null)
		{
			locale.name = locale.m_Identifier.CultureInfo.EnglishName;
		}
		return locale;
	}

	public static Locale CreateLocale(LocaleIdentifier identifier)
	{
		Locale locale = ScriptableObject.CreateInstance<Locale>();
		locale.m_Identifier = identifier;
		if (locale.m_Identifier.CultureInfo != null)
		{
			locale.LocaleName = locale.m_Identifier.CultureInfo.EnglishName;
		}
		return locale;
	}

	public static Locale CreateLocale(SystemLanguage language)
	{
		return CreateLocale(new LocaleIdentifier(SystemLanguageConverter.GetSystemLanguageCultureCode(language)));
	}

	public static Locale CreateLocale(CultureInfo cultureInfo)
	{
		return CreateLocale(new LocaleIdentifier(cultureInfo));
	}

	public int CompareTo(Locale other)
	{
		if (other == null)
		{
			return -1;
		}
		if (SortOrder != other.SortOrder)
		{
			return SortOrder.CompareTo(other.SortOrder);
		}
		if (GetType() == other.GetType())
		{
			int num = string.CompareOrdinal(LocaleName, other.LocaleName);
			if (num == 0)
			{
				return GetInstanceID().CompareTo(other.GetInstanceID());
			}
			return num;
		}
		if (other is PseudoLocale)
		{
			return -1;
		}
		return 1;
	}

	public void OnAfterDeserialize()
	{
		m_Formatter = null;
	}

	public void OnBeforeSerialize()
	{
		if (string.IsNullOrEmpty(m_LocaleName))
		{
			m_LocaleName = name;
		}
	}

	public override string ToString()
	{
		if (!string.IsNullOrEmpty(LocaleName))
		{
			return LocaleName;
		}
		return name;
	}

	public bool Equals(Locale other)
	{
		if (other == null)
		{
			return false;
		}
		if (LocaleName == other.LocaleName)
		{
			return Identifier.Equals(other.Identifier);
		}
		return false;
	}
}
