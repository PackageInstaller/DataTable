using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class GlobalCachedAssets : ScriptableObject
{
	public List<AssetDescriptionToCache> list = new List<AssetDescriptionToCache>();
}
