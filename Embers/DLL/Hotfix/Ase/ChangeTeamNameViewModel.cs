using GameFramework.Runtime;

namespace Ase;

public class ChangeTeamNameViewModel : ViewModelBase
{
	private BattleReadyViewModel _parentVm;

	private int _teamId;

	private string _teamName;

	private string _errorText;

	public int TeamId
	{
		get
		{
			return _teamId;
		}
		set
		{
			_teamId = value;
		}
	}

	public string TeamName
	{
		get
		{
			return _teamName;
		}
		set
		{
			_teamName = value;
		}
	}

	public string ErrorText
	{
		get
		{
			return _errorText;
		}
		set
		{
			Set(ref _errorText, value, "ErrorText");
		}
	}

	public ChangeTeamNameViewModel()
	{
	}

	public ChangeTeamNameViewModel(BattleReadyViewModel parentVm)
	{
		_parentVm = parentVm;
	}

	public void OnSureBtnClick()
	{
		if (ValidNameCheck())
		{
			_parentVm.ChangeTeamNameRequest(TeamId, TeamName);
		}
		else
		{
			TeamName = "请输入你的队伍名字";
		}
	}

	private bool ValidNameCheck()
	{
		ErrorText = "";
		bool result = true;
		if (string.IsNullOrEmpty(TeamName))
		{
			result = false;
			ErrorText = "队伍名不能为空";
		}
		else if (TeamName.Length > 5)
		{
			result = false;
			ErrorText = "队伍名长度不得超过五个字";
		}
		return result;
	}
}
