using GameFramework.Runtime;
using TMPro;

namespace Ase;

public class LoadingTipWindow : Window
{
	public TextMeshProUGUI message;

	protected override void OnCreate(IBundle bundle)
	{
		base.WindowType = WindowType.PROGRESS;
	}
}
