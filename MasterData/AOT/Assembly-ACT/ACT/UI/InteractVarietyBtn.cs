using System;
using ACT.Battle;
using ACT.Config;
using ACT.Event;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace ACT.UI;

public class InteractVarietyBtn : InteractBtn
{
	public UnityEvent interactEvent;

	private bool m_interactable = true;

	public BImage icon;

	public Func<bool> interactableAddCondition;

	public GameObject guidedEffect;

	[SerializeField]
	private GameObject _pcSwitch;

	[SerializeField]
	private GameObject _gamePadSwitch;

	[SerializeField]
	private GameObject _interactprompt;

	private const string InteractBindingAction = "UI/Interact";

	private DeviceInputMode _inputMode;

	private bool _isSelected;

	private int _visibleBtnCount;

	private bool haveDown;

	private int _loadedImageInfo = int.MinValue;

	private int _loadedSpriteId = int.MinValue;

	private int _loadedConfigId = int.MinValue;

	public int Index { get; set; } = -1;

	public new void Awake()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_InteractGuideEffectActive, OnActiveGuideEffect);
		if (MonoECS.instance != null)
		{
			MonoECS.instance.onInputModeChange.AddListener(InternalOnInputDeviceChange);
			InternalOnInputDeviceChange(MonoECS.instance.InputMode);
		}
		else
		{
			RefreshInputSwitch();
		}
	}

	public void RefreshInputSwitch(bool isSelected, int visibleBtnCount)
	{
		_isSelected = isSelected;
		_visibleBtnCount = visibleBtnCount;
		RefreshInputSwitch();
	}

	private void InternalOnInputDeviceChange(DeviceInputMode type)
	{
		_inputMode = type;
		RefreshInputSwitch();
	}

	private void RefreshInputSwitch()
	{
		bool flag = _visibleBtnCount > 1 && _isSelected;
		SetActiveIfNeeded(_interactprompt, _isSelected);
		SetActiveIfNeeded(_pcSwitch, flag && _inputMode == DeviceInputMode.KeyboardAndMouse);
		SetActiveIfNeeded(_gamePadSwitch, flag && _inputMode == DeviceInputMode.Gamepad);
	}

	private static void SetActiveIfNeeded(GameObject target, bool active)
	{
		if (target != null && target.activeSelf != active)
		{
			target.SetActive(active);
		}
	}

	protected override void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_InteractGuideEffectActive, OnActiveGuideEffect);
		if (MonoECS.instance != null)
		{
			MonoECS.instance.onInputModeChange.RemoveListener(InternalOnInputDeviceChange);
		}
		base.OnDestroy();
	}

	private void OnActiveGuideEffect(BaseEventContent baseEvent)
	{
		if (baseEvent is InteractGuideEffectActive interactGuideEffectActive && guidedEffect != null)
		{
			guidedEffect.SetActive(interactGuideEffectActive.active);
		}
	}

	public override bool GetInteractable()
	{
		return m_interactable;
	}

	public override void SetInteractable(bool value)
	{
		m_interactable = value;
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		if (!IsInteractable(eventData) || !haveDown)
		{
			haveDown = false;
			return;
		}
		interactEvent?.Invoke();
		haveDown = false;
	}

	public override void OnPointerDown(PointerEventData eventData)
	{
		if (IsInteractable(eventData))
		{
			base.OnPointerDown(eventData);
			haveDown = true;
		}
	}

	public override void ApplyStateEffect(InteractBtnAniState interactBtnAniState)
	{
		if (interactBtnAniState == selected)
		{
			if (selectedEffect != null)
			{
				selectedEffect.SetActive(value: true);
			}
		}
		else if (selectedEffect != null)
		{
			selectedEffect.SetActive(value: false);
		}
	}

	public void LoadImage(int configId)
	{
		if (_loadedConfigId == configId)
		{
			return;
		}
		NPCHeadIconConfig.IconConfig iconConfig = GameLoader.meta.npcOrInteractObjectIconConfig.FindConfigById(configId);
		if (iconConfig == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"找不到 {configId} 的NPCHeadIcon");
			}
			_loadedConfigId = configId;
			_loadedImageInfo = 237;
			_loadedSpriteId = int.MinValue;
		}
		else
		{
			_loadedConfigId = configId;
			LoadImageInternal(237, iconConfig.icon);
		}
	}

	private void LoadImageInternal(int imageInfo, int spriteId)
	{
		if (_loadedImageInfo != imageInfo || _loadedSpriteId != spriteId)
		{
			_loadedImageInfo = imageInfo;
			_loadedSpriteId = spriteId;
			this.GetImageStation().LoadImageAsync(imageInfo, spriteId, icon).Forget();
		}
	}

	public void Unload()
	{
		icon.UnLoad();
		haveDown = false;
		Index = -1;
		_loadedImageInfo = int.MinValue;
		_loadedSpriteId = int.MinValue;
		_loadedConfigId = int.MinValue;
	}

	private bool IsInteractable(PointerEventData eventData)
	{
		if (eventData.button != PointerEventData.InputButton.Left)
		{
			return false;
		}
		if (!interactable)
		{
			return false;
		}
		if (interactableAddCondition == null)
		{
			return true;
		}
		return interactableAddCondition();
	}

	public void SetDiameter(float diameter)
	{
		((RectTransform)transform).sizeDelta = diameter * Vector2.one;
	}
}
