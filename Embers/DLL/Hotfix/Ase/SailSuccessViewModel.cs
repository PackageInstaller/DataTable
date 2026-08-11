namespace Ase;

public class SailSuccessViewModel : OptionBase
{
	public bool IsGreat;

	public SailSuccessViewModel(OptionBase parent, bool isGreat)
	{
		base.parent = parent;
		IsGreat = isGreat;
	}

	public void BtnClose()
	{
		parent?.ItemOnClick(this);
	}
}
