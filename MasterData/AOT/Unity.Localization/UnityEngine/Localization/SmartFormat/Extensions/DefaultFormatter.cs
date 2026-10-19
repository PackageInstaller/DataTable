using System;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Parsing;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class DefaultFormatter : FormatterBase
{
	public override string[] DefaultNames => new string[3] { "default", "d", "" };

	public DefaultFormatter()
	{
		Names = DefaultNames;
	}

	public override bool TryEvaluateFormat(IFormattingInfo formattingInfo)
	{
		Format format = formattingInfo.Format;
		object obj = formattingInfo.CurrentValue;
		if (format != null && format.HasNested)
		{
			formattingInfo.Write(format, obj);
			return true;
		}
		if (obj == null)
		{
			obj = "";
		}
		IFormatProvider provider = formattingInfo.FormatDetails.Provider;
		string text;
		if (provider != null && provider.GetFormat(typeof(ICustomFormatter)) is ICustomFormatter customFormatter)
		{
			string format2 = format?.GetLiteralText();
			text = customFormatter.Format(format2, obj, provider);
		}
		else if (obj is IFormattable formattable)
		{
			string text2 = format?.ToString();
			text = formattable.ToString(text2, provider);
		}
		else
		{
			text = obj.ToString();
		}
		if (formattingInfo.Alignment > 0)
		{
			int num = formattingInfo.Alignment - text.Length;
			if (num > 0)
			{
				formattingInfo.Write(new string(' ', num));
			}
		}
		formattingInfo.Write(text);
		if (formattingInfo.Alignment < 0)
		{
			int num2 = -formattingInfo.Alignment - text.Length;
			if (num2 > 0)
			{
				formattingInfo.Write(new string(' ', num2));
			}
		}
		return true;
	}
}
