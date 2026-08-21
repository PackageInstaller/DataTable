using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace P08.Gamepad;

public class HIDBottomNoticeBar : MonoBehaviour
{
	private struct InputActionInfo
	{
		public string pageName;

		public InputAction action;

		public bool topPageOnly;
	}

	private class NoticeBarItem
	{
		public GameObject gameObject;

		public HIDInputBinding binding;

		public NoticeBarItem(GameObject template, Transform parent)
		{
			gameObject = Object.Instantiate(template);
			gameObject.transform.SetParent(parent, worldPositionStays: false);
			binding = gameObject.GetComponent<HIDInputBinding>();
		}

		public void SetInputBinding(InputBinding binding)
		{
			this.binding.SetInputBinding(binding);
		}

		public void UpdateVisibility(out bool visible)
		{
			bool flag = binding.GetInputBinding().action.enabled && binding.HasKey();
			SetVisibility(flag);
			visible = flag;
		}

		public void SetVisibility(bool visible)
		{
			if (gameObject.activeSelf != visible)
			{
				gameObject.SetActive(visible);
			}
		}
	}

	public GameObject template;

	public Transform content;

	private List<InputActionInfo> _inputActionInfos = new List<InputActionInfo>();

	private bool _inputActionInfoDirty;

	private List<NoticeBarItem> _noticeItems = new List<NoticeBarItem>();

	private En_GamepadType _oldGamepadType;

	private int _oldPagesVersion = -1;

	private bool _isShowBottomBar = true;

	public bool isShowBottomBar
	{
		get
		{
			return _isShowBottomBar;
		}
		set
		{
			_isShowBottomBar = value;
		}
	}

	private void CollectInputActions()
	{
		_inputActionInfos.Clear();
		foreach (PageInputActionMap pageEnable in InputManager.system.pageEnableList)
		{
			string pageName = pageEnable.pageName;
			bool topPageOnly = pageEnable.activeType == EInputActiveType.TopPage;
			foreach (var (_, inputAction2) in pageEnable.inputActions)
			{
				if (inputAction2.showInBottomBar)
				{
					_inputActionInfos.Add(new InputActionInfo
					{
						pageName = pageName,
						action = inputAction2,
						topPageOnly = topPageOnly
					});
				}
			}
		}
	}

	private void UpdateBindings()
	{
		int count = _inputActionInfos.Count;
		int count2 = _noticeItems.Count;
		while (_noticeItems.Count < _inputActionInfos.Count)
		{
			_noticeItems.Add(new NoticeBarItem(template, content));
		}
		for (int i = 0; i < count; i++)
		{
			NoticeBarItem noticeBarItem = _noticeItems[i];
			InputActionInfo inputActionInfo = _inputActionInfos[i];
			InputAction action = inputActionInfo.action;
			InputBinding pageInputBinding_ = InputManager.system.GetPageInputBinding_(inputActionInfo.pageName, action);
			noticeBarItem.SetInputBinding(pageInputBinding_);
		}
		for (int j = count; j < count2; j++)
		{
			_noticeItems[j].SetVisibility(visible: false);
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(content as RectTransform);
	}

	private void UpdateItemVisibility(out int visibleCount)
	{
		int num = 0;
		PageInputActionMap topPage = InputManager.system.topPage;
		int count = _inputActionInfos.Count;
		for (int i = 0; i < count; i++)
		{
			InputActionInfo inputActionInfo = _inputActionInfos[i];
			NoticeBarItem noticeBarItem = _noticeItems[i];
			PageInputActionMap pageInputActionMap = InputManager.system.GetPageInputActionMap(inputActionInfo.pageName);
			if ((inputActionInfo.topPageOnly && pageInputActionMap != topPage) || !pageInputActionMap.enabled)
			{
				noticeBarItem.SetVisibility(visible: false);
				continue;
			}
			noticeBarItem.UpdateVisibility(out var visible);
			if (visible)
			{
				num++;
			}
		}
		visibleCount = num;
	}

	private void Awake()
	{
		if (template == null)
		{
			template = Asset.Load<GameObject>(InputManager.settings.pathBottomBarItem, isDontDestroy: true);
		}
		if (content == null)
		{
			content = base.gameObject.transform;
		}
	}

	private void Update()
	{
		if (!isShowBottomBar)
		{
			SwitchVisible(val: false);
			return;
		}
		if (!HIDInputRemap.IsNeedRemapNotice())
		{
			SwitchVisible(val: false);
			return;
		}
		int pagesVersion = InputManager.system.pagesVersion;
		bool flag = _oldPagesVersion != pagesVersion;
		if (flag)
		{
			_oldPagesVersion = pagesVersion;
			CollectInputActions();
			_inputActionInfoDirty = true;
		}
		int count = _inputActionInfos.Count;
		if (count == 0)
		{
			SwitchVisible(val: false);
			return;
		}
		En_GamepadType gamepadType = GamepadManager.Instance.GetGamepadType();
		int num;
		if (count == _noticeItems.Count && !_inputActionInfoDirty)
		{
			num = ((_oldGamepadType != gamepadType) ? 1 : 0);
			if (num == 0)
			{
				goto IL_00ac;
			}
		}
		else
		{
			num = 1;
		}
		UpdateBindings();
		_inputActionInfoDirty = false;
		_oldGamepadType = gamepadType;
		goto IL_00ac;
		IL_00ac:
		if (((uint)num | (flag ? 1u : 0u)) != 0)
		{
			UpdateItemVisibility(out var visibleCount);
			SwitchVisible(visibleCount > 0);
		}
	}

	private void SwitchVisible(bool val)
	{
		if (content.gameObject.activeSelf != val)
		{
			content.gameObject.SetActive(val);
		}
	}
}
