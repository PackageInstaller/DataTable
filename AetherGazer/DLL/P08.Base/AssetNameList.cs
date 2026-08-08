using System;
using System.Collections.Generic;
using MessagePack;

[Serializable]
[MessagePackObject(false)]
public class AssetNameList
{
	[Key(0)]
	public Dictionary<string, AssetName> assetNames;
}
