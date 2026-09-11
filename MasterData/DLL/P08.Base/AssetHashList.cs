using System;
using System.Collections.Generic;

[Serializable]
public class AssetHashList
{
	public int buildCode = 100;

	public int appVersion;

	public int channel;

	public string versionName = "";

	public List<string> assetHashList;

	public AssetPendDict assetPendDict;
}
