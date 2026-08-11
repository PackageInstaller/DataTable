using GameFramework.Runtime;

namespace Ase;

public class DrawCardInfoItemData : OptionBase
{
	private string icon;

	private int id;

	private SimpleCommand openWindowCmd;

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

	public int Id
	{
		get
		{
			return id;
		}
		set
		{
			Set(ref id, value, "Id");
		}
	}

	public SimpleCommand OpenWindowCmd => openWindowCmd;

	public DrawCardInfoItemData(OptionBase parent)
	{
		base.parent = parent;
		openWindowCmd = new SimpleCommand(OpenOptionalWindow);
		Icon = "empty";
	}

	public void SetNewInfo(string icon, int id)
	{
		Icon = icon;
		Id = id;
	}

	private void OpenOptionalWindow()
	{
		openWindowCmd.Enabled = false;
		parent?.ItemOnClick(this);
	}
}
