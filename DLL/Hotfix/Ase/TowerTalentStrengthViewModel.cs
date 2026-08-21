using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class TowerTalentStrengthViewModel : OptionBase
{
	private CopyViewModel copyVM;

	private Dictionary<int, TowerTalentItemViewModel> towerTalentItemViewModels;

	private List<TowerTalentLevelDesViewModel> talentLevelDesList = new List<TowerTalentLevelDesViewModel>(4);

	private readonly InteractionRequest changeSelectRequest;

	private SimpleCommand<string> optCmd;

	private TowerTalentItemViewModel _selectTalent;

	private bool showType1;

	private string talentDes;

	private string talentName;

	private string upLevelBtnText;

	private int costNum;

	private KnapsackPropData costData;

	private bool showNormal;

	public List<TowerTalentLevelDesViewModel> TalentLevelDesList => talentLevelDesList;

	public IInteractionRequest ChangeSelectRequest => changeSelectRequest;

	public TowerTalentItemViewModel SelectTalent
	{
		get
		{
			return _selectTalent;
		}
		set
		{
			Set(ref _selectTalent, value, "SelectTalent");
		}
	}

	public bool ShowType1
	{
		get
		{
			return showType1;
		}
		set
		{
			Set(ref showType1, value, "ShowType1");
		}
	}

	public string TalentDes
	{
		get
		{
			return talentDes;
		}
		set
		{
			Set(ref talentDes, value, "TalentDes");
		}
	}

	public string TalentName
	{
		get
		{
			return talentName;
		}
		set
		{
			Set(ref talentName, value, "TalentName");
		}
	}

	public string UpLevelBtnText
	{
		get
		{
			return upLevelBtnText;
		}
		set
		{
			Set(ref upLevelBtnText, value, "UpLevelBtnText");
		}
	}

	public int CostNum
	{
		get
		{
			return costNum;
		}
		set
		{
			Set(ref costNum, value, "CostNum");
		}
	}

	public KnapsackPropData CostData
	{
		get
		{
			return costData;
		}
		set
		{
			Set(ref costData, value, "CostData");
		}
	}

	public bool ShowNormal
	{
		get
		{
			return showNormal;
		}
		set
		{
			Set(ref showNormal, value, "ShowNormal");
		}
	}

	public SimpleCommand<string> OptCmd
	{
		get
		{
			return optCmd;
		}
		set
		{
			optCmd = value;
		}
	}

	public Dictionary<int, TowerTalentItemViewModel> TowerTalentViewModels => towerTalentItemViewModels;

	public TowerTalentStrengthViewModel()
	{
		optCmd = new SimpleCommand<string>(OnOpt);
		copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
		towerTalentItemViewModels = new Dictionary<int, TowerTalentItemViewModel>(copyVM.TowerTalentViewModels.Count);
		foreach (KeyValuePair<int, TowerTalentViewModel> towerTalentViewModel in copyVM.TowerTalentViewModels)
		{
			TowerTalentItemViewModel value = new TowerTalentItemViewModel(this, towerTalentViewModel.Value);
			towerTalentItemViewModels.Add(towerTalentViewModel.Key, value);
		}
		changeSelectRequest = new InteractionRequest();
		GetSelectTalent();
	}

	private void GetSelectTalent()
	{
		int num = 0;
		TowerTalentItemViewModel towerTalentItemViewModel = null;
		TowerTalentItemViewModel towerTalentItemViewModel2 = null;
		foreach (TowerTalentItemViewModel value in towerTalentItemViewModels.Values)
		{
			if (towerTalentItemViewModel2 == null)
			{
				towerTalentItemViewModel2 = value;
			}
			if (value.Data.UnLock && value.Data.TalntLevel == 0)
			{
				towerTalentItemViewModel = SelectTalentItem(towerTalentItemViewModel, value);
				num = 1;
			}
			else if (value.Data.UnLock && value.Data.TalntLevel > 0 && value.Data.CanUpLevel)
			{
				if (num > 1)
				{
					towerTalentItemViewModel = SelectTalentItem(towerTalentItemViewModel, value);
					num = 2;
				}
			}
			else if (value.Data.UnLock && value.Data.TalntLevel > 0 && !value.Data.CanUpLevel)
			{
				if (num > 2)
				{
					towerTalentItemViewModel = SelectTalentItem(towerTalentItemViewModel, value);
					num = 3;
				}
			}
			else if (value.Data.UnLock && value.Data.TalntLevel >= value.Data.MaxLevel)
			{
				if (num > 3)
				{
					towerTalentItemViewModel = SelectTalentItem(towerTalentItemViewModel, value);
					num = 4;
				}
			}
			else if (!value.Data.UnLock && num > 4)
			{
				towerTalentItemViewModel = SelectTalentItem(towerTalentItemViewModel, value);
				num = 5;
			}
		}
		if (towerTalentItemViewModel == null)
		{
			towerTalentItemViewModel = towerTalentItemViewModel2;
		}
		towerTalentItemViewModel.IsSelect = true;
		SelectTalent = towerTalentItemViewModel;
		SelectTalentChange(SelectTalent.Data);
	}

	private void SelectTalentChange(TowerTalentViewModel towerTalentViewModel)
	{
		ShowNormal = true;
		if (towerTalentViewModel == null)
		{
			return;
		}
		if (towerTalentViewModel.UnLock && towerTalentViewModel.TalntLevel == 0)
		{
			UpLevelBtnText = "激活";
		}
		else
		{
			UpLevelBtnText = "升级";
		}
		DRTowerTalent[] dataRows = GameEntry.DataTable.GetDataRows((DRTowerTalent x) => x.Talent == towerTalentViewModel.TalentId);
		if (dataRows == null || dataRows.Length == 0)
		{
			return;
		}
		talentLevelDesList.Clear();
		for (int num = 0; num < dataRows.Length; num++)
		{
			if (dataRows[num].Order == towerTalentViewModel.TalntLevel + 1)
			{
				CostNum = dataRows[num].NeedNum;
				CostData = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(dataRows[num].NeedId);
				if (towerTalentViewModel.TalntLevel == 0)
				{
					TalentDes = dataRows[num].Desc;
					TalentName = dataRows[num].Name;
					ShowType1 = towerTalentViewModel.TalentType == 1;
				}
			}
			else if (dataRows[num].Order == towerTalentViewModel.TalntLevel && towerTalentViewModel.TalntLevel != 0)
			{
				TalentDes = dataRows[num].Desc;
				TalentName = dataRows[num].Name;
				ShowType1 = towerTalentViewModel.TalentType == 1;
			}
			talentLevelDesList.Add(new TowerTalentLevelDesViewModel(dataRows[num].Order, dataRows[num].Desc, towerTalentViewModel.TalntLevel == dataRows[num].Order));
		}
		if (costData == null)
		{
			CostData = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(dataRows[0].NeedId);
		}
	}

	private bool TalentDataSelectCurData(TowerTalentViewModel preData, TowerTalentViewModel curData)
	{
		if (curData.TalentType > preData.TalentType)
		{
			return true;
		}
		if (curData.TalntLevel > preData.TalntLevel)
		{
			return true;
		}
		if (curData.TalentId < preData.TalentId)
		{
			return true;
		}
		return false;
	}

	private TowerTalentItemViewModel SelectTalentItem(TowerTalentItemViewModel preTalent, TowerTalentItemViewModel talentData)
	{
		TowerTalentItemViewModel towerTalentItemViewModel = null;
		if (preTalent != null)
		{
			if (TalentDataSelectCurData(preTalent.Data, talentData.Data))
			{
				return talentData;
			}
			return preTalent;
		}
		return talentData;
	}

	public async UniTask UpTalentLevel()
	{
		await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().UpTowerTalentLevel(_selectTalent.Data.TalentId);
		if (_selectTalent != null)
		{
			SelectTalentChange(_selectTalent.Data);
		}
	}

	public async UniTask ResetTalentLevel()
	{
		await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().ResetTowerTalent();
		if (_selectTalent != null)
		{
			SelectTalentChange(_selectTalent.Data);
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (!(obj is TowerTalentItemViewModel towerTalentItemViewModel))
		{
			return;
		}
		foreach (TowerTalentItemViewModel value in towerTalentItemViewModels.Values)
		{
			if (value == towerTalentItemViewModel)
			{
				value.IsSelect = true;
				SelectTalent = value;
				SelectTalentChange(SelectTalent.Data);
				changeSelectRequest.Raise();
			}
			else
			{
				value.IsSelect = false;
			}
		}
	}

	private void ClickSpecialTalent()
	{
		ShowNormal = false;
		if (SelectTalent != null)
		{
			SelectTalent.IsSelect = false;
		}
	}

	private void OnOpt(string optName)
	{
		if ("ClickSpecialTalent".Equals(optName))
		{
			ClickSpecialTalent();
		}
	}
}
