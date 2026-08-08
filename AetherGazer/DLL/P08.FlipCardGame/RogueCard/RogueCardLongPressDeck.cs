using UnityEngine;
using UnityEngine.EventSystems;

namespace RogueCard;

public class RogueCardLongPressDeck : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IPointerClickHandler
{
	private float _timer;

	private bool _isPointerDown;

	public float _requiredHoldTime = 0.2f;

	public int index;

	public void OnPointerDown(PointerEventData eventData)
	{
		if (!RogueCardGameMain.CheckDisableInput())
		{
			_timer = 0f;
			_isPointerDown = true;
		}
	}

	private void Update()
	{
		if (_isPointerDown && !RogueCardGameMain.CheckDisableInput())
		{
			_timer += Time.deltaTime;
			if (_timer >= _requiredHoldTime)
			{
				RogueCardGameMain.Instance.ShowDeckInfoUI(isShow: true);
				_isPointerDown = false;
			}
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (!RogueCardGameMain.CheckDisableInput())
		{
			if (_timer < _requiredHoldTime)
			{
				LuaHelper.CallFunction("RogueCardGameBridge.OpenDeckInfo");
				RogueCardGameMain.Instance.HideTips();
			}
			_timer = 0f;
			_isPointerDown = false;
			RogueCardGameMain.Instance.ShowDeckInfoUI(isShow: false);
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (!RogueCardGameMain.CheckDisableInput())
		{
			RogueCardGameMain.Instance.ShowDeckInfoUI(isShow: false);
		}
	}
}
