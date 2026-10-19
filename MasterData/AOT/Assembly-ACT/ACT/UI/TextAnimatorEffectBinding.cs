using System;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public class TextAnimatorEffectBinding
{
	public string effectId;

	public GameObject prefab;

	public int lifetimeMilliseconds = 1000;

	public int maxPoolSize = 16;
}
