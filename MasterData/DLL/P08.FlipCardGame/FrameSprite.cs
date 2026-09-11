using System;
using UnityEngine;

[Serializable]
public class FrameSprite
{
	public Sprite[] spriteList;

	public int spriteNums;

	public bool isLoop = true;

	public float changeTime = 0.1f;
}
