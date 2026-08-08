using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class InputFieldExtend : InputField
{
	protected override void Start()
	{
		base.transform.GetComponent<InputField>().onValueChange.AddListener(DealBlank);
		base.Start();
	}

	public override void OnPointerDown(PointerEventData eventData)
	{
		if (!MayDrag(eventData))
		{
			return;
		}
		EventSystem.current.SetSelectedGameObject(base.gameObject, eventData);
		bool flag = base.isFocused;
		base.OnPointerDown(eventData);
		if (TouchScreenKeyboard.isSupported)
		{
			DeactivateInputField();
			SendOnSubmit();
			OnSelect(eventData);
			return;
		}
		if (flag)
		{
			RectTransformUtility.ScreenPointToLocalPointInRectangle(base.textComponent.rectTransform, eventData.position, eventData.pressEventCamera, out var localPoint);
			int num = (base.caretPositionInternal = GetCharacterIndexFromPosition(localPoint) + m_DrawStart);
			base.caretSelectPositionInternal = num;
		}
		UpdateLabel();
		eventData.Use();
	}

	private bool MayDrag(PointerEventData eventData)
	{
		if (IsActive() && IsInteractable() && eventData.button == PointerEventData.InputButton.Left)
		{
			return m_TextComponent != null;
		}
		return false;
	}

	private void DealBlank(string str)
	{
		if (str.Contains(" "))
		{
			base.transform.GetComponent<InputField>().text = str.Replace(" ", "\u00a0");
		}
	}
}
