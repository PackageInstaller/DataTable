using ACT.World;
using UnityEngine;

namespace ACT.UI;

public class LargeMapReceiveSideMissionIcon : LargeMapNormalIcon
{
	private int _missionId;

	private int _npcUid;

	public void Init(int missionId, int npcUid, MapArea area, Vector3 npcPosition)
	{
		type = MapIconType.SideMission;
		_missionId = missionId;
		_npcUid = npcUid;
		mapArea = area;
		worldPos = npcPosition;
		LoadSprite(10909);
		UpdateImageScale();
		name = $"{type}_{_missionId}";
	}

	protected override void LoadSprite(int spriteId)
	{
		base.LoadSprite(spriteId);
		this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, spriteId, normalAtlasImage);
	}

	public int GetMissionId()
	{
		return _missionId;
	}

	public int GetSpriteId()
	{
		return 10909;
	}

	public int GetNpcUid()
	{
		return _npcUid;
	}

	public override int GetId()
	{
		return _missionId;
	}
}
