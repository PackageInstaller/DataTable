using System.IO;
using UnityEngine;

namespace YooAsset;

public struct DecryptResult
{
	public AssetBundle Result;

	public AssetBundleCreateRequest CreateRequest;

	public Stream ManagedStream;
}
