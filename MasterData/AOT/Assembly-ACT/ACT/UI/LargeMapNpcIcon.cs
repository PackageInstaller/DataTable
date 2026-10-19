using ACT.Model;
using ACT.World;

namespace ACT.UI;

public class LargeMapNpcIcon : LargeMapNormalIcon
{
	private int swId;

	private int iconDataId;

	private int spriteId;

	public void Init(int npcId, int iconId, MapArea area)
	{
		type = MapIconType.Npc;
		mapArea = area;
		spriteId = iconId;
		swId = npcId;
		iconDataId = -1;
		Model<MapModel>.Interface.AddNpcSpriteIdToDic(npcId, spriteId);
		name = $"{type.ToString()}_{swId}";
		this.GetImageStation().LoadSprite(GameLoader.meta.interactIconNameAssetID, iconId, normalAtlasImage);
	}

	public int GetSwId()
	{
		return swId;
	}

	public override int GetId()
	{
		return swId;
	}

	public int GetSpriteId()
	{
		return spriteId;
	}

	public int GetIconDataId()
	{
		return iconDataId;
	}
}
