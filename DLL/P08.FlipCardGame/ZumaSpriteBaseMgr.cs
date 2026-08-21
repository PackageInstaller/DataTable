using System.Collections.Generic;
using UnityEngine;
using ZumaGame;

public class ZumaSpriteBaseMgr : MonoBehaviour
{
	[HideInInspector]
	public List<string> ballColorStrList = new List<string> { "Color1_", "Color2_", "Color3_", "Color4_", "Color5_", "Color6_", "Color7_", "Color8_" };

	public List<FrameSpriteData> frameDataConstList;

	[HideInInspector]
	public Dictionary<FrameType, FrameSpriteData> frameDataDict = new Dictionary<FrameType, FrameSpriteData>();

	public string atlasPath = "ZumaSprite";

	private void Awake()
	{
		for (int i = 0; i < frameDataConstList.Count; i++)
		{
			frameDataDict.Add(frameDataConstList[i].frameType, frameDataConstList[i]);
		}
		atlasPath = "Atlas/" + atlasPath;
		AwakeInit();
	}

	public virtual void AwakeInit()
	{
	}

	public FrameSpriteData GetFrameSpriteData(FrameType frameType)
	{
		return frameDataDict[frameType];
	}

	public FrameSprite GetFrameSprite(FrameType frameType, BallColorType colorType = BallColorType.EmptyColor)
	{
		FrameSpriteData frameSpriteData = GetFrameSpriteData(frameType);
		if (frameSpriteData.frameColorDict.ContainsKey(colorType))
		{
			return frameSpriteData.frameColorDict[colorType];
		}
		FrameSprite frameSprite = new FrameSprite();
		frameSprite.spriteList = new Sprite[frameSpriteData.spriteNums];
		frameSprite.spriteNums = frameSpriteData.spriteNums;
		frameSprite.isLoop = frameSpriteData.isLoop;
		frameSprite.changeTime = frameSpriteData.changeTime;
		string text = string.Empty;
		if (colorType != BallColorType.EmptyColor)
		{
			text = ballColorStrList[(int)colorType];
		}
		for (int i = 1; i <= frameSprite.spriteNums; i++)
		{
			frameSprite.spriteList[i - 1] = AtlasManager.GetSprite(atlasPath, frameSpriteData.path + text + i);
		}
		frameSpriteData.frameColorDict[colorType] = frameSprite;
		return frameSpriteData.frameColorDict[colorType];
	}
}
