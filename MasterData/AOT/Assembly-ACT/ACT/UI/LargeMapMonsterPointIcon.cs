using ACT.Model;
using ACT.World;

namespace ACT.UI;

public class LargeMapMonsterPointIcon : LargeMapNormalIcon
{
	private int _uid;

	private int _enemyId;

	private MapSubArea _mapSubArea;

	public void Init(MapArea curArea, MapSubArea mapSubArea, int uid, int enemyId)
	{
		_uid = uid;
		_enemyId = enemyId;
		mapArea = curArea;
		_mapSubArea = mapSubArea;
		type = MapIconType.MonsterPoint;
		LoadSprite(Model<MaterialTrackModel>.Interface.GetMonsterTypeIconAtlasId(_enemyId));
		isTrace?.SetActive(value: false);
		UpdateImageScale();
	}

	protected override void LoadSprite(int spriteId)
	{
		base.LoadSprite(spriteId);
		this.GetImageStation().LoadSpriteAsync(GameLoader.meta.MonsterCircleHeadAtlasAssetID, spriteId, normalAtlasImage);
	}

	public int GetUid()
	{
		return _uid;
	}

	public override int GetId()
	{
		return GetUid();
	}

	public int GetEnemyId()
	{
		return _enemyId;
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
