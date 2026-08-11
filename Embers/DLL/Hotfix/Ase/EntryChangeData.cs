using GameFramework.Runtime;

namespace Ase;

public class EntryChangeData : ViewModelBase
{
	private EntryData entryData;

	public EntryChangeEnum ChangeEnum { get; set; }

	public EntryData EntryData
	{
		get
		{
			return entryData;
		}
		set
		{
			Set(ref entryData, value, "EntryData");
		}
	}

	public int OriLevel { get; set; }

	public int CurLevel { get; set; }

	public EntryChangeData()
	{
	}

	public EntryChangeData(EntryData entryData, int oriLevel, int curLevel)
	{
		EntryData = entryData;
		OriLevel = oriLevel;
		CurLevel = curLevel;
		if (oriLevel <= 0 && curLevel > 0)
		{
			ChangeEnum = EntryChangeEnum.New;
		}
		else if (curLevel <= 0 && oriLevel > 0)
		{
			ChangeEnum = EntryChangeEnum.Disappear;
		}
		else if (curLevel > oriLevel)
		{
			ChangeEnum = EntryChangeEnum.Add;
		}
		else if (curLevel < oriLevel)
		{
			ChangeEnum = EntryChangeEnum.Reduce;
		}
		else
		{
			ChangeEnum = EntryChangeEnum.None;
		}
	}
}
