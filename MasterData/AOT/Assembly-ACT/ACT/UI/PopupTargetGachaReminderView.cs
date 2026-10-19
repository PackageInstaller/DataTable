using System;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class PopupTargetGachaReminderView : BaseUIView<PopupTargetGachaReminderViewInputController>
{
	[SerializeField]
	private ActButton closeButton;

	[SerializeField]
	private ActButton goTargetGachaButton;

	[SerializeField]
	private ActButton continueDrawButton;

	[SerializeField]
	private Toggle dontRemindToggle;

	[SerializeField]
	public ViewControlRoot viewControlRoot;

	[SerializeField]
	public ViewControlLayer viewControlLayer;

	private PopupTargetGachaReminderViewData m_data;

	public override async UniTask PreInit()
	{
		m_data = uiViewData as PopupTargetGachaReminderViewData;
		closeButton?.SetBtnClick(Close, "event:/UI/Common/Popup_Close");
		goTargetGachaButton?.SetBtnClick(OpenTargetGacha, "event:/UI/Interface/DrawCard/Tab");
		continueDrawButton?.SetBtnClick(ContinueDraw, "event:/UI/Interface/DrawCard/Extract1");
		if (dontRemindToggle != null)
		{
			dontRemindToggle.SetIsOnWithoutNotify(m_data?.SilenceEnabled ?? false);
		}
		await base.PreInit();
	}

	protected override void UnInit()
	{
		m_data = null;
		base.UnInit();
	}

	private void OpenTargetGacha()
	{
		if (m_data != null)
		{
			int gachaId = m_data.GachaId;
			Close();
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPTARGETGACHA, new PopupTargetGachaViewData
			{
				GachaId = gachaId
			});
		}
	}

	private void ContinueDraw()
	{
		Action action = m_data?.OnContinue;
		if (m_data != null && dontRemindToggle != null && dontRemindToggle.isOn)
		{
			m_data.OnClickSilence?.Invoke(obj: true);
		}
		Close();
		action?.Invoke();
	}

	public void HandleGamepadSubmit()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	public void HandleGamepadCancel()
	{
		Close();
	}

	public void HandleGamepadToggleSilence()
	{
		if (dontRemindToggle != null)
		{
			dontRemindToggle.isOn = !dontRemindToggle.isOn;
		}
	}
}
