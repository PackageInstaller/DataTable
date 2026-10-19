using System;
using System.Globalization;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Parsing;
using UnityEngine.Localization.SmartFormat.Net.Utilities;
using UnityEngine.Localization.SmartFormat.Utilities;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class TimeFormatter : FormatterBase
{
	[SerializeField]
	private TimeSpanFormatOptions m_DefaultFormatOptions = TimeSpanUtility.DefaultFormatOptions;

	private string m_DefaultTwoLetterIsoLanguageName = "en";

	public override string[] DefaultNames => new string[4] { "timespan", "time", "t", "" };

	public TimeSpanFormatOptions DefaultFormatOptions
	{
		get
		{
			return m_DefaultFormatOptions;
		}
		set
		{
			m_DefaultFormatOptions = value;
		}
	}

	public string DefaultTwoLetterISOLanguageName
	{
		get
		{
			return m_DefaultTwoLetterIsoLanguageName;
		}
		set
		{
			if (CommonLanguagesTimeTextInfo.GetTimeTextInfo(value) == null)
			{
				throw new ArgumentException("Language '" + value + "' for value is not implemented.");
			}
			m_DefaultTwoLetterIsoLanguageName = value;
		}
	}

	public TimeFormatter()
	{
		Names = DefaultNames;
	}

	public override bool TryEvaluateFormat(IFormattingInfo formattingInfo)
	{
		Format format = formattingInfo.Format;
		object currentValue = formattingInfo.CurrentValue;
		if (format != null && format.HasNested)
		{
			return false;
		}
		string formatOptionsString;
		if (string.IsNullOrEmpty(formattingInfo.FormatterOptions))
		{
			formatOptionsString = ((format == null) ? string.Empty : format.GetLiteralText());
		}
		else
		{
			formatOptionsString = formattingInfo.FormatterOptions;
		}
		TimeSpan fromTime;
		if (!(currentValue is TimeSpan timeSpan))
		{
			if (!(currentValue is DateTime dateTime))
			{
				if (!(currentValue is DateTimeOffset dateTimeOffset))
				{
					return false;
				}
				if (!(formattingInfo.FormatterOptions != string.Empty))
				{
					return false;
				}
				fromTime = SystemTime.OffsetNow().UtcDateTime.Subtract(dateTimeOffset.UtcDateTime);
			}
			else
			{
				if (!(formattingInfo.FormatterOptions != string.Empty))
				{
					return false;
				}
				fromTime = SystemTime.Now().ToUniversalTime().Subtract(dateTime.ToUniversalTime());
			}
		}
		else
		{
			fromTime = timeSpan;
		}
		TimeTextInfo timeTextInfo = GetTimeTextInfo(formattingInfo.FormatDetails.Provider);
		if (timeTextInfo == null)
		{
			return false;
		}
		TimeSpanFormatOptions options = TimeSpanFormatOptionsConverter.Parse(formatOptionsString);
		string text = fromTime.ToTimeString(options, timeTextInfo);
		formattingInfo.Write(text);
		return true;
	}

	private TimeTextInfo GetTimeTextInfo(IFormatProvider provider)
	{
		if (provider == null)
		{
			return CommonLanguagesTimeTextInfo.GetTimeTextInfo(DefaultTwoLetterISOLanguageName);
		}
		if (provider.GetFormat(typeof(TimeTextInfo)) is TimeTextInfo result)
		{
			return result;
		}
		if (!(provider is CultureInfo cultureInfo))
		{
			return CommonLanguagesTimeTextInfo.GetTimeTextInfo(DefaultTwoLetterISOLanguageName);
		}
		return CommonLanguagesTimeTextInfo.GetTimeTextInfo(cultureInfo.TwoLetterISOLanguageName);
	}
}
