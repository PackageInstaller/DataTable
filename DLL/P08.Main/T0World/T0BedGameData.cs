using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
[CreateAssetMenu(fileName = "T0BedGameData", menuName = "T0小场景/交互小游戏/床上小游戏数据")]
public class T0BedGameData : ScriptableObject
{
	public List<BedGameLikeData> likeStageDataList;

	public List<BedGamePropSelectData> propDataList;

	public List<BedGameHandleSelectData> handleDataList;

	public T0BedGameIceData iceData;

	public List<T0BedGameEmotionData> emotionDataList;
}
