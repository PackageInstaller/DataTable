using System;
using MessagePack;

[Serializable]
[MessagePackObject(false)]
public class AssetName
{
	[Key(0)]
	public string loadName;

	[Key(1)]
	public string bundleName;

	[Key(2)]
	public string assetName;
}
