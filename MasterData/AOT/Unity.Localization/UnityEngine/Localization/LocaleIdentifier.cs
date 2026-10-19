using System;
using System.Globalization;

namespace UnityEngine.Localization;

[Serializable]
public struct LocaleIdentifier : IEquatable<LocaleIdentifier>, IComparable<LocaleIdentifier>
{
	[SerializeField]
	private string m_Code;

	private CultureInfo m_CultureInfo;

	public string Code => m_Code;

	public CultureInfo CultureInfo
	{
		get
		{
			if (m_CultureInfo == null && !string.IsNullOrEmpty(m_Code))
			{
				try
				{
					m_CultureInfo = CultureInfo.GetCultureInfo(m_Code);
				}
				catch (CultureNotFoundException)
				{
				}
			}
			return m_CultureInfo;
		}
	}

	public LocaleIdentifier(string code)
	{
		m_Code = code;
		m_CultureInfo = null;
	}

	public LocaleIdentifier(CultureInfo culture)
	{
		if (culture == null)
		{
			throw new ArgumentNullException("culture");
		}
		m_Code = culture.Name;
		m_CultureInfo = culture;
	}

	public LocaleIdentifier(SystemLanguage systemLanguage)
		: this(SystemLanguageConverter.GetSystemLanguageCultureCode(systemLanguage))
	{
	}

	public static implicit operator LocaleIdentifier(string code)
	{
		return new LocaleIdentifier(code);
	}

	public static implicit operator LocaleIdentifier(CultureInfo culture)
	{
		return new LocaleIdentifier(culture);
	}

	public static implicit operator LocaleIdentifier(SystemLanguage systemLanguage)
	{
		return new LocaleIdentifier(systemLanguage);
	}

	public override string ToString()
	{
		if (string.IsNullOrEmpty(m_Code))
		{
			return "undefined";
		}
		return ((CultureInfo != null) ? CultureInfo.EnglishName : "Custom") + "(" + Code + ")";
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is LocaleIdentifier other)
		{
			return Equals(other);
		}
		return false;
	}

	public bool Equals(LocaleIdentifier other)
	{
		if (string.IsNullOrEmpty(other.Code) && string.IsNullOrEmpty(Code))
		{
			return true;
		}
		return Code.Equals(other.Code, StringComparison.OrdinalIgnoreCase);
	}

	public override int GetHashCode()
	{
		if (string.IsNullOrEmpty(Code))
		{
			return base.GetHashCode();
		}
		return Code.GetHashCode();
	}

	public int CompareTo(LocaleIdentifier other)
	{
		if (CultureInfo == null || other.CultureInfo == null)
		{
			return 1;
		}
		return string.CompareOrdinal(CultureInfo.EnglishName, other.CultureInfo.EnglishName);
	}

	public static bool operator ==(LocaleIdentifier l1, LocaleIdentifier l2)
	{
		return l1.Equals(l2);
	}

	public static bool operator !=(LocaleIdentifier l1, LocaleIdentifier l2)
	{
		return !l1.Equals(l2);
	}
}
