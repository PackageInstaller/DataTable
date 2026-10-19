using ACT.Event;
using ACT.Model;
using ACT.UI;
using Fundamental;
using UnityEngine;

namespace ACT.Config.Action;

public class EffectShow : GuideStepAction, IActionUninit
{
	[SerializeReference]
	public FindHighlightObjAction findAction;

	private Transform transform;

	public override void Execute(GuideStepData data)
	{
		Init(data);
	}

	private void Init(GuideStepData data)
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_AfterShowAni, OnUIOpen);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_AfterHideAni, OnUIHide);
		IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
		if (topActiveUI != null && topActiveUI.UIType == findAction.uiType)
		{
			Show();
		}
	}

	private void OnUIHide(BaseEventContent obj)
	{
		if (obj is UIEvent uIEvent && uIEvent.UIType == findAction.uiType)
		{
			Hide();
		}
	}

	private void OnUIOpen(BaseEventContent obj)
	{
		if (obj is UIEvent uIEvent && uIEvent.UIType == findAction.uiType)
		{
			Show();
		}
	}

	public void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_AfterShowAni, OnUIOpen);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_AfterHideAni, OnUIHide);
		Hide();
	}

	private void Show()
	{
		transform = findAction.Find();
		if (transform != null)
		{
			transform.gameObject.SetActive(value: true);
		}
	}

	private void Hide()
	{
		if (transform != null)
		{
			transform.gameObject.SetActive(value: false);
		}
		transform = null;
	}
}
