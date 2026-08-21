using GameFramework.Runtime;

namespace Ase;

public class CopySecondType3EntryViewModel : OptionBase
{
	private readonly SimpleCommand<string> optCommand;

	private string timeLeft;

	public ICommand OptCommand => optCommand;

	public string Title => "暗箱裂隙";

	public string Desc => "请选择挑战模式";

	public string TimeLeft
	{
		get
		{
			return timeLeft;
		}
		private set
		{
			Set(ref timeLeft, value, "TimeLeft");
		}
	}

	public CopySecondType3EntryViewModel()
	{
		optCommand = new SimpleCommand<string>(OnOpt);
	}

	public CopySecondType3EntryViewModel(OptionBase parent)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		if (parent is CopySecondType3ViewModel copySecondType3ViewModel)
		{
			SetTimeLeft(copySecondType3ViewModel.TimeLeft);
		}
	}

	private void OnOpt(string optName)
	{
		if (parent is CopySecondType3ViewModel copySecondType3ViewModel)
		{
			if (optName.Equals("OpenMulti"))
			{
				copySecondType3ViewModel.SwitchPage(CopyType3Page.Multi);
			}
			else if (optName.Equals("OpenFirePower"))
			{
				copySecondType3ViewModel.SwitchPage(CopyType3Page.FirePower);
			}
			else if (optName.Equals("OpenExtreme"))
			{
				copySecondType3ViewModel.SwitchPage(CopyType3Page.Extreme);
			}
			else if (optName.Equals("Close"))
			{
				copySecondType3ViewModel.Close();
			}
		}
	}

	public void SetTimeLeft(string value)
	{
		TimeLeft = value;
	}
}
