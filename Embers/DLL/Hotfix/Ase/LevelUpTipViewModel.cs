using System.Collections.Generic;

namespace Ase;

public class LevelUpTipViewModel : OptionBase
{
	private List<string> tipList;

	private int level;

	public int Level => level;

	public List<string> TipList => tipList;

	public LevelUpTipViewModel(OptionBase parent, int level)
	{
		base.parent = parent;
		tipList = new List<string>();
		this.level = level;
		DRAccountGrade dataRow = GameEntry.DataTable.GetDataRow<DRAccountGrade>(level);
		if (dataRow == null)
		{
			return;
		}
		foreach (string item in dataRow.FunctionOpen)
		{
			tipList.Add(item);
		}
	}
}
