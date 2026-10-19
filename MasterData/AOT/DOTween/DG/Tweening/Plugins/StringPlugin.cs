using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;

namespace DG.Tweening.Plugins;

public class StringPlugin : ABSTweenPlugin<string, string, StringOptions>
{
	private static readonly StringBuilder _Buffer = new StringBuilder();

	private static readonly List<char> _OpenedTags = new List<char>();

	public override void SetFrom(TweenerCore<string, string, StringOptions> t, bool isRelative)
	{
		string endValue = t.endValue;
		t.endValue = t.getter();
		t.startValue = endValue;
		t.setter(t.startValue);
	}

	public override void SetFrom(TweenerCore<string, string, StringOptions> t, string fromValue, bool setImmediately, bool isRelative)
	{
		if (fromValue == null)
		{
			fromValue = "";
		}
		if (isRelative)
		{
			string text = t.getter();
			fromValue += text;
		}
		t.startValue = fromValue;
		if (setImmediately)
		{
			t.setter(fromValue);
		}
	}

	public override void Reset(TweenerCore<string, string, StringOptions> t)
	{
		t.startValue = (t.endValue = (t.changeValue = ""));
	}

	public override string ConvertToStartValue(TweenerCore<string, string, StringOptions> t, string value)
	{
		return value;
	}

	public override void SetRelativeEndValue(TweenerCore<string, string, StringOptions> t)
	{
	}

	public override void SetChangeValue(TweenerCore<string, string, StringOptions> t)
	{
		t.changeValue = t.endValue;
		bool flag = string.IsNullOrEmpty(t.startValue);
		bool flag2 = string.IsNullOrEmpty(t.changeValue);
		t.plugOptions.startValueStrippedLength = ((!flag) ? Regex.Replace(t.startValue, "<[^>]*>", "").Length : 0);
		t.plugOptions.changeValueStrippedLength = ((!flag2) ? Regex.Replace(t.changeValue, "<[^>]*>", "").Length : 0);
		int num = ((!flag) ? t.startValue.Length : 0);
		int num2 = ((!flag2) ? t.changeValue.Length : 0);
		if (num > 3 && t.startValue[num - 1] == '>')
		{
			for (int num3 = num - 3; num3 > -1; num3--)
			{
				if (t.startValue[num3] == '<')
				{
					if (t.startValue[num3 + 1] != '/')
					{
						t.plugOptions.startValueStrippedLength++;
					}
					break;
				}
			}
		}
		if (num2 <= 3 || t.changeValue[num2 - 1] != '>')
		{
			return;
		}
		for (int num4 = num2 - 3; num4 > -1; num4--)
		{
			if (t.changeValue[num4] == '<')
			{
				if (t.changeValue[num4 + 1] != '/')
				{
					t.plugOptions.changeValueStrippedLength++;
				}
				break;
			}
		}
	}

	public override float GetSpeedBasedDuration(StringOptions options, float unitsXSecond, string changeValue)
	{
		float num = (float)(options.richTextEnabled ? options.changeValueStrippedLength : changeValue.Length) / unitsXSecond;
		if (num < 0f)
		{
			num = 0f - num;
		}
		return num;
	}

	public override void EvaluateAndApply(StringOptions options, Tween t, bool isRelative, DOGetter<string> getter, DOSetter<string> setter, float elapsed, string startValue, string changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		_Buffer.Remove(0, _Buffer.Length);
		if (isRelative && t.loopType == LoopType.Incremental)
		{
			int num = (t.isComplete ? (t.completedLoops - 1) : t.completedLoops);
			if (num > 0)
			{
				_Buffer.Append(startValue);
				for (int i = 0; i < num; i++)
				{
					_Buffer.Append(changeValue);
				}
				startValue = _Buffer.ToString();
				_Buffer.Remove(0, _Buffer.Length);
			}
		}
		int num2 = (options.richTextEnabled ? options.startValueStrippedLength : ((!string.IsNullOrEmpty(startValue)) ? startValue.Length : 0));
		int num3 = (options.richTextEnabled ? options.changeValueStrippedLength : changeValue.Length);
		int num4 = (int)Math.Round((float)num3 * EaseManager.Evaluate(t.easeType, t.customEase, elapsed, duration, t.easeOvershootOrAmplitude, t.easePeriod));
		if (num4 > num3)
		{
			num4 = num3;
		}
		else if (num4 < 0)
		{
			num4 = 0;
		}
		if (isRelative)
		{
			_Buffer.Append(startValue);
			if (options.scrambleMode != ScrambleMode.None)
			{
				setter(Append(changeValue, 0, num4, options.richTextEnabled).AppendScrambledChars(num3 - num4, ScrambledCharsToUse(options)).ToString());
			}
			else
			{
				setter(Append(changeValue, 0, num4, options.richTextEnabled).ToString());
			}
			return;
		}
		if (options.scrambleMode != ScrambleMode.None)
		{
			setter(Append(changeValue, 0, num4, options.richTextEnabled).AppendScrambledChars(num3 - num4, ScrambledCharsToUse(options)).ToString());
			return;
		}
		int num5 = num2 - num3;
		int num6 = num2;
		if (num5 > 0)
		{
			float num7 = (float)num4 / (float)num3;
			num6 -= (int)((float)num6 * num7);
		}
		else
		{
			num6 -= num4;
		}
		Append(changeValue, 0, num4, options.richTextEnabled);
		if (num4 < num3 && num4 < num2)
		{
			Append(startValue, num4, options.richTextEnabled ? (num4 + num6) : num6, options.richTextEnabled);
		}
		setter(_Buffer.ToString());
	}

	private StringBuilder Append(string value, int startIndex, int length, bool richTextEnabled)
	{
		if (!richTextEnabled)
		{
			_Buffer.Append(value, startIndex, length);
			return _Buffer;
		}
		_OpenedTags.Clear();
		bool flag = false;
		int length2 = value.Length;
		int i;
		for (i = 0; i < length && i <= length2 - 1; i++)
		{
			char c = value[i];
			if (c == '<')
			{
				bool flag2 = flag;
				char c2 = value[i + 1];
				flag = i >= length2 - 1 || c2 != '/';
				if (flag)
				{
					_OpenedTags.Add((c2 == '#') ? 'c' : c2);
				}
				else
				{
					_OpenedTags.RemoveAt(_OpenedTags.Count - 1);
				}
				Match match = Regex.Match(value.Substring(i), "<.*?(>)");
				if (!match.Success)
				{
					continue;
				}
				if (!flag && !flag2)
				{
					char c3 = value[i + 1];
					char[] array = ((c3 != 'c') ? new char[1] { c3 } : new char[2] { '#', 'c' });
					for (int num = i - 1; num > -1; num--)
					{
						if (value[num] == '<' && value[num + 1] != '/' && Array.IndexOf(array, value[num + 2]) != -1)
						{
							_Buffer.Insert(0, value.Substring(num, value.IndexOf('>', num) + 1 - num));
							break;
						}
					}
				}
				_Buffer.Append(match.Value);
				int num2 = match.Groups[1].Index + 1;
				length += num2;
				startIndex += num2;
				i += num2 - 1;
			}
			else if (i >= startIndex)
			{
				_Buffer.Append(c);
			}
		}
		if (_OpenedTags.Count > 0 && i < length2 - 1)
		{
			while (_OpenedTags.Count > 0 && i < length2 - 1)
			{
				Match match2 = Regex.Match(value.Substring(i), "(</).*?>");
				if (!match2.Success)
				{
					break;
				}
				if (match2.Value[2] == _OpenedTags[_OpenedTags.Count - 1])
				{
					_Buffer.Append(match2.Value);
					_OpenedTags.RemoveAt(_OpenedTags.Count - 1);
				}
				i += match2.Value.Length;
			}
		}
		return _Buffer;
	}

	private char[] ScrambledCharsToUse(StringOptions options)
	{
		return options.scrambleMode switch
		{
			ScrambleMode.Uppercase => StringPluginExtensions.ScrambledCharsUppercase, 
			ScrambleMode.Lowercase => StringPluginExtensions.ScrambledCharsLowercase, 
			ScrambleMode.Numerals => StringPluginExtensions.ScrambledCharsNumerals, 
			ScrambleMode.Custom => options.scrambledChars, 
			_ => StringPluginExtensions.ScrambledCharsAll, 
		};
	}
}
