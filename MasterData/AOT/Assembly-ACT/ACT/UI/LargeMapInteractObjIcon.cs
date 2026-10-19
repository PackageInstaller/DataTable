using ACT.Battle;
using ACT.World;
using ACT.World.Asset;
using Fundamental;

namespace ACT.UI;

public class LargeMapInteractObjIcon : LargeMapNormalIcon
{
	private StateWorldAssetData stateWorldAssetData;

	private int swId;

	private int iconDataId;

	private int stateId;

	private int _worldBossId;

	public void Init(BakeStaticMapIconData data, MapArea area)
	{
		swId = data.uid;
		mapArea = area;
		iconDataId = data.iconDescId;
		stateId = MonoECS.instance.ruleManager.SharedGetState(swId);
		type = (MapIconType)data.iconTypeId;
		worldPos = data.initPos;
		SetForbidShow(forbidShow: false);
		LoadSprite(MapUtility.GetInteractObjSpriteId(swId));
		UpdateImageScale();
		name = $"{type.ToString()}_{data.uid}";
	}

	protected override void LoadSprite(int spriteId)
	{
		base.LoadSprite(spriteId);
		this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, spriteId, normalAtlasImage);
	}

	public int GetSwId()
	{
		return swId;
	}

	public override int GetId()
	{
		return swId;
	}

	public int GetIconDataId()
	{
		return iconDataId;
	}

	public int GetStateId()
	{
		return stateId;
	}

	public int GetWorldBossId()
	{
		return _worldBossId;
	}

	public int GetDataId()
	{
		if (type == MapIconType.Temple)
		{
			return (Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(swId) as TempleEnterData).id;
		}
		return 0;
	}
}
