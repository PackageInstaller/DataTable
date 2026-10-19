using System;
using System.Collections.Generic;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Parsing;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class ChooseFormatter : FormatterBase, IFormatterLiteralExtractor
{
	[SerializeField]
	private char m_SplitChar = '|';

	public char SplitChar
	{
		get
		{
			return m_SplitChar;
		}
		set
		{
			m_SplitChar = value;
		}
	}

	public override string[] DefaultNames => new string[2] { "choose", "c" };

	public ChooseFormatter()
	{
		Names = DefaultNames;
	}

	public override bool TryEvaluateFormat(IFormattingInfo formattingInfo)
	{
		if (formattingInfo.FormatterOptions == "")
		{
			return false;
		}
		string[] chooseOptions = formattingInfo.FormatterOptions.Split(SplitChar);
		IList<Format> list = formattingInfo.Format.Split(SplitChar);
		if (list.Count < 2)
		{
			return false;
		}
		Format format = DetermineChosenFormat(formattingInfo, list, chooseOptions);
		formattingInfo.Write(format, formattingInfo.CurrentValue);
		return true;
	}

	private static Format DetermineChosenFormat(IFormattingInfo formattingInfo, IList<Format> choiceFormats, string[] chooseOptions)
	{
		object currentValue = formattingInfo.CurrentValue;
		string text = ((currentValue == null) ? "null" : currentValue.ToString());
		int num = Array.IndexOf(chooseOptions, text);
		if (choiceFormats.Count < chooseOptions.Length)
		{
			throw formattingInfo.FormattingException("You must specify at least " + chooseOptions.Length + " choices");
		}
		if (choiceFormats.Count > chooseOptions.Length + 1)
		{
			throw formattingInfo.FormattingException("You cannot specify more than " + (chooseOptions.Length + 1) + " choices");
		}
		if (num == -1 && choiceFormats.Count == chooseOptions.Length)
		{
			throw formattingInfo.FormattingException("\"" + text + "\" is not a valid choice, and a \"default\" choice was not supplied");
		}
		if (num == -1)
		{
			num = choiceFormats.Count - 1;
		}
		return choiceFormats[num];
	}

	public void WriteAllLiterals(IFormattingInfo formattingInfo)
	{
		if (formattingInfo.FormatterOptions == "")
		{
			return;
		}
		IList<Format> list = formattingInfo.Format.Split(SplitChar);
		if (list.Count >= 2)
		{
			for (int i = 0; i < list.Count; i++)
			{
				formattingInfo.Write(list[i], null);
			}
		}
	}
}
