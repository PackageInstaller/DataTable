using System;
using System.Collections.Generic;
using UnityEngine;
using ZumaGame;

[Serializable]
public class FrameSpriteData
{
	public int spriteNums;

	public bool isLoop = true;

	public FrameType frameType;

	public string path;

	public float changeTime = 0.1f;

	[HideInInspector]
	public Dictionary<BallColorType, FrameSprite> frameColorDict = new Dictionary<BallColorType, FrameSprite>();
}
