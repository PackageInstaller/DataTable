using GameFramework.Runtime;

namespace Ase;

public class ArmourPresetNameViewModel : OptionBase
{
	private readonly SimpleCommand<string> optCmd;

	private bool createMode;

	private string presetName = string.Empty;

	public string PresetName
	{
		get
		{
			return presetName;
		}
		set
		{
			Set(ref presetName, value, "PresetName");
		}
	}

	public bool CreateMode => createMode;

	public ICommand OptCmd => optCmd;

	public bool IsCreateMode => createMode;

	public ArmourPresetNameViewModel()
	{
		optCmd = new SimpleCommand<string>(OnOpt);
	}

	public ArmourPresetNameViewModel(OptionBase parent, bool createMode, string presetName)
		: this()
	{
		base.parent = parent;
		this.createMode = createMode;
		this.presetName = presetName;
	}

	private void OnOpt(string optName)
	{
		if ("Confirm".Equals(optName))
		{
			Confirm();
		}
		else if ("Cancel".Equals(optName))
		{
			Cancel();
		}
	}

	private void Confirm()
	{
		parent?.ItemOnClick(new OptionArg(this, "Confirm"));
	}

	private void Cancel()
	{
		parent?.ItemOnClick(new OptionArg(this, "Cancel"));
	}
}
