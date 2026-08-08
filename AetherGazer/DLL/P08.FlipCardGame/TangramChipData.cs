using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class TangramChipData
{
	public int chipIndex;

	public List<TangramChipTileData> relevanceList;

	public bool isRotate;

	public int startAngle;

	public int answerX;

	public int answerY;

	public Vector3 position;

	public Vector3 eulerAngles;

	public string spritePath;

	public bool needCutout;
}
