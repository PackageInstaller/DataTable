using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine;

namespace QwStreaming;

[DebuggerDisplay("[{modelInfo.assetPath}, {loadState}, {loadMode}]")]
public class StreamingInfo
{
	public ModelInfo modelInfo;

	public EStreamingLoadState loadState;

	public StreamingLoadMode loadMode;

	public AssetBundleLoadAssetOperation<Object> loadOp;

	public List<IStreamingObject> requestObjects;

	public int counter;

	public float unloadTime;
}
