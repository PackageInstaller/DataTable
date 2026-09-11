using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace UnityEngine.UI;

[AddComponentMenu("UI/Scroll Rect Ex", 47)]
[SelectionBase]
[ExecuteAlways]
[DisallowMultipleComponent]
[RequireComponent(typeof(RectTransform))]
public class ScrollRectEx : ScrollRect
{
	public class ExitScrollAreaEvent : UnityEvent
	{
	}

	private ExitScrollAreaEvent m_OnExit = new ExitScrollAreaEvent();

	private bool exitArea;

	private bool callOnce;

	[SerializeField]
	public bool ResetPosition = true;

	public ExitScrollAreaEvent ExitScrollArea
	{
		get
		{
			return m_OnExit;
		}
		set
		{
			m_OnExit = value;
		}
	}

	public void AddContentPosition(Vector2 newPos)
	{
		m_ContentStartPosition += newPos;
		base.content.anchoredPosition += newPos;
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (base.content == null)
		{
			return;
		}
		if (ResetPosition)
		{
			base.normalizedPosition = new Vector2(0f, 1f);
		}
		if (base.movementType == MovementType.Elastic)
		{
			if (base.verticalNormalizedPosition > 1f || base.horizontalNormalizedPosition > 1f)
			{
				SetNormalizedPosition(1f, base.vertical ? 1 : 0);
			}
			else if (base.verticalNormalizedPosition < 0f || base.horizontalNormalizedPosition < 0f)
			{
				SetNormalizedPosition(0f, base.vertical ? 1 : 0);
			}
		}
	}

	public void SetContentAnchoredPositionInter(Vector2 position)
	{
		SetContentAnchoredPosition(position);
	}

	public void SetVerticalAnchoredPositionInter(float pos)
	{
		Vector2 anchoredPosition = base.content.anchoredPosition;
		anchoredPosition.y = pos;
		base.content.anchoredPosition = anchoredPosition;
	}

	protected override void SetContentAnchoredPosition(Vector2 position)
	{
		if (!Approximately(base.content.anchoredPosition, position))
		{
			base.SetContentAnchoredPosition(position);
		}
	}

	private static bool Approximately(Vector2 vec1, Vector2 vec2, float threshold = 0.0001f)
	{
		return (double)(vec1 - vec2).sqrMagnitude < (double)threshold;
	}

	public override void OnDrag(PointerEventData eventData)
	{
		base.OnDrag(eventData);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(base.content, eventData.position, eventData.enterEventCamera, out var localPoint);
		float num = base.content.rect.height * (1f - base.content.pivot.y);
		float num2 = base.content.rect.width * (1f - base.content.pivot.x);
		float num3 = base.content.rect.width * base.content.pivot.x;
		if (localPoint.y > num && localPoint.x <= num2 && localPoint.x >= num3)
		{
			exitArea = true;
		}
	}

	public override void OnInitializePotentialDrag(PointerEventData eventData)
	{
		base.OnInitializePotentialDrag(eventData);
		exitArea = false;
		callOnce = false;
	}

	protected override void LateUpdate()
	{
		base.LateUpdate();
		if (exitArea && !callOnce)
		{
			if (m_OnExit != null)
			{
				m_OnExit.Invoke();
			}
			callOnce = true;
		}
	}
}
