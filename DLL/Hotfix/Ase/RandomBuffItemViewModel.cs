namespace Ase;

public class RandomBuffItemViewModel : OptionBase
{
	private new OptionBase parent;

	private bool selectItem;

	private string iconName;

	private string buffName;

	private string buffDes;

	private int buffQuality;

	private int buffId;

	private bool collectRes;

	private bool commendBuff;

	public bool SelectItem
	{
		get
		{
			return selectItem;
		}
		set
		{
			Set(ref selectItem, value, "SelectItem");
		}
	}

	public string BuffName
	{
		get
		{
			return buffName;
		}
		set
		{
			Set(ref buffName, value, "BuffName");
		}
	}

	public string IconName
	{
		get
		{
			return iconName;
		}
		set
		{
			Set(ref iconName, value, "IconName");
		}
	}

	public string BuffDes
	{
		get
		{
			return buffDes;
		}
		set
		{
			Set(ref buffDes, value, "BuffDes");
		}
	}

	public int BuffQuality
	{
		get
		{
			return buffQuality;
		}
		set
		{
			Set(ref buffQuality, value, "BuffQuality");
		}
	}

	public bool CollectRes
	{
		get
		{
			return collectRes;
		}
		set
		{
			Set(ref collectRes, value, "CollectRes");
		}
	}

	public bool CommendBuff
	{
		get
		{
			return commendBuff;
		}
		set
		{
			Set(ref commendBuff, value, "CommendBuff");
		}
	}

	public int BuffId => buffId;

	public RandomBuffItemViewModel(OptionBase parent, int buffId, int copyId, bool recommend)
	{
		this.parent = parent;
		DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(buffId);
		DRTowerBuffUp dataRow2 = GameEntry.DataTable.GetDataRow<DRTowerBuffUp>(buffId);
		if (dataRow != null)
		{
			IconName = dataRow2.BuffIcon;
			BuffName = dataRow.Name;
			BuffDes = dataRow.Desc;
			buffQuality = dataRow2?.Bufflv ?? 0;
			this.buffId = buffId;
			commendBuff = recommend;
			collectRes = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetRandomBuffCollectState(copyId, buffId);
		}
	}

	public void OnClickSelectBuff()
	{
		SelectItem = !SelectItem;
		parent.ItemOnClick(this);
	}
}
