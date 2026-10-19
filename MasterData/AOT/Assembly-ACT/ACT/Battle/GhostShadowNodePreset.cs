using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public class GhostShadowNodePreset
{
	public string name = "默认";

	public List<GameObject> nodes = new List<GameObject>();

	public float interval = 0.1f;

	public float ghostShadowDuration = 0.3f;

	public float fadeThres = 0.3f;

	[Range(-1f, 2f)]
	public float Intension = 1f;

	public Color shadowCol;

	public Material material;

	[SerializeField]
	[HideInInspector]
	public bool paramsMigrated;
}
