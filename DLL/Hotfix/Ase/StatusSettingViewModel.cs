using System.Collections.Generic;
using System.Collections.Specialized;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class StatusSettingViewModel : OptionBase
{
	public class StatusBattleSnapshot
	{
		public ObservableList<BuffItemViewModel> LiveBuffList;

		public Dictionary<string, double> PropertyValues { get; } = new Dictionary<string, double>();

		public List<BuffItemViewModel> BuffList { get; } = new List<BuffItemViewModel>();

		public double GetPropertyValue(string key)
		{
			if (PropertyValues != null && PropertyValues.TryGetValue(key, out var value))
			{
				return value;
			}
			return 0.0;
		}
	}

	public class StatusHeroSnapshot
	{
		public int HeroId;

		public string HeroSkinSuffix;

		public WeaponEnum Weapon;

		public HeroAttributeEnum Attribute;

		public int DestinyLevel;

		public HeroModel HeroModel;

		public EntryData MainEntry;

		public Dictionary<string, double> OuterProperties { get; } = new Dictionary<string, double>();

		public List<EntryData> EntryList { get; } = new List<EntryData>();

		public double GetOuterProperty(string key)
		{
			if (OuterProperties != null && OuterProperties.TryGetValue(key, out var value))
			{
				return value;
			}
			return 0.0;
		}
	}

	public class TabItemViewModel : SelectItemViewModel
	{
		public string OptName { get; }

		public TabItemViewModel(OptionBase parent, string optName)
			: base(parent)
		{
			OptName = optName;
		}
	}

	private readonly List<StatusAttrItemViewModel> attrItems = new List<StatusAttrItemViewModel>();

	private readonly InteractionRequest<OptionArg> optRequest = new InteractionRequest<OptionArg>();

	private readonly List<CopyTeamItemViewModel> heroList = new List<CopyTeamItemViewModel>();

	private readonly Dictionary<int, StatusHeroSnapshot> heroDict = new Dictionary<int, StatusHeroSnapshot>();

	private readonly Dictionary<int, StatusBattleSnapshot> battleDict = new Dictionary<int, StatusBattleSnapshot>();

	private readonly List<StatusBuffItemViewModel> buffItems = new List<StatusBuffItemViewModel>();

	private readonly List<EntryLevelItemData> entryItems = new List<EntryLevelItemData>();

	private EntryInfoViewModel entryInfoViewModel;

	private EntryLevelItem selectedEntryLevelItem;

	private TabItemViewModel attrTabVm;

	private TabItemViewModel buffTabVm;

	private string heroName;

	private bool enableRealtimeBuff;

	private ObservableList<BuffItemViewModel> currentLiveBuffList;

	public IReadOnlyList<StatusAttrItemViewModel> AttrItems => attrItems;

	public IInteractionRequest OptRequest => optRequest;

	public IReadOnlyList<CopyTeamItemViewModel> TeamItemList => heroList;

	public IReadOnlyList<StatusBuffItemViewModel> BuffItems => buffItems;

	public IReadOnlyList<EntryLevelItemData> EntryItems => entryItems;

	public TabItemViewModel AttrTabVm => attrTabVm;

	public TabItemViewModel BuffTabVm => buffTabVm;

	public EntryInfoViewModel EntryInfoViewModel => entryInfoViewModel;

	public string HeroName
	{
		get
		{
			return heroName;
		}
		private set
		{
			Set(ref heroName, value, "HeroName");
		}
	}

	public StatusSettingViewModel()
	{
	}

	public StatusSettingViewModel(OptionBase parent)
	{
		base.parent = parent;
		InitTabsIfNeed();
		InitEmptyData();
		entryInfoViewModel = new EntryInfoViewModel(this);
	}

	public void SetRealtimeBuffEnabled(bool enabled)
	{
		enableRealtimeBuff = enabled;
		if (!enabled)
		{
			UnbindLiveBuffList();
		}
	}

	public void TickBuffRealtime()
	{
		if (enableRealtimeBuff && buffTabVm != null && buffTabVm.IsSelect)
		{
			for (int i = 0; i < buffItems.Count; i++)
			{
				buffItems[i]?.Update();
			}
		}
	}

	private void InitEmptyData()
	{
		attrItems.Clear();
		buffItems.Clear();
		entryItems.Clear();
		heroList.Clear();
	}

	public void InitTabsIfNeed()
	{
		if (attrTabVm == null || buffTabVm == null)
		{
			attrTabVm = new TabItemViewModel(this, "ShowAttr");
			buffTabVm = new TabItemViewModel(this, "ShowBuff");
			attrTabVm.SetSelect(isSelect: true);
			buffTabVm.SetSelect(isSelect: false);
		}
	}

	public void SetHeroes(List<StatusHeroSnapshot> heroes, Dictionary<int, StatusBattleSnapshot> battleDataMap)
	{
		UnbindLiveBuffList();
		heroList.Clear();
		heroDict.Clear();
		battleDict.Clear();
		buffItems.Clear();
		entryItems.Clear();
		if (heroes != null)
		{
			for (int num = heroes.Count - 1; num >= 0; num--)
			{
				StatusHeroSnapshot statusHeroSnapshot = heroes[num];
				if (statusHeroSnapshot != null)
				{
					heroDict[statusHeroSnapshot.HeroId] = statusHeroSnapshot;
					heroList.Add(new CopyTeamItemViewModel(this, new HeroSkinBind
					{
						heroId = statusHeroSnapshot.HeroId,
						heroSkinSuffix = statusHeroSnapshot.HeroSkinSuffix,
						skinConfigId = statusHeroSnapshot.HeroModel.SkinConfigId
					}));
				}
			}
		}
		if (battleDataMap != null)
		{
			foreach (KeyValuePair<int, StatusBattleSnapshot> item in battleDataMap)
			{
				if (item.Value != null)
				{
					battleDict[item.Key] = item.Value;
				}
			}
		}
		if (heroList.Count > 0)
		{
			SelectHero(heroList[heroList.Count - 1]);
		}
		optRequest.Raise(new OptionArg(this, "ResetScroll"));
		optRequest.Raise(new OptionArg(this, "RefreshHero"));
		optRequest.Raise(new OptionArg(this, "RefreshBuff"));
		optRequest.Raise(new OptionArg(this, "RefreshEntry"));
	}

	public void Refresh(StatusBattleSnapshot battleData, StatusHeroSnapshot heroSnap, IList<BuffItemViewModel> buffList = null)
	{
		attrItems.Clear();
		buffItems.Clear();
		if (battleData == null || heroSnap == null)
		{
			optRequest.Raise(new OptionArg(this, "RefreshAttr"));
			return;
		}
		int num = 0;
		attrItems.Add(StatusAttrItemViewModel.CreateBasic("职业", GetWeaponDisplayName(heroSnap.Weapon), GetWeaponIconName(heroSnap.Weapon), num++));
		attrItems.Add(StatusAttrItemViewModel.CreateBasic("属性", GetAttributeDisplayName(heroSnap.Attribute), GetAttributeIconName(heroSnap.Attribute), num++));
		attrItems.Add(StatusAttrItemViewModel.CreateBasic("冠级", heroSnap.DestinyLevel.ToString(), GetDestinyIconName(heroSnap.DestinyLevel), num++));
		AddProp(battleData, heroSnap, "Hp", "生命");
		AddProp(battleData, heroSnap, "Defence", "防御");
		AddProp(battleData, heroSnap, "Attack", "攻击");
		AddPropPercent(battleData, heroSnap, "Crit", "暴击率");
		AddPropPercentPlusOne(battleData, heroSnap, "CritRadio", "暴击伤害");
		AddProp(battleData, heroSnap, "Energy", "能量上限");
		AddPropPercent(battleData, heroSnap, "LightDamageRadio", string.Empty);
		AddPropPercent(battleData, heroSnap, "DarkDamageRadio", string.Empty);
		AddPropPercent(battleData, heroSnap, "WaterDamageRadio", string.Empty);
		AddPropPercent(battleData, heroSnap, "FireDamageRadio", string.Empty);
		AddPropPercent(battleData, heroSnap, "WindDamageRadio", string.Empty);
		AddPropPercent(battleData, heroSnap, "IceDamageRadio", string.Empty);
		AddPropPercent(battleData, heroSnap, "ThunderDamageRadio", string.Empty);
		optRequest.Raise(new OptionArg(this, "RefreshAttr"));
		IList<BuffItemViewModel> list = buffList;
		if (list == null)
		{
			list = battleData?.LiveBuffList;
		}
		if (list == null)
		{
			list = battleData?.BuffList;
		}
		BuildBuffItems(list);
		optRequest.Raise(new OptionArg(this, "RefreshBuff"));
		BuildEntryItems(heroSnap);
		optRequest.Raise(new OptionArg(this, "RefreshEntry"));
		optRequest.Raise(new OptionArg(this, "ResetScroll"));
	}

	private void BuildBuffItems(IList<BuffItemViewModel> sourceBuffList)
	{
		Dictionary<Buff, bool> dictionary = new Dictionary<Buff, bool>();
		for (int i = 0; i < buffItems.Count; i++)
		{
			StatusBuffItemViewModel statusBuffItemViewModel = buffItems[i];
			if (statusBuffItemViewModel?.Buff != null && !dictionary.ContainsKey(statusBuffItemViewModel.Buff))
			{
				dictionary[statusBuffItemViewModel.Buff] = statusBuffItemViewModel.IsExpand;
			}
		}
		buffItems.Clear();
		if (sourceBuffList == null)
		{
			return;
		}
		for (int j = 0; j < sourceBuffList.Count; j++)
		{
			BuffItemViewModel buffItemViewModel = sourceBuffList[j];
			if (buffItemViewModel != null && buffItemViewModel.Buff != null)
			{
				StatusBuffItemViewModel statusBuffItemViewModel2 = new StatusBuffItemViewModel(buffItemViewModel.Buff, j, this);
				if (dictionary.TryGetValue(buffItemViewModel.Buff, out var value))
				{
					statusBuffItemViewModel2.SetExpand(value);
				}
				buffItems.Add(statusBuffItemViewModel2);
			}
		}
	}

	private void BindLiveBuffList(StatusBattleSnapshot battleData)
	{
		UnbindLiveBuffList();
		if (enableRealtimeBuff && battleData?.LiveBuffList != null)
		{
			currentLiveBuffList = battleData.LiveBuffList;
			currentLiveBuffList.CollectionChanged += OnLiveBuffListChanged;
		}
	}

	private void UnbindLiveBuffList()
	{
		if (currentLiveBuffList != null)
		{
			currentLiveBuffList.CollectionChanged -= OnLiveBuffListChanged;
			currentLiveBuffList = null;
		}
	}

	private void OnLiveBuffListChanged(object sender, NotifyCollectionChangedEventArgs e)
	{
		BuildBuffItems(currentLiveBuffList);
		optRequest.Raise(new OptionArg(this, "RefreshBuff"));
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is CopyTeamItemViewModel copyTeamItemViewModel)
		{
			if (!copyTeamItemViewModel.IsSelect)
			{
				SelectHero(copyTeamItemViewModel);
			}
		}
		else if (obj is TabItemViewModel tabItemViewModel)
		{
			attrTabVm?.SetSelect(tabItemViewModel == attrTabVm);
			buffTabVm?.SetSelect(tabItemViewModel == buffTabVm);
			optRequest.Raise(new OptionArg(this, tabItemViewModel.OptName));
		}
		else if (obj is StatusBuffItemViewModel)
		{
			optRequest.Raise(new OptionArg(this, "RefreshBuff"));
		}
		else
		{
			if (!(obj is OptionArg optionArg))
			{
				return;
			}
			if (optionArg.OptionName.Equals("OpenEntryPanelLevel"))
			{
				if (selectedEntryLevelItem != null)
				{
					selectedEntryLevelItem.SetSelected(selected: false);
				}
				selectedEntryLevelItem = (EntryLevelItem)optionArg.Obj;
				selectedEntryLevelItem.SetSelected(selected: true);
				ShowEntryDetail(selectedEntryLevelItem);
			}
			else if (optionArg.Obj is EntryInfoViewModel && optionArg.OptionName.Equals("HideEntryPanelLevel"))
			{
				if (selectedEntryLevelItem != null)
				{
					selectedEntryLevelItem.SetSelected(selected: false);
				}
				optRequest.Raise(new OptionArg(this, "HideEntryDetail"));
			}
		}
	}

	private void ShowEntryDetail(EntryLevelItem entryLevelItem)
	{
		if (!(entryLevelItem == null) && entryLevelItem.viewModel != null)
		{
			EntryItemData entryItemData = new EntryItemData(entryLevelItem.viewModel.EntryData);
			entryItemData.IsMainEntry = !entryLevelItem.viewModel.ShowLevel;
			entryInfoViewModel.RefreshData(entryItemData);
			optRequest.Raise(new OptionArg(entryItemData, "ShowEntryDetail"));
		}
	}

	private void SelectHero(CopyTeamItemViewModel heroItem)
	{
		for (int i = 0; i < heroList.Count; i++)
		{
			if (heroList[i].IsSelect && heroList[i] != heroItem)
			{
				heroList[i].SetSelect(isSelect: false);
			}
		}
		heroItem.SetSelect(isSelect: true);
		heroDict.TryGetValue(heroItem.HeroId, out var value);
		battleDict.TryGetValue(heroItem.HeroId, out var value2);
		BindLiveBuffList(value2);
		IList<BuffItemViewModel> list = value2?.LiveBuffList;
		if (list == null)
		{
			list = value2?.BuffList;
		}
		SetHeroName(value);
		BuildEntryItems(value);
		optRequest.Raise(new OptionArg(this, "RefreshEntry"));
		Refresh(value2, value, list);
		if (buffTabVm != null && buffTabVm.IsSelect)
		{
			optRequest.Raise(new OptionArg(this, "ShowBuff"));
		}
		else
		{
			optRequest.Raise(new OptionArg(this, "ShowAttr"));
		}
	}

	private void SetHeroName(StatusHeroSnapshot heroSnap)
	{
		if (heroSnap == null)
		{
			HeroName = string.Empty;
			return;
		}
		HeroModel heroModel = heroSnap.HeroModel;
		HeroName = ((heroModel != null) ? heroModel.Name : string.Empty);
	}

	private void AddProp(StatusBattleSnapshot battleData, StatusHeroSnapshot heroSnap, string key, string name)
	{
		string propertyDisplayName = GetPropertyDisplayName(key, name);
		double num = GetOuterPropertyFromService(heroSnap, key);
		switch (key)
		{
		case "Hp":
		case "Defence":
		case "Attack":
			num = Mathf.Ceil((float)num);
			break;
		}
		double num2 = (battleData?.GetPropertyValue(key) ?? 0.0) - num;
		string outerDisplayValue = NumericalExtension.GetOuterDisplayValue(num);
		string delta = FormatDelta(num2, isPercent: false);
		string propertyIconName = GetPropertyIconName(key);
		attrItems.Add(new StatusAttrItemViewModel(propertyDisplayName, outerDisplayValue, delta, num2, propertyIconName, attrItems.Count));
	}

	private void AddPropPercent(StatusBattleSnapshot battleData, StatusHeroSnapshot heroSnap, string key, string name)
	{
		string propertyDisplayName = GetPropertyDisplayName(key, name);
		double outerPropertyFromService = GetOuterPropertyFromService(heroSnap, key);
		double num = (battleData?.GetPropertyValue(key) ?? 0.0) - outerPropertyFromService;
		string outerDisplayPercentValue = NumericalExtension.GetOuterDisplayPercentValue(outerPropertyFromService);
		string delta = FormatDelta(num, isPercent: true);
		string propertyIconName = GetPropertyIconName(key);
		attrItems.Add(new StatusAttrItemViewModel(propertyDisplayName, outerDisplayPercentValue, delta, num, propertyIconName, attrItems.Count));
	}

	private void AddPropPercentPlusOne(StatusBattleSnapshot battleData, StatusHeroSnapshot heroSnap, string key, string name)
	{
		string propertyDisplayName = GetPropertyDisplayName(key, name);
		double num = GetOuterPropertyFromService(heroSnap, key) + 1.0;
		double num2 = (battleData?.GetPropertyValue(key) ?? 0.0) + 1.0 - num;
		string outerDisplayPercentValue = NumericalExtension.GetOuterDisplayPercentValue(num);
		string delta = FormatDelta(num2, isPercent: true);
		string propertyIconName = GetPropertyIconName(key);
		attrItems.Add(new StatusAttrItemViewModel(propertyDisplayName, outerDisplayPercentValue, delta, num2, propertyIconName, attrItems.Count));
	}

	private string GetPropertyDisplayName(string key, string fallback)
	{
		DRPropertyKeyName dataRow = GameEntry.DataTable.GetDataRow((DRPropertyKeyName p) => p.PropertyKey.Equals(key));
		if (dataRow != null)
		{
			if (!string.IsNullOrEmpty(dataRow.PropertyName2))
			{
				return dataRow.PropertyName2;
			}
			if (!string.IsNullOrEmpty(dataRow.PropertyName))
			{
				return dataRow.PropertyName;
			}
		}
		DRAffix dataRow2 = GameEntry.DataTable.GetDataRow((DRAffix p) => p.AffixKey.Equals(key));
		if (dataRow2 != null && !string.IsNullOrEmpty(dataRow2.Desc))
		{
			return dataRow2.Desc;
		}
		if (!string.IsNullOrEmpty(fallback))
		{
			return fallback;
		}
		return key;
	}

	private double GetOuterPropertyFromService(StatusHeroSnapshot heroSnap, string key)
	{
		if (heroSnap == null || string.IsNullOrEmpty(key))
		{
			return 0.0;
		}
		HeroModel heroModel = heroSnap.HeroModel;
		if (heroModel != null)
		{
			NumericalProperty totalProperty = heroModel.TotalProperty;
			if (totalProperty != null)
			{
				return totalProperty.GetTotalProperty(key);
			}
		}
		return heroSnap.GetOuterProperty(key);
	}

	private string GetPropertyIconName(string key)
	{
		if (string.IsNullOrEmpty(key))
		{
			return string.Empty;
		}
		DRAffix dataRow = GameEntry.DataTable.GetDataRow((DRAffix p) => p.AffixKey.Equals(key));
		if (dataRow != null)
		{
			return dataRow.Icon.ToString();
		}
		return string.Empty;
	}

	private string GetWeaponIconName(WeaponEnum weapon)
	{
		return $"Icon_{weapon}";
	}

	private string GetAttributeIconName(HeroAttributeEnum attribute)
	{
		return $"hero_attr_{(int)attribute}";
	}

	private string GetDestinyIconName(int destinyLevel)
	{
		return $"Hero_Seat_{Mathf.Max(1, destinyLevel)}";
	}

	private string GetWeaponDisplayName(WeaponEnum weapon)
	{
		if (UiConvert.Equip.WeaponEnum2Name.TryGetValue(weapon, out var value))
		{
			return value;
		}
		return weapon.ToString();
	}

	private string GetAttributeDisplayName(HeroAttributeEnum attribute)
	{
		if (UiConvert.Hero.Attribute2Name.TryGetValue(attribute, out var value))
		{
			return value;
		}
		return attribute.ToString();
	}

	private void BuildEntryItems(StatusHeroSnapshot heroSnap)
	{
		entryItems.Clear();
		if (heroSnap == null)
		{
			return;
		}
		HeroModel heroModel = heroSnap.HeroModel;
		if (heroModel == null)
		{
			return;
		}
		heroModel.Armours.TryGetValue(5, out var value);
		EntryData entryData = null;
		if (value != null && value.EntryDataList != null && value.EntryDataList.Count > 0)
		{
			entryData = NormalizeEntryData(value.EntryDataList[0]);
		}
		int num = entryData?.DrEntry.EntryId ?? 0;
		if (num != 0)
		{
			EntryLevelItemData item = new EntryLevelItemData(this, entryData, entryData.CurLevel, showLevel: false);
			entryItems.Add(item);
		}
		List<EntryData> allEntry = heroModel.GetAllEntry();
		if (allEntry == null)
		{
			return;
		}
		foreach (EntryData item3 in allEntry)
		{
			EntryData entryData2 = NormalizeEntryData(item3);
			if (entryData2 != null && entryData2.DrEntry.EntryId != num)
			{
				EntryLevelItemData item2 = new EntryLevelItemData(this, entryData2, entryData2.CurLevel);
				entryItems.Add(item2);
			}
		}
		entryItems.Sort(delegate(EntryLevelItemData x, EntryLevelItemData y)
		{
			if (x.ShowLevel.CompareTo(y.ShowLevel) != 0)
			{
				return x.ShowLevel.CompareTo(y.ShowLevel);
			}
			if (x.EntryData.IsSpecial.CompareTo(y.EntryData.IsSpecial) != 0)
			{
				return y.EntryData.IsSpecial.CompareTo(x.EntryData.IsSpecial);
			}
			return (x.IsMax.CompareTo(y.IsMax) != 0) ? y.IsMax.CompareTo(x.IsMax) : y.CurLevel.CompareTo(x.CurLevel);
		});
	}

	private EntryData NormalizeEntryData(EntryData entry)
	{
		if (entry == null || entry.DrEntry == null)
		{
			return entry;
		}
		return new EntryData(entry.DrEntry.EntryId, entry.CurLevel);
	}

	private string FormatDelta(double delta, bool isPercent)
	{
		if (Mathf.Approximately((float)delta, 0f))
		{
			if (!isPercent)
			{
				return "+0";
			}
			return "+0%";
		}
		string text = ((delta > 0.0) ? "+" : string.Empty);
		if (isPercent)
		{
			return text + NumericalExtension.GetOuterDisplayPercentValue(delta);
		}
		return text + NumericalExtension.GetOuterDisplayValue(delta);
	}

	protected override void Dispose(bool disposing)
	{
		UnbindLiveBuffList();
		base.Dispose(disposing);
	}
}
