#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class HeroWarehouseViewModel : OptionBase
{
	private List<HeroItemViewModel> _heroItemViewModels = new List<HeroItemViewModel>();

	private InteractionRequest _refreshHeroListRst = new InteractionRequest();

	private InteractionRequest _playAnimatorRequest = new InteractionRequest();

	private SimpleCommand<HeroModel> openCultivateWindowCmd;

	private HeroScreenPanelViewModel _screenPanelViewModel;

	public List<HeroItemViewModel> HeroItemViewModels
	{
		get
		{
			return _heroItemViewModels;
		}
		private set
		{
			Set(ref value, _heroItemViewModels, "HeroItemViewModels");
		}
	}

	public HeroScreenPanelViewModel ScreenPanelViewModel => _screenPanelViewModel;

	public InteractionRequest RefreshHeroListRst => _refreshHeroListRst;

	public InteractionRequest PlayAnimatorRequest => _playAnimatorRequest;

	public HeroWarehouseViewModel()
	{
	}

	public HeroWarehouseViewModel(OptionBase parent)
	{
		base.parent = parent;
		openCultivateWindowCmd = new SimpleCommand<HeroModel>(OpenCultivateWindow);
		_screenPanelViewModel = new HeroScreenPanelViewModel(this, _heroItemViewModels);
		SyncWithServerData();
	}

	private void SyncWithServerData()
	{
		_heroItemViewModels.Clear();
		foreach (HeroModel item in Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetAllHeroData().Values.ToList())
		{
			_heroItemViewModels.Add(new HeroItemViewModel(this, item));
		}
		_heroItemViewModels.Sort(new HeroSortByLevel());
		_screenPanelViewModel.SetHeroItemDatas(_heroItemViewModels);
		_refreshHeroListRst.Raise();
	}

	private async void OpenCultivateWindow(HeroModel heroModel)
	{
		try
		{
			if (openCultivateWindowCmd != null)
			{
				openCultivateWindowCmd.Enabled = false;
			}
			_playAnimatorRequest?.Raise();
			HeroCultivateViewModel userData = new HeroCultivateViewModel(this, heroModel);
			await GameEntry.UI.OpenWindow<HeroCultivateWindow>("Hero/HeroCultivateWindow", userData);
			_screenPanelViewModel.ClearSelectedHeroModels();
			_screenPanelViewModel.RefreshScreeningHeroModels();
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is HeroItemViewModel heroItemViewModel)
		{
			openCultivateWindowCmd.Execute(heroItemViewModel.HeroModel);
		}
		else if (obj is HeroCultivateViewModel)
		{
			SyncWithServerData();
			openCultivateWindowCmd.Enabled = true;
		}
		else if (obj is List<HeroItemViewModel>)
		{
			_refreshHeroListRst.Raise();
		}
		if (obj is OptionArg optionArg && "OnMulti".Equals(optionArg.OptionName))
		{
			parent.ItemOnClick(optionArg);
		}
	}
}
