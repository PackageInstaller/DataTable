using ACT.Config;
using ACT.Core;
using ACT.Game.Data;

namespace ACT.Model.EquipSuit;

public class EquipSuit : IBagItem
{
	private int _suitId;

	private int _quality;

	public EquipSuitData EquipSuitData { get; private set; }

	public EquipSuit(int equipSuitId)
	{
		_suitId = equipSuitId;
		EquipSuitData = CoreUtils.GetData(equipSuitId, RuntimeConfigs.data.equipSuitDatas);
		_quality = CoreUtils.GetData(equipSuitId, RuntimeConfigs.data.itemDatas)?.quality ?? 0;
	}

	public int GetId()
	{
		return _suitId;
	}

	public int GetCount()
	{
		return 1;
	}

	public int GetQuality()
	{
		return _quality;
	}

	public static int GetLocalizationName(int equipSuitId)
	{
		return CoreUtils.GetData(equipSuitId, RuntimeConfigs.data.itemDatas)?.nameLocal ?? CoreUtils.GetData(equipSuitId, RuntimeConfigs.data.equipSuitDatas)?.suitName ?? 0;
	}

	public int GetLocalizationName()
	{
		return GetLocalizationName(_suitId);
	}

	public int GetUid()
	{
		return 0;
	}
}
