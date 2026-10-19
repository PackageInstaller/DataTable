using ACT.Battle;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

public class CharacterEnergyUI : MonoBehaviour
{
	public TouchUIMaskWithOne battleEnergy;

	public void Init(Ability ab)
	{
		battleEnergy.value = ab.owner.GetCompAbility().EnergyValue;
	}
}
