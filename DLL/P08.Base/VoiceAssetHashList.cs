using System;
using System.Collections.Generic;

[Serializable]
public class VoiceAssetHashList
{
	public string versionName = "";

	public int version;

	public int size;

	public List<string> assetHashList = new List<string>();
}
