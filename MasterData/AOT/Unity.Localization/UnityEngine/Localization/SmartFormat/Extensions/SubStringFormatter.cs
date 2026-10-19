using System;
using UnityEngine.Localization.SmartFormat.Core.Extensions;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class SubStringFormatter : FormatterBase
{
	public enum SubStringOutOfRangeBehavior
	{
		ReturnEmptyString,
		ReturnStartIndexToEndOfString,
		ThrowException
	}

	[SerializeField]
	private char m_ParameterDelimiter = ',';

	[SerializeField]
	private string m_NullDisplayString = "(null)";

	[SerializeField]
	private SubStringOutOfRangeBehavior m_OutOfRangeBehavior;

	public SubStringOutOfRangeBehavior OutOfRangeBehavior
	{
		get
		{
			return m_OutOfRangeBehavior;
		}
		set
		{
			m_OutOfRangeBehavior = value;
		}
	}

	public override string[] DefaultNames => new string[1] { "substr" };

	public char ParameterDelimiter
	{
		get
		{
			return m_ParameterDelimiter;
		}
		set
		{
			m_ParameterDelimiter = value;
		}
	}

	public string NullDisplayString
	{
		get
		{
			return m_NullDisplayString;
		}
		set
		{
			m_NullDisplayString = value;
		}
	}

	public SubStringFormatter()
	{
		Names = DefaultNames;
	}

	public override bool TryEvaluateFormat(IFormattingInfo formattingInfo)
	{
		if (formattingInfo.FormatterOptions == string.Empty)
		{
			return false;
		}
		string[] array = formattingInfo.FormatterOptions.Split(ParameterDelimiter);
		string text = formattingInfo.CurrentValue?.ToString();
		if (text == null)
		{
			formattingInfo.Write(NullDisplayString);
			return true;
		}
		int num = int.Parse(array[0]);
		int num2 = ((array.Length > 1) ? int.Parse(array[1]) : 0);
		if (num < 0)
		{
			num = text.Length + num;
		}
		if (num > text.Length)
		{
			num = text.Length;
		}
		if (num2 < 0)
		{
			num2 = text.Length - num + num2;
		}
		switch (OutOfRangeBehavior)
		{
		case SubStringOutOfRangeBehavior.ReturnEmptyString:
			if (num + num2 > text.Length)
			{
				num2 = 0;
			}
			break;
		case SubStringOutOfRangeBehavior.ReturnStartIndexToEndOfString:
			if (num > text.Length)
			{
				num = text.Length;
			}
			if (num + num2 > text.Length)
			{
				num2 = text.Length - num;
			}
			break;
		}
		string text2 = ((array.Length > 1) ? text.Substring(num, num2) : text.Substring(num));
		formattingInfo.Write(text2);
		return true;
	}
}
