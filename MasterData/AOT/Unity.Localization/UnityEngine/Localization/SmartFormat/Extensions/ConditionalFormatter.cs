using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text.RegularExpressions;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Parsing;
using UnityEngine.Localization.SmartFormat.Net.Utilities;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class ConditionalFormatter : FormatterBase, IFormatterLiteralExtractor
{
	private static readonly Regex _complexConditionPattern = new Regex("^  (?:   ([&/]?)   ([<>=!]=?)   ([0-9.-]+)   )+   \\?", RegexOptions.Compiled | RegexOptions.IgnorePatternWhitespace);

	public override string[] DefaultNames => new string[3] { "conditional", "cond", "" };

	public ConditionalFormatter()
	{
		Names = DefaultNames;
	}

	public override bool TryEvaluateFormat(IFormattingInfo formattingInfo)
	{
		Format format = formattingInfo.Format;
		object currentValue = formattingInfo.CurrentValue;
		if (format == null)
		{
			return false;
		}
		if (format.baseString[format.startIndex] == ':')
		{
			format = format.Substring(1);
		}
		IList<Format> list = format.Split('|');
		if (list.Count == 1)
		{
			return false;
		}
		bool flag = currentValue is byte || currentValue is short || currentValue is int || currentValue is long || currentValue is float || currentValue is double || currentValue is decimal;
		if (!flag && currentValue != null && currentValue.GetType().GetTypeInfo().IsEnum)
		{
			flag = true;
		}
		decimal num = (flag ? Convert.ToDecimal(currentValue) : 0m);
		int num2;
		if (flag)
		{
			num2 = -1;
			while (true)
			{
				num2++;
				if (num2 == list.Count)
				{
					return true;
				}
				if (!TryEvaluateCondition(list[num2], num, out var conditionResult, out var outputItem))
				{
					if (num2 == 0)
					{
						break;
					}
					conditionResult = true;
				}
				if (conditionResult)
				{
					formattingInfo.Write(outputItem, currentValue);
					return true;
				}
			}
		}
		int count = list.Count;
		if (flag)
		{
			num2 = ((!(num < 0m)) ? Math.Min((int)Math.Floor(num), count - 1) : (count - 1));
		}
		else
		{
			object obj = currentValue;
			if (obj is bool)
			{
				num2 = ((!(bool)obj) ? 1 : 0);
			}
			else if (!(obj is DateTime dateTime))
			{
				if (!(obj is DateTimeOffset dateTimeOffset))
				{
					if (!(obj is TimeSpan timeSpan))
					{
						num2 = ((!(obj is string value)) ? ((currentValue == null) ? 1 : 0) : (string.IsNullOrEmpty(value) ? 1 : 0));
					}
					else
					{
						TimeSpan timeSpan2 = timeSpan;
						if (count == 3 && timeSpan2 == TimeSpan.Zero)
						{
							num2 = 1;
						}
						else
						{
							TimeSpan timeSpan3 = timeSpan;
							num2 = ((timeSpan3.CompareTo(TimeSpan.Zero) > 0) ? (count - 1) : 0);
						}
					}
				}
				else
				{
					DateTimeOffset dateTimeOffset2 = dateTimeOffset;
					if (count == 3 && dateTimeOffset2.UtcDateTime.Date == SystemTime.OffsetNow().UtcDateTime.Date)
					{
						num2 = 1;
					}
					else
					{
						DateTimeOffset dateTimeOffset3 = dateTimeOffset;
						num2 = ((!(dateTimeOffset3.UtcDateTime <= SystemTime.OffsetNow().UtcDateTime)) ? (count - 1) : 0);
					}
				}
			}
			else
			{
				DateTime dateTime2 = dateTime;
				if (count == 3 && dateTime2.ToUniversalTime().Date == SystemTime.Now().ToUniversalTime().Date)
				{
					num2 = 1;
				}
				else
				{
					DateTime dateTime3 = dateTime;
					num2 = ((!(dateTime3.ToUniversalTime() <= SystemTime.Now().ToUniversalTime())) ? (count - 1) : 0);
				}
			}
		}
		Format format2 = list[num2];
		formattingInfo.Write(format2, currentValue);
		return true;
	}

	private static bool TryEvaluateCondition(Format parameter, decimal value, out bool conditionResult, out Format outputItem)
	{
		conditionResult = false;
		Match match = _complexConditionPattern.Match(parameter.baseString, parameter.startIndex, parameter.endIndex - parameter.startIndex);
		if (!match.Success)
		{
			outputItem = parameter;
			return false;
		}
		CaptureCollection captures = match.Groups[1].Captures;
		CaptureCollection captures2 = match.Groups[2].Captures;
		CaptureCollection captures3 = match.Groups[3].Captures;
		for (int i = 0; i < captures.Count; i++)
		{
			decimal num = decimal.Parse(captures3[i].Value);
			bool flag = false;
			switch (captures2[i].Value)
			{
			case ">":
				flag = value > num;
				break;
			case "<":
				flag = value < num;
				break;
			case "=":
			case "==":
				flag = value == num;
				break;
			case "<=":
				flag = value <= num;
				break;
			case ">=":
				flag = value >= num;
				break;
			case "!":
			case "!=":
				flag = value != num;
				break;
			}
			if (i == 0)
			{
				conditionResult = flag;
			}
			else if (captures[i].Value == "/")
			{
				conditionResult |= flag;
			}
			else
			{
				conditionResult &= flag;
			}
		}
		int startIndex = match.Index + match.Length - parameter.startIndex;
		outputItem = parameter.Substring(startIndex);
		return true;
	}

	public void WriteAllLiterals(IFormattingInfo formattingInfo)
	{
		Format format = formattingInfo.Format;
		if (format == null)
		{
			return;
		}
		if (format.baseString[format.startIndex] == ':')
		{
			format = format.Substring(1);
		}
		IList<Format> list = format.Split('|');
		if (list.Count == 1)
		{
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			Format format2 = list[i];
			Match match = _complexConditionPattern.Match(format2.baseString, format2.startIndex, format2.endIndex - format2.startIndex);
			if (match.Success)
			{
				int startIndex = match.Index + match.Length - format2.startIndex;
				format2 = format2.Substring(startIndex);
			}
			formattingInfo.Write(format2, null);
		}
	}
}
