using System.Collections.Generic;
using UnityEngine;

namespace QwStreaming;

public class Streaming
{
	private static List<StreamingInfo> _requestList;

	private static Dictionary<int, StreamingInfo> _streamingInfo;

	private static Dictionary<string, ModelInfo> _modelInfo;

	private static bool _hasSyncLoading;

	public static bool HaveAssetsLoaded(int assetIndex)
	{
		return _streamingInfo.ContainsKey(assetIndex);
	}

	public static bool AreAllAssetsLoaded()
	{
		return _requestList.Count == 0;
	}

	public static StreamingInfo GetStreamingInfo(ModelInfo modelInfo)
	{
		if (_streamingInfo.TryGetValue(modelInfo.assetIndex, out var value))
		{
			return value;
		}
		return null;
	}

	public static ModelInfo GetModelInfo(string assetPath)
	{
		if (_modelInfo.TryGetValue(assetPath, out var value))
		{
			return value;
		}
		value = new ModelInfo();
		value.SetAssetPath(assetPath);
		_modelInfo[assetPath] = value;
		return value;
	}

	public static void Init()
	{
		_requestList = new List<StreamingInfo>();
		_streamingInfo = new Dictionary<int, StreamingInfo>();
		_modelInfo = new Dictionary<string, ModelInfo>();
		_hasSyncLoading = false;
	}

	public static void Shutdown()
	{
		foreach (var (_, streamingInfo2) in _streamingInfo)
		{
			if (streamingInfo2.counter > 0)
			{
				Debug.LogError("退出时 StreamingInfo " + streamingInfo2.modelInfo.assetPath + " 引用计数大于0!");
			}
			Asset.Unload(streamingInfo2.modelInfo.assetPath);
		}
		_requestList.Clear();
		_streamingInfo.Clear();
		_modelInfo.Clear();
		_requestList = null;
		_streamingInfo = null;
		_modelInfo = null;
	}

	public static bool HasSyncLoading()
	{
		return _hasSyncLoading;
	}

	public static void Update()
	{
		if (_requestList == null)
		{
			return;
		}
		_hasSyncLoading = false;
		foreach (StreamingInfo request in _requestList)
		{
			TickStreamingInfo(request);
		}
		_requestList.RemoveAll((StreamingInfo streamingInfo) => streamingInfo.requestObjects.Count == 0);
	}

	public static void ImmediateLoadModel(ModelInfo modelInfo)
	{
		if (_streamingInfo.TryGetValue(modelInfo.assetIndex, out var value))
		{
			ChangeStreamingLoadMode(value, StreamingLoadMode.Immediate);
		}
	}

	public static void RequestObject(IStreamingObject streamingObject, ModelInfo modelInfo, StreamingLoadMode mode)
	{
		if (!_streamingInfo.TryGetValue(modelInfo.assetIndex, out var value))
		{
			value = new StreamingInfo();
			value.modelInfo = modelInfo;
			value.loadState = EStreamingLoadState.LoadRequested;
			value.loadMode = mode;
			value.requestObjects = new List<IStreamingObject>();
			_streamingInfo[modelInfo.assetIndex] = value;
		}
		else if (value.loadState == EStreamingLoadState.NotLoaded)
		{
			value.loadState = EStreamingLoadState.LoadRequested;
		}
		value.requestObjects.Add(streamingObject);
		value.counter++;
		if (!_requestList.Contains(value))
		{
			_requestList.Add(value);
		}
		ChangeStreamingLoadMode(value, mode);
	}

	public static void RemoveObject(IStreamingObject streamingObject, ModelInfo modelInfo)
	{
		if (_streamingInfo.TryGetValue(modelInfo.assetIndex, out var value))
		{
			value.requestObjects.Remove(streamingObject);
			value.counter--;
		}
	}

	private static void ChangeStreamingLoadMode(StreamingInfo streamingInfo, StreamingLoadMode mode)
	{
		if (streamingInfo.loadMode != mode)
		{
			streamingInfo.loadMode = mode;
		}
		if (mode == StreamingLoadMode.Immediate)
		{
			TickStreamingInfo(streamingInfo);
		}
	}

	private static void TickStreamingInfoUnload(StreamingInfo streamingInfo)
	{
		if (streamingInfo.loadState == EStreamingLoadState.NotLoaded || streamingInfo.counter != 0)
		{
			return;
		}
		switch (streamingInfo.loadState)
		{
		case EStreamingLoadState.Loaded:
			streamingInfo.unloadTime = -1f;
			if (streamingInfo.unloadTime < Time.time)
			{
				Asset.Unload(streamingInfo.modelInfo.assetPath);
				streamingInfo.loadState = EStreamingLoadState.NotLoaded;
			}
			break;
		case EStreamingLoadState.LoadRequested:
			streamingInfo.loadState = EStreamingLoadState.NotLoaded;
			break;
		}
	}

	private static void TickStreamingInfoLoad(StreamingInfo streamingInfo)
	{
		switch (streamingInfo.loadState)
		{
		case EStreamingLoadState.Loaded:
			if (streamingInfo.requestObjects.Count <= 0)
			{
				break;
			}
			foreach (IStreamingObject requestObject in streamingInfo.requestObjects)
			{
				requestObject.OnModelLoaded(streamingInfo.modelInfo);
			}
			streamingInfo.requestObjects.Clear();
			break;
		case EStreamingLoadState.LoadRequested:
			if (streamingInfo.loadMode == StreamingLoadMode.Immediate)
			{
				streamingInfo.modelInfo.asset = Asset.Load(streamingInfo.modelInfo.assetPath);
				if (streamingInfo.modelInfo.asset == null)
				{
					streamingInfo.loadState = EStreamingLoadState.NotLoaded;
					Debug.LogError(streamingInfo.modelInfo.assetPath + " 未加载成功");
				}
				else
				{
					streamingInfo.loadState = EStreamingLoadState.Loaded;
					TickStreamingInfoLoad(streamingInfo);
				}
			}
			else
			{
				streamingInfo.loadOp = Asset.LoadAssetAsync<Object>(streamingInfo.modelInfo.assetPath);
				if (streamingInfo.loadOp == null)
				{
					streamingInfo.loadState = EStreamingLoadState.NotLoaded;
					Debug.LogError(streamingInfo.modelInfo.assetPath + " 未加载成功");
				}
				else
				{
					streamingInfo.loadState = EStreamingLoadState.Loading;
				}
			}
			break;
		case EStreamingLoadState.Loading:
			if (streamingInfo.loadOp.IsDone())
			{
				streamingInfo.modelInfo.asset = streamingInfo.loadOp.GetAsset();
				if (streamingInfo.modelInfo.asset == null)
				{
					streamingInfo.loadState = EStreamingLoadState.NotLoaded;
					Debug.LogError(streamingInfo.modelInfo.assetPath + " 未加载成功");
				}
				else
				{
					streamingInfo.loadState = EStreamingLoadState.Loaded;
				}
			}
			else if (streamingInfo.loadMode == StreamingLoadMode.Immediate)
			{
				streamingInfo.loadState = EStreamingLoadState.LoadRequested;
				TickStreamingInfoLoad(streamingInfo);
				Asset.Unload(streamingInfo.modelInfo.assetPath);
			}
			break;
		}
	}

	private static void TickStreamingInfo(StreamingInfo streamingInfo)
	{
		TickStreamingInfoUnload(streamingInfo);
		TickStreamingInfoLoad(streamingInfo);
		if (!_hasSyncLoading && streamingInfo.loadMode == StreamingLoadMode.CutScene && (streamingInfo.loadState == EStreamingLoadState.LoadRequested || streamingInfo.loadState == EStreamingLoadState.Loading))
		{
			_hasSyncLoading = true;
		}
	}
}
