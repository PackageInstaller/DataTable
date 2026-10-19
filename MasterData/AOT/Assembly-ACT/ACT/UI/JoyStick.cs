using ACT.Battle;
using ACT.Event;
using ACT.Model;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class JoyStick : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	public enum JoystickModeEnum
	{
		Fix,
		Follow,
		Float,
		AreaFollow
	}

	public CanvasGroup PressedCanvas;

	public CanvasGroup NoPressedCanvas;

	public CanvasGroup DirCanvas;

	public Transform joystickPoint;

	public Transform joystickDir;

	public RectTransform floatRect;

	public RectTransform fixFloatRect;

	public RectTransform fixRect;

	public RectTransform dynamicRect;

	public RectTransform dynamicLimitRect;

	public GameObject guideeff;

	public float moveThreshold = 1f;

	private RectTransform m_Father;

	public RectTransform m_Bg;

	public CanvasGroup m_BgImageCanvas;

	private RectTransform rt;

	private Vector2 m_StartPos;

	private Vector2 m_StartSize;

	private Vector2 m_Offset;

	private float localScale;

	private bool m_Init;

	private Vector2 m_FloatFatherPos;

	private Vector2 m_rtFatherPos;

	private Vector2 m_FatherPos;

	private Vector2[] corners = new Vector2[4];

	public JoystickModeEnum joyStickMode;

	private OnScreenControlNodeVector2 _onScreenStick;

	private bool m_IsPCMode;

	private int m_ActivePointerId = -1;

	private Camera m_PressEventCamera;

	private bool m_IsPointerDown;

	public void Init()
	{
		m_IsPCMode = MonoECS.instance.ispc;
		InitValue();
		SettingOptions settingOptions = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Other.JoystickMode");
		UpdateJoystickMode(settingOptions.GetAppliedValue());
		TryGetComponent<OnScreenControlNodeVector2>(out _onScreenStick);
		InitJoyStick();
		settingOptions.AddApplyListener(UpdateJoystickMode);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_JoyStickBtn_UpdateBtnEffectActive, OnUpdateBtnEffectActive);
		Model<BattleMainModel>.Interface.OnMoveModeDisabledChangeEventHandler -= OnMoveModeDisabledChangeEventHandler;
		Model<BattleMainModel>.Interface.OnMoveModeDisabledChangeEventHandler += OnMoveModeDisabledChangeEventHandler;
	}

	private void InitValue()
	{
		m_Init = true;
		m_IsPointerDown = false;
		m_Father = transform.parent.GetComponentInParent<RectTransform>();
		rt = (RectTransform)transform;
		m_StartPos = m_Father.InverseTransformPoint(rt.position);
		m_StartSize = rt.rect.size / 2f * rt.localScale;
		localScale = rt.localScale.x;
		m_FloatFatherPos = m_Father.InverseTransformPoint(floatRect.position);
		m_rtFatherPos = m_StartPos;
		m_FatherPos = Vector2.zero;
		corners[0] = new Vector2(floatRect.rect.xMin, floatRect.rect.yMin);
		corners[1] = new Vector2(floatRect.rect.xMax, floatRect.rect.yMin);
		corners[2] = new Vector2(floatRect.rect.xMax, floatRect.rect.yMax);
		corners[3] = new Vector2(floatRect.rect.xMin, floatRect.rect.yMax);
		fixRect.gameObject.SetActive(value: false);
		fixFloatRect.gameObject.SetActive(value: false);
		dynamicRect.gameObject.SetActive(value: false);
		guideeff.SetActive(value: false);
	}

	private void InitJoyStick()
	{
		PressedCanvas.alpha = 0f;
		m_BgImageCanvas.alpha = 1f;
		NoPressedCanvas.alpha = 1f;
	}

	private void OnDisable()
	{
		if (m_Init && m_IsPointerDown)
		{
			ResetJoyStickState(unregisterPointer: true);
		}
	}

	private void Update()
	{
		if (!m_IsPCMode && m_Init && m_IsPointerDown)
		{
			if (!Singleton<GameInputActionManager>.instance.TouchPointer.TryGetPointerPosition(m_ActivePointerId, out var position))
			{
				ResetJoyStickState(unregisterPointer: true);
			}
			else
			{
				Handle(position, m_PressEventCamera);
			}
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (m_IsPCMode || !m_Init || m_Father == null)
		{
			return;
		}
		if (m_IsPointerDown)
		{
			eventData.Use();
		}
		else
		{
			if (!Singleton<GameInputActionManager>.instance.TouchPointer.TryRegisterPointer(eventData, out m_ActivePointerId))
			{
				return;
			}
			m_PressEventCamera = eventData.pressEventCamera;
			RectTransformUtility.ScreenPointToLocalPointInRectangle(m_Father, eventData.position, eventData.pressEventCamera, out var localPoint);
			switch (joyStickMode)
			{
			case JoystickModeEnum.Fix:
				m_Offset = m_StartPos;
				break;
			case JoystickModeEnum.Float:
				if (!RectTransformUtility.RectangleContainsScreenPoint(floatRect, eventData.position, eventData.pressEventCamera))
				{
					Vector2? vector = FindIntersection(m_rtFatherPos - m_FloatFatherPos, localPoint - m_FloatFatherPos);
					if (vector.HasValue)
					{
						vector = vector + m_FloatFatherPos - m_FatherPos;
						m_Bg.localPosition = vector.Value - m_StartPos;
						m_Offset = vector.Value;
					}
				}
				else
				{
					m_Bg.localPosition = localPoint - m_StartPos;
					m_Offset = localPoint;
				}
				break;
			default:
				m_Bg.localPosition = localPoint - m_StartPos;
				m_Offset = localPoint;
				break;
			}
			PressedCanvas.alpha = 1f;
			m_BgImageCanvas.alpha = 0f;
			NoPressedCanvas.alpha = 0f;
			m_IsPointerDown = true;
			Handle(eventData.position, eventData.pressEventCamera);
			eventData.Use();
		}
	}

	private void Handle(Vector2 screenPosition, Camera eventCamera)
	{
		if (m_Father == null)
		{
			return;
		}
		RectTransformUtility.ScreenPointToLocalPointInRectangle(m_Father, screenPosition, eventCamera, out var localPoint);
		Vector2 vector = localPoint - m_Offset;
		JoystickModeEnum joystickModeEnum = joyStickMode;
		if ((joystickModeEnum == JoystickModeEnum.Follow || joystickModeEnum == JoystickModeEnum.AreaFollow) && !((joyStickMode == JoystickModeEnum.AreaFollow) & !RectTransformUtility.RectangleContainsScreenPoint(dynamicLimitRect, screenPosition, eventCamera)))
		{
			Vector2 vector2 = vector / m_StartSize.x;
			float magnitude = vector2.magnitude;
			Vector2 normalized = vector2.normalized;
			if (magnitude > moveThreshold)
			{
				Vector3 vector3 = normalized * (magnitude - moveThreshold) * m_StartSize.x;
				m_Bg.localPosition += vector3;
				m_Offset = (Vector2)m_Bg.localPosition + m_StartPos;
				vector = localPoint - m_Offset;
			}
		}
		joystickPoint.localPosition = vector / localScale;
		vector = Vector2.ClampMagnitude(vector, m_StartSize.x);
		vector /= m_StartSize.x;
		if (Mathf.Approximately(vector.sqrMagnitude, 0f))
		{
			DirCanvas.alpha = 0f;
		}
		else
		{
			DirCanvas.alpha = 1f;
		}
		joystickDir.rotation = Quaternion.FromToRotation(Vector2.one, vector);
		SendValueToControl(vector);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (!m_IsPCMode && m_Init && eventData.pointerId == m_ActivePointerId)
		{
			ResetJoyStickState(unregisterPointer: true);
			eventData.Use();
		}
	}

	private void SendValueToControl(Vector2 delta)
	{
		_onScreenStick.SendValue(delta);
	}

	public void UnInit()
	{
		if (m_Init)
		{
			ResetJoyStickState(unregisterPointer: true);
			guideeff.SetActive(value: false);
			SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Other.JoystickMode").RemoveApplyListener(UpdateJoystickMode);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_JoyStickBtn_UpdateBtnEffectActive, OnUpdateBtnEffectActive);
			Model<BattleMainModel>.Interface.OnMoveModeDisabledChangeEventHandler -= OnMoveModeDisabledChangeEventHandler;
		}
	}

	private void ResetJoyStickState(bool unregisterPointer)
	{
		PressedCanvas.alpha = 0f;
		m_BgImageCanvas.alpha = 1f;
		NoPressedCanvas.alpha = 1f;
		m_IsPointerDown = false;
		if (m_Bg != null)
		{
			m_Bg.localPosition = Vector2.zero;
		}
		SendValueToControl(Vector2.zero);
		if (unregisterPointer && m_ActivePointerId >= 0)
		{
			Singleton<GameInputActionManager>.instance.TouchPointer.UnregisterPointer(m_ActivePointerId);
		}
		m_ActivePointerId = -1;
		m_PressEventCamera = null;
	}

	private void UpdateJoystickMode(int joystickMode)
	{
		joyStickMode = (JoystickModeEnum)joystickMode;
		switch (joyStickMode)
		{
		case JoystickModeEnum.Fix:
			fixRect.gameObject.SetActive(value: true);
			break;
		case JoystickModeEnum.Float:
			fixFloatRect.gameObject.SetActive(value: true);
			break;
		case JoystickModeEnum.Follow:
			dynamicRect.gameObject.SetActive(value: true);
			break;
		case JoystickModeEnum.AreaFollow:
			dynamicRect.gameObject.SetActive(value: true);
			break;
		}
	}

	private void OnMoveModeDisabledChangeEventHandler()
	{
		if (gameObject == null)
		{
			return;
		}
		bool moveModeDisabled = Model<BattleMainModel>.Interface.MoveModeDisabled;
		if (MonoECS.instance.ispc)
		{
			if ((bool)gameObject)
			{
				gameObject.SetActive(value: false);
			}
		}
		else if ((bool)gameObject)
		{
			gameObject.SetActive(!moveModeDisabled);
		}
	}

	private Vector2? FindIntersection(Vector2 insidePoint, Vector2 outsidePoint)
	{
		for (int i = 0; i < corners.Length; i++)
		{
			Vector2? result = LineIntersection(insidePoint, outsidePoint, corners[i], corners[(i + 1) % corners.Length]);
			if (result.HasValue)
			{
				return result;
			}
		}
		return null;
	}

	private Vector2? LineIntersection(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4)
	{
		float num = p2.y - p1.y;
		float num2 = p1.x - p2.x;
		float num3 = num * p1.x + num2 * p1.y;
		float num4 = p4.y - p3.y;
		float num5 = p3.x - p4.x;
		float num6 = num4 * p3.x + num5 * p3.y;
		float num7 = num * num5 - num4 * num2;
		if (Mathf.Abs(num7) < Mathf.Epsilon)
		{
			return null;
		}
		Vector2 vector = new Vector2((num5 * num3 - num2 * num6) / num7, (num * num6 - num4 * num3) / num7);
		if (IsBetween(p1, p2, vector) && IsBetween(p3, p4, vector))
		{
			return vector;
		}
		return null;
	}

	private bool IsBetween(Vector2 a, Vector2 b, Vector2 c)
	{
		float num = Mathf.Min(a.x, b.x);
		float num2 = Mathf.Max(a.x, b.x);
		float num3 = Mathf.Min(a.y, b.y);
		float num4 = Mathf.Max(a.y, b.y);
		if ((num < c.x || Mathf.Approximately(num, c.x)) && (c.x < num2 || Mathf.Approximately(num2, c.x)) && (num3 < c.y || Mathf.Approximately(num3, c.y)))
		{
			if (!(c.y < num4))
			{
				return Mathf.Approximately(num4, c.y);
			}
			return true;
		}
		return false;
	}

	private void OnUpdateBtnEffectActive(BaseEventContent obj = null)
	{
		if (obj is JoyStickEffectBtnEvt joyStickEffectBtnEvt && !(guideeff == null))
		{
			guideeff.SetActive(joyStickEffectBtnEvt.active);
		}
	}
}
