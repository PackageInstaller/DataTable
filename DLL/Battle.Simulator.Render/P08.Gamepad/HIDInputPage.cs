using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

namespace P08.Gamepad;

public class HIDInputPage : MonoBehaviour
{
	[Serializable]
	public struct ActionBinding
	{
		public string actionName;

		public GameObject target;

		public bool hideNoticeUI;
	}

	public List<ActionBinding> actionBindings = new List<ActionBinding>();

	public bool noHidButton;

	public bool shouldReusePage;

	private Dictionary<string, HIDButtonBandFlag> buttonBandFlagDict = new Dictionary<string, HIDButtonBandFlag>();

	[SerializeField]
	[FormerlySerializedAs("page")]
	private PageInputActionRes _page;

	private PageInputActionMap _pageMap;

	private List<HIDInputBinding> _hidInputBindings = new List<HIDInputBinding>();

	private En_GamepadType _oldGamepadType;

	private bool _isRemapNoticed;

	private bool _actionsDirty;

	private bool _enable;

	private bool _reusing;

	private bool _forceHideFlag;

	public string pageName => pageMap.pageName;

	public PageInputActionRes page => _page;

	private PageInputActionMap pageMap
	{
		get
		{
			if (_pageMap == null)
			{
				if (shouldReusePage)
				{
					PageInputActionMap pageInputActionMap = InputManager.system.GetPageInputActionMap(_page?.pageName ?? base.gameObject.name);
					if (pageInputActionMap != null)
					{
						_reusing = true;
						_pageMap = pageInputActionMap;
						return _pageMap;
					}
				}
				_reusing = false;
				if (_page == null)
				{
					_pageMap = InputManager.system.CreateDummyPageMap(base.gameObject.name);
				}
				else
				{
					_pageMap = InputManager.system.CreatePageInputActionMap(_page);
				}
			}
			return _pageMap;
		}
		set
		{
			if (_pageMap != null)
			{
				DisablePage();
				if (!_reusing)
				{
					InputManager.system.DestroyPageInputActoinMap(_pageMap);
				}
			}
			_pageMap = value;
			if (value != null)
			{
				EnablePageIfNeed();
			}
		}
	}

	public void EnablePage()
	{
		if (!_enable)
		{
			_enable = true;
			if (!_reusing)
			{
				PageInputActionMap pageInputActionMap = pageMap;
				InputManager.system.EnablePage(pageInputActionMap);
			}
		}
	}

	public void DisablePage()
	{
		if (_enable)
		{
			if (_reusing)
			{
				_enable = false;
				return;
			}
			PageInputActionMap pageInputActionMap = pageMap;
			InputManager.system.DisablePage(pageInputActionMap);
			_enable = false;
		}
	}

	public void EnablePageIfNeed()
	{
		if (pageMap.activeType != EInputActiveType.Manual)
		{
			EnablePage();
		}
	}

	public void DisablePageIfNeed()
	{
		EInputActiveType activeType = pageMap.activeType;
		if (activeType != EInputActiveType.Manual && activeType != EInputActiveType.Global)
		{
			DisablePage();
		}
	}

	public void RebindActions()
	{
		BindActions();
		UpdateRemapVisibility(_isRemapNoticed);
	}

	public void AddAction(ActionBinding actionBinding)
	{
		Debug.Log($"HIDInputPage: AddAction({actionBinding.actionName},{actionBinding.target.name},{actionBinding.hideNoticeUI})");
		_actionsDirty = true;
		actionBindings.Add(actionBinding);
		BindAction(in actionBinding);
	}

	public void RemoveAction(ActionBinding actionBinding)
	{
		Debug.Log($"HIDInputPage: RemoveAction({actionBinding.actionName},{actionBinding.target.name},{actionBinding.hideNoticeUI})");
		_actionsDirty = true;
		GameObject target = actionBinding.target;
		if (!(target == null))
		{
			HIDButton hIDButton = U3DUtil.Get<HIDButton>(target);
			if (hIDButton != null)
			{
				hIDButton.UnRegister();
				hIDButton.pageName = null;
				hIDButton.actionName = null;
			}
			Transform transform = target.transform.Find(InputManager.settings.nameBindingNotice);
			if (transform != null && transform.TryGetComponent<HIDInputBinding>(out var component))
			{
				component.SetInputBinding(null);
				_hidInputBindings.Remove(component);
			}
			actionBindings.Remove(actionBinding);
		}
	}

	private void Awake()
	{
		if (base.isActiveAndEnabled)
		{
			BindActions();
		}
	}

	private void Update()
	{
		bool flag = HIDInputRemap.IsNeedRemapNotice();
		En_GamepadType gamepadType = GamepadManager.Instance.GetGamepadType();
		if (_isRemapNoticed != flag || _oldGamepadType != gamepadType || _actionsDirty)
		{
			UpdateRemapVisibility(flag);
			_isRemapNoticed = flag;
			_oldGamepadType = gamepadType;
			_actionsDirty = false;
		}
		RefereshBandState();
	}

	private void BindActions()
	{
		if (noHidButton)
		{
			return;
		}
		_ = pageMap.pageName;
		foreach (ActionBinding actionBinding in actionBindings)
		{
			ActionBinding binding = actionBinding;
			BindAction(in binding);
			buttonBandFlagDict[binding.actionName] = binding.target.GetComponent<HIDButtonBandFlag>();
		}
	}

	private void BindAction(in ActionBinding binding)
	{
		GameObject target = binding.target;
		if (target == null)
		{
			Debug.LogError("HIDInputPage: " + base.gameObject.name + " try bind " + binding.actionName + " to an empty object!");
		}
		else
		{
			HIDButton hIDButton = U3DUtil.Get<HIDButton>(target);
			hIDButton.pageName = pageName;
			hIDButton.actionName = binding.actionName;
			hIDButton.Rebind();
		}
	}

	public void SetRemapVisibility(bool visible)
	{
		_forceHideFlag = !visible;
		UpdateRemapVisibility(visible);
	}

	public void UpdateRemapVisibility(bool visible)
	{
		visible = (_forceHideFlag ? (!_forceHideFlag) : (visible && HIDInputRemap.IsNeedRemapNotice()));
		string nameBindingNotice = InputManager.settings.nameBindingNotice;
		_hidInputBindings.Clear();
		foreach (ActionBinding actionBinding in actionBindings)
		{
			GameObject target = actionBinding.target;
			if (target == null)
			{
				continue;
			}
			Transform transform = target.transform.Find(nameBindingNotice);
			if (actionBinding.hideNoticeUI || !visible)
			{
				transform?.gameObject.SetActive(value: false);
			}
			else if (transform == null)
			{
				transform = AddBindingNoticeGo(target);
			}
			if (!((transform != null) & visible) || !transform.TryGetComponent<HIDInputBinding>(out var component))
			{
				continue;
			}
			InputAction inputAction = _pageMap.GetInputAction(actionBinding.actionName);
			InputBinding inputBinding = null;
			if (inputAction != null)
			{
				inputBinding = _pageMap.GetInputBinding_(inputAction);
				if (inputBinding == null)
				{
					Debug.LogError("HIDInputPage: " + actionBinding.actionName + " 没有 InputBinding！");
				}
			}
			component.SetInputBinding(inputBinding);
			_hidInputBindings.Add(component);
		}
	}

	public static Transform AddBindingNoticeGo(GameObject go)
	{
		RectTransform rectTransform = go.transform as RectTransform;
		Transform obj = Asset.Instantiate(InputManager.settings.pathBindingNotice).transform;
		obj.name = InputManager.settings.nameBindingNotice;
		obj.localPosition = new Vector3(0f, (0f - rectTransform.rect.size.y) / 2f, 0f);
		obj.SetParent(rectTransform, worldPositionStays: false);
		return obj;
	}

	public void ReplaceButtonType(En_ButtonType buttonType)
	{
		if (actionBindings.Count > 1)
		{
			Debug.Log(pageName + " 的 HIDInputPage 需要动态替换按键映射，最多只能有一个 action");
		}
		foreach (ActionBinding actionBinding in actionBindings)
		{
			InputAction inputAction = _pageMap.GetInputAction(actionBinding.actionName);
			InputBinding inputBinding = null;
			if (inputAction != null)
			{
				inputBinding = _pageMap.GetInputBinding_(inputAction);
				if (inputBinding == null)
				{
					Debug.LogError("HIDInputPage: " + actionBinding.actionName + " 没有 InputBinding！");
				}
			}
			inputBinding.buttonType = buttonType;
		}
	}

	public void ReplaceButtonTypeIndex(int buttonIndex)
	{
		ReplaceButtonType((En_ButtonType)(0 + buttonIndex));
	}

	public void ReplaceNumButtonType(int num)
	{
		ReplaceButtonType((En_ButtonType)(40000 + num));
	}

	public void RevertButtonType()
	{
		foreach (HIDInputBinding hidInputBinding in _hidInputBindings)
		{
			hidInputBinding.GetInputBinding().buttonType = hidInputBinding.GetInputBinding().defaultButtonType;
		}
	}

	public void RefreshActionUI()
	{
		foreach (HIDInputBinding hidInputBinding in _hidInputBindings)
		{
			hidInputBinding.UpdateUI();
		}
	}

	public void RefereshBandState()
	{
		foreach (ActionBinding actionBinding in actionBindings)
		{
			if (!(actionBinding.target != null))
			{
				continue;
			}
			HIDButtonBandFlag hIDButtonBandFlag = buttonBandFlagDict[actionBinding.actionName];
			if ((bool)hIDButtonBandFlag)
			{
				if (GamepadManager.Instance.IsUsingJoystick())
				{
					hIDButtonBandFlag.SwitchBandButton(!Cursor.visible && PlatformHelper.IsPC());
				}
				else
				{
					hIDButtonBandFlag.SwitchBandButton(flag: true);
				}
			}
		}
	}

	private void OnEnable()
	{
		EnablePageIfNeed();
	}

	private void OnDisable()
	{
		DisablePageIfNeed();
	}

	private void OnDestroy()
	{
		pageMap = null;
	}
}
