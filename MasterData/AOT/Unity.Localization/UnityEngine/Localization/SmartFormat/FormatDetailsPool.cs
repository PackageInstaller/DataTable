using System;
using System.Collections.Generic;
using UnityEngine.Localization.SmartFormat.Core.Formatting;
using UnityEngine.Localization.SmartFormat.Core.Output;
using UnityEngine.Localization.SmartFormat.Core.Parsing;
using UnityEngine.Pool;

namespace UnityEngine.Localization.SmartFormat;

internal static class FormatDetailsPool
{
	internal static readonly ObjectPool<FormatDetails> s_Pool = new ObjectPool<FormatDetails>(() => new FormatDetails(), null, (FormatDetails fd) =>
	{
		fd.Clear();
	});

	public static FormatDetails Get(SmartFormatter formatter, Format originalFormat, IList<object> originalArgs, FormatCache formatCache, IFormatProvider provider, IOutput output)
	{
		FormatDetails formatDetails = s_Pool.Get();
		formatDetails.Init(formatter, originalFormat, originalArgs, formatCache, provider, output);
		return formatDetails;
	}

	public static PooledObject<FormatDetails> Get(SmartFormatter formatter, Format originalFormat, object[] originalArgs, FormatCache formatCache, IFormatProvider provider, IOutput output, out FormatDetails value)
	{
		PooledObject<FormatDetails> result = s_Pool.Get(out value);
		value.Init(formatter, originalFormat, originalArgs, formatCache, provider, output);
		return result;
	}

	public static void Release(FormatDetails toRelease)
	{
		s_Pool.Release(toRelease);
	}
}
