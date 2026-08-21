using System.Globalization;

namespace System.Text.RegularExpressions;

internal sealed class RegexFC
{
	private RegexCharClass _cc;

	public bool _nullable;

	public bool CaseInsensitive { get; private set; }

	public RegexFC(bool nullable)
	{
		_cc = new RegexCharClass();
		_nullable = nullable;
	}

	public RegexFC(char ch, bool not, bool nullable, bool caseInsensitive)
	{
		_cc = new RegexCharClass();
		if (not)
		{
			if (ch > '\0')
			{
				_cc.AddRange('\0', (char)(ch - 1));
			}
			if (ch < '\uffff')
			{
				_cc.AddRange((char)(ch + 1), '\uffff');
			}
		}
		else
		{
			_cc.AddRange(ch, ch);
		}
		CaseInsensitive = caseInsensitive;
		_nullable = nullable;
	}

	public RegexFC(string charClass, bool nullable, bool caseInsensitive)
	{
		_cc = RegexCharClass.Parse(charClass);
		_nullable = nullable;
		CaseInsensitive = caseInsensitive;
	}

	public bool AddFC(RegexFC fc, bool concatenate)
	{
		if (!_cc.CanMerge || !fc._cc.CanMerge)
		{
			return false;
		}
		if (concatenate)
		{
			if (!_nullable)
			{
				return true;
			}
			if (!fc._nullable)
			{
				_nullable = false;
			}
		}
		else if (fc._nullable)
		{
			_nullable = true;
		}
		CaseInsensitive |= fc.CaseInsensitive;
		_cc.AddCharClass(fc._cc);
		return true;
	}

	public string GetFirstChars(CultureInfo culture)
	{
		if (CaseInsensitive)
		{
			_cc.AddLowercase(culture);
		}
		return _cc.ToStringClass();
	}
}
