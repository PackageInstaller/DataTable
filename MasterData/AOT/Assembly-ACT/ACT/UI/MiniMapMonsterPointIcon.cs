using ACT.Model;
using ACT.World;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MiniMapMonsterPointIcon : MiniMapNormalIcon
{
	public Image board;

	public GameObject InTrace;

	private int _uid;

	private int _enemyId;

	public void Init(MapArea area, int uid, int enemyId)
	{
		_uid = uid;
		type = MapIconType.MonsterPoint;
		_enemyId = enemyId;
		mapArea = area;
		LoadSprite(Model<MaterialTrackModel>.Interface.GetMonsterTypeIconAtlasId(_enemyId));
		UpdateImageScale();
	}

	public override int GetId()
	{
		return _uid;
	}

	protected override void LoadSprite(int spriteId)
	{
		base.LoadSprite(spriteId);
		this.GetImageStation().LoadSpriteAsync(GameLoader.meta.MonsterCircleHeadAtlasAssetID, spriteId, normalAtlasImage);
	}

	public override void SetIsTrack(bool isTrack)
	{
		base.SetIsTrack(isTrack);
		if (InTrace != null)
		{
			InTrace.SetActive(isTrack);
		}
		board.maskable = !isTrack;
	}
}
