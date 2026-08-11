using GameFramework.Runtime;

namespace Ase;

public class PrepareTeamViewModel : ViewModelBase
{
	private BattleReadyViewModel _battleReadyViewModel;

	private int _curSelectTeamId;

	public int CurSelectTeamId
	{
		get
		{
			return _curSelectTeamId;
		}
		set
		{
			_curSelectTeamId = value;
		}
	}

	public PrepareTeamViewModel(BattleReadyViewModel battleReadyViewModel)
	{
		_battleReadyViewModel = battleReadyViewModel;
	}

	public void OnConfirmBtnClick()
	{
		_battleReadyViewModel.SelectionTeamChanged(CurSelectTeamId);
	}
}
