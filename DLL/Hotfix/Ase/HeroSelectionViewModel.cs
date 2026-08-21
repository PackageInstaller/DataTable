using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HeroSelectionViewModel : OptionBase
{
	public enum SelectHeroEnum
	{
		None,
		Add,
		Change,
		Remove
	}

	protected HeroItemViewModel curSelectedVM;

	private bool curSelected;

	protected HeroItemViewModel parentSelected;

	protected int parentSeatId;

	protected SimpleCommand detailCommand;

	protected InteractionRequest _refreshHeroListRst = new InteractionRequest();

	private InteractionRequest onShowHeroChangedRequest = new InteractionRequest();

	protected Dictionary<int, HeroItemViewModel> allHeroViewModels = new Dictionary<int, HeroItemViewModel>();

	protected List<HeroItemViewModel> showHeroViewModels = new List<HeroItemViewModel>();

	protected List<HeroItemViewModel> screenResultViewModels = new List<HeroItemViewModel>();

	protected Dictionary<int, HeroItemViewModel> result = new Dictionary<int, HeroItemViewModel>();

	protected HeroScreenPanelViewModel _screenPanelViewModel;

	protected int entryType;

	private string funcBtnText;

	protected SelectHeroEnum btnType;

	public int ParentSeatId => parentSeatId;

	public string FuncBtnText
	{
		get
		{
			return funcBtnText;
		}
		set
		{
			Set(ref funcBtnText, value, "FuncBtnText");
		}
	}

	public HeroScreenPanelViewModel ScreenPanelViewModel => _screenPanelViewModel;

	public Dictionary<int, HeroItemViewModel> Result => result;

	public HeroItemViewModel CurSelectedVM => curSelectedVM;

	public bool CurSelected
	{
		get
		{
			return curSelected;
		}
		set
		{
			Set(ref curSelected, value, "CurSelected");
		}
	}

	public List<HeroItemViewModel> ShowHeroViewModels => showHeroViewModels;

	public SimpleCommand DetailCommand => detailCommand;

	public InteractionRequest OnShowHeroChangedRequest => onShowHeroChangedRequest;

	public InteractionRequest RefreshHeroListRst => _refreshHeroListRst;

	public override void ItemOnClick(object obj)
	{
		if (obj is HeroItemViewModel showHeroCurrent)
		{
			SetShowHeroCurrent(showHeroCurrent);
		}
		else if (obj is List<HeroItemViewModel>)
		{
			AfterScreenHero();
		}
		else if (obj is HeroScreenPanelViewModel)
		{
			AfterScreenHero();
		}
	}

	public HeroSelectionViewModel()
	{
	}

	public HeroSelectionViewModel(OptionBase parent)
	{
		base.parent = parent;
		detailCommand = new SimpleCommand(OpenHeroCultureWindow);
		foreach (HeroModel value in Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetAllHeroData().Values)
		{
			allHeroViewModels.Add(value.Id, new HeroItemViewModel(this, value));
		}
		showHeroViewModels = allHeroViewModels.Values.ToList();
		screenResultViewModels = allHeroViewModels.Values.ToList();
		_screenPanelViewModel = new HeroScreenPanelViewModel(this, screenResultViewModels);
	}

	protected virtual void AfterScreenHero()
	{
		showHeroViewModels.Clear();
		List<HeroItemViewModel> list = new List<HeroItemViewModel>();
		foreach (KeyValuePair<int, HeroItemViewModel> item in result)
		{
			if (item.Value != null)
			{
				list.Add(item.Value);
			}
		}
		showHeroViewModels.AddRange(list);
		foreach (HeroItemViewModel hero in list)
		{
			screenResultViewModels.RemoveAll((HeroItemViewModel p) => p.HeroModel.Id == hero.HeroModel.Id);
		}
		showHeroViewModels.AddRange(screenResultViewModels);
		int targetHeroId = ((curSelectedVM == null) ? showHeroViewModels[0].HeroModel.Id : curSelectedVM.HeroModel.Id);
		HeroItemViewModel showHeroCurrent = showHeroViewModels.Find((HeroItemViewModel p) => p.HeroModel.Id == targetHeroId);
		SetShowHeroCurrent(showHeroCurrent);
		_refreshHeroListRst.Raise();
	}

	public virtual void OnBattleReadyOpen(List<BattleReadySeatViewModel> seatViewModels, BattleReadySeatViewModel parentSelected, int parentSeatId)
	{
		result.Clear();
		this.parentSeatId = parentSeatId;
		if (parentSelected != null && !parentSelected.Empty)
		{
			this.parentSelected = allHeroViewModels[parentSelected.Data.Id];
		}
		else
		{
			this.parentSelected = null;
		}
		for (int i = 1; i <= 3; i++)
		{
			result.Add(i, null);
		}
		foreach (BattleReadySeatViewModel seatViewModel in seatViewModels)
		{
			if (seatViewModel != null && !seatViewModel.Empty)
			{
				allHeroViewModels[seatViewModel.Data.Id].SetSeatId(seatViewModel.SeatId);
				result[seatViewModel.SeatId] = allHeroViewModels[seatViewModel.Data.Id];
			}
		}
		if (result[parentSeatId] != null)
		{
			SetShowHeroCurrent(result[parentSeatId]);
		}
		AfterScreenHero();
	}

	public void SetSelectHero(int heroId, int heroTryIndex, int teamSetId)
	{
		if (heroId == 0)
		{
			if (showHeroViewModels[0].HeroTryTag)
			{
				allHeroViewModels[showHeroViewModels[0].HeroTryId].SetSeatId(0);
			}
			else
			{
				allHeroViewModels[showHeroViewModels[0].HeroModel.Id].SetSeatId(0);
			}
			SetShowHeroCurrent(showHeroViewModels[0]);
			return;
		}
		result.Clear();
		parentSeatId = 0;
		int key = 0;
		foreach (KeyValuePair<int, HeroItemViewModel> allHeroViewModel in allHeroViewModels)
		{
			HeroItemViewModel value = allHeroViewModel.Value;
			if (value.HeroModel.Id == heroId && value.TeamSetId == teamSetId && value.TryHeroIndex == heroTryIndex)
			{
				key = allHeroViewModel.Key;
				break;
			}
		}
		parentSelected = allHeroViewModels[key];
		allHeroViewModels[key].SetSeatId(0);
		result.Add(0, allHeroViewModels[key]);
		SetShowHeroCurrent(allHeroViewModels[key]);
	}

	public override void Close()
	{
		parent?.ItemOnClick(this);
		base.Close();
	}

	protected virtual void SetShowHeroCurrent(HeroItemViewModel heroViewModel)
	{
		if (curSelectedVM == null || curSelectedVM != heroViewModel)
		{
			curSelectedVM?.SetSelected(value: false);
			curSelectedVM = heroViewModel;
			CurSelected = true;
			curSelectedVM?.SetSelected(value: true);
			SetFuncBtn();
			onShowHeroChangedRequest.Raise();
		}
	}

	protected virtual void OpenHeroCultureWindow()
	{
		detailCommand.Enabled = false;
		HeroCultivateViewModel userData = new HeroCultivateViewModel(this, curSelectedVM.HeroModel, 1, Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess() != GameProcessType.Story);
		openWindowRequest.Raise(new OpenViewArg(typeof(HeroCultivateWindow), userData), delegate
		{
			detailCommand.Enabled = true;
		});
	}

	public virtual void OnFuncBtnClick()
	{
		switch (btnType)
		{
		case SelectHeroEnum.Add:
			if (curSelectedVM.SeatId != -1)
			{
				result[curSelectedVM.SeatId] = null;
			}
			curSelectedVM.SetSeatId(parentSeatId);
			result[parentSeatId] = curSelectedVM;
			break;
		case SelectHeroEnum.Change:
		{
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
		parent?.ItemOnClick(this);
		base.Close();
	}

	private void SetFuncBtn()
	{
		btnType = GetFuncBtnType();
		FuncBtnText = GetFuncBtnText();
	}

	private SelectHeroEnum GetFuncBtnType()
	{
		if (entryType == 1)
		{
			if (curSelectedVM == parentSelected)
			{
				return SelectHeroEnum.None;
			}
			return SelectHeroEnum.Change;
		}
		if (curSelectedVM == null)
		{
			return SelectHeroEnum.None;
		}
		if (curSelectedVM == parentSelected)
		{
			return SelectHeroEnum.Remove;
		}
		if (parentSelected == null)
		{
			return SelectHeroEnum.Add;
		}
		return SelectHeroEnum.Change;
	}

	private string GetFuncBtnText()
	{
		return btnType switch
		{
			SelectHeroEnum.Change => "更换", 
			SelectHeroEnum.Remove => "换下", 
			SelectHeroEnum.Add => "加入", 
			_ => null, 
		};
	}
}
