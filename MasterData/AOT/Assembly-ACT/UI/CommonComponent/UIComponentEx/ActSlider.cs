using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

namespace UI.CommonComponent.UIComponentEx;

public class ActSlider : Slider
{
	[SerializeField]
	private UnityEvent _onPointUp = new UnityEvent();

	public UnityEvent OnPointUp
	{
		get
		{
			return _onPointUp;
		}
		set
		{
			_onPointUp = value;
		}
	}

	public override void OnPointerUp(PointerEventData eventData)
	{
		base.OnPointerUp(eventData);
		_onPointUp.Invoke();
	}
}
