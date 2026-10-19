using ACT.Battle.Configs;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class MiniMapMissionIcon : MiniMapNormalIcon
{
	public BImage radiusAtlasImage;

	private int missionId;

	private float m_Radius;

	public void Init(MissionPointData missionPointData)
	{
		int missionType = missionPointData.GetMissionType();
		type = MapUtility.GetMapIconTypeByMissionType(missionType);
		mapArea = missionPointData.MapArea;
		missionId = missionPointData.MissionId;
		worldPos = missionPointData.GetActualPos();
		m_Radius = missionPointData.Radius;
		LoadSprite(missionType);
		UpdateImageScale();
		normalAtlasImage.icon.gameObject.SetActive(missionPointData.ShowIcon);
	}

	public override void UpdateScale(float mapScale)
	{
		base.UpdateScale(mapScale);
		radiusAtlasImage.icon.rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, m_Radius * 2f * GameLoader.meta.mapConfig.miniMapRatio);
		radiusAtlasImage.icon.rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, m_Radius * 2f * GameLoader.meta.mapConfig.miniMapRatio);
		radiusAtlasImage.icon.transform.localScale = Vector3.one * mapScale;
	}

	protected override void LoadSprite(int spriteId)
	{
		base.LoadSprite(spriteId);
		this.GetImageStation().LoadImage(200, spriteId, normalAtlasImage);
	}

	public override int GetId()
	{
		return missionId;
	}
}
