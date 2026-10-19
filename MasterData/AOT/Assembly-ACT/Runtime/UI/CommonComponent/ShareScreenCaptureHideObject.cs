using ACT.Event;
using Fundamental;
using UnityEngine;

namespace Runtime.UI.CommonComponent;

public class ShareScreenCaptureHideObject : MonoBehaviour
{
	private bool isActive;

	private void Awake()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ShareScreenShot, Handle);
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ShareScreenShot, Handle);
	}

	private void Handle(BaseEventContent obj)
	{
		if (!(obj is ShareScreenshotEvent shareScreenshotEvent))
		{
			return;
		}
		if (shareScreenshotEvent.Start)
		{
			isActive = gameObject.activeSelf;
			if (isActive)
			{
				gameObject.SetActive(value: false);
			}
		}
		else if (isActive)
		{
			gameObject.SetActive(value: true);
		}
	}
}
