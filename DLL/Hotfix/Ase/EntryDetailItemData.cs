using System.Collections.Generic;

namespace Ase;

public class EntryDetailItemData : OptionBase
{
	private List<TabItemNormalData> levelItem;

	private string entryLevel;

	private string entryIcon;

	private string entryName;

	private string entryDetail;

	public string EntryIcon => entryIcon;

	public string EntryName => entryName;

	public string EntryDetail => entryDetail;

	public List<TabItemNormalData> LevelItem => levelItem;

	public string EntryLevel => entryLevel;

	public EntryDetailItemData()
	{
	}

	public EntryDetailItemData(EntryData entryData, List<TabItemNormalData> levelItem, int curLevel)
	{
		entryIcon = entryData.IconPath;
		entryName = entryData.DrEntry.Name;
		entryDetail = entryData.DrEntry.DetailDesc;
		this.levelItem = levelItem;
		entryLevel = ((curLevel >= entryData.MaxLevel) ? $"<color=#FE8B79>Lv.{curLevel}</color>/{entryData.MaxLevel}" : $"Lv.{curLevel}/{entryData.MaxLevel}");
	}
}
