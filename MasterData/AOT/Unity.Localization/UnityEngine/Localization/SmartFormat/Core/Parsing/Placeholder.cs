using System.Collections.Generic;
using System.Text;

namespace UnityEngine.Localization.SmartFormat.Core.Parsing;

public class Placeholder : FormatItem
{
	public int NestedDepth { get; set; }

	public List<Selector> Selectors { get; } = new List<Selector>();

	public int Alignment { get; set; }

	public string FormatterName { get; set; }

	public string FormatterOptions { get; set; }

	public Format Format { get; set; }

	public void ReleaseToPool()
	{
		Clear();
		if (Format != null)
		{
			FormatItemPool.ReleaseFormat(Format);
		}
		Format = null;
		NestedDepth = 0;
		Alignment = 0;
		foreach (Selector selector in Selectors)
		{
			FormatItemPool.ReleaseSelector(selector);
		}
		Selectors.Clear();
	}

	public override string ToString()
	{
		StringBuilder value;
		using (StringBuilderPool.Get(out value))
		{
			int num = endIndex - startIndex;
			if (value.Capacity < num)
			{
				value.Capacity = num;
			}
			value.Append('{');
			foreach (Selector selector in Selectors)
			{
				value.Append(selector.baseString, selector.operatorStart, selector.endIndex - selector.operatorStart);
			}
			if (Alignment != 0)
			{
				value.Append(',');
				value.Append(Alignment);
			}
			if (FormatterName != "")
			{
				value.Append(':');
				value.Append(FormatterName);
				if (FormatterOptions != "")
				{
					value.Append('(');
					value.Append(FormatterOptions);
					value.Append(')');
				}
			}
			if (Format != null)
			{
				value.Append(':');
				value.Append(Format);
			}
			value.Append('}');
			return value.ToString();
		}
	}
}
