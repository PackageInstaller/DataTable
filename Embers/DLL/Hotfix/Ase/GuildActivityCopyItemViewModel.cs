namespace Ase;

public class GuildActivityCopyItemViewModel : SelectItemViewModel
{
	private GuildCopyData data;

	private string bossNameAndLv;

	public GuildCopyData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public string BossNameAndLv
	{
		get
		{
			return bossNameAndLv;
		}
		private set
		{
			Set(ref bossNameAndLv, value, "BossNameAndLv");
		}
	}

	public GuildActivityCopyItemViewModel()
	{
	}

	public GuildActivityCopyItemViewModel(OptionBase parent, GuildCopyData data)
		: base(parent)
	{
		this.data = data;
	}

	public override void OnClick()
	{
		if (!isSelect)
		{
			parent?.ItemOnClick(this);
		}
	}

	public void SetBossNameAndLv()
	{
		if (data.CopyData.BossTypes != null && data.CopyData.BossTypes.Count != 0)
		{
			DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow((DRMonsterAttr p) => p.Id == data.CopyData.BossTypes[0]);
			if (dataRow != null)
			{
				BossNameAndLv = $"Lv.{dataRow.MonsterLevel}{dataRow.Name}";
			}
		}
	}
}
