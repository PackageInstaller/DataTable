using GameFramework.Runtime;

namespace Ase;

public class WeaponViewModel : OptionBase
{
	private WeaponDetailViewModel _weaponDetailViewModel;

	private InteractionRequest _onRefreshRequest;

	public WeaponDetailViewModel WeaponDetailViewModel => _weaponDetailViewModel;

	public InteractionRequest OnRefreshRequest => _onRefreshRequest;

	public WeaponViewModel(OptionBase parent, WeaponData weaponData)
	{
		base.parent = parent;
		_weaponDetailViewModel = new WeaponDetailViewModel(this, weaponData);
		_onRefreshRequest = new InteractionRequest();
	}
}
