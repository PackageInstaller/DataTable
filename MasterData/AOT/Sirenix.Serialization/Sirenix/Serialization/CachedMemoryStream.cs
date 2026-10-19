using System.IO;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

internal sealed class CachedMemoryStream : ICacheNotificationReceiver
{
	public static int InitialCapacity = 1024;

	public static int MaxCapacity = 32768;

	private MemoryStream memoryStream;

	public MemoryStream MemoryStream
	{
		get
		{
			if (!memoryStream.CanRead)
			{
				memoryStream = new MemoryStream(InitialCapacity);
			}
			return memoryStream;
		}
	}

	public CachedMemoryStream()
	{
		memoryStream = new MemoryStream(InitialCapacity);
	}

	public void OnFreed()
	{
		memoryStream.SetLength(0L);
		memoryStream.Position = 0L;
		if (memoryStream.Capacity > MaxCapacity)
		{
			memoryStream.Capacity = MaxCapacity;
		}
	}

	public void OnClaimed()
	{
		memoryStream.SetLength(0L);
		memoryStream.Position = 0L;
	}

	public static Cache<CachedMemoryStream> Claim(int minCapacity)
	{
		Cache<CachedMemoryStream> cache = Cache<CachedMemoryStream>.Claim();
		if (cache.Value.MemoryStream.Capacity < minCapacity)
		{
			cache.Value.MemoryStream.Capacity = minCapacity;
		}
		return cache;
	}

	public static Cache<CachedMemoryStream> Claim(byte[] bytes = null)
	{
		Cache<CachedMemoryStream> cache = Cache<CachedMemoryStream>.Claim();
		if (bytes != null)
		{
			cache.Value.MemoryStream.Write(bytes, 0, bytes.Length);
			cache.Value.MemoryStream.Position = 0L;
		}
		return cache;
	}
}
