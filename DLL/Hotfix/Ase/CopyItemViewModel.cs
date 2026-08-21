using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class CopyItemViewModel : OptionBase
{
	private CopyData data;

	private int bossLv;

	private List<CopyData> data4s;

	private InteractionRequest<string> optRequest = new InteractionRequest<string>();

	private SimpleCommand<string> optCommand;

	private bool isSelect;

	private bool isRecommend;

	private bool isOpenDetail;

	private string lockDesc;

	private string icon;

	private int quality;

	private int starCur;

	private int starMax;

	private int starConfigMax;

	private int taskId;

	private string bossName;

	private string bossNameAndLv;

	private List<int> adItemListType5;

	private float rate;

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		private set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public bool IsRecommend
	{
		get
		{
			return isRecommend;
		}
		private set
		{
			Set(ref isRecommend, value, "IsRecommend");
		}
	}

	public bool IsOpenDetail
	{
		get
		{
			return isOpenDetail;
		}
		private set
		{
			Set(ref isOpenDetail, value, "IsOpenDetail");
		}
	}

	public string LockDesc
	{
		get
		{
			return lockDesc;
		}
		private set
		{
			Set(ref lockDesc, value, "LockDesc");
		}
	}

	public string BossName
	{
		get
		{
			return bossName;
		}
		private set
		{
			Set(ref bossName, value, "BossName");
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

	public IInteractionRequest OptRequest => optRequest;

	public ICommand OptCommand => optCommand;

	public CopyData Data
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

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public int BossLv
	{
		get
		{
			return bossLv;
		}
		private set
		{
			Set(ref bossLv, value, "BossLv");
		}
	}

	public int Quality
	{
		get
		{
			return quality;
		}
		set
		{
			Set(ref quality, value, "Quality");
		}
	}

	public int StarConfigMax
	{
		get
		{
			return starConfigMax;
		}
		private set
		{
			Set(ref starConfigMax, value, "StarConfigMax");
		}
	}

	public int StarMax
	{
		get
		{
			return starMax;
		}
		private set
		{
			Set(ref starMax, value, "StarMax");
		}
	}

	public int StarCur
	{
		get
		{
			return starCur;
		}
		private set
		{
			Set(ref starCur, value, "StarCur");
		}
	}

	public float Rate
	{
		get
		{
			return rate;
		}
		private set
		{
			Set(ref rate, value, "Rate");
		}
	}

	public int TaskId => taskId;

	public List<int> AdItemListType5 => adItemListType5;

	public CopyItemViewModel()
	{
	}

	public CopyItemViewModel(OptionBase parent, CopyData data)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		this.data = data;
	}

	public CopyItemViewModel(OptionBase parent, CopyData data, int copyMainType)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		this.data = data;
		switch (copyMainType)
		{
		case 2:
			InitType2(data);
			break;
		case 4:
			InitType4(data);
			break;
		}
	}

	public void InitType2(CopyData data)
	{
		DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow((DRMonsterAttr p) => p.Id == data.GetBossId(0));
		if (dataRow == null)
		{
			BossLv = 0;
		}
		else
		{
			BossLv = dataRow.MonsterLevel;
		}
	}

	public void InitType4(CopyData data)
	{
		data4s = new List<CopyData>();
		data4s.Add(data);
	}

	public CopyItemViewModel(OptionBase parent, CopyData data, float rate)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		this.data = data;
		RefreshAdItemListType5();
		this.rate = rate;
	}

	public bool AddCopyData(CopyData data)
	{
		if (this.data.CopyRank == data.CopyRank && this.data.Id != data.Id)
		{
			data4s.Add(data);
			return true;
		}
		return false;
	}

	public void CalcuStar()
	{
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		for (int i = 0; i < data4s.Count; i++)
		{
			num += data4s[i].StarCur;
			if (data4s[i].StarMax > 0)
			{
				num2 += data4s[i].StarMax;
			}
			num3 += data4s[i].StarConfigMax;
		}
		StarCur = num;
		StarMax = num2;
		StarConfigMax = num3;
	}

	public void SetMaterial(int materialType)
	{
		DRCopyDrop dRCopyDrop = null;
		dRCopyDrop = ((materialType <= 0) ? GameEntry.DataTable.GetDataRow((DRCopyDrop p) => p.RewardGroupId == data.Drops) : GameEntry.DataTable.GetDataRow((DRCopyDrop p) => p.RewardGroupId == data.Drops && p.DropeType == materialType));
		if (dRCopyDrop == null)
		{
			return;
		}
		if (dRCopyDrop.CopyPropTypeShow.Count != dRCopyDrop.CopyPropIDShow.Count || dRCopyDrop.CopyPropTypeShow.Count == 0)
		{
			Icon = "";
			Quality = 1;
			return;
		}
		PropDataBase propDataBase = PropDataBase.CreateByType(dRCopyDrop.CopyPropTypeShow[0], dRCopyDrop.CopyPropIDShow[0]);
		if (propDataBase == null)
		{
			Icon = "";
			Quality = 1;
		}
		else
		{
			Icon = propDataBase.Icon;
			Quality = propDataBase.GetRarity();
		}
	}

	public void SetQuality(int val)
	{
		Quality = val;
	}

	private void RefreshAdItemListType5()
	{
		adItemListType5 = ((data == null) ? new List<int>() : data.GetBuffsReverseOrder());
	}

	private void OnOpt(string obj)
	{
		parent.ItemOnClick(this);
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}

	public void SetRecommend(bool isRecommend)
	{
		IsRecommend = isRecommend;
	}

	public void SetOpenDetail(bool isOpenDetail)
	{
		IsOpenDetail = isOpenDetail;
	}

	public void OnBuffClick()
	{
		parent.ItemOnClick(new OptionArg(this, "ShowCopyBuffDesc"));
	}

	public void SetBossName()
	{
		if (data.BossTypes != null && data.BossTypes.Count != 0)
		{
			DRMonsterInfo dataRow = GameEntry.DataTable.GetDataRow((DRMonsterInfo p) => p.Id == data.BossTypes[0]);
			if (dataRow != null)
			{
				LockDesc = dataRow.Name;
			}
		}
	}

	public void SetBossName(string bossName)
	{
		BossName = bossName;
		BossNameAndLv = bossName;
	}

	public void SetBossNameAndLv()
	{
		int bossType = ((data.BossTypes != null && data.BossTypes.Count > 0) ? data.BossTypes[0] : 0);
		if (bossType > 0)
		{
			DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow((DRMonsterAttr p) => p.Id == bossType);
			if (dataRow != null)
			{
				BossNameAndLv = $"Lv.{dataRow.MonsterLevel}{dataRow.Name}";
				BossName = dataRow.Name;
				return;
			}
		}
		int bossId = data.GetBossId(0);
		if (bossId > 0)
		{
			DRMonsterAttr dataRow2 = GameEntry.DataTable.GetDataRow((DRMonsterAttr p) => p.Id == bossId);
			if (dataRow2 != null)
			{
				BossNameAndLv = $"Lv.{dataRow2.MonsterLevel}{dataRow2.Name}";
				BossName = dataRow2.Name;
				return;
			}
		}
		if (bossType > 0)
		{
			DRMonsterInfo dataRow3 = GameEntry.DataTable.GetDataRow((DRMonsterInfo p) => p.Id == bossType);
			if (dataRow3 != null)
			{
				BossNameAndLv = dataRow3.Name;
				BossName = dataRow3.Name;
			}
		}
	}

	public void AddTaskId(int taskId)
	{
		this.taskId = taskId;
	}

	public List<CopyData> GetCopyDatas()
	{
		return data4s;
	}

	public bool CheckCopyDataIn(int copyId)
	{
		for (int i = 0; i < data4s.Count; i++)
		{
			if (data4s[i].Id == copyId)
			{
				return true;
			}
		}
		return false;
	}

	public void PlayUnlockEffect()
	{
		if (!data.IsLock && !data.HasPlayUnlock)
		{
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().PlayUnlockEffect(data);
			optRequest.Raise("PlayUnlockEffect");
		}
	}

	public void AfterPlayNewUnlockEffect()
	{
		parent?.ItemOnClick(new OptionArg(this, "AfterPlayNewUnlockEffect"));
	}
}
