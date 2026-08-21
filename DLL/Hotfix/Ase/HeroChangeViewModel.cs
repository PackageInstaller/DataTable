using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HeroChangeViewModel : OptionBase
{
	private SimpleCommand _confirmCmd;

	private SimpleCommand openCultureCmd;

	private HeroItemViewModel _checkHero;

	private int _checkHeroIndex;

	private HeroItemViewModel _selectedHero;

	private List<HeroItemViewModel> _heroItemViewModels = new List<HeroItemViewModel>();

	private HeroScreenPanelViewModel _screenPanelViewModel;

	private InteractionRequest _refreshSelectionRequest;

	private InteractionRequest _refreshSortRequest;

	private List<int> _teamHeroId;

	private string assetTag;

	private bool isLevelFix;

	public HeroItemViewModel CheckHero => _checkHero;

	public bool IsLevelFix
	{
		get
		{
			return isLevelFix;
		}
		private set
		{
			Set(ref isLevelFix, value, "IsLevelFix");
		}
	}

	public SimpleCommand ConfirmCmd => _confirmCmd;

	public HeroItemViewModel SelectedHero => _selectedHero;

	public int CheckHeroIndex => _checkHeroIndex;

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

	public InteractionRequest RefreshSortRequest => _refreshSortRequest;

	public InteractionRequest RefreshSelectionRequest => _refreshSelectionRequest;

	public SimpleCommand OpenCultureCmd => openCultureCmd;

	public string AssetTag => assetTag;

	public HeroChangeViewModel(OptionBase parent, int heroId, int selfIndex, bool isCap, string assetTag = "")
	{
		base.parent = parent;
		_confirmCmd = new SimpleCommand(ConfirmHero);
		openCultureCmd = new SimpleCommand(OpenHeroCultureWindow);
		_refreshSortRequest = new InteractionRequest();
		_refreshSelectionRequest = new InteractionRequest();
		this.assetTag = assetTag;
		foreach (HeroModel item in Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetAllHeroData().Values.ToList())
		{
			HeroItemViewModel heroItemViewModel = new HeroItemViewModel(this, item);
			heroItemViewModel.SetIdentity(selfIndex, isCap);
			_heroItemViewModels.Add(heroItemViewModel);
		}
		_screenPanelViewModel = new HeroScreenPanelViewModel(this, _heroItemViewModels);
		for (int i = 0; i < _heroItemViewModels.Count; i++)
		{
			if (_heroItemViewModels[i].HeroModel.Id == heroId)
			{
				RefreshSelectedHero(_heroItemViewModels[i]);
				RefreshCheckHero(_heroItemViewModels[i]);
				break;
			}
		}
	}

	public void SetLevelFix(int level)
	{
		IsLevelFix = true;
		for (int i = 0; i < _heroItemViewModels.Count; i++)
		{
			_heroItemViewModels[i].SetLevelFix(level);
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is HeroItemViewModel itemViewModel)
		{
			RefreshSelectedHero(itemViewModel);
		}
		else if (obj is List<HeroItemViewModel>)
		{
			_refreshSortRequest.Raise();
		}
		else if (obj is HeroScreenPanelViewModel)
		{
			AfterHeroScreen();
		}
		else if (obj is HeroCultivateViewModel heroCultivateViewModel)
		{
			if (_checkHero.HeroModel.Id == heroCultivateViewModel.HeroModel.Id)
			{
				SendUpdateHeroInfo(_checkHero.HeroModel.Id);
			}
			RefreshHero();
		}
	}

	private async void SendUpdateHeroInfo(int heroId)
	{
		await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().TeamRoomChangeSelectRole(heroId);
	}

	private void AfterHeroScreen()
	{
		HeroItemViewModel itemViewModel = _heroItemViewModels.Find((HeroItemViewModel p) => p.HeroModel.Id == SelectedHero.HeroModel.Id) ?? _heroItemViewModels[0];
		RefreshSelectedHero(itemViewModel);
	}

	private void RefreshSelectedHero(HeroItemViewModel itemViewModel)
	{
		if (_selectedHero == null || _selectedHero != itemViewModel)
		{
			if (_selectedHero != null)
			{
				_selectedHero.SetSelected(value: false);
			}
			_selectedHero = itemViewModel;
			_selectedHero.SetSelected(value: true);
			_refreshSelectionRequest.Raise();
		}
	}

	private void RefreshCheckHero(HeroItemViewModel itemViewModel)
	{
		if (_checkHero != null && _checkHero == itemViewModel)
		{
			return;
		}
		if (_checkHero != null)
		{
			_checkHero.SetChecked(value: false);
			_checkHero.SetSeatId(0);
		}
		_checkHero = itemViewModel;
		_checkHero.SetChecked(value: true);
		_checkHero.SetSeatId(1);
		for (int i = 0; i < _heroItemViewModels.Count; i++)
		{
			if (_heroItemViewModels[i].HeroModel.Id == _checkHero.HeroModel.Id)
			{
				_checkHeroIndex = i;
			}
		}
	}

	private void ConfirmHero()
	{
		_confirmCmd.Enabled = false;
		SendSettingRoom();
		_confirmCmd.Enabled = true;
	}

	private void OpenHeroCultureWindow()
	{
		openCultureCmd.Enabled = false;
		HeroCultivateViewModel heroCultivateViewModel = new HeroCultivateViewModel(this, _selectedHero.HeroModel, 1, changeHeroEnable: false);
		heroCultivateViewModel.SetMultiEnter(isMultiEnter: true);
		openWindowRequest.Raise(new OpenViewArg(typeof(HeroCultivateWindow), heroCultivateViewModel), delegate
		{
			openCultureCmd.Enabled = true;
		});
	}

	private void RefreshHero()
	{
		parent?.ItemOnClick(new OptionArg(this, "Skin"));
		_refreshSelectionRequest.Raise();
	}

	public override void Close()
	{
		parent?.ItemOnClick(new OptionArg(this, "Close"));
		base.Close();
	}

	private void SendSettingRoom()
	{
		if (SelectedHero.HeroModel.Id == CheckHero.HeroModel.Id)
		{
			Close();
		}
		parent?.ItemOnClick(new OptionArg(this, "Change"));
	}
}
