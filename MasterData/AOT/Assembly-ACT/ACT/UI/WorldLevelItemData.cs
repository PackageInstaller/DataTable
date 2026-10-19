using ACT.Model;

namespace ACT.UI;

public class WorldLevelItemData
{
	public int WorldLevelItemIndex { get; private set; }

	public bool IsSelect { get; private set; }

	public DisplayItemType ItemType { get; private set; }

	public bool IsPlaceholder { get; private set; }

	public WorldLevelItemData(DisplayItemType type, int index, bool isSelect, bool isPlaceholder = false)
	{
		ItemType = type;
		WorldLevelItemIndex = index;
		IsSelect = isSelect;
		IsPlaceholder = isPlaceholder;
	}

	public void SetIsSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}
}
