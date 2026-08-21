using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine.Pool;

namespace Ase;

public class RandomBuffDisplayViewModel : OptionBase
{
	private List<RandomBuffDisplayItemViewModel> _buffDisplayItemViewModels = new List<RandomBuffDisplayItemViewModel>(6);

	private InteractionRequest refreshBuffRequest;

	private bool showDisplay;

	private Action<bool> gamePause;

	public List<RandomBuffDisplayItemViewModel> BuffDisplayItemViewModels => _buffDisplayItemViewModels;

	public IInteractionRequest RefreshBuffRequest => refreshBuffRequest;

	public bool ShowDisplay
	{
		get
		{
			return showDisplay;
		}
		set
		{
			Set(ref showDisplay, value, "ShowDisplay");
		}
	}

	public RandomBuffDisplayViewModel(List<int> buffIds, Action<bool> gamePauseAction)
	{
		gamePause = gamePauseAction;
		refreshBuffRequest = new InteractionRequest();
		AddBuff(buffIds);
	}

	public void RefreshBuff(List<int> buffIds)
	{
		_buffDisplayItemViewModels.Clear();
		AddBuff(buffIds);
		refreshBuffRequest.Raise();
	}

	public void ClickOpenBtn()
	{
		ShowDisplay = true;
		refreshBuffRequest.Raise();
		gamePause(obj: true);
	}

	public void ClickCloseBtn()
	{
		ShowDisplay = false;
		gamePause(obj: false);
	}

	private void AddBuff(List<int> buffIds)
	{
		if (buffIds == null)
		{
			return;
		}
		int num = 1;
		RandomBuffDisplayItemViewModel randomBuffDisplayItemViewModel = null;
		DRTowerBuffUp[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRTowerBuffUp>();
		int num2 = allDataRow.Length;
		_ = buffIds.Count;
		List<RandomBuffDisplayItemViewModel> list = CollectionPool<List<RandomBuffDisplayItemViewModel>, RandomBuffDisplayItemViewModel>.Get();
		List<RandomBuffDisplayItemViewModel> list2 = CollectionPool<List<RandomBuffDisplayItemViewModel>, RandomBuffDisplayItemViewModel>.Get();
		for (int i = 0; i < num2; i++)
		{
			DRTowerBuffUp dRTowerBuffUp = allDataRow[i];
			if (i != 0 && dRTowerBuffUp.Bufflv == 1 && randomBuffDisplayItemViewModel != null)
			{
				list.Add(randomBuffDisplayItemViewModel);
				randomBuffDisplayItemViewModel.CurMaxLv = true;
				list2.Remove(randomBuffDisplayItemViewModel);
				randomBuffDisplayItemViewModel = null;
				num = 1;
			}
			if (buffIds.Contains(dRTowerBuffUp.Id))
			{
				RandomBuffDisplayItemViewModel randomBuffDisplayItemViewModel2 = new RandomBuffDisplayItemViewModel(dRTowerBuffUp, this);
				list2.Add(randomBuffDisplayItemViewModel2);
				if (dRTowerBuffUp.Bufflv >= num)
				{
					randomBuffDisplayItemViewModel = randomBuffDisplayItemViewModel2;
					num = dRTowerBuffUp.Bufflv;
				}
			}
		}
		if (randomBuffDisplayItemViewModel != null)
		{
			list.Add(randomBuffDisplayItemViewModel);
			list2.Remove(randomBuffDisplayItemViewModel);
			randomBuffDisplayItemViewModel.CurMaxLv = true;
			randomBuffDisplayItemViewModel = null;
		}
		_buffDisplayItemViewModels.AddRange(list);
		_buffDisplayItemViewModels.AddRange(list2);
		CollectionPool<List<RandomBuffDisplayItemViewModel>, RandomBuffDisplayItemViewModel>.Release(list);
		CollectionPool<List<RandomBuffDisplayItemViewModel>, RandomBuffDisplayItemViewModel>.Release(list2);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is RandomBuffDisplayItemViewModel)
		{
			refreshBuffRequest.Raise();
		}
	}
}
