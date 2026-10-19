using System;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.LocalLoader;

public class MonoMessageBox : MonoBehaviour
{
	public enum OpenAfterAction
	{
		On,
		Off
	}

	public struct Message
	{
		public string btn1Text;

		public string btn1MiniText;

		public string btn2Text;

		public string btn2MiniText;

		public string titleText;

		public Action callBack;

		public Action callBack2;

		public int tableEntryReference;

		public string tableName;

		public string content;

		public bool isShowSingle;
	}

	public LocalizeStringEvent message;

	public Action callBack;

	public Action callBack2;

	public Button confirm;

	public Button cancel;

	public TextMeshProUGUI textMeshPro;

	public TextMeshProUGUI btn1Text;

	public TextMeshProUGUI btn2Text;

	public TextMeshProUGUI titleText;

	public GameStartMessageBtnSelector btnSelector;

	private LocalAudioManager _localAudioManager;

	private Action _onShow;

	private Action _onHide;

	public static void SetGamepadInteractable(bool interactable)
	{
		GameStartMessageBtnSelector.SetGamepadInteractable(interactable);
	}

	private void Start()
	{
		_localAudioManager = UnityEngine.Object.FindObjectOfType<LocalAudioManager>(includeInactive: true);
		confirm.onClick.AddListener(OnClick);
		cancel.onClick.AddListener(OnClick2);
	}

	public void SetShowHideCallback(Action onShow, Action onHide)
	{
		_onShow = onShow;
		_onHide = onHide;
	}

	private void OnEnable()
	{
		_onShow?.Invoke();
	}

	private void OnDisable()
	{
		_onHide?.Invoke();
	}

	public void Init(Message uiViewData)
	{
		if (_localAudioManager == null && (object)_localAudioManager == null)
		{
			_localAudioManager = UnityEngine.Object.FindObjectOfType<LocalAudioManager>(includeInactive: true);
		}
		callBack = uiViewData.callBack;
		callBack2 = uiViewData.callBack2;
		if (!string.IsNullOrEmpty(uiViewData.content))
		{
			textMeshPro.text = uiViewData.content;
			if (!string.IsNullOrEmpty(uiViewData.btn1Text))
			{
				btn1Text.SetText(uiViewData.btn1Text);
			}
			if (!string.IsNullOrEmpty(uiViewData.btn2Text))
			{
				btn2Text.SetText(uiViewData.btn2Text);
			}
			if (!string.IsNullOrEmpty(uiViewData.titleText))
			{
				titleText.SetText(uiViewData.titleText);
			}
			else
			{
				titleText.gameObject.SetActive(value: false);
			}
		}
		else
		{
			message.SetTable(uiViewData.tableName);
			message.StringReference.TableEntryReference = uiViewData.tableEntryReference;
		}
		gameObject.SetActive(value: true);
		_localAudioManager?.PlayWindowSound();
		bool active = uiViewData.callBack != null;
		bool active2 = uiViewData.callBack2 != null;
		confirm.gameObject.SetActive(active);
		cancel.gameObject.SetActive(active2);
		btnSelector.UpdateSelectionMode();
	}

	public void OnClick()
	{
		_localAudioManager?.PlayCommonBtnClickSound();
		callBack?.Invoke();
		gameObject.SetActive(value: false);
	}

	public void OnClick2()
	{
		_localAudioManager?.PlayCommonBtnClickSound();
		callBack2?.Invoke();
		gameObject.SetActive(value: false);
	}
}
