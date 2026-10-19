using ACT.Event;
using ACT.Model;
using ACT.UI;
using Fundamental;

namespace ACT.Config.Action;

public class OpenTips : GuideStepAction, IActionUninit
{
	public UI_TYPE UIType;

	public int _tipsId;

	public override void Execute(GuideStepData data)
	{
		Init(data);
	}

	private void Init(GuideStepData data)
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_AfterShowAni, OnUIOpen);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_AfterHideAni, OnUIHide);
		IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
		if (topActiveUI != null && topActiveUI.UIType == UIType && topActiveUI.State == UIState.Opened)
		{
			Show();
		}
	}

	private void OnUIHide(BaseEventContent obj)
	{
		if (obj is UIEvent uIEvent && uIEvent.UIType == UIType)
		{
			Hide(hideNotComplete: true);
		}
	}

	private void OnUIOpen(BaseEventContent obj)
	{
		if (obj is UIEvent uIEvent && uIEvent.UIType == UIType)
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
		Model<GuideModel>.Interface.OpenTips(_tipsId);
	}

	private void Hide(bool hideNotComplete = false)
	{
		Model<GuideModel>.Interface.CloseTips(hideNotComplete);
	}
}
