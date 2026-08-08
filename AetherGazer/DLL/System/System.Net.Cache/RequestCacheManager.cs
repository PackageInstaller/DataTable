namespace System.Net.Cache;

internal sealed class RequestCacheManager
{
	private static volatile RequestCachingSectionInternal s_CacheConfigSettings;

	private static readonly RequestCacheBinding s_BypassCacheBinding = new RequestCacheBinding(null, null, new RequestCachePolicy(RequestCacheLevel.BypassCache));

	private static volatile RequestCacheBinding s_DefaultGlobalBinding;

	private static volatile RequestCacheBinding s_DefaultHttpBinding;

	private static volatile RequestCacheBinding s_DefaultFtpBinding;

	internal static RequestCacheBinding GetBinding(string internedScheme)
	{
		if (internedScheme == null)
		{
			throw new ArgumentNullException("uriScheme");
		}
		if (s_CacheConfigSettings == null)
		{
			LoadConfigSettings();
		}
		if (s_CacheConfigSettings.DisableAllCaching)
		{
			return s_BypassCacheBinding;
		}
		if (internedScheme.Length == 0)
		{
			return s_DefaultGlobalBinding;
		}
		if ((object)internedScheme == Uri.UriSchemeHttp || (object)internedScheme == Uri.UriSchemeHttps)
		{
			return s_DefaultHttpBinding;
		}
		if ((object)internedScheme == Uri.UriSchemeFtp)
		{
			return s_DefaultFtpBinding;
		}
		return s_BypassCacheBinding;
	}

	internal static void SetBinding(string uriScheme, RequestCacheBinding binding)
	{
		if (uriScheme == null)
		{
			throw new ArgumentNullException("uriScheme");
		}
		if (s_CacheConfigSettings == null)
		{
			LoadConfigSettings();
		}
		if (!s_CacheConfigSettings.DisableAllCaching)
		{
			if (uriScheme.Length == 0)
			{
				s_DefaultGlobalBinding = binding;
			}
			else if (uriScheme == Uri.UriSchemeHttp || uriScheme == Uri.UriSchemeHttps)
			{
				s_DefaultHttpBinding = binding;
			}
			else if (uriScheme == Uri.UriSchemeFtp)
			{
				s_DefaultFtpBinding = binding;
			}
		}
	}

	private static void LoadConfigSettings()
	{
		lock (s_BypassCacheBinding)
		{
			if (s_CacheConfigSettings == null)
			{
				s_CacheConfigSettings = new RequestCachingSectionInternal();
			}
		}
	}
}
