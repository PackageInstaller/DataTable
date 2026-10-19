using System;
using ACT.UI.InputController;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopupRaidDoubleView : BaseUIView<PopupRaidDoubleInputController>
{
	[SerializeField]
	private ActButton m_confirmButton;

	[SerializeField]
	private ActButton m_cancelButton;

	[SerializeField]
	private ActButton m_closeButton;

	[SerializeField]
	private LocalizeStringEvent m_costAndRewardText;

	[SerializeField]
	private LocalizeStringEvent m_doubleRewardText;

	[Header("右侧顶部")]
	[SerializeField]
	private PowerBar _powerBar;

	[SerializeField]
	private TextMeshProUGUI m_doubleRewardCount;

	private PopupRaidDoubleViewData m_data;

	protected override void Init()
	{
		base.Init();
		m_data = uiViewData as PopupRaidDoubleViewData;
		RefreshContent();
		BindButtons();
	}

	protected override void UnInit()
	{
		UnbindButtons();
		m_data = null;
		base.UnInit();
	}

	private void BindButtons()
	{
		m_confirmButton?.SetBtnClick(Confirm);
		m_cancelButton?.SetBtnClick(Cancel);
		m_closeButton?.SetBtnClick(Close);
	}

	private void UnbindButtons()
	{
		m_confirmButton?.OnClick.RemoveListener(Confirm);
		m_cancelButton?.OnClick.RemoveListener(Cancel);
	}

	private void RefreshContent()
	{
		if (m_data != null)
		{
			if (m_doubleRewardCount != null)
			{
				m_doubleRewardCount.SetText("{0:0}/{1:0}", m_data.LeftDoubleRewardCount, m_data.TotalDoubleRewardCount);
			}
			SetVariable(m_costAndRewardText, "0", m_data.PowerCost);
			SetVariable(m_costAndRewardText, "1", m_data.RewardCount);
			SetVariable(m_doubleRewardText, "0", m_data.DoubleRewardCost);
		}
	}

	private static void SetVariable(LocalizeStringEvent localizeEvent, string key, int value)
	{
		if (!(localizeEvent == null))
		{
			localizeEvent.StringReference.GetVariable<int>(key).Value = value;
		}
	}

	private void Confirm()
	{
		Action action = m_data?.OnConfirm;
		Close();
		action?.Invoke();
	}

	private void Cancel()
	{
		Close();
	}

	public void FocusDefaultButton()
	{
		if (m_confirmButton != null && m_confirmButton.IsInteractable())
		{
			EventSystemHelper.SetSelectedGameObject(m_confirmButton.gameObject);
		}
	}

	public void SelectButton(MoveDirection direction)
	{
		ActButton actButton = ((direction == MoveDirection.Left) ? m_cancelButton : m_confirmButton);
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected == m_confirmButton?.gameObject && direction == MoveDirection.Left)
		{
			actButton = m_cancelButton;
		}
		else if (currentSelected == m_cancelButton?.gameObject && direction == MoveDirection.Right)
		{
			actButton = m_confirmButton;
		}
		if (actButton != null && actButton.IsInteractable())
		{
			EventSystemHelper.SetSelectedGameObject(actButton.gameObject);
		}
	}

	public void HandleGamepadSubmit()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected == null)
		{
			FocusDefaultButton();
			currentSelected = EventSystemHelper.CurrentSelected;
		}
		if (currentSelected != null)
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	public void HandleGamepadCancel()
	{
		Cancel();
	}

	public void OnRightStickPress()
	{
		if (_powerBar != null && _powerBar.addPowerBtn != null && _powerBar.addPowerBtn.gameObject.activeSelf && _powerBar.addPowerBtn.IsInteractable())
		{
			_powerBar.addPowerBtn.OnSubmit(null);
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
	}
}
