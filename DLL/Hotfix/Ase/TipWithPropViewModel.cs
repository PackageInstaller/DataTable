using GameFramework.Runtime;

namespace Ase;

public class TipWithPropViewModel : OptionBase
{
	private string itemIcon;

	private int itemRarity;

	private string title1;

	private string title2;

	private SimpleCommand confirmCmd;

	public SimpleCommand ConfirmCmd => confirmCmd;

	public string Title1 => title1;

	public string Title2 => title2;

	public string ItemIcon => itemIcon;

	public int ItemRarity => itemRarity;

	public TipWithPropViewModel(OptionBase parent, string itemIcon, int itemRarity, string title1 = "", string title2 = "")
	{
		base.parent = parent;
		this.itemIcon = itemIcon;
		this.itemRarity = itemRarity;
		confirmCmd = new SimpleCommand(ConfirmOnClick);
		this.title1 = title1;
		this.title2 = title2;
	}

	private void ConfirmOnClick()
	{
		parent?.ItemOnClick(new OptionArg(this, ""));
		Close();
	}
}
