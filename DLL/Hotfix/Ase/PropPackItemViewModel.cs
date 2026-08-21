namespace Ase;

public class PropPackItemViewModel : KnapsackItemViewModel
{
	private int propAmount;

	public int PropAmount => propAmount;

	public PropPackItemViewModel(OptionBase parent, PropDataBase data)
		: base(parent, data)
	{
		base.parent = parent;
		Refresh(data);
		propAmount = data.Amount;
	}

	public void OpenPropPopupOnClick()
	{
		OpenViewArg obj = OpenPopupWindow(parent);
		parent?.ItemOnClick(obj);
	}

	public void SelectPropOnClick()
	{
		parent?.ItemOnClick(this);
	}
}
