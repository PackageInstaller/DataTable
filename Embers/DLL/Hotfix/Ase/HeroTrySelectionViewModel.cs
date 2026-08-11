using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HeroTrySelectionViewModel : HeroSelectionViewModel
{
	private DRTeamSet teamSet;

	private List<HeroItemViewModel> heroTryList;

	private List<HeroItemViewModel> otherHeroList;

	public HeroTrySelectionViewModel(OptionBase parent, int teamSetId)
	{
		base.parent = parent;
		detailCommand = new SimpleCommand(OpenHeroCultureWindow);
		heroTryList = new List<HeroItemViewModel>();
		otherHeroList = new List<HeroItemViewModel>();
		teamSet = GameEntry.DataTable.GetDataRow<DRTeamSet>(teamSetId);
		if (teamSet != null)
		{
			for (int i = 0; i < teamSet.TryHero.Count; i++)
			{
				HeroModel heroModel = null;
				DRPresetHeroData dataRow = GameEntry.DataTable.GetDataRow<DRPresetHeroData>(teamSet.TryHero[i]);
				if (dataRow != null)
				{
					WeaponData weaponData = WeaponData.CreateWeaponData(dataRow.Weapon);
					weaponData.SetLevel(weaponData, dataRow.WeaponLv, dataRow.WeaponLv / 20, dataRow.WeaponRefine);
					heroModel = HeroModel.CreateByPreset(dataRow, weaponData);
					HeroItemViewModel heroItemViewModel = new HeroItemViewModel(this, heroModel);
					heroItemViewModel.SetHeroTryTag(teamSet.Lock.Count > i && teamSet.Lock[i] == 1 && teamSet.Pos.Count > i && teamSet.Pos[i] != 0, heroTryTag: true);
					allHeroViewModels.Add(teamSet.TryHero[i], heroItemViewModel);
					heroItemViewModel.SetHeroTryId(teamSet.TryHero[i], teamSetId, i);
					heroTryList.Add(heroItemViewModel);
				}
			}
		}
		foreach (HeroModel value in Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetAllHeroData().Values)
		{
			if (teamSet.AvailableHero == null || teamSet.AvailableHero.Count == 0 || (teamSet.AvailableHero != null && teamSet.AvailableHero.Contains(value.Id)))
			{
				allHeroViewModels.Add(value.Id, new HeroItemViewModel(this, value));
				otherHeroList.Add(allHeroViewModels[value.Id]);
			}
		}
		showHeroViewModels = new List<HeroItemViewModel>();
		otherHeroList.Sort(new HeroSortByLevel());
		for (int j = 0; j < heroTryList.Count; j++)
		{
			showHeroViewModels.Add(heroTryList[j]);
		}
		for (int k = 0; k < otherHeroList.Count; k++)
		{
			showHeroViewModels.Add(otherHeroList[k]);
		}
		screenResultViewModels = otherHeroList;
		_screenPanelViewModel = new HeroScreenPanelViewModel(this, screenResultViewModels);
	}

	public override void OnBattleReadyOpen(List<BattleReadySeatViewModel> seatViewModels, BattleReadySeatViewModel parentSelected, int parentSeatId)
	{
		result.Clear();
		base.parentSeatId = parentSeatId;
		if (parentSelected != null && !parentSelected.Empty)
		{
			base.parentSelected = allHeroViewModels[parentSelected.HeroTryId];
		}
		else
		{
			base.parentSelected = null;
		}
		for (int i = 1; i <= 3; i++)
		{
			result.Add(i, null);
		}
		foreach (BattleReadySeatViewModel seatViewModel in seatViewModels)
		{
			if (seatViewModel != null && !seatViewModel.Empty)
			{
				allHeroViewModels[seatViewModel.HeroTryId].SetSeatId(seatViewModel.SeatId);
				result[seatViewModel.SeatId] = allHeroViewModels[seatViewModel.HeroTryId];
			}
		}
		if (result[parentSeatId] != null)
		{
			SetShowHeroCurrent(result[parentSeatId]);
		}
		AfterScreenHero();
	}

	protected override void AfterScreenHero()
	{
		showHeroViewModels.Clear();
		for (int i = 0; i < heroTryList.Count; i++)
		{
			showHeroViewModels.Add(heroTryList[i]);
		}
		List<HeroItemViewModel> list = new List<HeroItemViewModel>();
		foreach (KeyValuePair<int, HeroItemViewModel> item in result)
		{
			if (item.Value != null)
			{
				list.Add(item.Value);
			}
		}
		foreach (HeroItemViewModel item2 in list)
		{
			for (int num = screenResultViewModels.Count - 1; num >= 0; num--)
			{
				if (screenResultViewModels[num] == item2)
				{
					screenResultViewModels.RemoveAt(num);
					break;
				}
			}
		}
		for (int num2 = list.Count - 1; num2 >= 0; num2--)
		{
			for (int j = 0; j < showHeroViewModels.Count; j++)
			{
				if (list[num2] == showHeroViewModels[j])
				{
					list.RemoveAt(num2);
					break;
				}
			}
		}
		showHeroViewModels.AddRange(list);
		showHeroViewModels.AddRange(screenResultViewModels);
		int targetHeroId = ((curSelectedVM == null) ? showHeroViewModels[0].HeroModel.Id : curSelectedVM.HeroModel.Id);
		HeroItemViewModel showHeroCurrent = showHeroViewModels.Find((HeroItemViewModel p) => p.HeroModel.Id == targetHeroId);
		SetShowHeroCurrent(showHeroCurrent);
		_refreshHeroListRst.Raise();
	}

	protected override void OpenHeroCultureWindow()
	{
		if (curSelectedVM.HeroTryTag)
		{
			Toast.ShowInfo("试玩烬天使无法养成");
		}
		else
		{
			base.OpenHeroCultureWindow();
		}
	}

	public override void OnFuncBtnClick()
	{
		if (curSelectedVM.SeatLockTag)
		{
			Toast.ShowInfo("无法调整锁定烬天使");
			return;
		}
		switch (btnType)
		{
		case SelectHeroEnum.Add:
			foreach (KeyValuePair<int, HeroItemViewModel> item in result)
			{
				if (item.Value != null && curSelectedVM != item.Value && curSelectedVM.HeroModel.Id == item.Value.HeroModel.Id)
				{
					Toast.ShowInfo("无法选择重复烬天使");
					return;
				}
			}
			if (curSelectedVM.SeatId != -1)
			{
				result[curSelectedVM.SeatId] = null;
			}
			curSelectedVM.SetSeatId(parentSeatId);
			result[parentSeatId] = curSelectedVM;
			break;
		case SelectHeroEnum.Change:
		{
			foreach (KeyValuePair<int, HeroItemViewModel> item2 in result)
			{
				if (curSelectedVM != item2.Value && curSelectedVM.HeroModel.Id == item2.Value.HeroModel.Id && parentSelected.HeroModel.Id != curSelectedVM.HeroModel.Id)
				{
					Toast.ShowInfo("无法选择重复烬天使");
					return;
				}
			}
			if (entryType == 1)
			{
				result[1] = curSelectedVM;
				break;
			}
			int seatId = curSelectedVM.SeatId;
			curSelectedVM.SetSeatId(parentSeatId);
			result[parentSeatId] = curSelectedVM;
			parentSelected.SetSeatId(seatId);
			if (seatId != -1)
			{
				result[seatId] = parentSelected;
			}
			break;
		}
		case SelectHeroEnum.Remove:
			curSelectedVM.SetSeatId(-1);
			result[parentSeatId] = null;
			break;
		}
		Close();
	}
}
