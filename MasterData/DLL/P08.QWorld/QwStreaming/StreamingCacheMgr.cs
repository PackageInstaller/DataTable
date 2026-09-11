using System.Collections.Generic;
using UnityEngine;

namespace QwStreaming;

public class StreamingCacheMgr
{
	public enum ECacheCleanJob
	{
		None,
		WaitingStart,
		PerObject,
		NoObject
	}

	private static List<StreamingCacheGameObject> _cacheToClean;

	private static Dictionary<ModelInfo, StreamingCacheGameObject> _cache;

	public static StreamingCacheGameObject GetCache(ModelInfo modelInfo)
	{
		if (_cache.TryGetValue(modelInfo, out var value))
		{
			return value;
		}
		return null;
	}

	public static StreamingCacheGameObject RequestCache(ModelInfo modelInfo)
	{
		if (_cache.TryGetValue(modelInfo, out var value))
		{
			return value;
		}
		value = new StreamingCacheGameObject();
		value.Init(modelInfo);
		_cache[modelInfo] = value;
		return value;
	}

	public static void Init()
	{
		_cacheToClean = new List<StreamingCacheGameObject>();
		_cache = new Dictionary<ModelInfo, StreamingCacheGameObject>();
	}

	public static void Shutdown()
	{
		foreach (KeyValuePair<ModelInfo, StreamingCacheGameObject> item in _cache)
		{
			item.Deconstruct(out var _, out var value);
			value.Dispose();
		}
		_cache.Clear();
		_cache = null;
		_cacheToClean.Clear();
		_cacheToClean = null;
	}

	public static void DoClearJob()
	{
		if (_cacheToClean == null)
		{
			return;
		}
		float time = Time.time;
		for (int num = _cacheToClean.Count - 1; num >= 0; num--)
		{
			StreamingCacheGameObject streamingCacheGameObject = _cacheToClean[num];
			bool flag = false;
			if (time >= streamingCacheGameObject.cacheData.nextCleanTime)
			{
				switch (streamingCacheGameObject.cacheData.cleanJob)
				{
				case ECacheCleanJob.None:
					flag = true;
					break;
				case ECacheCleanJob.WaitingStart:
					if (streamingCacheGameObject.cacheData.freeItemCount > 0)
					{
						if (streamingCacheGameObject.cacheSettings.perObjectClearTimeLeft >= 0f)
						{
							streamingCacheGameObject.cacheData.cleanJob = ECacheCleanJob.PerObject;
							streamingCacheGameObject.cacheData.nextCleanTime = Time.time + streamingCacheGameObject.cacheSettings.perObjectClearTimeLeft;
							break;
						}
					}
					else if (streamingCacheGameObject.cacheData.allItemCount == 0 && streamingCacheGameObject.cacheSettings.noObjectUnloadTimeLeft >= 0f)
					{
						streamingCacheGameObject.cacheData.cleanJob = ECacheCleanJob.NoObject;
						streamingCacheGameObject.cacheData.nextCleanTime = Time.time + streamingCacheGameObject.cacheSettings.noObjectUnloadTimeLeft;
						break;
					}
					flag = true;
					break;
				case ECacheCleanJob.PerObject:
					streamingCacheGameObject.Shrink(1);
					if (streamingCacheGameObject.cacheData.freeItemCount > 0)
					{
						streamingCacheGameObject.cacheData.nextCleanTime = Time.time + streamingCacheGameObject.cacheSettings.perObjectClearTimeLeft;
					}
					else if (streamingCacheGameObject.cacheData.allItemCount == 0 && streamingCacheGameObject.cacheSettings.noObjectUnloadTimeLeft >= 0f)
					{
						streamingCacheGameObject.cacheData.cleanJob = ECacheCleanJob.NoObject;
						streamingCacheGameObject.cacheData.nextCleanTime = Time.time + streamingCacheGameObject.cacheSettings.noObjectUnloadTimeLeft;
					}
					else
					{
						flag = true;
					}
					break;
				case ECacheCleanJob.NoObject:
				{
					if (streamingCacheGameObject.cacheData.allItemCount > 0)
					{
						flag = true;
						break;
					}
					if (_cache.TryGetValue(streamingCacheGameObject.modelInfo, out var value) && value == streamingCacheGameObject)
					{
						_cache.Remove(streamingCacheGameObject.modelInfo);
					}
					streamingCacheGameObject.Dispose();
					flag = true;
					break;
				}
				}
			}
			if (flag)
			{
				streamingCacheGameObject.cacheData.cleanJob = ECacheCleanJob.None;
				_cacheToClean.RemoveAt(num);
			}
		}
	}

	public static void RegisterClearJob(StreamingCacheGameObject streamingCache)
	{
		if (_cacheToClean.Contains(streamingCache))
		{
			if (streamingCache.cacheData.cleanJob == ECacheCleanJob.NoObject)
			{
				streamingCache.cacheData.cleanJob = ECacheCleanJob.WaitingStart;
			}
		}
		else if (streamingCache.cacheSettings.startClearTimeLeft >= 0f)
		{
			_cacheToClean.Add(streamingCache);
			streamingCache.cacheData.nextCleanTime = Time.time + streamingCache.cacheSettings.startClearTimeLeft;
			streamingCache.cacheData.cleanJob = ECacheCleanJob.WaitingStart;
		}
	}
}
