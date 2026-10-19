using System;
using ACT.UI;
using UnityEngine;

namespace ACT;

public class GraphicPanel : SettingPanel
{
	public GameObject pipelineOptimize;

	public GameObject vSync;

	public BetterAnimation betterAnimation;

	[SerializeField]
	private GraphicPanelContentControl _contentControl;

	private void Start()
	{
		if (pipelineOptimize != null)
		{
			pipelineOptimize.SetActive(SettingsManager.Instance.RuntimeSettings.GetSetting("Graphic.PipelineOptimize")?.Usable ?? false);
		}
		if (vSync != null)
		{
			vSync.SetActive(SettingsManager.Instance.RuntimeSettings.GetSetting("Graphic.VSync")?.Usable ?? false);
		}
		_contentControl?.SetPerformanceBarVisible(SettingsManager.Instance.RuntimeSettings.PerformanceBarEnabled);
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
