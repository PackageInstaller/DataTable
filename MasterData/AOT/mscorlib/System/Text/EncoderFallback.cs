using System.Threading;

namespace System.Text;

[Serializable]
public abstract class EncoderFallback
{
	private static EncoderFallback s_replacementFallback;

	private static EncoderFallback s_exceptionFallback;

	public static EncoderFallback ReplacementFallback
	{
		get
		{
			if (s_replacementFallback == null)
			{
				Interlocked.CompareExchange(ref s_replacementFallback, new EncoderReplacementFallback(), null);
			}
			return s_replacementFallback;
		}
	}

	public static EncoderFallback ExceptionFallback
	{
		get
		{
			if (s_exceptionFallback == null)
			{
				Interlocked.CompareExchange(ref s_exceptionFallback, new EncoderExceptionFallback(), null);
			}
			return s_exceptionFallback;
		}
	}

	public abstract int MaxCharCount { get; }

	public abstract EncoderFallbackBuffer CreateFallbackBuffer();
}
