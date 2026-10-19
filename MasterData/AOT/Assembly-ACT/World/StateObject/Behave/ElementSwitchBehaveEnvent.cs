using ACT.Battle;
using ACT.World.StateObject;
using Bamboo.ECS;
using UnityEngine;

namespace World.StateObject.Behave;

public class ElementSwitchBehaveEnvent : MonoBehaviour
{
	public InteractElementSwitch interactElementSwitch;

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		if (component != null && component.entity.IsCharacter() && interactElementSwitch != null)
		{
			interactElementSwitch.ChangeToFinalState();
		}
	}
}
