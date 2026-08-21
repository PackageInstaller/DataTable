using Cysharp.Threading.Tasks;

namespace Ase;

public class ArmourPresetEditViewModel : ArmourChangeViewModel
{
	private readonly ArmourPresetSlotData slotData;

	public override string CurrentSlotTitle => "当前预设";

	public ArmourPresetEditViewModel()
	{
	}

	public ArmourPresetEditViewModel(OptionBase parent, HeroModel heroModel, ArmourPresetSlotData slotData, int position)
		: base(parent, heroModel, (ArmourEnum)position, deferInitialize: true)
	{
		this.slotData = slotData;
		curArmourType = (ArmourEnum)position;
		base.InitializeAfterSetup();
	}

	protected override ArmourData GetCurrentSlotArmourData()
	{
		return slotData?.GetEquipment((int)curArmourType);
	}

	protected override void SetShowArmours()
	{
		base.SetShowArmours();
		RefreshCurrentPresetSlotState();
	}

	protected override void SetCurTab(TabItemData data)
	{
		base.SetCurTab(data);
		RefreshCurrentPresetSlotState();
	}

	protected override void HideContrastPanel()
	{
		base.ShowArmourMask = false;
		base.HideContrastPanel();
	}

	protected override void EquipmentOnClick(ArmourItemData itemData, bool needCheck = true)
	{
		if (itemData == null || itemData.Data == null || selectedViewModel == null)
		{
			return;
		}
		if (curItemData != null)
		{
			if (needCheck && curItemData.Data.Uid == itemData.Data.Uid)
			{
				return;
			}
			curItemData.IsSelected = false;
		}
		curItemData = itemData;
		curItemData.IsSelected = true;
		hideEntryDetailRequest.Raise();
		selectedViewModel.RefreshData(curItemData.Data);
		selectedViewModel.RefreshHeroInfo();
		base.ArmourData = curItemData.Data;
		base.ShowArmour = true;
		ArmourData currentSlotArmourData = GetCurrentSlotArmourData();
		if (currentSlotArmourData != null && currentSlotArmourData.Uid == curItemData.Data.Uid)
		{
			base.ShowArmourMask = false;
			HideContrastPanel();
			contrastViewModel?.RefreshData(null);
		}
		else if (currentSlotArmourData != null)
		{
			base.ShowArmourMask = true;
			ShowContrastPanel(currentSlotArmourData, curItemData.Data);
		}
		else
		{
			base.ShowArmourMask = false;
			HideContrastPanel();
			contrastViewModel?.RefreshData(null);
		}
		RefreshDetailFunction();
	}

	protected override void RefreshDetailFunction()
	{
		if (curItemData != null && !heroModel.IsNullOrEmpty() && selectedViewModel != null)
		{
			ArmourData currentSlotArmourData = GetCurrentSlotArmourData();
			if (currentSlotArmourData != null && curItemData.Data.Uid == currentSlotArmourData.Uid)
			{
				selectedViewModel.SetFunction(isChange: false, "移出预设");
			}
			else if (currentSlotArmourData != null)
			{
				selectedViewModel.SetFunction(isChange: true, "替换预设");
			}
			else
			{
				selectedViewModel.SetFunction(isChange: true, "放入预设");
			}
		}
	}

	protected override void ChangeEquipment()
	{
		if (!isArmourChanging)
		{
			isArmourChanging = true;
			ChangeArmour();
		}
	}

	protected override async void ChangeArmour()
	{
		if (curItemData == null || curItemData.Data == null || slotData == null)
		{
			isArmourChanging = false;
			return;
		}
		ArmourData currentSlotArmourData = GetCurrentSlotArmourData();
		if (currentSlotArmourData != null && currentSlotArmourData.Uid == curItemData.Data.Uid)
		{
			selectedViewModel.ReSetLeftCmd();
			isArmourChanging = false;
			return;
		}
		Loading loading = await Loading.Show();
		try
		{
			slotData.SetEquipment((int)curArmourType, curItemData.Data.Uid);
			if (await SavePresetSlot())
			{
				HideContrastPanel();
				contrastViewModel?.RefreshData(null);
				RefreshCurrentSlotData();
				RefreshCurrentPresetSlotState();
				SetEquipmentShowList();
				armourChangeRequest.Raise();
				refreshShowDatasRequest.Raise();
				selectedViewModel.ReSetLeftCmd();
				parent?.ItemOnClick(this);
			}
		}
		finally
		{
			loading.Dispose();
			isArmourChanging = false;
		}
	}

	protected override async void RemoveEquip()
	{
		if (slotData == null)
		{
			isArmourChanging = false;
		}
		else
		{
			if (isArmourChanging)
			{
				return;
			}
			isArmourChanging = true;
			Loading loading = await Loading.Show();
			try
			{
				slotData.RemoveEquipment((int)curArmourType);
				if (await SavePresetSlot())
				{
					RefreshCurrentSlotData();
					RefreshCurrentPresetSlotState();
					RefreshRemovedCurrentSelection();
					refreshShowDatasRequest.Raise();
					selectedViewModel.ReSetLeftCmd();
					parent?.ItemOnClick(this);
				}
			}
			finally
			{
				loading.Dispose();
				isArmourChanging = false;
			}
		}
	}

	private void RefreshRemovedCurrentSelection()
	{
		if (curItemData == null || curItemData.Data == null || selectedViewModel == null)
		{
			SetEquipmentShowList();
			return;
		}
		curItemData.IsSelected = true;
		base.ArmourData = curItemData.Data;
		base.ShowArmour = true;
		base.ShowArmourMask = false;
		HideContrastPanel();
		contrastViewModel?.RefreshData(null);
		selectedViewModel.RefreshData(curItemData.Data);
		selectedViewModel.RefreshHeroInfo();
		RefreshDetailFunction();
	}

	private void RefreshCurrentPresetSlotState()
	{
		if (datas == null)
		{
			return;
		}
		long num = GetCurrentSlotArmourData()?.Uid ?? 0;
		foreach (ArmourItemData value in datas.Values)
		{
			if (value != null && value.Data != null)
			{
				value.IsInCurrentPresetSlot = num > 0 && value.Data.Uid == num;
			}
		}
	}

	private async UniTask<bool> SavePresetSlot()
	{
		slotData.RemoveInvalidEquipments();
		ArmourPresetSlotData armourPresetSlotData = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().SetPresetEquipment(heroModel?.Id ?? 0, slotData);
		if (armourPresetSlotData == null)
		{
			return false;
		}
		slotData.ReplaceWith(armourPresetSlotData);
		return true;
	}
}
