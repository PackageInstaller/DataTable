using GameFramework.Runtime;

namespace Ase;

public class MonsterInfoData : ViewModelBase
{
	public string monsterIcon;

	public string monsterName;

	public MonsterInfoData(int mType, string icon)
	{
		DRMonsterInfo dataRow = GameEntry.DataTable.GetDataRow((DRMonsterInfo p) => p.Id == mType);
		if (dataRow == null)
		{
			monsterName = "Unknow";
		}
		else
		{
			monsterName = dataRow.Name;
		}
		monsterIcon = icon;
	}
}
