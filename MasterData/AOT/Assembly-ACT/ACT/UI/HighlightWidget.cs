using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class HighlightWidget : GuideWidget, IPointerDownHandler, IEventSystemHandler
{
	private const int MaxTextCharactersPerLine = 20;

	private const float TextRootFramePadding = 25f;

	[SerializeReference]
	private Image bg;

	[SerializeReference]
	private RectTransform frame;

	[SerializeReference]
	private RectTransform clickArea;

	[SerializeReference]
	public Material rectMaterial;

	[SerializeReference]
	public Material circleMaterial;

	[SerializeReference]
	public GuideSkipComp GudieSkipCompt;

	[SerializeReference]
	public Transform TfGudieSkipTop;

	[SerializeReference]
	public Transform TfGudieSkipDown;

	[SerializeReference]
	private RectTransform textRoot;

	[SerializeReference]
	private RectTransform textGroupRoot;

	[SerializeReference]
	private LocalizeStringEvent textLocalize;

	[SerializeReference]
	private RectTransform arrow;

	[SerializeReference]
	private BetterAnimation betterAnimation;

	public GameObject GoPressAnyKey;

	public BImage ImagePressAnykey;

	public GameObject InstructionRoot;

	public float _arrowDistance = 10f;

	private string _actionPath;

	private Transform _target;

	private Dictionary<string, object> _promptTMPVariables;

	private TMP_Text _guideText;

	private LayoutElement _guideTextLayoutElement;

	public HighlightStepData _highlightStepData;

	private GameObject _currentGuideSelection;

	private Vector3[] frameWorldCorner = new Vector3[4];

	private Vector2 center;

	private float width;

	private float height;

	public override void Init(GuideStepData stepData)
	{
		_highlightStepData = null;
		if (stepData is HighlightStepData highlightStepData)
		{
			_promptTMPVariables = DictionaryPool<string, object>.Get();
			RegisterTextUpdateListener();
			textLocalize.StringReference.TableEntryReference = 0L;
			_highlightStepData = highlightStepData;
			_stepId = stepData.Id;
			_actionPath = stepData._actionPath;
			InitBg();
			AddListener();
			InitFrame(_highlightStepData);
			InitClickArea(_highlightStepData);
			InitText(_highlightStepData);
			betterAnimation?.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				betterAnimation.GetSequence("Loop").Play().SetLoops(-1);
			}).Play();
			InitSkip();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Guide");
			_currentGuideSelection = MonoECS.instance.eventSystem.currentSelectedGameObject;
		}
	}

	private void Update()
	{
		InitFrame(_highlightStepData);
		InitClickArea(_highlightStepData);
		InitText(_highlightStepData);
	}

	public override void UnInit()
	{
		GudieSkipCompt?.UnInit();
		UnregisterTextUpdateListener();
		DictionaryPool<string, object>.Release(_promptTMPVariables);
		RemoveListener();
		base.UnInit();
	}

	private void AddListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Input_FinshCurrentGuideStep, OnStepFinsh);
		RegisterInputActionCallback("Guide/ClickFinshGuideStep", OnClickAnyKeyPressed);
		RegisterInputActionCallback("Guide/ClickSkipGuide", OnClickSkipGuidePressed);
	}

	private void RemoveListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Input_FinshCurrentGuideStep, OnStepFinsh);
		UnregisterInputActionCallback("Guide/ClickFinshGuideStep", OnClickAnyKeyPressed);
		UnregisterInputActionCallback("Guide/ClickSkipGuide", OnClickSkipGuidePressed);
	}

	private void OnStepFinsh(BaseEventContent obj)
	{
		if (obj is GuideInputFinshStepEvt guideInputFinshStepEvt && guideInputFinshStepEvt.InputActionPath.Equals(_actionPath))
		{
			StepFinish();
		}
	}

	public void OnClick()
	{
		if (_highlightStepData.ClickAnywhere)
		{
			StepFinish();
		}
	}

	public override void StepFinish()
	{
		GuideStepFinishEvt evt = Singleton<EventManager>.instance.GetEvt<GuideStepFinishEvt>();
		evt.stepId = _stepId;
		evt.type = GuideConsts.GuideType.ClickFinshEvent;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Guide_StepFinish, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void InitBg()
	{
		bg.raycastTarget = true;
		bg.material = new Material(rectMaterial);
		RectTransform rectTransform = bg.rectTransform;
		rectTransform.pivot = 0.5f * Vector2.one;
		rectTransform.anchorMin = Vector2.zero;
		rectTransform.anchorMax = Vector2.one;
		rectTransform.offsetMin = Vector2.zero;
		rectTransform.offsetMax = Vector2.zero;
		rectTransform.localScale = Vector3.one;
	}

	private void InitFrame(HighlightStepData highlightStepData)
	{
		if (highlightStepData.FindAction == null)
		{
			_ = LuminApplication.LogEnabled;
			StepFinishInError();
			return;
		}
		Transform transform = highlightStepData.FindAction.Find();
		if (transform == null)
		{
			StepFinishInError();
			_ = LuminApplication.LogEnabled;
			return;
		}
		_target = transform;
		RectTransform rectTransform = transform as RectTransform;
		Vector3 vector = GameUtility.uiCamera.WorldToScreenPoint(UIUtility.GetWorldPosIgnorePivot(rectTransform));
		if (!(vector.x >= 0f) || !(vector.x <= (float)Screen.width) || !(vector.y >= 0f) || !(vector.y <= (float)Screen.height))
		{
			StepFinishInError();
			_ = LuminApplication.LogEnabled;
			_ = LuminApplication.LogEnabled;
			_ = LuminApplication.LogEnabled;
			return;
		}
		frame.position = UIUtility.GetWorldPosIgnorePivot(rectTransform);
		frame.sizeDelta = new Vector2(rectTransform.rect.width, rectTransform.rect.height);
		Vector3[] worldCorners = UIUtility.GetWorldCorners(rectTransform);
		Vector3[] worldCorners2 = UIUtility.GetWorldCorners(frame);
		float num = worldCorners[2].x - worldCorners[0].x;
		float num2 = worldCorners2[2].x - worldCorners2[0].x;
		frame.sizeDelta *= num / num2;
		InitBgMaterialParam();
	}

	private void InitSkip()
	{
		bool flag = Model<GuideModel>.Interface.GetCurrentGuide()?._isNeedSkip ?? false;
		bool flag2 = _highlightStepData.SkipBtnPosTypeType == HighlightGuideSkipPosType.Down;
		InstructionRoot.transform.SetParent(flag2 ? TfGudieSkipDown : TfGudieSkipTop);
		InstructionRoot.transform.localPosition = Vector3.zero;
		GudieSkipCompt.gameObject.SetActive(flag);
		GudieSkipCompt?.Init(OnSkipStrongGudie, flag);
	}

	private void RegisterInputActionCallback(string actionPath, Action<InputAction.CallbackContext> callback)
	{
		if (MonoECS.instance.TryGetInputAction(actionPath, out var action))
		{
			action.performed -= callback;
			action.performed += callback;
			action.Enable();
		}
	}

	private void UnregisterInputActionCallback(string actionPath, Action<InputAction.CallbackContext> callback)
	{
		if (MonoECS.instance.TryGetInputAction(actionPath, out var action))
		{
			action.performed -= callback;
			action.Disable();
		}
	}

	protected virtual void OnClickAnyKeyPressed(InputAction.CallbackContext callbackContext)
	{
		if (!callbackContext.ReadValueAsButton() && _highlightStepData.ClickAnywhere)
		{
			GuideFinsh();
		}
	}

	protected virtual void OnClickSkipGuidePressed(InputAction.CallbackContext callbackContext)
	{
		bool flag = callbackContext.ReadValueAsButton();
		if (flag)
		{
			ACT.Model.GuideData currentGuide = Model<GuideModel>.Interface.GetCurrentGuide();
			if (currentGuide != null && currentGuide._isNeedSkip && GudieSkipCompt != null && GudieSkipCompt.CanSkip)
			{
				Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("Guide/ClickSkipGuide", GudieSkipCompt.BeginLongPress, 0.2f, 1, 0.1f);
			}
		}
		if (!flag)
		{
			GudieSkipCompt?.EndLongPress();
		}
	}

	private void GuideFinsh()
	{
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.ClickFinshEvent);
	}

	private void OnSkipStrongGudie()
	{
		Model<GuideModel>.Interface.SkipCurrentStrongGuide();
	}

	private void InitBgMaterialParam()
	{
		frame.GetWorldCorners(frameWorldCorner);
		for (int i = 0; i < frameWorldCorner.Length; i++)
		{
			frameWorldCorner[i] = WorldToScreenPoint(GameUtility.uiCanvas, frameWorldCorner[i]);
		}
		center.x = frameWorldCorner[0].x + (frameWorldCorner[3].x - frameWorldCorner[0].x) / 2f;
		center.y = frameWorldCorner[0].y + (frameWorldCorner[1].y - frameWorldCorner[0].y) / 2f;
		width = (frameWorldCorner[3].x - frameWorldCorner[0].x) / 2f;
		height = (frameWorldCorner[1].y - frameWorldCorner[0].y) / 2f;
		bg.material.SetVector("_Center", center);
		bg.material.SetFloat("_SliderX", width);
		bg.material.SetFloat("_SliderY", height);
	}

	private void InitClickArea(HighlightStepData highlightStepData)
	{
		clickArea.pivot = frame.pivot;
		clickArea.GetComponent<UIPassEvent>().enabled = !highlightStepData.ClickAnywhere;
		GoPressAnyKey.SetActive(highlightStepData.ClickAnywhere && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		if (highlightStepData.ClickAnywhere && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			MonoECS.instance.GetInputDeviceButtonIconAsync("Guide/ClickFinshGuideStep", OnGetHandShankSkipIcon);
		}
		if (highlightStepData.ClickAnywhere)
		{
			clickArea.anchoredPosition = Vector2.zero;
			RectTransform rectTransform = ((GameUtility.uiCanvas != null) ? (GameUtility.uiCanvas.transform as RectTransform) : null);
			clickArea.sizeDelta = ((rectTransform != null) ? rectTransform.rect.size : UIUtility.fullScreen);
		}
		else
		{
			clickArea.position = frame.position;
			clickArea.sizeDelta = frame.sizeDelta;
		}
	}

	private void OnGetHandShankSkipIcon(bool success, Sprite icon, InputDevice device)
	{
		if (!(ImagePressAnykey?.icon == null))
		{
			ImagePressAnykey.icon.sprite = (success ? icon : null);
			ImagePressAnykey.icon.gameObject.SetActive(success && icon != null);
			if (success && icon != null)
			{
				ImagePressAnykey.icon.SetNativeSize();
			}
		}
	}

	private Vector2 WorldToScreenPoint(Canvas canvas, Vector3 world)
	{
		Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(canvas.worldCamera, world);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(canvas.GetComponent<RectTransform>(), screenPoint, canvas.worldCamera, out var localPoint);
		return localPoint;
	}

	private void RegisterTextUpdateListener()
	{
		if (!(textLocalize == null))
		{
			textLocalize.OnUpdateString.RemoveListener(OnTextUpdated);
			textLocalize.OnUpdateString.AddListener(OnTextUpdated);
		}
	}

	private void UnregisterTextUpdateListener()
	{
		textLocalize?.OnUpdateString.RemoveListener(OnTextUpdated);
		_guideText = null;
		_guideTextLayoutElement = null;
	}

	private void OnTextUpdated(string localizedText)
	{
		if (textLocalize == null)
		{
			return;
		}
		if (localizedText == null)
		{
			localizedText = string.Empty;
		}
		if ((object)_guideText == null)
		{
			_guideText = textLocalize.GetComponent<TMP_Text>();
		}
		if (!(_guideText == null))
		{
			if ((object)_guideTextLayoutElement == null)
			{
				_guideTextLayoutElement = _guideText.GetComponent<LayoutElement>() ?? _guideText.gameObject.AddComponent<LayoutElement>();
			}
			ContentSizeFitter component = _guideText.GetComponent<ContentSizeFitter>();
			if (component != null)
			{
				component.horizontalFit = ContentSizeFitter.FitMode.Unconstrained;
			}
			_guideText.text = localizedText;
			_guideText.enableWordWrapping = true;
			_guideText.ForceMeshUpdate();
			float x = _guideText.GetPreferredValues(new string('中', 20), 0f, 0f).x;
			float num = Mathf.Min(_guideText.GetPreferredValues(localizedText, 0f, 0f).x, x);
			_guideTextLayoutElement.preferredWidth = num;
			_guideTextLayoutElement.minWidth = 0f;
			_guideTextLayoutElement.flexibleWidth = 0f;
			_guideTextLayoutElement.ignoreLayout = false;
			_guideText.rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, num);
		}
	}

	private Vector2 GetTextRootAnchoredPosition(HighlightGuideStepTextPosType textPosType)
	{
		Vector2 anchoredPosition = frame.anchoredPosition;
		return textPosType switch
		{
			HighlightGuideStepTextPosType.Up => new Vector2(anchoredPosition.x, anchoredPosition.y + frame.rect.yMax + 25f), 
			HighlightGuideStepTextPosType.Down => new Vector2(anchoredPosition.x, anchoredPosition.y + frame.rect.yMin - 25f), 
			HighlightGuideStepTextPosType.Left => new Vector2(anchoredPosition.x + frame.rect.xMin - 25f, anchoredPosition.y), 
			HighlightGuideStepTextPosType.Right => new Vector2(anchoredPosition.x + frame.rect.xMax + 25f, anchoredPosition.y), 
			_ => anchoredPosition, 
		};
	}

	private void InitText(HighlightStepData highlightStepData)
	{
		if (highlightStepData.GuideTutorialDesId != 0)
		{
			GuideTutorialDes data = CoreUtils.GetData(highlightStepData.GuideTutorialDesId, RuntimeConfigs.data.guideTutorialDess);
			if (data == null)
			{
				return;
			}
			if (data.type == 2)
			{
				RefreshHasPromptDisplay(data);
			}
			else
			{
				RefreshNormalDisplay(data);
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"id为{highlightStepData.Id}的引导配置中，教程描述表id没配置，不需要描述的请忽略");
		}
		textGroupRoot.anchoredPosition = Vector2.zero;
		switch (highlightStepData.TextPosType)
		{
		case HighlightGuideStepTextPosType.Up:
			textGroupRoot.anchorMin = new Vector2(0.5f, 0f);
			textGroupRoot.anchorMax = new Vector2(0.5f, 0f);
			textGroupRoot.pivot = new Vector2(0.5f, 0f);
			arrow.anchorMin = new Vector2(0.5f, 0f);
			arrow.anchorMax = new Vector2(0.5f, 0f);
			arrow.anchoredPosition = new Vector2(0f, 0f - _arrowDistance);
			arrow.rotation = Quaternion.Euler(0f, 0f, 90f);
			textRoot.anchoredPosition = GetTextRootAnchoredPosition(highlightStepData.TextPosType);
			break;
		case HighlightGuideStepTextPosType.Down:
			textGroupRoot.anchorMin = new Vector2(0.5f, 1f);
			textGroupRoot.anchorMax = new Vector2(0.5f, 1f);
			textGroupRoot.pivot = new Vector2(0.5f, 1f);
			arrow.anchorMin = new Vector2(0.5f, 1f);
			arrow.anchorMax = new Vector2(0.5f, 1f);
			arrow.anchoredPosition = new Vector2(0f, _arrowDistance);
			arrow.rotation = Quaternion.Euler(0f, 0f, -90f);
			textRoot.anchoredPosition = GetTextRootAnchoredPosition(highlightStepData.TextPosType);
			break;
		case HighlightGuideStepTextPosType.Left:
			textGroupRoot.anchorMin = new Vector2(1f, 0.5f);
			textGroupRoot.anchorMax = new Vector2(1f, 0.5f);
			textGroupRoot.pivot = new Vector2(1f, 0.5f);
			arrow.anchorMin = new Vector2(1f, 0.5f);
			arrow.anchorMax = new Vector2(1f, 0.5f);
			arrow.anchoredPosition = new Vector2(_arrowDistance, 0f);
			arrow.rotation = Quaternion.Euler(0f, 0f, 180f);
			textRoot.anchoredPosition = GetTextRootAnchoredPosition(highlightStepData.TextPosType);
			break;
		case HighlightGuideStepTextPosType.Right:
			textGroupRoot.anchorMin = new Vector2(0f, 0.5f);
			textGroupRoot.anchorMax = new Vector2(0f, 0.5f);
			textGroupRoot.pivot = new Vector2(0f, 0.5f);
			arrow.anchorMin = new Vector2(0f, 0.5f);
			arrow.anchorMax = new Vector2(0f, 0.5f);
			arrow.anchoredPosition = new Vector2(0f - _arrowDistance, 0f);
			arrow.rotation = Quaternion.Euler(0f, 0f, 0f);
			textRoot.anchoredPosition = GetTextRootAnchoredPosition(highlightStepData.TextPosType);
			break;
		}
	}

	private void RefreshHasPromptDisplay(GuideTutorialDes tipData)
	{
		_promptTMPVariables.Clear();
		int num = -1;
		for (int i = 0; i < tipData.actionPrompt.Length; i++)
		{
			string bindingAction = tipData.actionPrompt[i];
			num++;
			string bindingKeyName3;
			if (MonoECS.instance.TryGetInputActionKeyBindingInfo(bindingAction, out var bindingInfo) && bindingInfo.GetMode() == MonoECS.CompositeMode.OneModifier)
			{
				string bindingKeyName = bindingInfo.GetKeyBinding(0);
				if (KeyNameTransferToTMPVariableName(ref bindingKeyName))
				{
					_promptTMPVariables[num.FastToString()] = bindingKeyName;
					num++;
				}
				string bindingKeyName2 = bindingInfo.GetKeyBinding(-1);
				if (KeyNameTransferToTMPVariableName(ref bindingKeyName2))
				{
					_promptTMPVariables[num.FastToString()] = bindingKeyName2;
					num++;
				}
			}
			else if (MonoECS.instance.GetInputDeviceButtonBindingKeyName(bindingAction, out bindingKeyName3))
			{
				if (!KeyNameTransferToTMPVariableName(ref bindingKeyName3))
				{
					if (!LuminApplication.LogEnabled)
					{
					}
				}
				else
				{
					_promptTMPVariables[num.FastToString()] = bindingKeyName3;
				}
			}
			else
			{
				_ = LuminApplication.LogEnabled;
			}
		}
		textLocalize.SetTable("longcommon");
		Model<GuideTipModel>.Interface.SetVariables(textLocalize, _promptTMPVariables);
		textLocalize.StringReference.TableEntryReference = tipData.tutorialTitle;
	}

	private bool KeyNameTransferToTMPVariableName(ref string bindingKeyName)
	{
		if (!string.IsNullOrEmpty(bindingKeyName))
		{
			bindingKeyName = bindingKeyName.Replace("/", "_");
			if (MonoECS.instance.activeInputDevice is DualShockGamepad)
			{
				bindingKeyName = bindingKeyName.Replace("gamepad", "gamepad_Sony");
			}
			return true;
		}
		return false;
	}

	private void RefreshNormalDisplay(GuideTutorialDes tipData)
	{
		textLocalize.SetTable("longcommon");
		textLocalize.StringReference.TableEntryReference = tipData.tutorialTitle;
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (_currentGuideSelection != null)
		{
			EventSystemHelper.SetSelectedGameObject(_currentGuideSelection);
		}
	}
}
