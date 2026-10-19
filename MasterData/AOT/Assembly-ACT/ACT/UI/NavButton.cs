using ACT.Model;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

public class NavButton : MonoBehaviour
{
	public RectTransform self;

	public RectTransform inner;

	public RectTransform outer;

	public Button navBtn;

	public BImage innerUIAtlasImage;

	public void TrackMissionInit(int missionSpriteId)
	{
		gameObject.SetActive(value: false);
		if (missionSpriteId >= 0)
		{
			this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, missionSpriteId, innerUIAtlasImage);
		}
	}

	public void TrackMonsterPointInit(int enemyId, bool needHideMonster = false)
	{
		gameObject.SetActive(value: false);
		this.GetImageStation().LoadSprite(GameLoader.meta.MonsterCircleHeadAtlasAssetID, needHideMonster ? 99 : Model<MaterialTrackModel>.Interface.GetMonsterTypeIconAtlasId(enemyId), innerUIAtlasImage);
	}

	public void TrackGeneralPointInit(int PointType)
	{
		gameObject.SetActive(value: false);
		this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, PointType, innerUIAtlasImage);
	}

	public void TrackCollectionPointInit()
	{
		gameObject.SetActive(value: false);
		this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, Model<TrackModel>.Interface.GetTrackCollectionSpriteId(), innerUIAtlasImage);
	}

	public void TrackNpcPointInit(int spriteId)
	{
		gameObject.SetActive(value: false);
		this.GetImageStation().LoadSprite(GameLoader.meta.interactIconNameAssetID, spriteId, innerUIAtlasImage);
	}

	public void AddClickAction(UnityAction action)
	{
		navBtn.onClick.RemoveAllListeners();
		navBtn.onClick.AddListener(action);
	}

	public void OnDestroy()
	{
		innerUIAtlasImage.UnLoad();
	}
}
