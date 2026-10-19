using System;
using ACT.Battle;
using ACT.Event;
using Fundamental;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class DisconnectionPanel : UIBehaviour
{
	private Action _onConfirm;

	public void Open(Action onConfirm)
	{
		_onConfirm = onConfirm;
		gameObject.SetActive(value: true);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TopLayerUI_Open, null);
		MonoECS.instance.PushPauseInput();
	}

	public void Close()
	{
		_onConfirm = null;
		gameObject.SetActive(value: false);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TopLayerUI_Close, null);
		MonoECS.instance.PopPauseInput();
	}

	public void Confirm()
	{
		_onConfirm?.Invoke();
		Close();
	}
}
