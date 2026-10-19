using System.Collections.Generic;

namespace Bamboo.Command;

internal class PeekInfosCachePool
{
	private readonly List<PeekInfosCache> _caches = new List<PeekInfosCache>();

	public PeekInfosCache Get()
	{
		foreach (PeekInfosCache cache in _caches)
		{
			if (!cache.IsUsing)
			{
				cache.Use();
				return cache;
			}
		}
		PeekInfosCache peekInfosCache = new PeekInfosCache();
		peekInfosCache.Use();
		_caches.Add(peekInfosCache);
		return peekInfosCache;
	}
}
