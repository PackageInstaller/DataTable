using UnityEngine.Localization.SmartFormat.Core.Parsing;
using UnityEngine.Localization.SmartFormat.Core.Settings;
using UnityEngine.Pool;

namespace UnityEngine.Localization.SmartFormat;

internal static class FormatItemPool
{
	internal static readonly ObjectPool<LiteralText> s_LiteralTextPool = new ObjectPool<LiteralText>(() => new LiteralText(), null, (LiteralText lt) =>
	{
		lt.Clear();
	});

	internal static readonly ObjectPool<Format> s_FormatPool = new ObjectPool<Format>(() => new Format(), null, (Format f) =>
	{
		f.ReleaseToPool();
	});

	internal static readonly ObjectPool<Placeholder> s_PlaceholderPool = new ObjectPool<Placeholder>(() => new Placeholder(), null, (Placeholder p) =>
	{
		p.ReleaseToPool();
	});

	internal static readonly ObjectPool<Selector> s_SelectorPool = new ObjectPool<Selector>(() => new Selector(), null, (Selector s) =>
	{
		s.Clear();
	});

	public static LiteralText GetLiteralText(SmartSettings smartSettings, FormatItem parent, int startIndex)
	{
		LiteralText literalText = s_LiteralTextPool.Get();
		literalText.Init(smartSettings, parent, startIndex);
		return literalText;
	}

	public static LiteralText GetLiteralText(SmartSettings smartSettings, FormatItem parent, int startIndex, int endIndex)
	{
		LiteralText literalText = s_LiteralTextPool.Get();
		literalText.Init(smartSettings, parent, startIndex, endIndex);
		return literalText;
	}

	public static LiteralText GetLiteralText(SmartSettings smartSettings, FormatItem parent, string baseString, int startIndex, int endIndex)
	{
		LiteralText literalText = s_LiteralTextPool.Get();
		literalText.Init(smartSettings, parent, baseString, startIndex, endIndex);
		return literalText;
	}

	public static Format GetFormat(SmartSettings smartSettings, string baseString)
	{
		Format format = s_FormatPool.Get();
		format.Init(smartSettings, null, baseString, 0, baseString.Length);
		return format;
	}

	public static Format GetFormat(SmartSettings smartSettings, string baseString, int startIndex, int endIndex)
	{
		Format format = s_FormatPool.Get();
		format.Init(smartSettings, null, baseString, startIndex, endIndex);
		return format;
	}

	public static Format GetFormat(SmartSettings smartSettings, string baseString, int startIndex, int endIndex, bool nested)
	{
		Format format = s_FormatPool.Get();
		format.Init(smartSettings, null, baseString, startIndex, endIndex);
		format.HasNested = nested;
		return format;
	}

	public static Format GetFormat(SmartSettings smartSettings, Placeholder parent, int startIndex)
	{
		Format format = s_FormatPool.Get();
		format.Init(smartSettings, parent, startIndex);
		format.parent = parent;
		return format;
	}

	public static Placeholder GetPlaceholder(SmartSettings smartSettings, Format parent, int startIndex, int nestedDepth)
	{
		Placeholder placeholder = s_PlaceholderPool.Get();
		placeholder.Init(smartSettings, parent, startIndex);
		placeholder.NestedDepth = nestedDepth;
		placeholder.FormatterName = "";
		placeholder.FormatterOptions = "";
		return placeholder;
	}

	public static Placeholder GetPlaceholder(SmartSettings smartSettings, Format parent, int startIndex, int nestedDepth, Format itemFormat, int endIndex)
	{
		Placeholder placeholder = s_PlaceholderPool.Get();
		placeholder.Init(smartSettings, parent, startIndex, endIndex);
		placeholder.Format = itemFormat;
		placeholder.NestedDepth = nestedDepth;
		placeholder.FormatterName = "";
		placeholder.FormatterOptions = "";
		return placeholder;
	}

	public static Selector GetSelector(SmartSettings smartSettings, FormatItem parent, string baseString, int startIndex, int endIndex, int operatorStart, int selectorIndex)
	{
		Selector selector = s_SelectorPool.Get();
		selector.Init(smartSettings, parent, baseString, startIndex, endIndex);
		selector.operatorStart = operatorStart;
		selector.SelectorIndex = selectorIndex;
		return selector;
	}

	public static void ReleaseLiteralText(LiteralText literal)
	{
		s_LiteralTextPool.Release(literal);
	}

	public static void ReleaseFormat(Format format)
	{
		s_FormatPool.Release(format);
	}

	public static void ReleasePlaceholder(Placeholder placeholder)
	{
		s_PlaceholderPool.Release(placeholder);
	}

	public static void ReleaseSelector(Selector selector)
	{
		s_SelectorPool.Release(selector);
	}

	public static void Release(FormatItem format)
	{
		if (!(format is LiteralText literal))
		{
			if (!(format is Format format2))
			{
				if (!(format is Placeholder placeholder))
				{
					if (format is Selector selector)
					{
						ReleaseSelector(selector);
					}
					else
					{
						Debug.LogError("Unhandled type " + format.GetType());
					}
				}
				else
				{
					ReleasePlaceholder(placeholder);
				}
			}
			else
			{
				ReleaseFormat(format2);
			}
		}
		else
		{
			ReleaseLiteralText(literal);
		}
	}
}
