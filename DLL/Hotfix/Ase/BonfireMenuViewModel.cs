using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public class BonfireMenuViewModel : OptionBase
{
	private int levelId;

	private int selfHeroId;

	private List<PeripheryHeroData> teamHeroModels;

	private TabItemData curTabItemData;

	private bool openWindowEnable = true;

	public Action<BonfireRestViewModel> OnFinish;

	public BonfireMenuViewModel()
	{
	}

	public BonfireMenuViewModel(OptionBase parent, int levelId, int selfHeroId, List<PeripheryHeroData> teamHeroModels)
	{
		base.parent = parent;
		this.levelId = levelId;
		this.selfHeroId = selfHeroId;
		this.teamHeroModels = teamHeroModels;
	}

	private void OpenBattleReadyWindow()
	{
		openWindowEnable = false;
		BattleReadyData readyData = new BattleReadyData(BattleReadyTarget.Level, levelId);
		BattleReadyViewModel battleReadyVm = new BattleReadyViewModel(this, readyData);
		openWindowRequest.Raise(new OpenViewArg(typeof(BattleReadyWindow), battleReadyVm), delegate
		{
			ClearSelected();
			openWindowEnable = true;
			List<TeamMember> list = battleReadyVm.TeamData();
			List<PeripheryHeroData> list2 = new List<PeripheryHeroData>();
			for (int i = 0; i < list.Count; i++)
			{
				list2.Add(list[i].GetPeripheryHeroData());
			}
			Rest(list2);
		});
	}

	private void OpenHeroWarehouseWindow()
	{
		openWindowEnable = false;
		Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(selfHeroId);
		openWindowRequest.Raise(new OpenViewArg(typeof(HeroWarehouseWindow), new HeroWarehouseViewModel(this)), delegate
		{
			ClearSelected();
			openWindowEnable = true;
			Rest(teamHeroModels);
		});
	}

	private async void OpenBonfireRestWindow(BonfireRestViewModel vm)
	{
		openWindowRequest.Raise(new OpenViewArg(typeof(BonfireRestWindow), vm));
	}

	public void GamePause()
	{
		parent?.ItemOnClick(ProcessOperationEnum.GamePause);
	}

	public void GameResume()
	{
		parent?.ItemOnClick(ProcessOperationEnum.GameResume);
	}

	public override void Close()
	{
		GameResume();
		base.Close();
	}

	private async void Rest(List<PeripheryHeroData> heroConfigIdList = null)
	{
		if (Singleton<OuterSystem>.Instance == null)
		{
			return;
		}
		if (heroConfigIdList != null)
		{
			for (int i = 0; i < heroConfigIdList.Count; i++)
			{
				PeripheryHeroData peripheryHeroData = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroConfigIdList[i].Id, emptyCreateNew: true, saveNew: false).GetPeripheryHeroData(0L);
				heroConfigIdList[i] = peripheryHeroData;
			}
		}
		BonfireRestViewModel restVm = new BonfireRestViewModel(curTabItemData.TabIndex, heroConfigIdList);
		OpenBonfireRestWindow(restVm);
		await UniTask.WaitForSeconds(0.8f);
		OnFinish?.Invoke(restVm);
		Close();
	}

	private void ClearSelected()
	{
		if (curTabItemData != null)
		{
			curTabItemData.IsSelected = false;
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabItemData)
		{
			if (openWindowEnable)
			{
				ClearSelected();
				curTabItemData = tabItemData;
				curTabItemData.IsSelected = true;
				switch (curTabItemData.TabIndex)
				{
				case 0:
					Rest();
					break;
				case 1:
					OpenBattleReadyWindow();
					break;
				case 2:
					OpenHeroWarehouseWindow();
					break;
				case 3:
					Close();
					OnFinish?.Invoke(null);
					break;
				}
			}
		}
		else if (obj is BattleReadyViewModel battleReadyViewModel)
		{
			battleReadyViewModel.Close();
		}
	}
}
