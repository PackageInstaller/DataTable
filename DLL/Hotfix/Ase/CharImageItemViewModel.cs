namespace Ase;

public class CharImageItemViewModel : TabItemViewModel
{
	private int typeId;

	private new string name;

	public new string Icon
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

	public CharImageItemViewModel()
	{
	}

	public CharImageItemViewModel(OptionBase parent, DREmoticon emoticon)
		: base(parent)
	{
		icon = emoticon.Resource;
		id = emoticon.Id;
		typeId = emoticon.TypeId;
	}

	public override void OnClick()
	{
		parent?.ItemOnClick(this);
	}
}
