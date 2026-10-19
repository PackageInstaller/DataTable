using ACT.Battle;
using ACT.World;
using ACT.World.Asset;

namespace ACT.UI;

public class LargeMapRewardBoxIcon : LargeMapNormalIcon
{
	private StateWorldAssetData stateWorldAssetData;

	private int swId;

	private int iconDataId;

	private int stateId;

	public void Init(BakeStaticMapIconData data, MapArea area)
	{
		swId = data.uid;
		mapArea = area;
		iconDataId = data.iconDescId;
		stateId = MonoECS.instance.ruleManager.SharedGetState(swId);
		type = (MapIconType)data.iconTypeId;
		worldPos = data.initPos;
		SetForbidShow(forbidShow: false);
		LoadSprite(MapUtility.GetMapIconSpriteIdByBakeData(data));
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
}
