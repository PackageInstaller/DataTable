using System.Collections.Generic;

namespace Ase;

public class GameMonsterInfoViewModel : OptionBase
{
	private string imgPath;

	private string title;

	private string desc;

	private List<TabItemNormalData> skillDataList;

	public string ImgPath => imgPath;

	public string Title => title;

	public string Desc => desc;

	public List<TabItemNormalData> SkillDataList => skillDataList;

	public GameMonsterInfoViewModel(OptionBase parent, int id)
	{
		base.parent = parent;
		DRMonsterInfo[] dataRows = GameEntry.DataTable.GetDataRows((DRMonsterInfo p) => p.GuideId == id);
		if (dataRows.Length != 0)
		{
			imgPath = dataRows[0].MonsterIcon;
			title = dataRows[0].Name;
			desc = dataRows[0].Information.Replace("\\n", "\n");
		}
		skillDataList = new List<TabItemNormalData>();
		DRMonsterSkillNote[] dataRows2 = GameEntry.DataTable.GetDataRows((DRMonsterSkillNote p) => p.Type == id);
		if (dataRows2 != null)
		{
			DRMonsterSkillNote[] array = dataRows2;
			foreach (DRMonsterSkillNote dRMonsterSkillNote in array)
			{
				TabItemNormalData item = new TabItemNormalData(null, dRMonsterSkillNote.BossIcon, 0, isSelected: false, dRMonsterSkillNote.SkillDesc);
				skillDataList.Add(item);
			}
		}
		else
		{
			Toast.ShowError($"未找到ID:{id}种类怪物的技能说明");
		}
	}
}
