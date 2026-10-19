using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ChangeCharacterButton : ActButton
{
	[SerializeField]
	private OnScreenControlNodeBool _onScreenControlNode;

	[SerializeField]
	private PointerEventData.InputButton _HandleButtonType;

	public override void OnPointerDown(PointerEventData eventData)
	{
		if (eventData.button == _HandleButtonType)
		{
			_onScreenControlNode?.SendValue(value: true);
		}
	}

	public override void OnPointerUp(PointerEventData eventData)
	{
		if (eventData.button == _HandleButtonType)
		{
			_onScreenControlNode?.SendValue(value: false);
		}
	}

	public override void OnSelect(BaseEventData eventData)
	{
	}
}
