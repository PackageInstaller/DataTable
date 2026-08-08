using System.Collections.Generic;
using UnityEngine;

public class LoadingTime
{
	public struct AsyncLoadTime
	{
		public float startTime;

		public float loadedTime;

		public float getAssetTime;

		public float endTime;
	}

	private static LoadingTime instance;

	public float startTime;

	public float lastSceneExitTime;

	public float enterEmptySceneAndClearMemoryTime;

	public float onSceneEnterFinishedTime;

	public float onLoadCoroutineFinishedTime;

	public float clearMemoryAndOnSceneLoadedFinishedTime;

	public float finishedTime;

	public Dictionary<string, AsyncLoadTime> asyncLoadTime = new Dictionary<string, AsyncLoadTime>();

	public Dictionary<string, AsyncLoadTime> syncLoadTime = new Dictionary<string, AsyncLoadTime>();

	public static LoadingTime GetInstance()
	{
		if (instance == null)
		{
			instance = new LoadingTime();
		}
		return instance;
	}

	public void SetStartTime(string path)
	{
		asyncLoadTime[path] = new AsyncLoadTime
		{
			startTime = Time.realtimeSinceStartup
		};
	}

	public void SetEndTime(string path)
	{
		AsyncLoadTime value = asyncLoadTime[path];
		value.endTime = Time.realtimeSinceStartup;
		asyncLoadTime[path] = value;
	}

	public void SetLoadedTime(string path)
	{
		AsyncLoadTime value = asyncLoadTime[path];
		value.loadedTime = Time.realtimeSinceStartup;
		asyncLoadTime[path] = value;
	}

	public void SetGetAssetTime(string path)
	{
		AsyncLoadTime value = asyncLoadTime[path];
		value.getAssetTime = Time.realtimeSinceStartup;
		asyncLoadTime[path] = value;
	}

	public void SetSyncStartTime(string path)
	{
		syncLoadTime[path] = new AsyncLoadTime
		{
			startTime = Time.realtimeSinceStartup
		};
	}

	public void SetSyncEndTime(string path)
	{
		AsyncLoadTime value = syncLoadTime[path];
		value.endTime = Time.realtimeSinceStartup;
		syncLoadTime[path] = value;
	}

	public void SetSyncLoadedTime(string path)
	{
		AsyncLoadTime value = syncLoadTime[path];
		value.loadedTime = Time.realtimeSinceStartup;
		syncLoadTime[path] = value;
	}

	public void SetSyncGetAssetTime(string path)
	{
		AsyncLoadTime value = syncLoadTime[path];
		value.getAssetTime = Time.realtimeSinceStartup;
		syncLoadTime[path] = value;
	}

	public void Clear()
	{
		asyncLoadTime.Clear();
		syncLoadTime.Clear();
	}

	public void PrintResult()
	{
		asyncLoadTime.Clear();
		syncLoadTime.Clear();
	}
}
