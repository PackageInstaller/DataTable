using System;
using System.Collections.Generic;
using ACT.Core;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public struct ElementColor
{
	public WeakColor weakColor;

	public Sprite[] numSprites;

	public CriticalGlowColor criticalGlowColor;

	public Sprite criticalIcon1;

	public Sprite criticalIcon2;

	public Dictionary<int, Sprite> dotIcon;

	public Dictionary<MannerType, Sprite> mannerIcon;
}
