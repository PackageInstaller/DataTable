using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SettingSwitch : MonoBehaviour, ISubmitHandler, IEventSystemHandler
{
	[Header("Data")]
	public List<LocalizedString> switchValues = new List<LocalizedString>();

	[Header("Components")]
	public ActButton LeftButton;

	public ActButton RightButton;

	[Header("Prompt")]
	public OperateBtnPrompt leftPrompt;

	public OperateBtnPrompt rightPrompt;

	public LocalizeStringEvent ValueText;

	private int currentIndex;

	public UnityEvent<int> OnValueChanged = new UnityEvent<int>();

	public int CurrentIndex
	{
		get
		{
			return currentIndex;
		}
		set
		{
			SetIndex(value);
		}
	}

	private void Awake()
	{
		SetButtonPrompt(value: false);
	}

	public void SetButtonPrompt(bool value)
	{
		leftPrompt.gameObject.SetActive(value);
		rightPrompt.gameObject.SetActive(value);
	}

	private void OnEnable()
	{
		LeftButton.OnClick.AddListener(OnClickLeft);
		RightButton.OnClick.AddListener(OnClickRight);
		RefreshUI();
	}

	private void OnDisable()
	{
		LeftButton.OnClick.RemoveListener(OnClickLeft);
		RightButton.OnClick.RemoveListener(OnClickRight);
	}

	private void OnClickLeft()
	{
		SetIndex(currentIndex - 1);
	}

	private void OnClickRight()
	{
		SetIndex(currentIndex + 1);
	}

	public void OnSubmit(BaseEventData eventData)
	{
		SetIndex((currentIndex < switchValues.Count - 1) ? (currentIndex + 1) : 0);
	}

	private void SetIndex(int newIndex)
	{
		if (switchValues != null && switchValues.Count != 0)
		{
			newIndex = Mathf.Clamp(newIndex, 0, switchValues.Count - 1);
			if (newIndex == currentIndex)
			{
				RefreshButtons();
				return;
			}
			currentIndex = newIndex;
			RefreshUI();
			OnValueChanged.Invoke(currentIndex);
		}
	}

	private void RefreshUI()
	{
		RefreshValueText();
		RefreshButtons();
	}

	private void RefreshValueText()
	{
		if (switchValues != null && switchValues.Count != 0)
		{
			ValueText.StringReference = switchValues[currentIndex];
		}
	}

	private void RefreshButtons()
	{
		if (switchValues == null || switchValues.Count == 0)
		{
			LeftButton.interactable = false;
			RightButton.interactable = false;
		}
		else
		{
			LeftButton.interactable = currentIndex > 0;
			RightButton.interactable = currentIndex < switchValues.Count - 1;
		}
	}
}
