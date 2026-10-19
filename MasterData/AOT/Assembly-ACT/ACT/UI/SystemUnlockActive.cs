using ACT.Event;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class SystemUnlockActive : MonoBehaviour
{
	public SystemType SystemType;

	public void Awake()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnSystemOpen);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_BlockStatusChanged, OnBlockStatusChanged);
		Refresh();
	}

	public void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnSystemOpen);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_BlockStatusChanged, OnBlockStatusChanged);
	}

	private void OnSystemOpen(BaseEventContent baseEventContent)
	{
		if (baseEventContent is SystemOpenEvt systemOpenEvt && systemOpenEvt.systemId == (int)SystemType)
		{
			Refresh();
		}
	}

	private void OnBlockStatusChanged(BaseEventContent baseEventContent)
	{
		if (baseEventContent is SystemBlockStatusChangedEvt systemBlockStatusChangedEvt && systemBlockStatusChangedEvt.status.MainID == (int)SystemType)
		{
			Refresh();
		}
	}

	public void Refresh()
	{
		gameObject.SetActive(Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType));
	}
}
