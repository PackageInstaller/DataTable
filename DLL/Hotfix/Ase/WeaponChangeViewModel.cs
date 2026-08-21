using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class WeaponChangeViewModel : OptionBase
{
	private IHeroService heroService;

	private HeroModel heroModel;

	private Dictionary<long, WeaponItemData> weaponDatas;

	private Dictionary<long, int> heroHeldEquip;

	private List<WeaponItemData> _weaponShowList;

	private WeaponItemData _curItemData;

	private WeaponItemData _heroWeaponItemData;

	private WeaponDetailViewModel _weaponDetailViewModel;

	private InteractionRequest refreshShowDatasRequest;

	private InteractionRequest _weaponShowRequest;

	private InteractionRequest _changeWeaponRequest;

	private InteractionRequest<EntryItem> _showEntryDetailRequest;

	public Dictionary<int, string> SortTypeEnum = new Dictionary<int, string>
	{
		[1] = "稀有度排序",
		[2] = "等级排序"
	};

	private int curSortType = 1;

	private string curSortName;

	private bool isEmpty;

	public WeaponItemData CurItemData => _curItemData;

	public WeaponDetailViewModel WeaponDetailViewModel => _weaponDetailViewModel;

	public InteractionRequest RefreshShowDatasRequest => refreshShowDatasRequest;

	public InteractionRequest WeaponShowRequest => _weaponShowRequest;

	public InteractionRequest<EntryItem> ShowEntryDetailRequest => _showEntryDetailRequest;

	public InteractionRequest ChangeWeaponRequest => _changeWeaponRequest;

	public List<WeaponItemData> WeaponShowList
	{
		get
		{
			return _weaponShowList;
		}
		private set
		{
			Set(ref _weaponShowList, value, "WeaponShowList");
		}
	}

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

	public WeaponChangeViewModel()
	{
	}

	public WeaponChangeViewModel(OptionBase parent, HeroModel heroModel)
	{
		base.parent = parent;
		this.heroModel = heroModel;
		refreshShowDatasRequest = new InteractionRequest();
		_weaponShowRequest = new InteractionRequest();
		_showEntryDetailRequest = new InteractionRequest<EntryItem>();
		_changeWeaponRequest = new InteractionRequest();
		_weaponShowList = new List<WeaponItemData>();
		heroService = Singleton<ServiceSystem>.Instance.GetService<IHeroService>();
		heroHeldEquip = heroService.GetHeroHeldEquip();
		weaponDatas = new Dictionary<long, WeaponItemData>();
		SetWeaponShowList();
		_weaponDetailViewModel = new WeaponDetailViewModel(this, heroModel.HeldWeapon);
		_weaponDetailViewModel.LeftBtnText = "替换";
		_weaponDetailViewModel.RightBtnText = "强化";
		WeaponItemOnClick(_heroWeaponItemData);
		RefreshSortWeapon(1);
		_weaponDetailViewModel.SetHeroImg(heroModel.Id);
	}

	public override void Close()
	{
		parent?.ItemOnClick(this);
		base.Close();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is WeaponItemData itemData)
		{
			WeaponItemOnClick(itemData);
		}
		else if (obj is WeaponDetailViewModel weaponDetailViewModel)
		{
			if (weaponDetailViewModel.ActionName.Equals("ChangeWeapon"))
			{
				ChangeEquipment();
			}
			else if (weaponDetailViewModel.ActionName.Equals("OpenCulture"))
			{
				OpenCultureWindow();
			}
		}
		else if (obj is WeaponCultureViewModel)
		{
			SetWeaponShowList();
			RefreshSortWeapon(CurSortType);
			if (weaponDatas.ContainsKey(_curItemData.Data.Uid))
			{
				WeaponItemOnClick(weaponDatas[_curItemData.Data.Uid], needCheck: false);
			}
		}
		else if (obj is int index)
		{
			CurSortType = index;
			RefreshSortWeapon(index);
		}
		else if (obj is KnapsackItemViewModel)
		{
			parent?.ItemOnClick(obj);
		}
		else if (obj is OptionArg optionArg && optionArg.OptionName.Equals("OnShowEntryPanel"))
		{
			ShowEntryDetail((EntryItem)optionArg.Obj);
		}
		if (obj is OptionArg optionArg2 && "OnMulti".Equals(optionArg2.OptionName))
		{
			parent.ItemOnClick(optionArg2);
		}
		else
		{
			_weaponShowRequest.Raise();
		}
	}

	private async void OpenCultureWindow()
	{
		WeaponCultureViewModel vm = new WeaponCultureViewModel(this, CurItemData.Data);
		await GameEntry.UI.OpenWindow<WeaponCultureWindow>("Equipment/WeaponCultureWindow", vm);
		vm.OpenCulturePanel();
		_weaponDetailViewModel.ResetRightCmd();
	}

	private void RefreshSortWeapon(int index)
	{
		switch (index)
		{
		case 1:
			WeaponShowList.Sort(new EquipmentSortByRarity());
			break;
		case 2:
			WeaponShowList.Sort(new EquipmentSortByLevel());
			break;
		}
		refreshShowDatasRequest.Raise();
	}

	public void SortWeaponReverse()
	{
		WeaponShowList.Reverse();
		refreshShowDatasRequest.Raise();
	}

	private void ShowEntryDetail(EntryItem entryItem)
	{
		entryItem.ViewModel.SetSelect(isSelect: true);
		EntryItem entryItemByHero = GetEntryItemByHero(entryItem);
		_showEntryDetailRequest.Raise(entryItemByHero);
	}

	private EntryItem GetEntryItemByHero(EntryItem entryItem)
	{
		List<EntryData> allEntry = heroModel.GetAllEntry();
		entryItem.ViewModel.SetLevel(0);
		for (int i = 0; i < allEntry.Count; i++)
		{
			if (allEntry[i].DrEntry.EntryId == entryItem.ViewModel.EntryData.DrEntry.EntryId)
			{
				entryItem.ViewModel.SetLevel(allEntry[i].DrEntry.Level);
			}
		}
		return entryItem;
	}

	private void ChangeEquipment()
	{
		int ownerId = _curItemData.OwnerId;
		if (_curItemData.Data.Uid == heroModel.HeldWeapon.Uid)
		{
			return;
		}
		if (ownerId != 0)
		{
			DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(ownerId);
			if (dataRow == null)
			{
				return;
			}
			IAsyncResult<int> result = AlertDialog.Show("提示", "该武魂已被" + dataRow.Name + "所拥有,是否更换武魂?", "确认", "取消");
			result.Callbackable().OnCallback(delegate
			{
				if (result.Result == -1)
				{
					ChangeWeapon();
				}
				else
				{
					_weaponDetailViewModel.ResetLeftCmd();
				}
			});
		}
		else
		{
			ChangeWeapon();
		}
	}

	private async void ChangeWeapon()
	{
		int curEquipHeroId = _curItemData.OwnerId;
		long oldUid = heroModel.HeldWeapon.Uid;
		Loading loading = await Loading.Show();
		try
		{
			if (await heroService.HeroChangeEquip(heroModel.Id, _curItemData.Data, heroModel.HeldWeapon.Uid))
			{
				_weaponDetailViewModel.RefreshData(_curItemData.Data, isShowChange: false);
				weaponDatas[_curItemData.Data.Uid].ChangeHeldHeroId(heroModel.Id);
				weaponDatas[oldUid].ChangeHeldHeroId(curEquipHeroId);
				_weaponDetailViewModel.SetHeroImg(heroModel.Id);
				_changeWeaponRequest.Raise();
				await UniTask.Delay(200);
				_weaponDetailViewModel.ResetLeftCmd();
				loading.Dispose();
			}
			else
			{
				loading.Dispose();
				await UIHelper.AccountDisconnect();
			}
		}
		catch (Exception value)
		{
			loading.Dispose();
			Console.WriteLine(value);
			throw;
		}
	}

	private void WeaponItemOnClick(WeaponItemData itemData, bool needCheck = true)
	{
		if (itemData == null)
		{
			return;
		}
		if (_curItemData != null)
		{
			if (needCheck && _curItemData.Data?.Uid == itemData.Data?.Uid)
			{
				return;
			}
			_curItemData.IsSelected = false;
		}
		_curItemData = itemData;
		_curItemData.IsSelected = true;
		if (itemData.OwnerId == heroModel?.Id)
		{
			WeaponDetailViewModel?.RefreshData(itemData.Data, isShowChange: false);
		}
		else
		{
			WeaponDetailViewModel?.RefreshData(itemData.Data);
		}
		_weaponDetailViewModel.SetHeroImg(heroModel?.Id ?? 0);
	}

	private void SetWeaponShowList()
	{
		heroHeldEquip = heroService.GetHeroHeldEquip();
		WeaponShowList.Clear();
		weaponDatas.Clear();
		foreach (KeyValuePair<long, WeaponData> allWeaponDatum in Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetAllWeaponData())
		{
			int value = 0;
			heroHeldEquip.TryGetValue(allWeaponDatum.Key, out value);
			WeaponItemData weaponItemData = new WeaponItemData(this, allWeaponDatum.Value, value);
			weaponDatas.Add(weaponItemData.Data.Uid, weaponItemData);
		}
		foreach (KeyValuePair<long, WeaponItemData> weaponData in weaponDatas)
		{
			if (weaponData.Value.Data.WeaponEnum == heroModel.Weapon)
			{
				WeaponShowList.Add(weaponData.Value);
			}
			if (weaponData.Value.Data.Uid == heroModel.HeldWeapon.Uid)
			{
				_heroWeaponItemData = weaponData.Value;
			}
		}
	}
}
