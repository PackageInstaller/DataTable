using GameFramework.Runtime;

namespace Ase;

public class WeaponActiveViewModel : OptionBase
{
	private WeaponEnum weaponType;

	private InteractionRequest<int> layerChangeRequest;

	public WeaponEnum WeaponType
	{
		get
		{
			return weaponType;
		}
		private set
		{
			Set(ref weaponType, value, "WeaponType");
		}
	}

	public IInteractionRequest LayerChangeRequest => layerChangeRequest;

	public override void ItemOnClick(object obj)
	{
	}

	public WeaponActiveViewModel(WeaponEnum weaponType)
	{
		layerChangeRequest = new InteractionRequest<int>();
	}
}
