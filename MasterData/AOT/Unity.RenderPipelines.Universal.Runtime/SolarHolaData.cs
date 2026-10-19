using System;
using UnityEngine;

[Serializable]
public class SolarHolaData
{
	public TexChannel TexChannel;

	[Range(0f, 1f)]
	public float offset = 0.05f;

	[Range(0f, 3f)]
	public float sizeX = 0.05f;

	[Range(0f, 3f)]
	public float sizeY = 0.05f;

	[Range(0f, 1f)]
	public float rotation;

	[ColorUsage(true, true)]
	public Color color = Color.white;

	public ACTRenderingFunction.ScreenBillBoardData drawData;

	public void updateData(Vector2 start, Vector2 end)
	{
		drawData.position = Vector2.Lerp(start, end, offset);
		drawData.size = new Vector2(sizeX, sizeY);
		drawData.roatation = rotation;
		drawData.color = color;
		drawData.customData = new Vector3((float)TexChannel, 0f, 0f);
	}
}
