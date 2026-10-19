using System;
using ACT.UI;
using Fundamental;
using UnityEngine;

namespace ACT;

public class LanguagePanel : SettingPanel
{
	[Header("语音资源管理弹窗触发按钮（可选）")]
	public ActButton voicePackageButton;

	public BetterAnimation betterAnimation;

	private void Start()
	{
		if (voicePackageButton != null)
		{
			voicePackageButton.OnClick.AddListener(OpenVoicePackagePopup);
		}
	}

	public void OpenVoicePackagePopup()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_VOICEPACKAGE, new VoicePackageViewData());
	}

	private void OnDestroy()
	{
		if (voicePackageButton != null)
		{
			voicePackageButton.OnClick.RemoveListener(OpenVoicePackagePopup);
		}
	}

	public override void PlayOpenAnim(Action onFinish = null)
	{
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			onFinish?.Invoke();
		}).Play();
	}

	public override void PlayCloseAnim(Action onFinish = null)
	{
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			onFinish?.Invoke();
		}).Play();
	}
}
