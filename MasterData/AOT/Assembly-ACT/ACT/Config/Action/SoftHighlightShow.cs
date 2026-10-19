using ACT.Event;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.Config.Action;

public class SoftHighlightShow : GuideStepAction, IActionUninit
{
	[SerializeReference]
	public FindHighlightObjAction findAction;

	[Header("角色界面子界面类型")]
	public CharacterViewScene.CvSceneType secondViewType;

	private SoftHighlightWidget _guideWidget;

	private SoftHighlightStepData _softHighlightStepData;

	public override void Execute(GuideStepData step)
	{
		Init(step);
	}

	private void Init(GuideStepData step)
	{
		if (findAction.uiType == UI_TYPE.UI_CHARACTER)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Character_SecondViewOpen, OnCharacterSecondOpen);
		}
		else
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_AfterShowAni, OnUIOpen);
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_AfterHideAni, OnUIHide);
		if (!(step is SoftHighlightStepData softHighlightStepData))
		{
			return;
		}
		_softHighlightStepData = softHighlightStepData;
		IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
		if (topActiveUI == null || topActiveUI.GetUIView() == null)
		{
			return;
		}
		IBaseUIView uIView = topActiveUI.GetUIView();
		if (findAction.uiType == UI_TYPE.UI_CHARACTER)
		{
			CharacterView characterView = uIView as CharacterView;
			if (characterView != null)
			{
				if (secondViewType == CharacterViewScene.CvSceneType.None)
				{
					CreateGuideWidget();
				}
				else if (characterView.GetSecondViewAniState(secondViewType))
				{
					CreateGuideWidget();
				}
			}
		}
		else if (uIView.UIType == findAction.uiType)
		{
			CreateGuideWidget();
		}
	}

	public void CreateGuideWidget()
	{
		if (!(_guideWidget != null))
		{
			string key = GuideModel.GenerateGuideWidgetKey(findAction.uiType, secondViewType, findAction);
			SoftHighlightWidget orCreateGuideWidget = Model<GuideModel>.Interface.GetOrCreateGuideWidget(key);
			if (orCreateGuideWidget != null)
			{
				_guideWidget = orCreateGuideWidget;
				Model<GuideModel>.Interface.RegisterGuideWidget(key, orCreateGuideWidget);
				return;
			}
			Transform parent = findAction.Find();
			_guideWidget = UIUtility.AddWidget<SoftHighlightWidget>(parent, Singleton<NewUIManager>.instance.GuideComp.SofthighlightPrefab);
			_guideWidget.Init(_softHighlightStepData.Id, _softHighlightStepData.DeleteTime, findAction);
			Model<GuideModel>.Interface.RegisterGuideWidget(key, _guideWidget);
		}
	}

	public void UnInit()
	{
		if (findAction.uiType == UI_TYPE.UI_CHARACTER)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Character_SecondViewOpen, OnCharacterSecondOpen);
		}
		else
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_AfterShowAni, OnUIOpen);
		}
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_AfterHideAni, OnUIHide);
		DestroyGuideWidget();
		_softHighlightStepData = null;
	}

	private void DestroyGuideWidget()
	{
		if (_guideWidget != null)
		{
			string key = GuideModel.GenerateGuideWidgetKey(findAction.uiType, secondViewType, findAction);
			Model<GuideModel>.Interface.UnregisterGuideWidget(key);
			_guideWidget = null;
		}
	}

	private void OnUIHide(BaseEventContent obj)
	{
		if (obj is UIEvent uIEvent && uIEvent.UIType == findAction.uiType)
		{
			DestroyGuideWidget();
		}
	}

	private void OnUIOpen(BaseEventContent obj)
	{
		if (obj is UIEvent uIEvent && uIEvent.UIType == findAction.uiType)
		{
			CreateGuideWidget();
		}
	}

	private void OnCharacterSecondOpen(BaseEventContent obj)
	{
		if (!(obj is CharacterSecondOpenEvent characterSecondOpenEvent))
		{
			return;
		}
		if (secondViewType == CharacterViewScene.CvSceneType.None)
		{
			if (characterSecondOpenEvent.type != CharacterViewScene.CvSceneType.Over && characterSecondOpenEvent.type != CharacterViewScene.CvSceneType.Skill && characterSecondOpenEvent.type != CharacterViewScene.CvSceneType.Elite && characterSecondOpenEvent.type != CharacterViewScene.CvSceneType.Equipment)
			{
				DestroyGuideWidget();
			}
			else if (characterSecondOpenEvent.type == CharacterViewScene.CvSceneType.Over || characterSecondOpenEvent.type == CharacterViewScene.CvSceneType.Skill || characterSecondOpenEvent.type == CharacterViewScene.CvSceneType.Elite || characterSecondOpenEvent.type == CharacterViewScene.CvSceneType.Equipment)
			{
				CreateGuideWidget();
			}
		}
		else if (characterSecondOpenEvent.type == secondViewType)
		{
			CreateGuideWidget();
		}
		else
		{
			DestroyGuideWidget();
		}
	}
}
