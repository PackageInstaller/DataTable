using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Parsing;
using UnityEngine.Localization.SmartFormat.Core.Settings;
using UnityEngine.Pool;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class ListFormatter : FormatterBase, ISource, IFormatterLiteralExtractor
{
	[SerializeReference]
	[HideInInspector]
	private SmartSettings m_SmartSettings;

	public override string[] DefaultNames => new string[3] { "list", "l", "" };

	private static int CollectionIndex { get; set; } = -1;

	public ListFormatter(SmartFormatter formatter)
	{
		formatter.Parser.AddOperators("[]()");
		m_SmartSettings = formatter.Settings;
		Names = DefaultNames;
	}

	public bool TryEvaluateSelector(ISelectorInfo selectorInfo)
	{
		object currentValue = selectorInfo.CurrentValue;
		string selectorText = selectorInfo.SelectorText;
		if (!(currentValue is IList list))
		{
			return false;
		}
		if ((selectorInfo.SelectorIndex != 0 || selectorInfo.SelectorOperator.Length != 0) && int.TryParse(selectorText, out var result) && result < list.Count)
		{
			selectorInfo.Result = list[result];
			return true;
		}
		if (selectorText.Equals("index", StringComparison.OrdinalIgnoreCase))
		{
			if (selectorInfo.SelectorIndex == 0)
			{
				selectorInfo.Result = CollectionIndex;
				return true;
			}
			if (0 <= CollectionIndex && CollectionIndex < list.Count)
			{
				selectorInfo.Result = list[CollectionIndex];
				return true;
			}
		}
		return false;
	}

	public override bool TryEvaluateFormat(IFormattingInfo formattingInfo)
	{
		Format format = formattingInfo.Format;
		object currentValue = formattingInfo.CurrentValue;
		if (!(currentValue is IEnumerable enumerable))
		{
			return false;
		}
		if (currentValue is string)
		{
			return false;
		}
		if (currentValue is IFormattable)
		{
			return false;
		}
		if (format == null)
		{
			return false;
		}
		IList<Format> list = format.Split('|', 4);
		if (list.Count < 2)
		{
			return false;
		}
		Format format2 = list[0];
		string text = ((list.Count >= 2) ? list[1].GetLiteralText() : "");
		string text2 = ((list.Count >= 3) ? list[2].GetLiteralText() : text);
		string text3 = ((list.Count >= 4) ? list[3].GetLiteralText() : text2);
		if (!format2.HasNested)
		{
			Format format3 = FormatItemPool.GetFormat(m_SmartSettings, format2.baseString, format2.startIndex, format2.endIndex, nested: true);
			Placeholder placeholder = FormatItemPool.GetPlaceholder(m_SmartSettings, format3, format2.startIndex, 0, format2, format2.endIndex);
			format3.Items.Add(placeholder);
			format2 = format3;
		}
		List<object> list2 = null;
		ICollection collection = currentValue as ICollection;
		if (collection == null)
		{
			list2 = CollectionPool<List<object>, object>.Get();
			foreach (object item in enumerable)
			{
				list2.Add(item);
			}
			collection = list2;
		}
		int collectionIndex = CollectionIndex;
		CollectionIndex = -1;
		foreach (object item2 in collection)
		{
			CollectionIndex++;
			if (text != null && CollectionIndex != 0)
			{
				if (CollectionIndex < collection.Count - 1)
				{
					formattingInfo.Write(text);
				}
				else if (CollectionIndex == 1)
				{
					formattingInfo.Write(text3);
				}
				else
				{
					formattingInfo.Write(text2);
				}
			}
			formattingInfo.Write(format2, item2);
		}
		CollectionIndex = collectionIndex;
		if (list2 != null)
		{
			CollectionPool<List<object>, object>.Release(list2);
		}
		return true;
	}

	public void WriteAllLiterals(IFormattingInfo formattingInfo)
	{
		Format format = formattingInfo.Format;
		if (format == null)
		{
			return;
		}
		IList<Format> list = format.Split('|', 4);
		if (list.Count >= 2)
		{
			Format format2 = list[0];
			if (list.Count >= 1)
			{
				formattingInfo.Write(list[0], null);
			}
			if (list.Count >= 3)
			{
				formattingInfo.Write(list[2], null);
			}
			if (list.Count >= 4)
			{
				formattingInfo.Write(list[3], null);
			}
			if (!format2.HasNested)
			{
				Format format3 = FormatItemPool.GetFormat(m_SmartSettings, format2.baseString, format2.startIndex, format2.endIndex, nested: true);
				Placeholder placeholder = FormatItemPool.GetPlaceholder(m_SmartSettings, format3, format2.startIndex, 0, format2, format2.endIndex);
				format3.Items.Add(placeholder);
				format2 = format3;
			}
			formattingInfo.Write(format2, null);
		}
	}
}
