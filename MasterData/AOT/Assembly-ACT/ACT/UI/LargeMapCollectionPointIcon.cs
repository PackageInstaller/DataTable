using ACT.Model;
using ACT.World;

namespace ACT.UI;

public class LargeMapCollectionPointIcon : LargeMapNormalIcon
{
	private int _uid;

	private int _configId;

	private MapSubArea _mapSubArea;

	public void Init(MapArea curArea, MapSubArea mapSubArea, int uid, int configId)
	{
		_uid = uid;
		_configId = configId;
		mapArea = curArea;
		_mapSubArea = mapSubArea;
		type = MapIconType.CollectionPoint;
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

	public MapSubArea GetSubArea()
	{
		return _mapSubArea;
	}

	public override void UpdateScale(float mapScale)
	{
		SetScale(1f / mapScale);
	}

	public override void SetIsFade(bool fade)
	{
		transform.gameObject.SetActive(!fade);
	}

	public override void SetIsTrack(bool isTrack)
	{
		if ((bool)isTrace)
		{
			isTrace.gameObject.SetActive(isTrack);
		}
	}
}
