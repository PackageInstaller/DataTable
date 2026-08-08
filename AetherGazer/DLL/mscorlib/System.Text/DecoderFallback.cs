using System.Threading;

namespace System.Text;

[Serializable]
public abstract class DecoderFallback
{
	private static DecoderFallback s_replacementFallback;

	private static DecoderFallback s_exceptionFallback;

	public static DecoderFallback ReplacementFallback => s_replacementFallback ?? Interlocked.CompareExchange(ref s_replacementFallback, new DecoderReplacementFallback(), null) ?? s_replacementFallback;

	public static DecoderFallback ExceptionFallback => s_exceptionFallback ?? Interlocked.CompareExchange(ref s_exceptionFallback, new DecoderExceptionFallback(), null) ?? s_exceptionFallback;

	public abstract int MaxCharCount { get; }

	public abstract DecoderFallbackBuffer CreateFallbackBuffer();
}
