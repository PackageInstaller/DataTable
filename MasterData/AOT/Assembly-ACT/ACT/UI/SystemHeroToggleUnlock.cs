using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.RichText;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class SystemHeroToggleUnlock : MonoBehaviour
{
	public int systemId;

	public ActToggle actToggle;

	public GameObject normal;

	public GameObject locked;

	public ActButton btnlock;

	protected void Awake()
	{
		if (!Singleton<SystemUnlockManager>.instance.IsUnlock(systemId))
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnSystemOpen);
			SetUnlockInit(isUnlock: false);
		}
		else
		{
			SetUnlockInit(isUnlock: true);
		}
		btnlock.SetBtnClick(OnLock);
	}

	private void OnLock()
	{
		Mission data = CoreUtils.GetData(CoreUtils.GetData(systemId, RuntimeConfigs.data.systemOpens).missionId, RuntimeConfigs.data.missions);
		GameUtility.OpenToolTip(CustomTagParser.ReplacePreconditionText(data, data.number, data.param));
	}

	private void SetUnlockInit(bool isUnlock)
	{
		locked?.gameObject.SetActive(!isUnlock);
		normal?.gameObject.SetActive(isUnlock);
		actToggle.interactable = isUnlock;
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnSystemOpen);
	}

	private void OnSystemOpen(BaseEventContent baseEvent)
	{
		if (Singleton<SystemUnlockManager>.instance.IsUnlock(systemId))
		{
			SetUnlockInit(isUnlock: true);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnSystemOpen);
		}
	}
}
