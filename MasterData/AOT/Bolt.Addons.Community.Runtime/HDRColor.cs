using System;
using Unity.VisualScripting;
using UnityEngine;

[Serializable]
[Inspectable]
[IncludeInSettings(true)]
[TypeIcon(typeof(Color))]
public struct HDRColor
{
	[Inspectable]
	[ColorUsage(true, true)]
	public Color color;
}
