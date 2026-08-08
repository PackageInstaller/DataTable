namespace System.Text;

public abstract class EncodingProvider
{
	private static object s_InternalSyncObject = new object();

	private static volatile EncodingProvider[] s_providers;

	public abstract Encoding GetEncoding(string name);

	public abstract Encoding GetEncoding(int codepage);

	public virtual Encoding GetEncoding(string name, EncoderFallback encoderFallback, DecoderFallback decoderFallback)
	{
		Encoding encoding = GetEncoding(name);
		if (encoding != null)
		{
			encoding = (Encoding)GetEncoding(name).Clone();
			encoding.EncoderFallback = encoderFallback;
			encoding.DecoderFallback = decoderFallback;
		}
		return encoding;
	}

	public virtual Encoding GetEncoding(int codepage, EncoderFallback encoderFallback, DecoderFallback decoderFallback)
	{
		Encoding encoding = GetEncoding(codepage);
		if (encoding != null)
		{
			encoding = (Encoding)GetEncoding(codepage).Clone();
			encoding.EncoderFallback = encoderFallback;
			encoding.DecoderFallback = decoderFallback;
		}
		return encoding;
	}

	internal static void AddProvider(EncodingProvider provider)
	{
		if (provider == null)
		{
			throw new ArgumentNullException("provider");
		}
		lock (s_InternalSyncObject)
		{
			if (s_providers == null)
			{
				s_providers = new EncodingProvider[1] { provider };
			}
			else if (Array.IndexOf(s_providers, provider) < 0)
			{
				EncodingProvider[] array = new EncodingProvider[s_providers.Length + 1];
				Array.Copy(s_providers, array, s_providers.Length);
				array[array.Length - 1] = provider;
				s_providers = array;
			}
		}
	}

	internal static Encoding GetEncodingFromProvider(int codepage)
	{
		if (s_providers == null)
		{
			return null;
		}
		EncodingProvider[] array = s_providers;
		for (int i = 0; i < array.Length; i++)
		{
			Encoding encoding = array[i].GetEncoding(codepage);
			if (encoding != null)
			{
				return encoding;
			}
		}
		return null;
	}

	internal static Encoding GetEncodingFromProvider(string encodingName)
	{
		if (s_providers == null)
		{
			return null;
		}
		EncodingProvider[] array = s_providers;
		for (int i = 0; i < array.Length; i++)
		{
			Encoding encoding = array[i].GetEncoding(encodingName);
			if (encoding != null)
			{
				return encoding;
			}
		}
		return null;
	}

	internal static Encoding GetEncodingFromProvider(int codepage, EncoderFallback enc, DecoderFallback dec)
	{
		if (s_providers == null)
		{
			return null;
		}
		EncodingProvider[] array = s_providers;
		for (int i = 0; i < array.Length; i++)
		{
			Encoding encoding = array[i].GetEncoding(codepage, enc, dec);
			if (encoding != null)
			{
				return encoding;
			}
		}
		return null;
	}

	internal static Encoding GetEncodingFromProvider(string encodingName, EncoderFallback enc, DecoderFallback dec)
	{
		if (s_providers == null)
		{
			return null;
		}
		EncodingProvider[] array = s_providers;
		for (int i = 0; i < array.Length; i++)
		{
			Encoding encoding = array[i].GetEncoding(encodingName, enc, dec);
			if (encoding != null)
			{
				return encoding;
			}
		}
		return null;
	}
}
