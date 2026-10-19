using ACT.Core;

namespace ACT.UI;

public class ItemInfo
{
	public int itemId;

	public string itemPicPath;

	public bool isMissionReward;

	public int Type => RuntimeConfigs.data.itemDatas[itemId].type;

	public int itemName => RuntimeConfigs.data.itemDatas[itemId].nameLocal;

	public int itemDesId => RuntimeConfigs.data.itemDatas[itemId].descLocal;

	public bool IsSpecial => RuntimeConfigs.data.specialShows.ContainsKey(Type);

	public int itemQuality => RuntimeConfigs.data.itemDatas[itemId].quality;
}
