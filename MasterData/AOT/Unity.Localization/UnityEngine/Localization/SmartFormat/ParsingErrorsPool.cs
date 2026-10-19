using UnityEngine.Localization.SmartFormat.Core.Parsing;
using UnityEngine.Pool;

namespace UnityEngine.Localization.SmartFormat;

internal static class ParsingErrorsPool
{
	internal static readonly ObjectPool<ParsingErrors> s_Pool = new ObjectPool<ParsingErrors>(() => new ParsingErrors(), null, (ParsingErrors pe) =>
	{
		pe.Clear();
	});

	public static ParsingErrors Get(Format format)
	{
		ParsingErrors parsingErrors = s_Pool.Get();
		parsingErrors.Init(format);
		return parsingErrors;
	}

	public static void Release(ParsingErrors toRelease)
	{
		s_Pool.Release(toRelease);
	}
}
