using ACT.Battle.Configs;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class MissionNavIcon : MonoBehaviour
{
	public BImage missionImage;

	public void Init(MissionPointData missionPointData)
	{
		LoadSprite(missionPointData.GetSpriteId());
	}

	public void UnInit()
	{
		missionImage.UnLoad();
	}

	private void LoadSprite(int spriteId)
	{
		this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, spriteId, missionImage);
	}

	public void SetPos(Vector2 pos)
	{
		(transform as RectTransform).anchoredPosition = pos;
	}
}
