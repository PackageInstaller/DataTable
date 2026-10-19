using UnityEngine.Localization.SmartFormat.Core.Formatting;
using UnityEngine.Localization.SmartFormat.Core.Parsing;
using UnityEngine.Pool;

namespace UnityEngine.Localization.SmartFormat;

internal static class FormattingInfoPool
{
	internal static readonly ObjectPool<FormattingInfo> s_Pool = new ObjectPool<FormattingInfo>(() => new FormattingInfo(), null, (FormattingInfo fi) =>
	{
		fi.ReleaseToPool();
	});

	public static FormattingInfo Get(FormatDetails formatDetails, Format format, object currentValue)
	{
		FormattingInfo formattingInfo = s_Pool.Get();
		formattingInfo.Init(formatDetails, format, currentValue);
		return formattingInfo;
	}

	public static FormattingInfo Get(FormattingInfo parent, FormatDetails formatDetails, Format format, object currentValue)
	{
		FormattingInfo formattingInfo = s_Pool.Get();
		formattingInfo.Init(parent, formatDetails, format, currentValue);
		return formattingInfo;
	}

	public static FormattingInfo Get(FormattingInfo parent, FormatDetails formatDetails, Placeholder placeholder, object currentValue)
	{
		FormattingInfo formattingInfo = s_Pool.Get();
		formattingInfo.Init(parent, formatDetails, placeholder, currentValue);
		return formattingInfo;
	}

	public static void Release(FormattingInfo toRelease)
	{
		s_Pool.Release(toRelease);
	}
}
