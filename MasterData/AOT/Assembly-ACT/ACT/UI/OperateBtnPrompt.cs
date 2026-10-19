using System;
using ACT.Battle;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Sirenix.Utilities;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class OperateBtnPrompt : UIBehaviour, IOperatePromptIconCollectionItem
{
	[Header("绑定行为")]
	[SerializeField]
	private string _bindingAction;

	[Header("提示文本")]
	[SerializeField]
	private TextMeshProUGUI btnInfoText;

	[SerializeField]
	private LocalizeStringEvent btnInfo;

	[Header("功能键")]
	[SerializeField]
	private BImage promptImage;

	[SerializeField]
	private LayoutElement iconLayoutElement;

	[Header("修饰键")]
	[SerializeField]
	private GameObject modifyNode;

	[SerializeField]
	private BImage modifyImage;

	[SerializeField]
	[Header("提示图片缩放")]
	private float imageScale = 1f;

	[SerializeField]
	[Header("长按底板Root，有长按功能才显示")]
	private GameObject _longPressRoot;

	[SerializeField]
	[Header("长按圆形进度，顺时针")]
	private Image _longPressImage;

	[SerializeField]
	[Header("箭头下移偏移")]
	private RectTransform arrowRT;

	[SerializeField]
	[Header("是否启用长按，默认关闭")]
	private bool _needLongPress;

	[SerializeField]
	[Header("长按触发时间(秒)，<=0时走输入系统默认值")]
	private float _requiredLongPressTime = 2f;

	[SerializeField]
	[Header("箭头下移高度，默认4")]
	private float _arrowDownOffset = 4f;

	[SerializeField]
	[Header("激活时隐藏对象")]
	private GameObject _onVisibleHideGameObject;

	[SerializeField]
	[Header("按键不能按时的disable遮罩")]
	private GameObject _disableState;

	[SerializeField]
	[Header("在键鼠模式时隐藏prompt")]
	[Tooltip("在非HUD界面键鼠模式时不显示prompt")]
	private bool _hideFromKeyboard;

	[Header("手动挡")]
	[Tooltip("手动控制Prompt显隐，不受Controller Handle影响")]
	[SerializeField]
	private bool _manualMode;

	[SerializeField]
	private LayoutElement _layoutElement;

	private Vector2 _arrowOriginAnchoredPos;

	private bool _arrowOriginCached;

	[SerializeField]
	private bool _originIgnoreLayout;

	private LayoutElement _onVisibleHideLayoutElement;

	private Transform _onVisibleHideTransform;

	private Vector3 _onVisibleHideOriginLocalPosition;

	private bool _onVisibleHideOriginCached;

	private static readonly Vector3 HiddenLocalPosition = new Vector3(100000f, 100000f, 0f);

	private IOperatePromptIconCollection _promptIconCollection;

	private IOperatePromptIconCollectionProvider _promptCollectionProvider;

	private Transform _parentTransform;

	private int _iconRequestVersion;

	private bool _isActive;

	private bool _couldVisible = true;

	private bool _hasIcon;

	public Action OnDisplay { get; set; }

	public bool ManualMode => _manualMode;

	public bool CouldDisplay
	{
		get
		{
			if (_hasIcon)
			{
				return couldDisplay;
			}
			return false;
		}
	}

	private bool couldDisplay
	{
		get
		{
			if (CouldVisible())
			{
				if (!_manualMode)
				{
					IGameInputBindingHandle gameInputBindingHandle = _promptIconCollection?.GetInputBindingHandle();
					if (gameInputBindingHandle != null)
					{
						return Singleton<GameInputActionManager>.instance.GetHandleCallbackIsActive(gameInputBindingHandle, in _bindingAction);
					}
					return false;
				}
				return true;
			}
			return false;
		}
	}

	public bool IsDestoried { get; private set; }

	public void InitCollectionProvider(BaseUIComponent view)
	{
		_promptCollectionProvider = view;
		_promptIconCollection = view?.GetPromptCollection();
		RefreshIcon();
	}

	protected override void Awake()
	{
		base.Awake();
		if (_layoutElement == null)
		{
			_layoutElement = GetComponent<LayoutElement>();
		}
		if (_layoutElement == null)
		{
			_layoutElement = gameObject.AddComponent<LayoutElement>();
		}
		EnsureOnVisibleHideGameObjectInitialized();
	}

	protected override void Start()
	{
		base.Start();
		_parentTransform = transform.parent;
	}

	protected override void OnEnable()
	{
		if (_promptIconCollection == null)
		{
			_promptCollectionProvider = FetchPromptCollectionProvider();
			_promptCollectionProvider?.RegisterPrompt(this);
		}
		_parentTransform = transform.parent;
		EnsureOnVisibleHideGameObjectInitialized();
		ResetLongPressVisual();
		UpdateVisible();
	}

	private IOperatePromptIconCollectionProvider FetchPromptCollectionProvider()
	{
		Transform parent = transform;
		while (parent != null)
		{
			IOperatePromptIconCollectionProvider component = parent.GetComponent<IOperatePromptIconCollectionProvider>();
			if (component != null)
			{
				return component;
			}
			parent = parent.parent;
		}
		return null;
	}

	private void EnsureOnVisibleHideGameObjectInitialized()
	{
		if (_onVisibleHideGameObject == null)
		{
			return;
		}
		if ((object)_onVisibleHideTransform == null)
		{
			_onVisibleHideTransform = _onVisibleHideGameObject.transform;
		}
		if (_onVisibleHideLayoutElement == null)
		{
			_onVisibleHideLayoutElement = _onVisibleHideGameObject.GetComponent<LayoutElement>();
			if (_onVisibleHideLayoutElement == null)
			{
				_onVisibleHideLayoutElement = _onVisibleHideGameObject.AddComponent<LayoutElement>();
			}
		}
		if (!_onVisibleHideOriginCached)
		{
			_onVisibleHideOriginLocalPosition = _onVisibleHideTransform.localPosition;
			_onVisibleHideOriginCached = true;
		}
		if (!_onVisibleHideGameObject.activeSelf)
		{
			_onVisibleHideGameObject.SetActive(value: true);
		}
	}

	public void SetText(string text)
	{
		btnInfoText?.SetText(text);
	}

	public void SetLocalizeString(int tableEntryReference, string table = "Common")
	{
		btnInfo.SetTable(table);
		btnInfo.StringReference.TableEntryReference = tableEntryReference;
		if (tableEntryReference == 0)
		{
			btnInfoText?.SetText("");
		}
	}

	public void SetBindingAction(string bindingAction)
	{
		if (!(_bindingAction == bindingAction))
		{
			_bindingAction = bindingAction;
			_iconRequestVersion++;
			ClearIconState();
			UpdateVisible();
		}
	}

	public string GetBindingAction()
	{
		return _bindingAction;
	}

	protected override void OnDestroy()
	{
		IsDestoried = true;
		_promptCollectionProvider?.CancelPromptRegistration(this);
		_promptCollectionProvider = null;
		_promptIconCollection?.UnRegister(this);
		_promptIconCollection = null;
		base.OnDestroy();
	}

	void IOperatePromptIconCollectionItem.SetActive(bool active)
	{
		if (!IsDestoried)
		{
			_isActive = active;
			if (active)
			{
				RefreshIcon();
			}
			else
			{
				UpdateVisible();
			}
		}
	}

	public bool CouldVisible()
	{
		if (_isActive)
		{
			return _couldVisible;
		}
		return false;
	}

	public void SetVisible(bool vis)
	{
		_couldVisible = vis;
		UpdateVisible();
	}

	private void UpdateVisible()
	{
		if (!(this == null) && !IsDestoried)
		{
			Image image = promptImage?.icon;
			bool flag = _hasIcon && couldDisplay;
			bool flag2 = image != null && image.sprite != null;
			transform.localScale = (flag ? Vector3.one : Vector3.zero);
			if ((bool)_layoutElement && !_originIgnoreLayout)
			{
				_layoutElement.ignoreLayout = !flag;
			}
			if (image != null)
			{
				image.transform.localScale = (flag2 ? (Vector3.one * imageScale) : Vector3.zero);
			}
			if (_longPressRoot != null)
			{
				_longPressRoot.SetActive(flag && _needLongPress);
			}
			if (flag)
			{
				CompensateParentScale();
				OnDisplay?.Invoke();
			}
			UpdateOnVisibleHideGameObject(flag);
		}
	}

	private void UpdateOnVisibleHideGameObject(bool showPrompt)
	{
		if (!(_onVisibleHideGameObject == null))
		{
			if (_onVisibleHideLayoutElement != null)
			{
				_onVisibleHideLayoutElement.ignoreLayout = showPrompt;
			}
			if (_onVisibleHideOriginCached && !(_onVisibleHideTransform == null))
			{
				_onVisibleHideTransform.localPosition = (showPrompt ? HiddenLocalPosition : _onVisibleHideOriginLocalPosition);
			}
		}
	}

	private void CompensateParentScale()
	{
		if (_parentTransform != null)
		{
			Vector3 localScale = _parentTransform.localScale;
			if (localScale != Vector3.one && localScale != Vector3.zero)
			{
				transform.localScale = new Vector3(1f / localScale.x, 1f / localScale.y, 1f / localScale.z);
			}
		}
	}

	public void SetEnableState(bool enable)
	{
		_disableState?.SetActive(!enable);
	}

	public void RefreshIcon()
	{
		if (this == null || IsDestoried)
		{
			return;
		}
		string bindingAction = _bindingAction;
		int requestVersion = ++_iconRequestVersion;
		if (MonoECS.instance.TryGetInputActionKeyBindingInfo(bindingAction, out var bindingInfo) && bindingInfo.GetMode() == MonoECS.CompositeMode.OneModifier)
		{
			string keyBinding = bindingInfo.GetKeyBinding(0);
			MonoECS.instance.GetKeyIconAsync(keyBinding, (bool success, Sprite icon, InputDevice device) =>
			{
				OnGetInputModifierButtonIcon(requestVersion, bindingAction, success, icon, device);
			});
			string keyBinding2 = bindingInfo.GetKeyBinding(-1);
			MonoECS.instance.GetKeyIconAsync(keyBinding2, (bool success, Sprite icon, InputDevice device) =>
			{
				OnGetInputControlButtonIcon(requestVersion, bindingAction, success, icon, device);
			});
		}
		else
		{
			if (modifyNode != null)
			{
				modifyNode.SetActive(value: false);
			}
			MonoECS.instance.GetInputDeviceButtonIconAsync(bindingAction, (bool success, Sprite icon, InputDevice device) =>
			{
				OnGetInputControlButtonIcon(requestVersion, bindingAction, success, icon, device);
			});
		}
	}

	private void OnGetInputModifierButtonIcon(int requestVersion, string bindingAction, bool success, Sprite icon, InputDevice device)
	{
		try
		{
			if (gameObject.SafeIsUnityNull())
			{
				IsDestoried = true;
				return;
			}
		}
		catch
		{
			IsDestoried = true;
			return;
		}
		if (requestVersion != _iconRequestVersion || _bindingAction != bindingAction)
		{
			return;
		}
		if (success && icon != null)
		{
			if ((bool)modifyImage.icon)
			{
				modifyImage.icon.sprite = icon;
				modifyImage.icon.SetNativeSize();
			}
			if (modifyNode != null)
			{
				modifyNode.SetActive(value: true);
			}
		}
		else if (modifyNode != null)
		{
			modifyNode.SetActive(value: false);
		}
	}

	public void SetNeedLongPress(bool needLongPress)
	{
		_needLongPress = needLongPress;
		if (!needLongPress)
		{
			ResetLongPressVisual();
		}
		UpdateVisible();
	}

	public void SetLongPressRequiredTime(float requiredLongPressTime)
	{
		_requiredLongPressTime = requiredLongPressTime;
	}

	public void SetArrowDownOffset(float arrowDownOffset)
	{
		_arrowDownOffset = arrowDownOffset;
		if (Mathf.Approximately(GetCurrentArrowOffset(), 0f))
		{
			ResetArrowPosition();
		}
	}

	public void OnBindingPressed(bool isPressed)
	{
		if (!_needLongPress)
		{
			return;
		}
		if (isPressed)
		{
			if (!string.IsNullOrEmpty(_bindingAction))
			{
				Singleton<GameInputActionManager>.instance.GetLongPressInputHandle(_bindingAction, null, _requiredLongPressTime, 1, 0.02f, OnLongPressUpdate, OnLongPressRelease);
			}
		}
		else
		{
			OnLongPressRelease();
		}
	}

	private void OnLongPressUpdate(float progress)
	{
		if (_needLongPress)
		{
			if (_longPressImage != null)
			{
				_longPressImage.fillAmount = Mathf.Clamp01(progress);
			}
			ApplyArrowOffset(_arrowDownOffset);
		}
	}

	private void OnLongPressRelease()
	{
		ResetLongPressVisual();
	}

	private void ResetLongPressVisual()
	{
		if (_longPressImage != null)
		{
			_longPressImage.fillAmount = 0f;
		}
		ResetArrowPosition();
	}

	private void CacheArrowOriginIfNeed()
	{
		if (!_arrowOriginCached && !(arrowRT == null))
		{
			_arrowOriginAnchoredPos = arrowRT.anchoredPosition;
			_arrowOriginCached = true;
		}
	}

	private void ApplyArrowOffset(float offset)
	{
		if (!(arrowRT == null))
		{
			CacheArrowOriginIfNeed();
			arrowRT.anchoredPosition = _arrowOriginAnchoredPos + Vector2.down * offset;
		}
	}

	private void ResetArrowPosition()
	{
		if (!(arrowRT == null))
		{
			CacheArrowOriginIfNeed();
			arrowRT.anchoredPosition = _arrowOriginAnchoredPos;
		}
	}

	private float GetCurrentArrowOffset()
	{
		if (arrowRT == null)
		{
			return 0f;
		}
		CacheArrowOriginIfNeed();
		return Vector2.Distance(arrowRT.anchoredPosition, _arrowOriginAnchoredPos);
	}

	private void OnGetInputControlButtonIcon(int requestVersion, string bindingAction, bool success, Sprite icon, InputDevice device)
	{
		try
		{
			if (gameObject.SafeIsUnityNull())
			{
				IsDestoried = true;
				return;
			}
		}
		catch
		{
			IsDestoried = true;
			return;
		}
		if (requestVersion != _iconRequestVersion || _bindingAction != bindingAction)
		{
			return;
		}
		Image image = promptImage?.icon;
		if (!success || icon == null || (_hideFromKeyboard && (device is Keyboard || device is Mouse)))
		{
			_hasIcon = false;
			ClearIconState();
		}
		else
		{
			_hasIcon = true;
			if (image != null)
			{
				image.sprite = icon;
				image.SetNativeSize();
				iconLayoutElement.preferredWidth = image.preferredWidth;
				iconLayoutElement.preferredHeight = image.preferredHeight;
			}
			CompensateParentScale();
		}
		UpdateVisible();
	}

	private void ClearIconState()
	{
		_hasIcon = false;
		if (promptImage?.icon != null)
		{
			promptImage.icon.sprite = null;
		}
		if (modifyImage?.icon != null)
		{
			modifyImage.icon.sprite = null;
		}
		if (iconLayoutElement != null)
		{
			iconLayoutElement.preferredWidth = 0f;
			iconLayoutElement.preferredHeight = 0f;
		}
		if (modifyNode != null)
		{
			modifyNode.SetActive(value: false);
		}
	}

	public void SetPromptDes(LocalizeTable tableType, int tableEntryReference)
	{
		btnInfo?.SetTable(tableType);
		if (btnInfo?.StringReference != null)
		{
			btnInfo.StringReference.TableEntryReference = tableEntryReference;
		}
	}
}
