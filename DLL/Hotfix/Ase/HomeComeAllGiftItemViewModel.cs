using GameFramework.Runtime;

namespace Ase;

public class HomeComeAllGiftItemViewModel : OptionBase
{
	private readonly SimpleCommand clickCommand;

	private readonly PropDataBase propData;

	private string icon;

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

	public PropDataBase PropData => propData;

	public SimpleCommand ClickCommand => clickCommand;

	public HomeComeAllGiftItemViewModel()
	{
	}

	public HomeComeAllGiftItemViewModel(OptionBase parent, PropDataBase propData)
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
