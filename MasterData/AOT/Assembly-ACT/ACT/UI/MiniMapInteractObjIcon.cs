using System.Linq;
using ACT.Model;
using ACT.World;
using ACT.World.Asset;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MiniMapInteractObjIcon : MiniMapNormalIcon
{
	public GameObject InTrace;

	private int _uid;

	private MapSubArea _subArea;

	private int _spriteId = -1;

	public bool isFinish { get; set; }

	public override int GetId()
	{
		return _uid;
	}

	public MapSubArea GetSubArea()
	{
		return _subArea;
	}

	public void Init(BakeStaticMapIconData bakeMapIconData, MapArea area)
	{
		_spriteId = -1;
		_uid = bakeMapIconData.uid;
		mapArea = area;
		type = (MapIconType)bakeMapIconData.iconTypeId;
		worldPos = bakeMapIconData.initPos;
		_subArea = (MapSubArea)bakeMapIconData.subAreaId;
		LoadSprite(MapUtility.GetMapIconSpriteIdByBakeData(bakeMapIconData));
		SetIsTrack(isTrack: false);
		UpdateImageScale();
	}

	public void RefreshState()
	{
		LoadSprite(MapUtility.GetInteractObjSpriteId(_uid));
		switch (type)
		{
		case MapIconType.Temple:
		{
			if (Model<TempleModel>.Interface.areaTempleDatas.TryGetValue((int)mapArea, out var value))
			{
				isFinish = value.FirstOrDefault((TempleData i) => i.templeId == GetDataId())?.isComplate ?? false;
			}
			else
			{
				isFinish = false;
			}
			break;
		}
		case MapIconType.TemporaryPortal:
		case MapIconType.BlockInteract:
		case MapIconType.OneWayDoor:
		case MapIconType.OneWayDoorOpposite:
		{
			StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(GetUid());
			SetActive(InteractStateId.IconActive((int)type, worldStateAssetDataBySGOID.stateId));
			break;
		}
		}
	}

	protected override void LoadSprite(int spriteId)
	{
		base.LoadSprite(spriteId);
		if (_spriteId != spriteId)
		{
			this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, spriteId, normalAtlasImage);
			_spriteId = spriteId;
		}
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

	public int GetDataId()
	{
		if (type == MapIconType.Temple)
		{
			return (Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(_uid) as TempleEnterData).id;
		}
		return _uid;
	}
}
