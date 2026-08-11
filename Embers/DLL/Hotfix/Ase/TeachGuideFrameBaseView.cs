using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class TeachGuideFrameBaseView : UGuiView
{
	public int GuideType = 1;

	protected TeachGuideViewModel _viewModel;

	public CustomUIMask CustomUIMask;

	public Image FrameImage;

	public GameObject OutLine;

	public TextMeshProUGUI FrameText;

	public GameObject FramgeHideRoot;

	[SerializeField]
	private GameObject FrameRoot;

	private bool pointUpCloseUI;

	public Button BgEmptyBtn;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = userData as TeachGuideViewModel;
		if (_viewModel.TeachConfig.TeachingType == GuideType)
		{
			BindingSet<TeachGuideFrameBaseView, TeachGuideViewModel> bindingSet = this.CreateBindingSet(_viewModel);
			bindingSet.Bind<TextMeshProUGUI>(FrameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TeachGuideViewModel vm) => vm.FrameText);
			bindingSet.Build();
			base.gameObject.SetActive(value: true);
			BgEmptyBtn.onClick.AddListener(ClickBgBtn);
			CustomUIMask customUIMask = CustomUIMask;
			customUIMask.OnPointDownBefore = (Action<PointerEventData>)Delegate.Combine(customUIMask.OnPointDownBefore, new Action<PointerEventData>(OnClickUIMaskBefore));
			CustomUIMask customUIMask2 = CustomUIMask;
			customUIMask2.OnPointDown = (Action<PointerEventData>)Delegate.Combine(customUIMask2.OnPointDown, new Action<PointerEventData>(OnClickUIMaskDown));
			CustomUIMask customUIMask3 = CustomUIMask;
			customUIMask3.OnClickUpBefore = (Action)Delegate.Combine(customUIMask3.OnClickUpBefore, new Action(OnClickUpBefore));
			CustomUIMask.NeedExecuteInputCommand = _viewModel.TeachConfig.FinishCondition == 1;
		}
	}

	public void ShowContent()
	{
		if (_viewModel.TeachConfig.TeachingType == GuideType)
		{
			FrameRoot.SetActive(value: true);
			ShowFrame();
		}
	}

	protected virtual void ShowFrame()
	{
		if (_viewModel.GuidanceType != GuideType)
		{
			return;
		}
		Vector2 vector = _viewModel.TeachConfig.FrameSize.ToVector2();
		RectTransform component = FrameImage.GetComponent<RectTransform>();
		RectTransform targetUI = null;
		FindTragetUI(ref targetUI);
		if (targetUI != null)
		{
			FrameImage.transform.position = targetUI.position;
			if (!string.IsNullOrEmpty(_viewModel.TeachConfig.SelectUI) && _viewModel.TeachConfig.TargetUIIndex != -1)
			{
				CustomUIMask.target = targetUI.transform.GetChild(_viewModel.TeachConfig.TargetUIIndex)?.GetComponent<RectTransform>();
			}
			else
			{
				CustomUIMask.target = targetUI;
			}
		}
		else if (_viewModel.FrameTrans != null)
		{
			FrameImage.transform.position = _viewModel.FrameTrans.position;
			CustomUIMask.target = _viewModel.FrameTrans.GetComponent<RectTransform>();
		}
		Vector2 vector2 = _viewModel.TeachConfig.FrameShifting.ToVector2();
		component.sizeDelta = vector;
		if (!_viewModel.TeachConfig.BlackShade)
		{
			Color black = Color.black;
			black.a = 0f;
			CustomUIMask.color = black;
		}
		CustomUIMask.center = component.anchoredPosition;
		CustomUIMask.offset = vector2;
		component.anchoredPosition += vector2;
		CustomUIMask.size = vector;
		SetRaycastPadding(component);
	}

	protected virtual void FindTragetUI(ref RectTransform targetUI)
	{
	}

	private void SetRaycastPadding(RectTransform frameRect)
	{
		if (_viewModel.TeachConfig.CanClikOtherArea && (_viewModel.TeachConfig.FinishCondition == 1 || _viewModel.TeachConfig.FinishCondition == 4))
		{
			Vector4 zero = Vector4.zero;
			Vector2 size = CustomUIMask.GetComponent<RectTransform>().rect.size;
			float x = frameRect.anchoredPosition.x;
			float y = frameRect.anchoredPosition.y;
			float num = _viewModel.TeachConfig.FrameSize[0];
			float num2 = _viewModel.TeachConfig.FrameSize[1];
			zero.x = size.x / 2f + x - num / 2f;
			zero.z = size.x / 2f - x - num / 2f;
			zero.y = size.y / 2f + y - num2 / 2f;
			zero.w = size.y / 2f - y - num2 / 2f;
			CustomUIMask.raycastPadding = zero;
			BgEmptyBtn.gameObject.SetActive(value: false);
		}
	}

	private void OnClickUIMaskBefore(PointerEventData eventData)
	{
		if (_viewModel.TeachConfig.FinishCondition == 3)
		{
			FinishConditionExcute();
		}
		else if (_viewModel.TeachConfig.FinishCondition == 1 && ClickInFrameArea(eventData))
		{
			FinishConditionExcute();
			_viewModel.SaveTeachGuide();
		}
	}

	private void OnClickUIMaskDown(PointerEventData eventData)
	{
		if (!pointUpCloseUI)
		{
			if (_viewModel.TeachConfig.FinishCondition == 3)
			{
				FinishConditionExcute();
			}
			else if (_viewModel.TeachConfig.FinishCondition == 4 && ClickInFrameArea(eventData))
			{
				FinishConditionExcute();
				_viewModel.SaveTeachGuide();
			}
		}
		if (pointUpCloseUI && _viewModel.TeachConfig.ClickDownFinish)
		{
			_viewModel.CloseUI();
			CustomUIMask.OnPointerUp(eventData);
		}
	}

	private void FinishConditionExcute()
	{
		_viewModel.ReResume();
		HideFrameUI();
		pointUpCloseUI = true;
	}

	private bool ClickInFrameArea(PointerEventData eventData)
	{
		_ = FrameImage.GetComponent<RectTransform>().anchoredPosition;
		return RectTransformUtility.RectangleContainsScreenPoint(FrameImage.GetComponent<RectTransform>(), eventData.position);
	}

	private void OnClickUpBefore()
	{
		if (pointUpCloseUI)
		{
			_viewModel.CloseUI();
		}
	}

	private void ClickBgBtn()
	{
		if (_viewModel.TeachConfig.FinishCondition == 3)
		{
			_viewModel.CloseUI();
		}
	}

	protected virtual void HideFrameUI()
	{
		_viewModel.ReResume();
		FramgeHideRoot.SetActive(value: false);
		FrameImage.gameObject.SetActive(value: false);
		Color black = Color.black;
		black.a = 0f;
		CustomUIMask.color = black;
	}

	public void SetMask()
	{
		CustomUIMask.cliclAnyWhere = false;
	}
}
