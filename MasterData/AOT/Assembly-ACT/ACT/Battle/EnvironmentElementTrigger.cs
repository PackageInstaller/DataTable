using ACT.World.Asset;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class EnvironmentElementTrigger : MonoBehaviour
{
	public EnvironmentElementData data;

	private bool _inTrigger;

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		if (!_inTrigger && component != null && MonoECS.instance.IsMainEntity(component.entity))
		{
			_inTrigger = true;
			Singleton<GameManager>.instance.worldManager.EnvironmentModule.EnterEnvironmentElement(data);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		if (_inTrigger && component != null && MonoECS.instance.IsMainEntity(component.entity))
		{
			_inTrigger = false;
			Singleton<GameManager>.instance.worldManager.EnvironmentModule.ExitEnvironmentElement(data);
		}
	}

	private void OnDestroy()
	{
		if (_inTrigger)
		{
			Singleton<GameManager>.instance.worldManager.EnvironmentModule.ExitEnvironmentElement(data);
		}
	}
}
