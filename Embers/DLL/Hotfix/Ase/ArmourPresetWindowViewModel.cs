using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ArmourPresetWindowViewModel : OptionBase
{
	public const int PresetNameMaxLength = 6;

	private const string PresetNameInvalidToast = "预设名称最多6个字符，仅支持中文、数字和字母";

	protected readonly InteractionRequest refreshRequest;

	protected readonly InteractionRequest<ArmourPresetNameViewModel> showNameViewRequest;

	protected readonly InteractionRequest hideNameViewRequest;

	protected readonly InteractionRequest<ArmourPresetApplyViewModel> showApplyViewRequest;

	protected readonly InteractionRequest hideApplyViewRequest;

	protected HeroModel heroModel;

	protected List<ArmourPresetTabItemData> tabItems = new List<ArmourPresetTabItemData>();

	protected List<ArmourPresetEquipItemData> armourItems = new List<ArmourPresetEquipItemData>();

	protected List<StatusAttrItemViewModel> attributeItems = new List<StatusAttrItemViewModel>();

	protected List<EntryLevelItemData> entryItems = new List<EntryLevelItemData>();

	protected ArmourPresetSlotData currentSlotData;

	protected ArmourPresetTabItemData curTabData;

	protected ArmourPresetSlotData pendingCreateEmptySlotData;

	private bool appliedPreset;

	private Dictionary<int, ArmourData> pendingApplyOriginalEquipments;

	public bool CanEditCurrentPreset
	{
		get
		{
			if (currentSlotData != null)
			{
				return !currentSlotData.IsCurrent;
			}
			return false;
		}
	}

	public bool CanShowCreatePresetButton => currentSlotData != null;

	public bool CanCreatePreset => FindFirstPresetSlot() != null;

	public bool IsCurrentPresetSlotEmpty
	{
		get
		{
			if (currentSlotData != null && !currentSlotData.IsCurrent)
			{
				return !currentSlotData.HasEquipment;
			}
			return false;
		}
	}

	public string CurrentPresetName => currentSlotData?.PresetName;

	public string CurrentPresetDefaultName => ArmourPresetSlotData.GetDefaultName(currentSlotData?.SlotId ?? 0);

	public List<ArmourPresetTabItemData> TabItems => tabItems;

	public List<ArmourPresetEquipItemData> ArmourItems => armourItems;

	public List<StatusAttrItemViewModel> AttributeItems => attributeItems;

	public List<EntryLevelItemData> EntryItems => entryItems;

	public InteractionRequest RefreshRequest => refreshRequest;

	public InteractionRequest<ArmourPresetNameViewModel> ShowNameViewRequest => showNameViewRequest;

	public InteractionRequest HideNameViewRequest => hideNameViewRequest;

	public InteractionRequest<ArmourPresetApplyViewModel> ShowApplyViewRequest => showApplyViewRequest;

	public InteractionRequest HideApplyViewRequest => hideApplyViewRequest;

	public ArmourPresetWindowViewModel()
	{
		refreshRequest = new InteractionRequest();
		showNameViewRequest = new InteractionRequest<ArmourPresetNameViewModel>();
		hideNameViewRequest = new InteractionRequest();
		showApplyViewRequest = new InteractionRequest<ArmourPresetApplyViewModel>();
		hideApplyViewRequest = new InteractionRequest();
	}

	public ArmourPresetWindowViewModel(OptionBase parent, HeroModel heroModel)
		: this()
	{
		base.parent = parent;
		this.heroModel = heroModel;
		InitData();
	}

	protected virtual void InitData()
	{
		tabItems.Clear();
		tabItems.Add(new ArmourPresetTabItemData(this, ArmourPresetSlotData.CreateCurrent(heroModel), heroModel));
		for (int i = 1; i <= 3; i++)
		{
			tabItems.Add(new ArmourPresetTabItemData(this, new ArmourPresetSlotData(heroModel?.Id ?? 0, i, ArmourPresetSlotData.GetDefaultName(i), isCreated: false)));
		}
		currentSlotData = tabItems[0].SlotData;
		SetTabSelected(tabItems[0]);
		RefreshCurrentData();
		LoadPresetSlotsFromServer();
	}

	protected virtual async void LoadPresetSlotsFromServer()
	{
		if (heroModel == null)
		{
			return;
		}
		List<ArmourPresetSlotData> list = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetPresetEquipments(heroModel.Id);
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				ApplyServerSlot(list[i]);
			}
			RefreshAllTabTexts();
			RefreshCurrentData();
		}
	}

	protected virtual void RefreshCurrentData()
	{
		armourItems.Clear();
		List<ArmourData> equipmentsInDisplayOrder = currentSlotData.GetEquipmentsInDisplayOrder();
		for (int i = 0; i < 7; i++)
		{
			if (i == 5)
			{
				armourItems.Add(new ArmourPresetEquipItemData(this));
				continue;
			}
			int num = ((i > 5) ? (i - 1) : i);
			bool showEmptyRedPoint = currentSlotData != null && !currentSlotData.IsCurrent;
			armourItems.Add(new ArmourPresetEquipItemData(this, num, equipmentsInDisplayOrder[num], showEmptyRedPoint));
		}
		attributeItems.Clear();
		List<StatusAttrItemViewModel> collection = ArmourOverviewDisplayUtil.BuildStatusAttrItems(equipmentsInDisplayOrder);
		attributeItems.AddRange(collection);
		entryItems.Clear();
		List<EntryLevelItemData> collection2 = ArmourOverviewDisplayUtil.BuildEntryItems(this, equipmentsInDisplayOrder);
		entryItems.AddRange(collection2);
		refreshRequest.Raise();
	}

	protected virtual void ApplyServerSlot(ArmourPresetSlotData slotData)
	{
		if (slotData != null)
		{
			ArmourPresetSlotData armourPresetSlotData = FindSlotData(slotData.SlotId);
			if (armourPresetSlotData != null && !armourPresetSlotData.IsCurrent)
			{
				armourPresetSlotData.ReplaceWith(slotData);
			}
		}
	}

	protected virtual ArmourPresetSlotData FindSlotData(int slotId)
	{
		for (int i = 0; i < tabItems.Count; i++)
		{
			if (tabItems[i].SlotData != null && tabItems[i].SlotData.SlotId == slotId)
			{
				return tabItems[i].SlotData;
			}
		}
		return null;
	}

	protected virtual void RefreshAllTabTexts()
	{
		for (int i = 0; i < tabItems.Count; i++)
		{
			tabItems[i].RefreshText();
			tabItems[i].RefreshIcon();
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is TabItemData tabItemData)
		{
			HandleTabClick(tabItemData as ArmourPresetTabItemData);
		}
		else if (obj is ArmourPresetEquipItemData armourPresetEquipItemData)
		{
			if (!armourPresetEquipItemData.IsBar && currentSlotData != null)
			{
				if (currentSlotData.IsCurrent)
				{
					OpenCurrentEquipmentDetail(armourPresetEquipItemData);
				}
				else
				{
					OpenEditWindow(armourPresetEquipItemData.Position);
				}
			}
		}
		else if (obj is ArmourPresetEditViewModel)
		{
			SyncInvalidPresetEquipments();
			parent?.ItemOnClick(this);
		}
		else if (obj is ArmourPresetApplyViewModel)
		{
			RefreshCurrentData();
		}
		else if (obj is OptionArg { Obj: ArmourPresetNameViewModel obj2 } optionArg)
		{
			HandleNameViewClick(obj2, optionArg.OptionName);
		}
	}

	private void HandleNameViewClick(ArmourPresetNameViewModel nameViewModel, string optionName)
	{
		if (nameViewModel != null)
		{
			if ("Confirm".Equals(optionName))
			{
				ConfirmNameView(nameViewModel.IsCreateMode, nameViewModel.PresetName);
			}
			else if ("Cancel".Equals(optionName))
			{
				CloseNameView();
			}
		}
	}

	public override void Close()
	{
		NotifyAppliedPresetClosed();
		base.Close();
	}

	public void NotifyAppliedPresetClosed()
	{
		if (appliedPreset)
		{
			appliedPreset = false;
			parent?.ItemOnClick(this);
		}
	}

	protected virtual void HandleTabClick(ArmourPresetTabItemData tabItemData)
	{
		if (tabItemData != null)
		{
			ArmourPresetSlotData slotData = tabItemData.SlotData;
			if (slotData != null && !slotData.IsCurrent && !slotData.IsCreated)
			{
				OpenCreateEmptyPresetNameView(slotData);
			}
			else
			{
				SetTabSelected(tabItemData);
			}
		}
	}

	protected virtual void SetTabSelected(ArmourPresetTabItemData tabItemData)
	{
		if (tabItemData != null && curTabData != tabItemData)
		{
			if (curTabData != null && curTabData != tabItemData)
			{
				curTabData.IsSelected = false;
			}
			curTabData = tabItemData;
			curTabData.IsSelected = true;
			currentSlotData = curTabData.SlotData;
			RefreshCurrentData();
		}
	}

	protected virtual void OpenEditWindow(int position)
	{
		ArmourPresetEditViewModel userData = new ArmourPresetEditViewModel(this, heroModel, currentSlotData, position);
		openWindowRequest.Raise(new OpenViewArg(typeof(ArmourChangeWindow), userData, "ArmourPreset"));
	}

	protected virtual void OpenCurrentEquipmentDetail(ArmourPresetEquipItemData equipItem)
	{
		ArmourData armourData = equipItem?.ArmourData;
		if (armourData != null)
		{
			openWindowRequest.Raise(PropHelper.OpenPopupWindow(armourData, this));
		}
	}

	private async void SyncInvalidPresetEquipments()
	{
		if (currentSlotData == null || currentSlotData.IsCurrent)
		{
			RefreshCurrentData();
			return;
		}
		if (!currentSlotData.RemoveInvalidEquipments())
		{
			RefreshCurrentData();
			return;
		}
		Loading loading = await Loading.Show();
		try
		{
			ArmourPresetSlotData armourPresetSlotData = ((!currentSlotData.HasEquipment) ? (await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().DeletePresetEquipment(heroModel?.Id ?? 0, currentSlotData.SlotId)) : (await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().SetPresetEquipment(heroModel?.Id ?? 0, currentSlotData)));
			if (armourPresetSlotData == null)
			{
				RefreshCurrentData();
				return;
			}
			currentSlotData.ReplaceWith(armourPresetSlotData);
			RefreshAllTabTexts();
			if (!currentSlotData.IsCreated)
			{
				SelectCurrentTab();
			}
			else
			{
				RefreshCurrentData();
			}
		}
		finally
		{
			loading.Dispose();
		}
	}

	public void OpenNameView(bool createMode, string presetName)
	{
		showNameViewRequest.Raise(new ArmourPresetNameViewModel(this, createMode, string.IsNullOrEmpty(presetName) ? CurrentPresetDefaultName : presetName));
	}

	public void OpenCreateNameView()
	{
		ArmourPresetSlotData armourPresetSlotData = FindFirstPresetSlot();
		if (armourPresetSlotData != null)
		{
			pendingCreateEmptySlotData = null;
			showNameViewRequest.Raise(new ArmourPresetNameViewModel(this, createMode: true, ArmourPresetSlotData.GetDefaultName(armourPresetSlotData.SlotId)));
		}
	}

	protected virtual void OpenCreateEmptyPresetNameView(ArmourPresetSlotData targetSlot)
	{
		if (targetSlot != null)
		{
			pendingCreateEmptySlotData = targetSlot;
			showNameViewRequest.Raise(new ArmourPresetNameViewModel(this, createMode: true, ArmourPresetSlotData.GetDefaultName(targetSlot.SlotId)));
		}
	}

	public void ConfirmNameView(bool createMode, string presetName)
	{
		string presetName2 = NormalizePresetName(presetName);
		if (!IsValidPresetName(presetName2))
		{
			Toast.ShowInfo("预设名称最多6个字符，仅支持中文、数字和字母");
			return;
		}
		if (createMode)
		{
			if (pendingCreateEmptySlotData != null)
			{
				CreateEmptyPresetAndOpenEdit(presetName2);
			}
			else
			{
				CreatePreset(presetName2);
			}
		}
		else
		{
			RenamePreset(presetName2);
		}
		CloseNameView();
	}

	public void CloseNameView()
	{
		pendingCreateEmptySlotData = null;
		hideNameViewRequest.Raise();
	}

	public virtual void CreatePreset()
	{
		CreatePreset(currentSlotData?.PresetName);
	}

	public virtual async void CreatePreset(string presetName)
	{
		ArmourPresetSlotData armourPresetSlotData = currentSlotData;
		if (IsCurrentPresetSlotEmpty)
		{
			Toast.ShowInfo("空预设无法存为新方案");
			return;
		}
		ArmourPresetSlotData targetSlot = FindFirstPresetSlot();
		if (targetSlot == null)
		{
			AlertDialog.Show("提示", "预设明饰方案已达到<color=#ab2b1a>上限</color>,若仍想<color=#ab2b1a>保存</color>新预设,请先<color=#ab2b1a>删除</color>已保存的预设", "确定", null);
			return;
		}
		ArmourPresetSlotData requestSlot = new ArmourPresetSlotData(targetSlot.RoleId, targetSlot.SlotId, NormalizePresetName(presetName, targetSlot), isCreated: true);
		if (armourPresetSlotData != null && !armourPresetSlotData.IsCurrent)
		{
			foreach (KeyValuePair<int, long> item in armourPresetSlotData.EquipmentUidsByPosition)
			{
				requestSlot.SetEquipment(item.Key, item.Value);
			}
		}
		else if (heroModel?.Armours != null)
		{
			foreach (KeyValuePair<int, ArmourData> armour in heroModel.Armours)
			{
				if (armour.Value != null)
				{
					requestSlot.SetEquipment(armour.Key, armour.Value.Uid);
				}
			}
		}
		Loading loading = await Loading.Show();
		try
		{
			ArmourPresetSlotData armourPresetSlotData2 = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().SetPresetEquipment(heroModel?.Id ?? 0, requestSlot);
			if (armourPresetSlotData2 != null)
			{
				targetSlot.ReplaceWith(armourPresetSlotData2);
				RefreshAllTabTexts();
				SelectSlot(targetSlot);
			}
		}
		finally
		{
			loading.Dispose();
		}
	}

	protected virtual async void CreateEmptyPresetAndOpenEdit(string presetName)
	{
		ArmourPresetSlotData targetSlot = pendingCreateEmptySlotData;
		pendingCreateEmptySlotData = null;
		if (targetSlot == null)
		{
			return;
		}
		ArmourPresetSlotData requestSlot = new ArmourPresetSlotData(targetSlot.RoleId, targetSlot.SlotId, NormalizePresetName(presetName, targetSlot), isCreated: true);
		Loading loading = await Loading.Show();
		try
		{
			ArmourPresetSlotData armourPresetSlotData = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().SetPresetEquipment(heroModel?.Id ?? 0, requestSlot);
			if (armourPresetSlotData != null)
			{
				targetSlot.ReplaceWith(armourPresetSlotData);
				RefreshAllTabTexts();
				SelectSlot(targetSlot);
				OpenEditWindow(0);
			}
		}
		finally
		{
			loading.Dispose();
		}
	}

	private void SelectSlot(ArmourPresetSlotData slotData)
	{
		for (int i = 0; i < tabItems.Count; i++)
		{
			if (tabItems[i].SlotData == slotData)
			{
				SetTabSelected(tabItems[i]);
				return;
			}
		}
		currentSlotData = slotData;
	}

	protected virtual ArmourPresetSlotData FindFirstPresetSlot()
	{
		for (int i = 0; i < tabItems.Count; i++)
		{
			ArmourPresetSlotData slotData = tabItems[i].SlotData;
			if (slotData != null && !slotData.IsCurrent && !slotData.IsCreated)
			{
				return slotData;
			}
		}
		return null;
	}

	public virtual void ApplyPreset()
	{
		if (IsCurrentPresetSlotEmpty)
		{
			Toast.ShowInfo("空预设无法应用");
		}
		else
		{
			ApplyCurrentSlotToHero();
		}
	}

	public virtual void RenamePreset()
	{
		RenamePreset(currentSlotData?.PresetName);
	}

	public virtual void RenamePreset(string presetName)
	{
		if (currentSlotData != null && !currentSlotData.IsCurrent)
		{
			RenameCurrentSlotOnServer(presetName);
		}
	}

	public virtual void DeletePreset()
	{
		if (currentSlotData != null && !currentSlotData.IsCurrent)
		{
			DeleteCurrentSlotOnServer();
		}
	}

	public virtual void EditPreset()
	{
		if (currentSlotData != null)
		{
			OpenEditWindow(0);
		}
	}

	protected virtual string NormalizePresetName(string presetName)
	{
		return NormalizePresetName(presetName, currentSlotData);
	}

	protected virtual string NormalizePresetName(string presetName, ArmourPresetSlotData slotData)
	{
		string text = (string.IsNullOrWhiteSpace(presetName) ? string.Empty : presetName.Trim());
		if (!string.IsNullOrEmpty(text))
		{
			return text;
		}
		return ArmourPresetSlotData.GetDefaultName(slotData?.SlotId ?? 0);
	}

	public static bool IsValidPresetName(string presetName)
	{
		if (string.IsNullOrEmpty(presetName) || presetName.Length > 6)
		{
			return false;
		}
		for (int i = 0; i < presetName.Length; i++)
		{
			if (!IsValidPresetNameChar(presetName[i]))
			{
				return false;
			}
		}
		return true;
	}

	public static bool IsValidPresetNameChar(char c)
	{
		if ((c < '0' || c > '9') && (c < 'a' || c > 'z') && (c < 'A' || c > 'Z'))
		{
			if (c >= '一')
			{
				return c <= '鿿';
			}
			return false;
		}
		return true;
	}

	protected virtual async void SaveCurrentSlotToServer()
	{
		if (currentSlotData == null)
		{
			return;
		}
		Loading loading = await Loading.Show();
		try
		{
			ArmourPresetSlotData armourPresetSlotData = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().SetPresetEquipment(heroModel?.Id ?? 0, currentSlotData);
			if (armourPresetSlotData != null)
			{
				currentSlotData.ReplaceWith(armourPresetSlotData);
				RefreshAllTabTexts();
				RefreshCurrentData();
			}
		}
		finally
		{
			loading.Dispose();
		}
	}

	protected virtual async void ApplyCurrentSlotToHero()
	{
		if (currentSlotData == null || currentSlotData.IsCurrent)
		{
			return;
		}
		List<ArmourPresetConflictData> localPresetConflicts = GetLocalPresetConflicts();
		pendingApplyOriginalEquipments = GetHeroEquipmentsSnapshot(heroModel);
		if (localPresetConflicts.Count > 0)
		{
			ArmourPresetApplyViewModel context = new ArmourPresetApplyViewModel(this, heroModel?.Id ?? 0, currentSlotData.SlotId, localPresetConflicts);
			showApplyViewRequest.Raise(context);
			return;
		}
		Loading loading = await Loading.Show();
		try
		{
			ArmourPresetApplyResultData armourPresetApplyResultData = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().ApplyPresetEquipment(heroModel?.Id ?? 0, currentSlotData.SlotId);
			if (armourPresetApplyResultData == null)
			{
				pendingApplyOriginalEquipments = null;
			}
			else if (armourPresetApplyResultData.HasConflicts)
			{
				ArmourPresetApplyViewModel context2 = new ArmourPresetApplyViewModel(this, heroModel?.Id ?? 0, currentSlotData.SlotId, armourPresetApplyResultData.Conflicts);
				showApplyViewRequest.Raise(context2);
			}
			else
			{
				OnPresetApplySucceeded();
			}
		}
		finally
		{
			loading.Dispose();
		}
	}

	private List<ArmourPresetConflictData> GetLocalPresetConflicts()
	{
		List<ArmourPresetConflictData> list = new List<ArmourPresetConflictData>();
		if (currentSlotData == null)
		{
			return list;
		}
		Dictionary<long, int> dictionary = Singleton<ServiceSystem>.Instance.GetService<IHeroService>()?.GetHeroHeldEquip();
		if (dictionary == null)
		{
			return list;
		}
		foreach (KeyValuePair<int, long> item in currentSlotData.EquipmentUidsByPosition)
		{
			if (item.Value > 0 && dictionary.TryGetValue(item.Value, out var value) && value != 0 && value != (heroModel?.Id ?? 0))
			{
				int thingType = ((item.Key == 5) ? 16 : 2);
				list.Add(new ArmourPresetConflictData(thingType, item.Key, item.Value, value));
			}
		}
		return list;
	}

	protected virtual async void RenameCurrentSlotOnServer(string presetName)
	{
		if (currentSlotData == null || currentSlotData.IsCurrent)
		{
			return;
		}
		Loading loading = await Loading.Show();
		try
		{
			string presetName2 = NormalizePresetName(presetName);
			ArmourPresetSlotData armourPresetSlotData = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().RenamePresetEquipment(heroModel?.Id ?? 0, currentSlotData, presetName2);
			if (armourPresetSlotData != null)
			{
				currentSlotData.ReplaceWith(armourPresetSlotData);
				RefreshAllTabTexts();
				RefreshCurrentData();
			}
		}
		finally
		{
			loading.Dispose();
		}
	}

	protected virtual async void DeleteCurrentSlotOnServer()
	{
		if (currentSlotData == null || currentSlotData.IsCurrent)
		{
			return;
		}
		Loading loading = await Loading.Show();
		try
		{
			ArmourPresetSlotData armourPresetSlotData = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().DeletePresetEquipment(heroModel?.Id ?? 0, currentSlotData.SlotId);
			if (armourPresetSlotData != null)
			{
				currentSlotData.ReplaceWith(armourPresetSlotData);
				RefreshAllTabTexts();
				SelectCurrentTab();
			}
		}
		finally
		{
			loading.Dispose();
		}
	}

	private void SelectCurrentTab()
	{
		if (tabItems.Count > 0)
		{
			SetTabSelected(tabItems[0]);
		}
	}

	public void CloseApplyView()
	{
		hideApplyViewRequest.Raise();
		pendingApplyOriginalEquipments = null;
		SyncCurrentSlotFromHero();
		RefreshCurrentData();
	}

	public void OnPresetApplySucceeded()
	{
		appliedPreset = true;
		hideApplyViewRequest.Raise();
		ApplyCurrentPresetToHeroModel();
		SyncCurrentSlotFromHero();
		RefreshCurrentData();
		Close();
		Toast.ShowInfo("应用成功");
	}

	private void ApplyCurrentPresetToHeroModel()
	{
		if (heroModel != null && currentSlotData != null && !currentSlotData.IsCurrent)
		{
			IHeroService service = Singleton<ServiceSystem>.Instance.GetService<IHeroService>();
			Dictionary<int, ArmourData> originalEquipments = pendingApplyOriginalEquipments ?? GetHeroEquipmentsSnapshot(heroModel);
			SwapPresetEquipmentsWithOtherHeroes(service, originalEquipments);
			for (int i = 0; i < 6; i++)
			{
				ArmourData equipment = currentSlotData.GetEquipment(i);
				EquipmentEnum equipType = ((i == 5) ? EquipmentEnum.SuitBox : EquipmentEnum.Armour);
				heroModel.SetEquipment(equipment, equipType, (ArmourEnum)i);
			}
			service?.RefreshHeroHeldEquipment(heroModel);
			pendingApplyOriginalEquipments = null;
		}
	}

	private Dictionary<int, ArmourData> GetHeroEquipmentsSnapshot(HeroModel sourceHero)
	{
		Dictionary<int, ArmourData> dictionary = new Dictionary<int, ArmourData>();
		if (sourceHero?.Armours == null)
		{
			return dictionary;
		}
		for (int i = 0; i < 6; i++)
		{
			sourceHero.Armours.TryGetValue(i, out var value);
			dictionary[i] = value;
		}
		return dictionary;
	}

	private void SwapPresetEquipmentsWithOtherHeroes(IHeroService heroService, Dictionary<int, ArmourData> originalEquipments)
	{
		if (heroService == null || currentSlotData == null || heroModel == null)
		{
			return;
		}
		HashSet<long> hashSet = new HashSet<long>(currentSlotData.EquipmentUidsByPosition.Values);
		if (hashSet.Count <= 0)
		{
			return;
		}
		Dictionary<int, HeroModel> allHeroData = heroService.GetAllHeroData();
		if (allHeroData == null)
		{
			return;
		}
		foreach (HeroModel value3 in allHeroData.Values)
		{
			if (value3 == null || value3.Id == heroModel.Id)
			{
				continue;
			}
			bool flag = false;
			for (int i = 0; i < 6; i++)
			{
				if (value3.Armours.TryGetValue(i, out var value) && value != null && hashSet.Contains(value.Uid))
				{
					EquipmentEnum equipType = ((i == 5) ? EquipmentEnum.SuitBox : EquipmentEnum.Armour);
					originalEquipments.TryGetValue(i, out var value2);
					value3.SetEquipment(value2, equipType, (ArmourEnum)i);
					flag = true;
				}
			}
			if (flag)
			{
				heroService.RefreshHeroHeldEquipment(value3);
			}
		}
	}

	private void SyncCurrentSlotFromHero()
	{
		((tabItems.Count > 0) ? tabItems[0].SlotData : null)?.ReplaceWith(ArmourPresetSlotData.CreateCurrent(heroModel));
	}
}
