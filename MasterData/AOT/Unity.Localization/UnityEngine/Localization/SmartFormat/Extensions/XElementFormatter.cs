using System;
using System.Collections.Generic;
using System.Xml.Linq;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Parsing;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class XElementFormatter : FormatterBase
{
	public override string[] DefaultNames => new string[4] { "xelement", "xml", "x", "" };

	public XElementFormatter()
	{
		Names = DefaultNames;
	}

	public override bool TryEvaluateFormat(IFormattingInfo formattingInfo)
	{
		Format format = formattingInfo.Format;
		object currentValue = formattingInfo.CurrentValue;
		XElement xElement = null;
		if (format != null && format.HasNested)
		{
			return false;
		}
		if (currentValue is IList<XElement> { Count: >0 } list)
		{
			xElement = list[0];
		}
		XElement xElement2 = xElement ?? (currentValue as XElement);
		if (xElement2 != null)
		{
			formattingInfo.Write(xElement2.Value);
			return true;
		}
		return false;
	}
}
