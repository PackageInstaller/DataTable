using ACT.Model;
using ACT.World;
using UnityEngine;

namespace ACT.UI;

public class MiniMapCollectPointIcon : MiniMapNormalIcon
{
	public GameObject InTrace;

	private int _uid;

	private int _configId;

	public void Init(MapArea area, int uid, int configId)
	{
		_uid = uid;
		type = MapIconType.CollectionPoint;
		_configId = configId;
		mapArea = area;
		this.GetImageStation().LoadSpriteAsync(GameLoader.meta.mapIconNameAssetID, Model<TrackModel>.Interface.GetTrackCollectionSpriteId(), normalAtlasImage);
		UpdateImageScale();
	}

	public override int GetId()
	{
		return _uid;
	}

	public int GetConfigId()
	{
		return _configId;
	}

	public override void SetIsTrack(bool isTrack)
	{
		base.SetIsTrack(isTrack);
		if (InTrace != null)
		{
			InTrace.SetActive(isTrack);
		}
	}
}
