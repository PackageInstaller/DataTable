using ACT.Event;
using ACT.Model;
using UnityEngine;

namespace ACT.UI;

public class EffectShowWidget : GuideWidget
{
	private EffectShowStepData _effectShowStepDat;

	private string _actionPath;

	public override void Init(GuideStepData stepData)
	{
		if (stepData is EffectShowStepData effectShowStepData)
		{
			AddListener();
			_effectShowStepDat = effectShowStepData;
			Show();
			_actionPath = effectShowStepData._actionPath;
		}
	}

	private void AddListener()
	{
	}

	private void OnStepFinsh(BaseEventContent obj)
	{
	}

	private void RemoveListener()
	{
	}

	private void Show()
	{
		Transform transform = _effectShowStepDat.FindAction.Find();
		if (transform != null)
		{
			transform.gameObject.SetActive(value: true);
		}
	}

	private void Hide()
	{
		Transform transform = _effectShowStepDat.FindAction.Find();
		if (transform != null)
		{
			transform.gameObject.SetActive(value: false);
		}
	}

	public override void UnInit()
	{
		Hide();
		RemoveListener();
		base.UnInit();
	}
}
