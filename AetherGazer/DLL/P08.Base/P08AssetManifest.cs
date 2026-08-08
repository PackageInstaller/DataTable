using System;
using System.Collections.Generic;
using MessagePack;

[Serializable]
[MessagePackObject(false)]
public class P08AssetManifest
{
	[Key(0)]
	public Dictionary<string, int> bundleDict;

	[Key(1)]
	public List<int[]> deps;
}
