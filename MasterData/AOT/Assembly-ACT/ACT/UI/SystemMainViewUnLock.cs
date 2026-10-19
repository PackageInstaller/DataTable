using ACT.Event;
using ACT.Game;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class SystemMainViewUnLock : MonoBehaviour
{
	public int systemId;

	protected void Awake()
	{
		if (!G.localPlayer.OpenSystems.Contains(systemId))
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnSystemOpen);
			gameObject.SetActive(value: false);
		}
		else if (!gameObject.activeInHierarchy)
		{
			gameObject.SetActive(value: true);
		}
	}

	private void OnSystemOpen(BaseEventContent baseEvent)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsUnlock(systemId))
		{
			return;
		}
		G.service.CheckSystemOpen(systemId, (bool isOpen) =>
		{
			if (isOpen)
			{
				gameObject.SetActive(value: true);
				GameUtility.OpenSystem(systemId);
				Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnSystemOpen);
			}
		});
	}
}
