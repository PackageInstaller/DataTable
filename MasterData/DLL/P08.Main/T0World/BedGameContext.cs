using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
public class BedGameContext
{
	private bool isCanClickUI = true;

	public string gameDataPath = "T0World/Data/Other/104402BedGameData";

	public T0BedGameData gameData;

	public BedSelectEnum currentSelectType = BedSelectEnum.prop;

	public BedPropEnum currentPropType = BedPropEnum.none;

	public BedHandleEnum currentHandleType = BedHandleEnum.click;

	public BedPosEnum currentPosType = BedPosEnum.none;

	public int checkBeforeLikeValue;

	public int likeValue;

	private int maxLikeValue;

	public List<string> showPenPatternKeyList = new List<string>();

	public string faceBindPath = "104402ui/104402ui_tpose";

	public Transform faceTimeLineTrans;

	public bool IsCanClickUI
	{
		get
		{
			return isCanClickUI;
		}
		set
		{
			isCanClickUI = value;
		}
	}

	public List<BedGameLikeData> likeStageDataList => gameData.likeStageDataList;

	public List<BedGamePropSelectData> propDataList => gameData.propDataList;

	public List<BedGameHandleSelectData> handleDataList => gameData.handleDataList;

	public void Init()
	{
		gameData = Asset.Load<T0BedGameData>(gameDataPath);
		currentSelectType = BedSelectEnum.prop;
		currentPropType = BedPropEnum.hand;
		currentHandleType = BedHandleEnum.click;
		currentPosType = BedPosEnum.none;
		checkBeforeLikeValue = 0;
		likeValue = 0;
		maxLikeValue = 0;
		for (int i = 0; i < likeStageDataList.Count; i++)
		{
			maxLikeValue += likeStageDataList[i].totalLikeValue;
		}
	}

	public int GetNowLikeLv()
	{
		int num = likeValue;
		int num2 = 1;
		for (int i = 0; i < likeStageDataList.Count; i++)
		{
			BedGameLikeData bedGameLikeData = likeStageDataList[i];
			if (num < bedGameLikeData.totalLikeValue)
			{
				break;
			}
			num -= bedGameLikeData.totalLikeValue;
			num2++;
		}
		return num2;
	}
}
