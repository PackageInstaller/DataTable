using System.Diagnostics;
using UnityEngine;

namespace QwStreaming;

[DebuggerDisplay("[{assetPath}, {asset}]")]
public class ModelInfo
{
	public Object asset;

	public int assetIndex;

	public string assetPath;

	public EStreamingLoadState loadState => Streaming.GetStreamingInfo(this)?.loadState ?? EStreamingLoadState.NotLoaded;

	public bool isLoadRequested => loadState == EStreamingLoadState.LoadRequested;

	public bool isLoadingOrRequested
	{
		get
		{
			EStreamingLoadState eStreamingLoadState = loadState;
			if (eStreamingLoadState != EStreamingLoadState.Loading)
			{
				return eStreamingLoadState == EStreamingLoadState.LoadRequested;
			}
			return true;
		}
	}

	public bool isLoaded => loadState == EStreamingLoadState.Loaded;

	public static int GetModelIndex(string str)
	{
		return str.GetHashCode();
	}

	public void SetAssetPath(string path)
	{
		assetPath = path;
		assetIndex = GetModelIndex(assetPath);
	}
}
