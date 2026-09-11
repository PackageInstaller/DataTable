using System;
using UnityEngine;

namespace QWorld.Story.Runtime;

[Serializable]
public struct CharContext
{
	public string tag;

	public string charPath;

	[NonSerialized]
	public GameObject charPrefab;
}
