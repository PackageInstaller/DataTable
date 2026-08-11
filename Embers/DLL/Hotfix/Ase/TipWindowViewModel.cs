using GameFramework.Runtime;

namespace Ase;

public class TipWindowViewModel : ViewModelBase
{
	private string tip;

	public int autoHideTime;

	public string Tip
	{
		get
		{
			return tip;
		}
		set
		{
			Set(ref tip, value, "Tip");
		}
	}
}
