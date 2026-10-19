using ACT.World;
using UnityEngine;

namespace ACT.UI;

public class MiniMapNpcIcon : MiniMapNormalIcon
{
	public GameObject InTrace;

	private int _uid;

	private int spriteId;

	public override int GetId()
	{
		return _uid;
	}

	public void Init(int npcId, int iconId, MapArea area)
	{
		type = MapIconType.Npc;
		mapArea = area;
		spriteId = iconId;
		_uid = npcId;
		LoadSprite(iconId);
		UpdateImageScale();
	}

	public void RefreshState()
	{
		gameObject.SetActive(value: true);
		LoadSprite(spriteId);
	}

	protected override void LoadSprite(int spriteId)
	{
		base.LoadSprite(spriteId);
		this.GetImageStation().LoadSprite(GameLoader.meta.interactIconNameAssetID, spriteId, normalAtlasImage);
	}

	public override void SetIsTrack(bool isTrack)
	{
		base.SetIsTrack(isTrack);
		if (InTrace != null)
		{
			InTrace.SetActive(isTrack);
		}
	}

	public void SetActive(bool isActive)
	{
		transform.gameObject.SetActive(isActive);
	}

	public int GetUid()
	{
		return _uid;
	}

	public int GetSpriteId()
	{
		return spriteId;
	}
}
