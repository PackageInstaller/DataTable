using ACT.Battle.Configs;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public sealed class LargeMapMissionIcon : LargeMapNormalIcon
{
	public BImage radiusAtlasImage;

	private int missionId;

	private int m_SpriteId;

	private float m_Radius;

	public int GetMissionId()
	{
		return missionId;
	}

	public override int GetId()
	{
		return GetMissionId();
	}

	public int GetSpriteId()
	{
		return m_SpriteId;
	}

	public void Init(MissionPointData missionPointData)
	{
		type = MapUtility.GetMapIconTypeByMissionType(missionPointData.GetMissionType());
		missionId = missionPointData.MissionId;
		m_SpriteId = missionPointData.GetSpriteId();
		mapArea = missionPointData.MapArea;
		worldPos = missionPointData.GetActualPos();
		m_Radius = missionPointData.Radius;
		LoadSprite(m_SpriteId);
		UpdateImageScale();
		normalAtlasImage.icon.gameObject.SetActive(missionPointData.ShowIcon);
	}

	public override void UpdateScale(float mapScale)
	{
		base.UpdateScale(mapScale);
		radiusAtlasImage.icon.rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, m_Radius * 2f * GameLoader.meta.mapConfig.largeMapRatio);
		radiusAtlasImage.icon.rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, m_Radius * 2f * GameLoader.meta.mapConfig.largeMapRatio);
		radiusAtlasImage.icon.transform.localScale = Vector3.one * mapScale;
	}

	protected override void LoadSprite(int spriteId)
	{
		base.LoadSprite(spriteId);
		this.GetImageStation().LoadImage(200, spriteId, normalAtlasImage);
	}

	public override void SetIsTrack(bool InTrace)
	{
	}
}
