using GameFramework.Runtime;

namespace Ase;

public class BattleMenuViewModel : OptionBase
{
	private BattleWorldMode _battleWorldMode;

	private bool canQuit;

	private SimpleCommand<int> handleCmd;

	private bool isInCaves;

	private bool isStory;

	public bool IsInCaves
	{
		get
		{
			return isInCaves;
		}
		set
		{
			Set(ref isInCaves, value, "IsInCaves");
		}
	}

	public bool CanQuit => canQuit;

	public BattleWorldMode BattleWorldMode => _battleWorldMode;

	public BattleMenuViewModel()
	{
		handleCmd = new SimpleCommand<int>(OnMenuItemClick);
	}

	public BattleMenuViewModel(OptionBase parent, bool isInCaves, bool isStory, bool canQuit = true)
	{
		base.parent = parent;
		IsInCaves = isInCaves;
		this.canQuit = canQuit;
		this.isStory = isStory;
		handleCmd = new SimpleCommand<int>(OnMenuItemClick);
	}

	public void GamePause()
	{
		parent.ItemOnClick(ProcessOperationEnum.GamePause);
	}

	public void OnContinueBtnClick()
	{
		handleCmd.Execute(1);
	}

	public void OnSetBtnClick()
	{
		handleCmd.Execute(2);
	}

	public void OnQuitBtnClick()
	{
		if (canQuit)
		{
			handleCmd.Execute(3);
			return;
		}
		OptionArg obj = new OptionArg(this, "Quit");
		parent.ItemOnClick(obj);
		Close();
	}

	private async void OnMenuItemClick(int index)
	{
		handleCmd.Enabled = false;
		switch (index)
		{
		case 1:
			parent.ItemOnClick(ProcessOperationEnum.GameResume);
			Close();
			break;
		case 2:
		{
			GameSettingViewModel gameSettingVm = new GameSettingViewModel(this, "战斗界面", inBattle: true);
			await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().InitManualServerInfo();
			parent.ItemOnClick(new OptionArg(gameSettingVm, "AddSettingHero"));
			openWindowRequest.Raise(new OpenViewArg(typeof(GameSettingWindow), gameSettingVm), delegate
			{
				handleCmd.Enabled = true;
			});
			break;
		}
		case 3:
			if (isStory && !Singleton<ServiceSystem>.Instance.GetService<ISOService>().CheckGuideComplete())
			{
				Toast.ShowInfo("前期剧情体验中，无法退出");
				handleCmd.Enabled = true;
			}
			else
			{
				parent.ItemOnClick(ProcessOperationEnum.GameOver);
			}
			break;
		case 4:
			if (isStory && !Singleton<ServiceSystem>.Instance.GetService<ISOService>().CheckGuideComplete())
			{
				Toast.ShowInfo("当前无法逃离！");
				handleCmd.Enabled = true;
			}
			else
			{
				parent.ItemOnClick(ProcessOperationEnum.GameResume);
				parent.ItemOnClick(new OptionArg(this, "Revert"));
				Close();
			}
			break;
		}
	}

	public void OnSafeBtnClick()
	{
		if (canQuit)
		{
			handleCmd.Execute(4);
			return;
		}
		OptionArg obj = new OptionArg(this, "Safe");
		parent.ItemOnClick(obj);
		Close();
	}
}
