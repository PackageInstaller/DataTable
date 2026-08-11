using GameFramework.Runtime;

namespace Ase;

public class HomeComeSignRewardCellViewModel : OptionBase
{
	private readonly SimpleCommand clickCommand;

	private readonly PropDataBase propData;

	private string icon;

	private bool showState;

	public PropDataBase PropData => propData;

	public string Icon
	{
		get
		{
			return icon;
		}
		set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public SimpleCommand ClickCommand => clickCommand;

	public bool ShowState
	{
		get
		{
			return showState;
		}
		set
		{
			Set(ref showState, value, "ShowState");
		}
	}

	public HomeComeSignRewardCellViewModel()
	{
	}

	public HomeComeSignRewardCellViewModel(OptionBase parent, PropDataBase propData)
	{
		base.parent = parent;
		this.propData = propData;
		icon = propData?.Icon ?? string.Empty;
		clickCommand = new SimpleCommand(OnClick);
	}

	private void OnClick()
	{
		parent?.ItemOnClick(this);
	}
}
