using System;
using System.Collections.Generic;
using System.Linq;
using GameFramework.Runtime;

namespace Ase;

public class HeroScreenPanelViewModel : OptionBase
{
	public Dictionary<int, string> SortTypeEnum = new Dictionary<int, string>
	{
		[1] = "等级排序",
		[2] = "稀有度排序",
		[3] = "元素排序"
	};

	private List<HeroItemViewModel> _allHeroItemViewModels = new List<HeroItemViewModel>();

	private List<HeroItemViewModel> _heroItemViewModels = new List<HeroItemViewModel>();

	private int curSortType = 1;

	private string curSortName;

	public HeroAttributeEnum[] HeroAttributeEnums;

	public WeaponEnum[] WeaponEnums;

	private Dictionary<WeaponEnum, WeaponEnum> _weaponEnumSelectedDic;

	private Dictionary<HeroAttributeEnum, HeroAttributeEnum> _attributeEnumSelectedDic;

	private List<HeroWarehouseSortButtonViewModel> _selectedSortData = new List<HeroWarehouseSortButtonViewModel>();

	private bool _clearBtnCanClick;

	private bool isShowScreenResult;

	private InteractionRequest _refreshSortRequest = new InteractionRequest();

	private InteractionRequest _refreshSelectedRequest = new InteractionRequest();

	private InteractionRequest _closeScreenRequest = new InteractionRequest();

	public int CurSortType
	{
		get
		{
			return curSortType;
		}
		set
		{
			Set(ref curSortType, value, "CurSortType");
			CurSortName = SortTypeEnum[curSortType];
		}
	}

	public bool IsShowScreenResult
	{
		get
		{
			return isShowScreenResult;
		}
		set
		{
			Set(ref isShowScreenResult, value, "IsShowScreenResult");
		}
	}

	public string CurSortName
	{
		get
		{
			return curSortName;
		}
		set
		{
			Set(ref curSortName, value, "CurSortName");
		}
	}

	public bool ClearBtnCanClick
	{
		get
		{
			return _clearBtnCanClick;
		}
		set
		{
			Set(ref _clearBtnCanClick, value, "ClearBtnCanClick");
		}
	}

	public List<HeroWarehouseSortButtonViewModel> SelectedSortData
	{
		get
		{
			return _selectedSortData;
		}
		private set
		{
			Set(ref _selectedSortData, value, "SelectedSortData");
		}
	}

	public Dictionary<WeaponEnum, WeaponEnum> WeaponEnumSelectedDic
	{
		get
		{
			return _weaponEnumSelectedDic;
		}
		set
		{
			Set(ref _weaponEnumSelectedDic, value, "WeaponEnumSelectedDic");
		}
	}

	public Dictionary<HeroAttributeEnum, HeroAttributeEnum> AttributeEnumSelectedDic
	{
		get
		{
			return _attributeEnumSelectedDic;
		}
		set
		{
			Set(ref _attributeEnumSelectedDic, value, "AttributeEnumSelectedDic");
		}
	}

	public InteractionRequest RefreshSortRequest => _refreshSortRequest;

	public InteractionRequest RefreshSelectedRequest => _refreshSelectedRequest;

	public InteractionRequest CloseScreenRequest => _closeScreenRequest;

	public HeroScreenPanelViewModel()
	{
	}

	public HeroScreenPanelViewModel(OptionBase parent, List<HeroItemViewModel> heroItemViewModels)
	{
		base.parent = parent;
		SetHeroItemDatas(heroItemViewModels);
		_attributeEnumSelectedDic = new Dictionary<HeroAttributeEnum, HeroAttributeEnum>();
		_weaponEnumSelectedDic = new Dictionary<WeaponEnum, WeaponEnum>();
		HeroAttributeEnums = (HeroAttributeEnum[])Enum.GetValues(typeof(HeroAttributeEnum));
		WeaponEnums = (WeaponEnum[])Enum.GetValues(typeof(WeaponEnum));
	}

	public void SetHeroItemDatas(List<HeroItemViewModel> heroItemViewModels)
	{
		_allHeroItemViewModels.Clear();
		_allHeroItemViewModels.AddRange(heroItemViewModels);
		_heroItemViewModels = heroItemViewModels;
	}

	public void SortHeroModels()
	{
		_heroItemViewModels.Reverse();
		OnHeroListChanged();
	}

	public void RefreshSortHeroModels()
	{
		RefreshSortHeroModels(CurSortType);
	}

	private void RefreshSortHeroModels(int index)
	{
		switch (index)
		{
		case 1:
			_heroItemViewModels.Sort(new HeroSortByLevel());
			break;
		case 2:
			_heroItemViewModels.Sort(new HeroSortByRarity());
			break;
		case 3:
			_heroItemViewModels.Sort(new HeroSortByAttribute());
			break;
		}
		OnHeroListChanged();
	}

	private void OnHeroListChanged()
	{
		_refreshSortRequest.Raise();
		parent?.ItemOnClick(_heroItemViewModels);
	}

	public void RefreshScreeningHeroModels()
	{
		bool flag = false;
		bool flag2 = false;
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		if (WeaponEnumSelectedDic.Count == 0)
		{
			flag = true;
			WeaponEnum[] weaponEnums = WeaponEnums;
			foreach (WeaponEnum weaponEnum in weaponEnums)
			{
				WeaponEnumSelectedDic.Add(weaponEnum, weaponEnum);
			}
		}
		if (AttributeEnumSelectedDic.Count == 0)
		{
			flag2 = true;
			HeroAttributeEnum[] heroAttributeEnums = HeroAttributeEnums;
			foreach (HeroAttributeEnum heroAttributeEnum in heroAttributeEnums)
			{
				AttributeEnumSelectedDic.Add(heroAttributeEnum, heroAttributeEnum);
			}
		}
		for (int j = 0; j < _allHeroItemViewModels.Count; j++)
		{
			if (WeaponEnumSelectedDic.ContainsKey(_allHeroItemViewModels[j].HeroModel.Weapon))
			{
				list2.Add(_allHeroItemViewModels[j].HeroModel.Id);
			}
			if (AttributeEnumSelectedDic.ContainsKey(_allHeroItemViewModels[j].HeroModel.Attribute))
			{
				list.Add(_allHeroItemViewModels[j].HeroModel.Id);
			}
		}
		List<int> list3 = list2.Intersect(list).ToList();
		if (flag)
		{
			WeaponEnumSelectedDic.Clear();
		}
		if (flag2)
		{
			AttributeEnumSelectedDic.Clear();
		}
		if (list3.Count == 0)
		{
			Toast.ShowInfo("未拥有满足筛选条件的角色");
			IsShowScreenResult = false;
			return;
		}
		_heroItemViewModels.Clear();
		foreach (int heroId in list3)
		{
			_heroItemViewModels.Add(_allHeroItemViewModels.Find((HeroItemViewModel p) => p.HeroModel.Id.Equals(heroId)));
		}
		if (SelectedSortData.Count > 0 && list3.Count > 0)
		{
			IsShowScreenResult = true;
		}
		else
		{
			IsShowScreenResult = false;
		}
		if (SelectedSortData.Count == 0)
		{
			_heroItemViewModels.Clear();
			_heroItemViewModels.AddRange(_allHeroItemViewModels);
			ClearBtnCanClick = false;
		}
		RefreshSortHeroModels(CurSortType);
		_closeScreenRequest.Raise();
		parent?.ItemOnClick(this);
	}

	public void ClearSelectedHeroModels()
	{
		foreach (HeroWarehouseSortButtonViewModel selectedSortDatum in SelectedSortData)
		{
			SortButtonDelete(selectedSortDatum);
		}
		SelectedSortData.Clear();
		ClearBtnCanClick = false;
		_refreshSelectedRequest.Raise();
	}

	private void SortButtonAdd(HeroWarehouseSortButtonViewModel viewModel)
	{
		viewModel.IsSelected = true;
		switch (viewModel.Type)
		{
		case 1:
			AttributeEnumSelectedDic.Add(viewModel.HeroAttributeEnum, viewModel.HeroAttributeEnum);
			break;
		case 2:
			WeaponEnumSelectedDic.Add(viewModel.WeaponEnumType, viewModel.WeaponEnumType);
			break;
		}
	}

	private void SortButtonDelete(HeroWarehouseSortButtonViewModel viewModel)
	{
		viewModel.IsSelected = false;
		switch (viewModel.Type)
		{
		case 1:
			AttributeEnumSelectedDic.Remove(viewModel.HeroAttributeEnum);
			break;
		case 2:
			WeaponEnumSelectedDic.Remove(viewModel.WeaponEnumType);
			break;
		}
	}

	private bool SortButtonCheck(HeroWarehouseSortButtonViewModel data1, HeroWarehouseSortButtonViewModel data2)
	{
		if (data1.Type != data2.Type)
		{
			return false;
		}
		return data2.Type switch
		{
			1 => data1.HeroAttributeEnum == data2.HeroAttributeEnum, 
			2 => data1.WeaponEnumType == data2.WeaponEnumType, 
			_ => false, 
		};
	}

	private void SortButtonOnClick(HeroWarehouseSortButtonViewModel viewModel)
	{
		bool flag = true;
		if (SelectedSortData.Count > 0)
		{
			for (int i = 0; i < SelectedSortData.Count; i++)
			{
				if (SortButtonCheck(SelectedSortData[i], viewModel))
				{
					SortButtonDelete(viewModel);
					SelectedSortData.RemoveAt(i);
					flag = false;
					break;
				}
			}
		}
		if (flag)
		{
			SelectedSortData.Add(viewModel);
			viewModel.IsSelected = true;
			SortButtonAdd(viewModel);
		}
		if (SelectedSortData.Count > 3)
		{
			SortButtonDelete(SelectedSortData[0]);
			SelectedSortData.RemoveAt(0);
		}
		if (SelectedSortData.Count > 0)
		{
			ClearBtnCanClick = true;
		}
		else
		{
			ClearBtnCanClick = false;
		}
		_refreshSelectedRequest.Raise();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is int index)
		{
			CurSortType = index;
			RefreshSortHeroModels(index);
		}
		else if (obj is HeroWarehouseSortButtonViewModel viewModel)
		{
			SortButtonOnClick(viewModel);
		}
	}
}
