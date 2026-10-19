using ACT.MissionSystem;
using ACT.World;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MiniMapReceiveSideMissionIcon : MiniMapNormalIcon
{
	public GameObject InTrace;

	private int _missionId;

	private int _npcUid;

	private int _spriteId;

	public void Init(int missionId, int npcUid, MapArea area, Vector3 npcPosition)
	{
		type = MapIconType.SideMission;
		_missionId = missionId;
		_npcUid = npcUid;
		mapArea = area;
		worldPos = npcPosition;
		_spriteId = 10909;
		LoadSprite(10909);
		UpdateImageScale();
		name = $"{type}_{_missionId}";
		RefreshState();
	}

	protected override void LoadSprite(int spriteId)
	{
		base.LoadSprite(spriteId);
		this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, spriteId, normalAtlasImage);
	}

	public void RefreshState()
	{
		transform.gameObject.SetActive(!Singleton<MissionManager>.instance.IsAccepting(_missionId));
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
		return _missionId;
	}

	public int GetSpriteId()
	{
		return _spriteId;
	}
}
