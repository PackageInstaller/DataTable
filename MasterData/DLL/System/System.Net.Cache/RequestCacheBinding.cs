namespace System.Net.Cache;

internal class RequestCacheBinding
{
	private RequestCache m_RequestCache;

	private RequestCacheValidator m_CacheValidator;

	private RequestCachePolicy m_Policy;

	internal RequestCache Cache => m_RequestCache;

	internal RequestCacheValidator Validator => m_CacheValidator;

	internal RequestCachePolicy Policy => m_Policy;

	internal RequestCacheBinding(RequestCache requestCache, RequestCacheValidator cacheValidator, RequestCachePolicy policy)
	{
		m_RequestCache = requestCache;
		m_CacheValidator = cacheValidator;
		m_Policy = policy;
	}
}
