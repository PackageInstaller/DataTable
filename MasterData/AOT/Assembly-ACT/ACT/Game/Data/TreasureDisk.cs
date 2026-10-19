using ACT.Core;

namespace ACT.Game.Data;

public class TreasureDisk : IBagItem
{
	public int TreasureId { get; }

	public int ItemId { get; }

	public Gem CollectedGem { get; private set; }

	public bool IsCollected => CollectedGem != null;

	public TreasureDisk(int treasureId, int itemId)
	{
		TreasureId = treasureId;
		ItemId = itemId;
	}

	public void SetCollectedGem(Gem gem)
	{
		CollectedGem = gem;
	}

	public int GetId()
	{
		return TreasureId;
	}

	public int GetUid()
	{
		return 0;
	}

	public int GetCount()
	{
		return 1;
	}

	public int GetQuality()
	{
		if (!IsCollected)
		{
			return 1;
		}
		return CoreUtils.GetData(ItemId, RuntimeConfigs.data.itemDatas)?.quality ?? 1;
	}

	public int GetLocalizationName()
	{
		return 0;
	}
}
