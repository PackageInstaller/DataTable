namespace UnityEngine.Localization.SmartFormat.Utilities;

public class TimeTextInfo
{
	private readonly string[] d;

	private readonly string[] day;

	private readonly string[] h;

	private readonly string[] hour;

	private readonly string lessThan;

	private readonly string[] m;

	private readonly string[] millisecond;

	private readonly string[] minute;

	private readonly string[] ms;

	private readonly PluralRules.PluralRuleDelegate PluralRule;

	private readonly string[] s;

	private readonly string[] second;

	private readonly string[] w;

	private readonly string[] week;

	public TimeTextInfo(PluralRules.PluralRuleDelegate pluralRule, string[] week, string[] day, string[] hour, string[] minute, string[] second, string[] millisecond, string[] w, string[] d, string[] h, string[] m, string[] s, string[] ms, string lessThan)
	{
		PluralRule = pluralRule;
		this.week = week;
		this.day = day;
		this.hour = hour;
		this.minute = minute;
		this.second = second;
		this.millisecond = millisecond;
		this.w = w;
		this.d = d;
		this.h = h;
		this.m = m;
		this.s = s;
		this.ms = ms;
		this.lessThan = lessThan;
	}

	public TimeTextInfo(string week, string day, string hour, string minute, string second, string millisecond, string lessThan)
	{
		d = (h = (m = (ms = (s = (w = new string[0])))));
		PluralRule = (decimal d, int c) => 0;
		this.week = new string[1] { week };
		this.day = new string[1] { day };
		this.hour = new string[1] { hour };
		this.minute = new string[1] { minute };
		this.second = new string[1] { second };
		this.millisecond = new string[1] { millisecond };
		this.lessThan = lessThan;
	}

	private static string GetValue(PluralRules.PluralRuleDelegate pluralRule, int value, string[] units)
	{
		int num = ((units.Length != 1) ? pluralRule(value, units.Length) : 0);
		return string.Format(units[num], value);
	}

	public string GetLessThanText(string minimumValue)
	{
		return string.Format(lessThan, minimumValue);
	}

	public virtual string GetUnitText(TimeSpanFormatOptions unit, int value, bool abbr)
	{
		return unit switch
		{
			TimeSpanFormatOptions.RangeWeeks => GetValue(PluralRule, value, abbr ? w : week), 
			TimeSpanFormatOptions.RangeDays => GetValue(PluralRule, value, abbr ? d : day), 
			TimeSpanFormatOptions.RangeHours => GetValue(PluralRule, value, abbr ? h : hour), 
			TimeSpanFormatOptions.RangeMinutes => GetValue(PluralRule, value, abbr ? m : minute), 
			TimeSpanFormatOptions.RangeSeconds => GetValue(PluralRule, value, abbr ? s : second), 
			TimeSpanFormatOptions.RangeMilliSeconds => GetValue(PluralRule, value, abbr ? ms : millisecond), 
			_ => null, 
		};
	}
}
