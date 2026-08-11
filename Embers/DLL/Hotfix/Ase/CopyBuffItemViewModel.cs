using GameFramework.Runtime;

namespace Ase;

public class CopyBuffItemViewModel : ViewModelBase
{
	private string icon = "";

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
}
