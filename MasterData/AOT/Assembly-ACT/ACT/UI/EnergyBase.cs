using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public abstract class EnergyBase : MonoBehaviour
{
	public abstract void Init(Ability ab);

	private void OnEnable()
	{
		SwitchRefresh();
	}

	public abstract void SwitchRefresh();
}
