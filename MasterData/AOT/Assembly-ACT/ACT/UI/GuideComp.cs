using System.Collections.Generic;
using ACT.Model;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class GuideComp : UIBehaviour
{
	public GameObject highlightPrefab;

	public GameObject SofthighlightPrefab;

	public GameObject EffectShowPrefab;

	public GameObject imageMobilePrefab;

	public GameObject imagePcPrefab;

	public GameObject videoMobilePrefab;

	public GameObject videoPcPrefab;

	private List<GuideWidget> _guideWidgets = new List<GuideWidget>();

	public void Init()
	{
		Model<GuideModel>.Interface.OnStepStart += OnStepStart;
		Model<GuideModel>.Interface.OnStepFinish += OnStepFinish;
	}

	public void UnInit()
	{
		Model<GuideModel>.Interface.OnStepStart -= OnStepStart;
		Model<GuideModel>.Interface.OnStepFinish -= OnStepFinish;
		for (int i = 0; i < _guideWidgets.Count; i++)
		{
			_guideWidgets[i].UnInit();
		}
		_guideWidgets.Clear();
	}

	private void OnStepStart(GuideStepData stepData)
	{
		Transform transform = null;
		if (stepData is SoftHighlightStepData)
		{
			IBaseUIView baseUIView = Singleton<NewUIManager>.instance.FindUIViewByUIType(stepData._precondition);
			if (stepData._precondition == UI_TYPE.UI_CHARACTER)
			{
				transform = (baseUIView as CharacterView).GetCharacterSubView(stepData.secondViewType);
			}
		}
		GuideWidget guideWidget;
		if (stepData is HighlightStepData)
		{
			guideWidget = Object.Instantiate(highlightPrefab, base.transform).GetComponent<GuideWidget>();
		}
		else if (stepData is SoftHighlightStepData)
		{
			guideWidget = Object.Instantiate(SofthighlightPrefab, (transform == null) ? base.transform : transform).GetComponent<GuideWidget>();
		}
		else if (stepData is ImageStepData)
		{
			guideWidget = Object.Instantiate(imageMobilePrefab, base.transform).GetComponent<GuideWidget>();
		}
		else if (stepData is VideoStepData)
		{
			guideWidget = Object.Instantiate(videoMobilePrefab, base.transform).GetComponent<GuideWidget>();
		}
		else
		{
			guideWidget = ((!(stepData is EffectShowStepData)) ? null : Object.Instantiate(EffectShowPrefab, base.transform).GetComponent<GuideWidget>());
		}
		GuideWidget guideWidget2 = guideWidget;
		_guideWidgets.Add(guideWidget2);
		guideWidget2.Init(stepData);
	}

	private void OnStepFinish(int stepDataId)
	{
		for (int i = 0; i < _guideWidgets.Count; i++)
		{
			if (_guideWidgets[i]._stepId == stepDataId)
			{
				_guideWidgets[i].UnInit();
				_guideWidgets.Remove(_guideWidgets[i]);
			}
		}
	}
}
