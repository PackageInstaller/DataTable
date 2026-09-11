using UnityEngine;
using UnityEngine.EventSystems;

namespace BilliardGame.Runtime;

public class LongPressTrigger : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IPointerClickHandler
{
	private float _timer;

	private bool _isPointerDown;

	public float _requiredHoldTime = 0.5f;

	public int index;

	public void OnPointerDown(PointerEventData eventData)
	{
		_timer = 0f;
		_isPointerDown = true;
		BilliardGameUIManager.Instance.ShowHeadInfoBar(index, isShow: true);
	}

	private void Update()
	{
		if (_isPointerDown)
		{
			_timer += Time.deltaTime;
			BilliardGameUIManager.Instance.OnLongPressHeroHead(index, _timer, _requiredHoldTime);
			if (_timer >= _requiredHoldTime)
			{
				BilliardGameUIManager.Instance.ShowHeroInfo(index);
				BilliardGameUIManager.Instance.ShowHeadInfoBar(index, isShow: false);
				_isPointerDown = false;
			}
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		_timer = 0f;
		_isPointerDown = false;
		BilliardGameUIManager.Instance.ShowHeadInfoBar(index, isShow: false);
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (BilliardGameLogicManager.Instance.turnState == TurnState.PlayerShootPhase)
		{
			BilliardGameLogicManager.Instance.CheckUseSkill(index);
		}
	}
}
