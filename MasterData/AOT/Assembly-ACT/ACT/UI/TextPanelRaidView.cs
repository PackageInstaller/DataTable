using System;
using ACT.Battle;
using ACT.Utility;
using Fundamental;
using TMPro;

namespace ACT.UI;

public class TextPanelRaidView : TextPanel<TextPanelRaidViewInputController>
{
	public class TextPanelRaidParam : TextPanel.Param
	{
		public int CancelCommonId;

		public int ConfirmCommonId;

		public Action OnClose;
	}

	public TextMeshProUGUI CancelText;

	public TextMeshProUGUI ConfirmText;

	public BetterAnimation middlePopUpCompAnim;

	public OperateBtnPrompt confirmPrompt;

	public OperateBtnPrompt cancelPrompt;

	private TextPanelRaidParam _param;

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
		if (middlePopUpCompAnim != null)
		{
			middlePopUpCompAnim.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
		betterAnimation?.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void Init()
	{
		base.Init();
		_param = (TextPanelRaidParam)m_Param;
		CancelBtn?.SetBtnClick(OnCancelBtn, "event:/UI/Common/Common_Button_Click");
		ConfirmBtn?.SetBtnClick(OnConfirmBtn, "event:/UI/Common/Common_Button_Click");
		CancelText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, _param?.CancelCommonId ?? 0);
		ConfirmText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, _param?.ConfirmCommonId ?? 0);
		UpdateBtnPromptActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		if (middlePopUpCompAnim != null)
		{
			middlePopUpCompAnim.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
		betterAnimation?.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		UpdateBtnPromptActive(type == DeviceInputMode.Gamepad);
	}

	private void UpdateBtnPromptActive(bool isActive)
	{
		confirmPrompt?.SetVisible(isActive);
		cancelPrompt?.SetVisible(isActive);
	}

	public override void Close()
	{
		_param?.OnClose?.Invoke();
		base.Close();
	}
}
