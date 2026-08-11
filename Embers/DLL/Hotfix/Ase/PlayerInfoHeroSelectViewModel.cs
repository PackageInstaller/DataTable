using System.Collections.Generic;
using System.Linq;
using GameFramework.Runtime;

namespace Ase;

public class PlayerInfoHeroSelectViewModel : OptionBase
{
	private InteractionRequest updateListRequest;

	private SimpleCommand<string> optCommand;

	private Dictionary<int, int> selectIds;

	private List<HeroItemViewModel> heroItemViewModels = new List<HeroItemViewModel>();

	public List<HeroItemViewModel> HeroItemViewModels
	{
		get
		{
			return heroItemViewModels;
		}
		private set
		{
			Set(ref value, heroItemViewModels, "HeroItemViewModels");
		}
	}

	public Dictionary<int, int> SelectIds => selectIds;

	public IInteractionRequest UpdateListRequest => updateListRequest;

	public ICommand OptCommand => optCommand;

	public override void ItemOnClick(object obj)
	{
		if (obj is HeroItemViewModel heroItemViewModel)
		{
			CheckSelectHeroItem(heroItemViewModel);
		}
	}

	public PlayerInfoHeroSelectViewModel()
	{
	}

	public PlayerInfoHeroSelectViewModel(OptionBase parent)
	{
		base.parent = parent;
		updateListRequest = new InteractionRequest();
		optCommand = new SimpleCommand<string>(OnOpt);
		selectIds = new Dictionary<int, int>();
		foreach (HeroModel item in Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetAllHeroData().Values.ToList())
		{
			heroItemViewModels.Add(new HeroItemViewModel(this, item));
		}
	}

	private void CheckSelectHeroItem(HeroItemViewModel heroItemViewModel)
	{
		if (heroItemViewModel.IsSelected)
		{
			heroItemViewModel.SetSelected(value: false);
			for (int i = 0; i < selectIds.Count; i++)
			{
				if (selectIds[i + 1] == heroItemViewModel.HeroModel.Id)
				{
					selectIds[i + 1] = 0;
				}
			}
		}
		else if (!heroItemViewModel.IsSelected && CheckDictionaryInfo())
		{
			int selectHeroIndex = 0;
			for (int j = 0; j < selectIds.Count; j++)
			{
				if (selectIds[j + 1] == 0)
				{
					selectIds[j + 1] = heroItemViewModel.HeroModel.Id;
					selectHeroIndex = j + 1;
					break;
				}
			}
			heroItemViewModel.SetSelected(value: true);
			heroItemViewModel.SetSelectHeroIndex(selectHeroIndex);
		}
		else if (selectIds.Count >= 3)
		{
			Toast.ShowInfo("展示角色已达上限!");
		}
	}

	private bool CheckDictionaryInfo()
	{
		if (selectIds.Count < 3)
		{
			int num = ((selectIds.Count > 0) ? selectIds.Keys.Max() : 0);
			while (selectIds.Count < 3)
			{
				num++;
				selectIds[num] = 0;
			}
		}
		for (int i = 0; i < selectIds.Count; i++)
		{
			if (selectIds[i + 1] == 0)
			{
				return true;
			}
		}
		return false;
	}

	private void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		if ("OnShow".Equals(optName))
		{
			OnShow();
		}
		optCommand.Enabled = true;
	}

	private void OnShow()
	{
		foreach (HeroItemViewModel heroItemViewModel in heroItemViewModels)
		{
			heroItemViewModel.SetChecked(heroItemViewModel.IsSelected);
		}
		heroItemViewModels.Sort(new HeroSortByLevelByCheck());
		ReorderHeroList();
		optCommand.Enabled = false;
		parent.ItemOnClick(new OptionArg(this, "OnShowHeroes"));
		Close();
	}

	public void OnOpen(List<int> selectIds, int selectId = 0)
	{
		this.selectIds.Clear();
		for (int i = 0; i < selectIds.Count; i++)
		{
			this.selectIds[i + 1] = selectIds[i];
		}
		foreach (HeroItemViewModel heroItemViewModel in heroItemViewModels)
		{
			bool flag = false;
			for (int j = 0; j < selectIds.Count; j++)
			{
				if (heroItemViewModel.HeroModel.Id != selectIds[j])
				{
					continue;
				}
				heroItemViewModel.SetChecked(value: true);
				heroItemViewModel.SetSelected(value: true);
				int num = -1;
				foreach (KeyValuePair<int, int> selectId2 in this.selectIds)
				{
					if (selectId2.Value == heroItemViewModel.HeroModel.Id)
					{
						num = selectId2.Key;
						break;
					}
				}
				if (num != -1)
				{
					heroItemViewModel.SetSelectHeroIndex(num);
				}
				flag = true;
			}
			if (!flag)
			{
				heroItemViewModel.SetChecked(value: false);
				heroItemViewModel.SetSelected(value: false);
			}
		}
		heroItemViewModels.Sort(new HeroSortByLevelByCheck());
		ReorderHeroList();
	}

	public override void Close()
	{
		selectIds.Clear();
		foreach (HeroItemViewModel heroItemViewModel in heroItemViewModels)
		{
			if (heroItemViewModel.IsChecked)
			{
				int key = selectIds.Count + 1;
				selectIds[key] = heroItemViewModel.HeroModel.Id;
			}
			heroItemViewModel.SetSelected(heroItemViewModel.IsChecked);
		}
		base.IsVisible = false;
	}

	public void Refresh()
	{
		if (selectIds.Count > 0)
		{
			heroItemViewModels.Sort(new HeroSortByLevelByCheck());
			ReorderHeroList();
			{
				foreach (int item in selectIds.Keys)
				{
					heroItemViewModels.Find((HeroItemViewModel x) => x.HeroModel.Id == selectIds[item])?.SetSelectHeroIndex(item);
				}
				return;
			}
		}
		foreach (HeroItemViewModel heroItemViewModel in heroItemViewModels)
		{
			heroItemViewModel.SetSelected(heroItemViewModel.IsChecked);
			if (heroItemViewModel.IsChecked)
			{
				int key = selectIds.Count + 1;
				selectIds[key] = heroItemViewModel.HeroModel.Id;
			}
		}
		heroItemViewModels.Sort(new HeroSortByLevelByCheck());
	}

	public void RefreshSelectAchiDic()
	{
		List<int> list = new List<int>();
		foreach (int value in selectIds.Values)
		{
			if (value != 0)
			{
				list.Add(value);
			}
		}
		for (int i = 0; i < 4; i++)
		{
			if (i < list.Count)
			{
				selectIds[i + 1] = list[i];
			}
			else
			{
				selectIds[i + 1] = 0;
			}
		}
	}

	public void EnableOpt()
	{
		optCommand.Enabled = true;
	}

	private void ReorderHeroList()
	{
		List<HeroItemViewModel> list = new List<HeroItemViewModel>();
		foreach (int item in selectIds.Keys.OrderBy((int k) => k).ToList())
		{
			int heroId = selectIds[item];
			if (heroId != 0)
			{
				HeroItemViewModel heroItemViewModel = heroItemViewModels.FirstOrDefault((HeroItemViewModel h) => h.HeroModel.Id == heroId);
				if (heroItemViewModel != null)
				{
					list.Add(heroItemViewModel);
				}
			}
		}
		foreach (HeroItemViewModel heroItem in heroItemViewModels)
		{
			if ((!selectIds.ContainsValue(heroItem.HeroModel.Id) || (selectIds.ContainsValue(heroItem.HeroModel.Id) && selectIds.First((KeyValuePair<int, int> kvp) => kvp.Value == heroItem.HeroModel.Id).Value == 0)) && !list.Contains(heroItem))
			{
				list.Add(heroItem);
			}
		}
		heroItemViewModels.Clear();
		heroItemViewModels.AddRange(list);
	}
}
