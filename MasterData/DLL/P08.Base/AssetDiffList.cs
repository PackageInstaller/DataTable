using System;
using System.Collections.Generic;

[Serializable]
public class AssetDiffList
{
	public int clientVersion;

	public int baseBuildCode;

	public int channelID;

	public int fromBuildCode = 100;

	public int toBuildCode;

	public List<string> assetHashList;
}
