using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using UnityEngine.Localization.SmartFormat.Core.Extensions;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class XmlSource : ISource
{
	public XmlSource(SmartFormatter formatter)
	{
		formatter.Parser.AddAlphanumericSelectors();
		formatter.Parser.AddAdditionalSelectorChars("_");
		formatter.Parser.AddOperators(".");
	}

	public bool TryEvaluateSelector(ISelectorInfo selectorInfo)
	{
		if (selectorInfo.CurrentValue is XElement xElement)
		{
			string selector = selectorInfo.SelectorText;
			List<XElement> list = (from x in xElement.Elements()
				where x.Name.LocalName == selector
				select x).ToList();
			if (list.Any())
			{
				selectorInfo.Result = list;
				return true;
			}
		}
		return false;
	}
}
