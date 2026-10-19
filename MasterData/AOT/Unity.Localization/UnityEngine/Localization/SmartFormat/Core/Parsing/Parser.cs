using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.Localization.SmartFormat.Core.Settings;

namespace UnityEngine.Localization.SmartFormat.Core.Parsing;

[Serializable]
public class Parser
{
	public enum ParsingError
	{
		TooManyClosingBraces = 1,
		TrailingOperatorsInSelector,
		InvalidCharactersInSelector,
		MissingClosingBrace
	}

	internal class ParsingErrorText
	{
		private readonly Dictionary<ParsingError, string> _errors = new Dictionary<ParsingError, string>
		{
			{
				ParsingError.TooManyClosingBraces,
				"Format string has too many closing braces"
			},
			{
				ParsingError.TrailingOperatorsInSelector,
				"There are trailing operators in the selector"
			},
			{
				ParsingError.InvalidCharactersInSelector,
				"Invalid character in the selector"
			},
			{
				ParsingError.MissingClosingBrace,
				"Format string is missing a closing brace"
			}
		};

		public string this[ParsingError parsingErrorKey] => _errors[parsingErrorKey];

		internal ParsingErrorText()
		{
		}
	}

	[SerializeField]
	private char m_OpeningBrace = '{';

	[SerializeField]
	private char m_ClosingBrace = '}';

	[SerializeReference]
	[HideInInspector]
	private SmartSettings m_Settings;

	[Tooltip("If false, only digits are allowed as selectors. If true, selectors can be alpha-numeric. This allows optimized alpha-character detection. Specify any additional selector chars in AllowedSelectorChars.")]
	[SerializeField]
	private bool m_AlphanumericSelectors;

	[SerializeField]
	[Tooltip("A list of allowable selector characters, to support additional selector syntaxes such as math. Digits are always included, and letters can be included with AlphanumericSelectors.")]
	private string m_AllowedSelectorChars = "";

	[SerializeField]
	[Tooltip("A list of characters that come between selectors. This can be \".\" for dot-notation, \"[]\" for arrays, or even math symbols. By default, there are no operators.")]
	private string m_Operators = "";

	[SerializeField]
	[Tooltip("If false, double-curly braces are escaped. If true, the AlternativeEscapeChar is used for escaping braces.")]
	private bool m_AlternativeEscaping;

	[SerializeField]
	[Tooltip("If AlternativeEscaping is true, then this character is used to escape curly braces.")]
	private char m_AlternativeEscapeChar = '\\';

	[SerializeField]
	[Tooltip("The character literal escape character e.g. for \t (TAB) and others. This is kind of overlapping functionality with `UseAlternativeEscapeChar` Note: In a future release escape characters for placeholders  and character literals should become the same.")]
	internal const char m_CharLiteralEscapeChar = '\\';

	private static ParsingErrorText s_ParsingErrorText;

	public SmartSettings Settings
	{
		get
		{
			return m_Settings;
		}
		set
		{
			m_Settings = value;
		}
	}

	public event EventHandler<ParsingErrorEventArgs> OnParsingFailure;

	public Parser(SmartSettings settings)
	{
		m_Settings = settings;
	}

	public void AddAlphanumericSelectors()
	{
		m_AlphanumericSelectors = true;
	}

	public void AddAdditionalSelectorChars(string chars)
	{
		for (int i = 0; i < chars.Length; i++)
		{
			char value = chars[i];
			if (m_AllowedSelectorChars.IndexOf(value) == -1)
			{
				m_AllowedSelectorChars += value;
			}
		}
	}

	public void AddOperators(string chars)
	{
		for (int i = 0; i < chars.Length; i++)
		{
			char value = chars[i];
			if (m_Operators.IndexOf(value) == -1)
			{
				m_Operators += value;
			}
		}
	}

	public void UseAlternativeEscapeChar(char alternativeEscapeChar = '\\')
	{
		m_AlternativeEscapeChar = alternativeEscapeChar;
		m_AlternativeEscaping = true;
	}

	public void UseBraceEscaping()
	{
		m_AlternativeEscaping = false;
	}

	public void UseAlternativeBraces(char opening, char closing)
	{
		m_OpeningBrace = opening;
		m_ClosingBrace = closing;
	}

	public Format ParseFormat(string format, IList<string> formatterExtensionNames)
	{
		Format format2 = FormatItemPool.GetFormat(Settings, format);
		Format format3 = format2;
		Placeholder placeholder = null;
		int num = -1;
		int num2 = -1;
		int num3 = -1;
		ParsingErrors parsingErrors = ParsingErrorsPool.Get(format2);
		if (s_ParsingErrorText == null)
		{
			s_ParsingErrorText = new ParsingErrorText();
		}
		char openingBrace = m_OpeningBrace;
		char closingBrace = m_ClosingBrace;
		int num4 = 0;
		int num5 = 0;
		int num6 = 0;
		int num7 = 0;
		int i = 0;
		for (int length = format.Length; i < length; i++)
		{
			char c = format[i];
			if (placeholder == null)
			{
				if (c == openingBrace)
				{
					if (i != num5)
					{
						format3.Items.Add(FormatItemPool.GetLiteralText(Settings, format3, num5, i));
					}
					num5 = i + 1;
					if (!m_AlternativeEscaping)
					{
						int num8 = num5;
						if (num8 < length && format[num8] == openingBrace)
						{
							i++;
							continue;
						}
					}
					num4++;
					placeholder = FormatItemPool.GetPlaceholder(Settings, format3, i, num4);
					format3.Items.Add(placeholder);
					format3.HasNested = true;
					num6 = i + 1;
					num7 = 0;
					num = -1;
				}
				else if (c == closingBrace)
				{
					if (i != num5)
					{
						format3.Items.Add(FormatItemPool.GetLiteralText(Settings, format3, num5, i));
					}
					num5 = i + 1;
					if (!m_AlternativeEscaping)
					{
						int num9 = num5;
						if (num9 < length && format[num9] == closingBrace)
						{
							i++;
							continue;
						}
					}
					if (format3.parent == null)
					{
						format3.Items.Add(FormatItemPool.GetLiteralText(Settings, format3, i, i + 1));
						parsingErrors.AddIssue(s_ParsingErrorText[ParsingError.TooManyClosingBraces], i, i + 1);
						continue;
					}
					num4--;
					format3.endIndex = i;
					format3.parent.endIndex = i + 1;
					format3 = format3.parent.Parent as Format;
					num = -1;
				}
				else if ((c == '\\' && Settings.ConvertCharacterStringLiterals) || (m_AlternativeEscaping && c == m_AlternativeEscapeChar))
				{
					num = -1;
					int num10 = i + 1;
					if (num10 < length && (format[num10] == openingBrace || format[num10] == closingBrace))
					{
						if (i != num5)
						{
							format3.Items.Add(FormatItemPool.GetLiteralText(Settings, format3, num5, i));
						}
						num5 = i + 1;
						i++;
						continue;
					}
					if (i != num5)
					{
						format3.Items.Add(FormatItemPool.GetLiteralText(Settings, format3, num5, i));
					}
					num5 = ((i + 1 >= format.Length || format[i + 1] != 'u') ? (i + 2) : (i + 6));
					if (num5 > length)
					{
						num5 = length;
					}
					format3.Items.Add(FormatItemPool.GetLiteralText(Settings, format3, i, num5));
					i++;
				}
				else
				{
					if (num == -1)
					{
						continue;
					}
					switch (c)
					{
					case '(':
						if (num == i)
						{
							num = -1;
						}
						else
						{
							num2 = i;
						}
						break;
					case ')':
					case ':':
					{
						if (c == ')')
						{
							bool flag = num2 != -1;
							int num11 = i + 1;
							bool flag2 = num11 < format.Length && (format[num11] == ':' || format[num11] == closingBrace);
							if (!flag || !flag2)
							{
								num = -1;
								break;
							}
							num3 = i;
							if (format[num11] == ':')
							{
								i++;
							}
						}
						bool flag3 = num == i;
						bool flag4 = num2 != -1 && num3 == -1;
						if (flag3 | flag4)
						{
							num = -1;
							break;
						}
						num5 = i + 1;
						Placeholder parent = format3.parent;
						if (num2 == -1)
						{
							string text = format.Substring(num, i - num);
							if (FormatterNameExists(text, formatterExtensionNames))
							{
								parent.FormatterName = text;
							}
							else
							{
								num5 = format3.startIndex;
							}
						}
						else
						{
							string text2 = format.Substring(num, num2 - num);
							if (FormatterNameExists(text2, formatterExtensionNames))
							{
								parent.FormatterName = text2;
								parent.FormatterOptions = format.Substring(num2 + 1, num3 - (num2 + 1));
							}
							else
							{
								num5 = format3.startIndex;
							}
						}
						format3.startIndex = num5;
						num = -1;
						break;
					}
					}
				}
			}
			else if (m_Operators.IndexOf(c) != -1)
			{
				if (i != num5)
				{
					placeholder.Selectors.Add(FormatItemPool.GetSelector(Settings, placeholder, format, num5, i, num6, num7));
					num7++;
					num6 = i;
				}
				num5 = i + 1;
			}
			else if (c == ':')
			{
				if (i != num5)
				{
					placeholder.Selectors.Add(FormatItemPool.GetSelector(Settings, placeholder, format, num5, i, num6, num7));
				}
				else if (num6 != i)
				{
					parsingErrors.AddIssue($"'0x{Convert.ToByte(c):X}': {s_ParsingErrorText[ParsingError.TrailingOperatorsInSelector]}", num6, i);
				}
				num5 = i + 1;
				placeholder.Format = FormatItemPool.GetFormat(Settings, placeholder, i + 1);
				format3 = placeholder.Format;
				placeholder = null;
				num = num5;
				num2 = -1;
				num3 = -1;
			}
			else if (c == closingBrace)
			{
				if (i != num5)
				{
					placeholder.Selectors.Add(FormatItemPool.GetSelector(Settings, placeholder, format, num5, i, num6, num7));
				}
				else if (num6 != i)
				{
					parsingErrors.AddIssue($"'0x{Convert.ToByte(c):X}': {s_ParsingErrorText[ParsingError.TrailingOperatorsInSelector]}", num6, i);
				}
				num5 = i + 1;
				num4--;
				placeholder.endIndex = i + 1;
				format3 = placeholder.Parent as Format;
				placeholder = null;
			}
			else if (('0' > c || c > '9') && (!m_AlphanumericSelectors || (('a' > c || c > 'z') && ('A' > c || c > 'Z'))) && m_AllowedSelectorChars.IndexOf(c) == -1)
			{
				parsingErrors.AddIssue($"'0x{Convert.ToByte(c):X}': {s_ParsingErrorText[ParsingError.TrailingOperatorsInSelector]}", i, i + 1);
			}
		}
		if (format3.parent != null || placeholder != null)
		{
			parsingErrors.AddIssue(s_ParsingErrorText[ParsingError.MissingClosingBrace], format.Length, format.Length);
			format3.endIndex = format.Length;
		}
		else if (num5 != format.Length)
		{
			format3.Items.Add(FormatItemPool.GetLiteralText(Settings, format3, num5, format.Length));
		}
		while (format3.parent != null)
		{
			format3 = format3.parent.Parent as Format;
			format3.endIndex = format.Length;
		}
		if (parsingErrors.HasIssues)
		{
			OnParsingFailure?.Invoke(this, new ParsingErrorEventArgs(parsingErrors, Settings.ParseErrorAction == ErrorAction.ThrowError));
			return HandleParsingErrors(parsingErrors, format2);
		}
		ParsingErrorsPool.Release(parsingErrors);
		return format2;
	}

	private Format HandleParsingErrors(ParsingErrors parsingErrors, Format currentResult)
	{
		switch (Settings.ParseErrorAction)
		{
		case ErrorAction.ThrowError:
			throw parsingErrors;
		case ErrorAction.MaintainTokens:
		{
			int i2;
			for (i2 = 0; i2 < currentResult.Items.Count; i2++)
			{
				if (currentResult.Items[i2] is Placeholder placeholder2 && parsingErrors.Issues.Any((ParsingErrors.ParsingIssue errItem) => errItem.Index >= currentResult.Items[i2].startIndex && errItem.Index <= currentResult.Items[i2].endIndex))
				{
					currentResult.Items[i2] = FormatItemPool.GetLiteralText(Settings, placeholder2.Format ?? FormatItemPool.GetFormat(Settings, placeholder2.baseString), placeholder2.startIndex, placeholder2.endIndex);
				}
			}
			return currentResult;
		}
		case ErrorAction.Ignore:
		{
			int i;
			for (i = 0; i < currentResult.Items.Count; i++)
			{
				if (currentResult.Items[i] is Placeholder placeholder && parsingErrors.Issues.Any((ParsingErrors.ParsingIssue errItem) => errItem.Index >= currentResult.Items[i].startIndex && errItem.Index <= currentResult.Items[i].endIndex))
				{
					currentResult.Items[i] = FormatItemPool.GetLiteralText(Settings, placeholder.Format ?? FormatItemPool.GetFormat(Settings, placeholder.baseString), placeholder.startIndex, placeholder.startIndex);
				}
			}
			return currentResult;
		}
		case ErrorAction.OutputErrorInResult:
		{
			Format format = FormatItemPool.GetFormat(Settings, parsingErrors.Message, 0, parsingErrors.Message.Length);
			format.Items.Add(FormatItemPool.GetLiteralText(Settings, format, 0));
			return format;
		}
		default:
			throw new ArgumentException("Illegal type for ParsingErrors", parsingErrors);
		}
	}

	private static bool FormatterNameExists(string name, IList<string> formatterExtensionNames)
	{
		foreach (string formatterExtensionName in formatterExtensionNames)
		{
			if (formatterExtensionName == name)
			{
				return true;
			}
		}
		return false;
	}
}
