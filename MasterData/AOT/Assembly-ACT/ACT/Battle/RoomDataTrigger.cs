using ACT.World.Asset;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class RoomDataTrigger : MonoBehaviour
{
	public RoomData roomData;

	private bool inTrigger;

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		if (!inTrigger && component != null && MonoECS.instance.IsMainEntity(component.entity))
		{
			inTrigger = true;
			Singleton<GameManager>.instance.worldManager.EnvironmentModule.EnterEnvironmentElement(roomData.environmentElementData);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		if (inTrigger && component != null && MonoECS.instance.IsMainEntity(component.entity))
		{
			inTrigger = false;
			Singleton<GameManager>.instance.worldManager.EnvironmentModule.ExitEnvironmentElement(roomData.environmentElementData);
		}
	}

	private void OnDestroy()
	{
		if (inTrigger)
		{
			Singleton<GameManager>.instance.worldManager.EnvironmentModule.ExitEnvironmentElement(roomData.environmentElementData);
		}
	}
}
