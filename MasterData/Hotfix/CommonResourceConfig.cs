using System;
using UnityEngine;

[Serializable]
public class CommonResourceConfig
{
	public string alias;

	[ReadOnly]
	public string path;

	public GameObject prefab;

	[HideInInspector]
	public int preloadNum = 1;

	public GameObject overridePrefab { get; set; }
}
