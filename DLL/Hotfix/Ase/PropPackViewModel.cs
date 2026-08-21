using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class PropPackViewModel : OptionBase
{
	private int packId;

	private string packName;

	private string packTip;

	private List<PropPackItemViewModel> propPackItemViewModelList;

	private List<int> selectPackId;

	private int selectItemMax;

	private int packType;

	private SimpleCommand confirmOnClickCmd;

	private InteractionRequest<float> fixSliderRequest;

	private int useCount;

	private int useCountMax;

	private bool canAdd;

	private bool canDec;

	private float useFillAmount;

	private bool needFix;

	private PropPackItemViewModel _singleChoiceItemData;

	public int UseCount
	{
		get
		{
			return useCount;
		}
		set
		{
			Set(ref useCount, value, "UseCount");
		}
	}

	public float UseFillAmount
	{
		get
		{
			return useFillAmount;
		}
		set
		{
			Set(ref useFillAmount, value, "UseFillAmount");
			if (needFix)
			{
				SetFillAmount((int)(value * (float)UseCountMax));
			}
			needFix = true;
		}
	}

	public string PackTip
	{
		get
		{
			return packTip;
		}
		set
		{
			Set(ref packTip, value, "PackTip");
		}
	}

	public bool CanAdd
	{
		get
		{
			return canAdd;
		}
		set
		{
			Set(ref canAdd, value, "CanAdd");
		}
	}

	public bool CanDec
	{
		get
		{
			return canDec;
		}
		set
		{
			Set(ref canDec, value, "CanDec");
		}
	}

	public int UseCountMax
	{
		get
		{
			return useCountMax;
		}
		set
		{
			Set(ref useCountMax, value, "UseCountMax");
		}
	}

	public string PackName => packName;

	public ICommand ConfirmOnClickCmd => confirmOnClickCmd;

	public InteractionRequest<float> FixSliderRequest => fixSliderRequest;

	public List<PropPackItemViewModel> PropPackItemViewModelList => propPackItemViewModelList;

	public PropPackViewModel(OptionBase parent, int packId, int useMax)
	{
		base.parent = parent;
		this.packId = packId;
		confirmOnClickCmd = new SimpleCommand(ConfirmOnClick);
		needFix = true;
		useCountMax = useMax;
		selectPackId = new List<int>();
		fixSliderRequest = new InteractionRequest<float>();
		LoadPackInfo();
		LoadPackItemList();
		SetUse();
		confirmOnClickCmd.Enabled = packType != 2;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is PropPackItemViewModel propPackItemViewModel && packType == 2)
		{
			SelectItem(propPackItemViewModel);
		}
	}

	private void LoadPackInfo()
	{
		DRPacks dataRow = GameEntry.DataTable.GetDataRow<DRPacks>(packId);
		if (dataRow != null)
		{
			packName = dataRow.Name;
			selectItemMax = dataRow.ChooseNUM;
			packType = dataRow.ChooseType;
			SetPackTip();
		}
	}

	private void SetPackTip()
	{
		PackTip = $"请在下方奖励中选择{selectItemMax}种 {selectPackId.Count}/{selectItemMax}";
		switch (packType)
		{
		case 1:
			PackTip = "获得下方所有奖励";
			break;
		case 2:
			PackTip = $"请在下方奖励中选择{selectItemMax}种 {selectPackId.Count}/{selectItemMax}";
			break;
		case 3:
			PackTip = $"在下方奖励中随机获得{selectItemMax}种";
			break;
		}
	}

	private void LoadPackItemList()
	{
		propPackItemViewModelList = new List<PropPackItemViewModel>();
		DRPacksInclude[] dataRows = GameEntry.DataTable.GetDataRows((DRPacksInclude p) => p.PacksID == packId);
		foreach (DRPacksInclude dRPacksInclude in dataRows)
		{
			PropDataBase propDataBase = PropDataBase.CreateByType(dRPacksInclude.IncludeType, dRPacksInclude.IncludeID, dRPacksInclude.IncludeNUM);
			propDataBase.ExValue = dRPacksInclude.Id;
			if (propDataBase.PropTypeEnum == PropTypeEnum.Hero)
			{
				propDataBase.Icon = $"UserHead{dRPacksInclude.IncludeID}_0";
			}
			PropPackItemViewModel item = new PropPackItemViewModel(this, propDataBase);
			propPackItemViewModelList.Add(item);
		}
	}

	private void SelectItem(PropPackItemViewModel propPackItemViewModel)
	{
		if (propPackItemViewModel.IsSelected)
		{
			selectPackId.Remove(propPackItemViewModel.ExValue);
			propPackItemViewModel.IsSelected = false;
			SetPackTip();
			confirmOnClickCmd.Enabled = selectPackId.Count == selectItemMax;
			return;
		}
		if (selectItemMax > 1 && selectItemMax <= selectPackId.Count)
		{
			Toast.ShowInfo("选择的数量已达到上限");
			return;
		}
		if (selectItemMax == 1)
		{
			SetSingleChoiceItemData(propPackItemViewModel);
		}
		selectPackId.Add(propPackItemViewModel.ExValue);
		propPackItemViewModel.IsSelected = true;
		SetPackTip();
		confirmOnClickCmd.Enabled = selectPackId.Count == selectItemMax;
	}

	private void SetSingleChoiceItemData(PropPackItemViewModel itemData)
	{
		if (_singleChoiceItemData != null)
		{
			if (_singleChoiceItemData.ExValue == itemData.ExValue)
			{
				return;
			}
			selectPackId.Remove(_singleChoiceItemData.ExValue);
			_singleChoiceItemData.IsSelected = false;
		}
		_singleChoiceItemData = itemData;
	}

	private async void ConfirmOnClick()
	{
		if (useCount <= 0)
		{
			return;
		}
		confirmOnClickCmd.Enabled = false;
		RewardThings rewardThings = await Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().OpenPackRequest(packId, useCount, selectPackId);
		if (rewardThings != null)
		{
			PropGetViewModel userData = new PropGetViewModel(this, rewardThings);
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData), delegate
			{
				Close();
			});
		}
	}

	private void SetUse()
	{
		UseFillAmount = CalUseFillAmount(1);
		fixSliderRequest.Raise(UseFillAmount);
	}

	private float CalUseFillAmount(int count)
	{
		UseCount = ((count <= 0) ? 1 : count);
		CanDec = UseCount > 1 && UseCountMax != 0;
		CanAdd = UseCount < UseCountMax;
		if (UseCountMax != 0)
		{
			return (float)count * 1f / (float)UseCountMax;
		}
		return 1f;
	}

	private void SetUseCount(int useCount)
	{
		UseCount = ((useCount <= 0) ? 1 : useCount);
		CanDec = UseCount > 1 && UseCountMax != 0;
		CanAdd = UseCount < UseCountMax;
		UseFillAmount = CalUseFillAmount(UseCount);
		fixSliderRequest.Raise(UseFillAmount);
	}

	private void SetFillAmount(int amout)
	{
		UseCount = ((amout <= 0) ? 1 : amout);
		CanDec = UseCount > 1 && UseCountMax != 0;
		CanAdd = UseCount < UseCountMax;
	}

	public virtual void AddProp()
	{
		if (UseCount < UseCountMax || UseCountMax == 0)
		{
			int num = useCount + 1;
			needFix = false;
			SetUseCount(num);
		}
	}

	public virtual void DecProp()
	{
		if (UseCount > 1)
		{
			int num = UseCount - 1;
			needFix = false;
			SetUseCount(num);
		}
	}
}
