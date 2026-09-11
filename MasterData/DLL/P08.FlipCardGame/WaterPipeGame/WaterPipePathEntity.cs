using System;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.UI;

namespace WaterPipeGame;

public class WaterPipePathEntity : SerializedMonoBehaviour
{
	public Image img;

	[SerializeField]
	public void UpdateImg(int beginPipeIndex, int middleIndex, int endPipeIndex)
	{
		GetPipeTypeAndDir(beginPipeIndex, middleIndex, endPipeIndex, out var pipeType, out var targetDir);
		string routeSpritePath = WaterPipeTools.GetRouteSpritePath(pipeType, PipeState.FINISH);
		img.sprite = AtlasManager.GetSpriteWithoutAtlas(routeSpritePath);
		base.transform.eulerAngles = WaterPipeConst.dirDic[targetDir];
	}

	public void GetPipeTypeAndDir(int beginPipeIndex, int middleIndex, int endPipeIndex, out PipeType pipeType, out DIR targetDir)
	{
		pipeType = PipeType.I_PIPE;
		targetDir = DIR.UP;
		int num = beginPipeIndex % WaterPipeGameManager.Instance.width;
		int num2 = beginPipeIndex / WaterPipeGameManager.Instance.width;
		int num3 = endPipeIndex % WaterPipeGameManager.Instance.width;
		int num4 = endPipeIndex / WaterPipeGameManager.Instance.width;
		switch (((num != num3) ? 1 : 0) + ((num2 != num4) ? 1 : 0))
		{
		case 1:
			pipeType = PipeType.I_PIPE;
			if (num2 == num4)
			{
				targetDir = DIR.UP;
			}
			else
			{
				targetDir = DIR.RIGHT;
			}
			break;
		case 2:
		{
			pipeType = PipeType.L_PIPE;
			int xA = middleIndex % WaterPipeGameManager.Instance.width;
			int yA = middleIndex / WaterPipeGameManager.Instance.width;
			DIR aToBDir = GetAToBDir(xA, yA, num, num2);
			DIR aToBDir2 = GetAToBDir(xA, yA, num3, num4);
			DIR[] array = WaterPipeConst.pipeTypeDir[PipeType.L_PIPE];
			{
				foreach (DIR value in Enum.GetValues(typeof(DIR)))
				{
					DIR dIR2 = WaterPipeTools.RotateDir(array[0], (int)(value - 1));
					DIR dIR3 = WaterPipeTools.RotateDir(array[1], (int)(value - 1));
					if ((aToBDir == dIR2 && aToBDir2 == dIR3) || (aToBDir == dIR3 && aToBDir2 == dIR2))
					{
						targetDir = value;
						break;
					}
				}
				break;
			}
		}
		}
	}

	public DIR GetAToBDir(int XA, int YA, int XB, int YB)
	{
		DIR result = DIR.LEFT;
		if (XA > XB)
		{
			result = DIR.LEFT;
		}
		else if (XB > XA)
		{
			result = DIR.RIGHT;
		}
		if (YA > YB)
		{
			result = DIR.UP;
		}
		else if (YB > YA)
		{
			result = DIR.DOWN;
		}
		return result;
	}

	public void Dispose()
	{
		if ((bool)base.gameObject)
		{
			UnityEngine.Object.DestroyImmediate(base.gameObject);
		}
	}
}
