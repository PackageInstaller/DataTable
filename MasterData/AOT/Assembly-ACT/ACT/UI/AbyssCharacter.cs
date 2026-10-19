using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class AbyssCharacter : MonoBehaviour
{
	public BImage HeadQuality;

	public BImage Head;

	public GameObject Team0;

	public GameObject Team1;

	public GameObject Team2;

	public void RefreshUI(int characterId, int skinId = 0)
	{
		MonoAbyssListView obj = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ABYSSLIST) as MonoAbyssListView;
		obj.Station.LoadImage(126, (skinId <= 0) ? characterId : skinId, Head);
		EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[characterId];
		obj.Station.LoadImage(175, entityCharacterData.stars, HeadQuality);
		SetTeam(-1);
	}

	public void SetTeam(int team)
	{
		Team0.SetActive(team == 0);
		Team1.SetActive(team == 1);
		Team2.SetActive(team == 2);
	}
}
