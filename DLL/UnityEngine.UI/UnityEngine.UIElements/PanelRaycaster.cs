using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine.EventSystems;

namespace UnityEngine.UIElements;

[AddComponentMenu("UI Toolkit/Panel Raycaster (UI Toolkit)")]
public class PanelRaycaster : BaseRaycaster, IRuntimePanelComponent
{
	[StructLayout(LayoutKind.Explicit, Size = 4)]
	private struct FloatIntBits
	{
		[FieldOffset(0)]
		public float f;

		[FieldOffset(0)]
		public int i;
	}

	private BaseRuntimePanel m_Panel;

	public IPanel panel
	{
		get
		{
			return (IPanel)(object)m_Panel;
		}
		set
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Expected O, but got Unknown
			BaseRuntimePanel val = (BaseRuntimePanel)value;
			if (m_Panel != val)
			{
				UnregisterCallbacks();
				m_Panel = val;
				RegisterCallbacks();
			}
		}
	}

	private GameObject selectableGameObject
	{
		get
		{
			BaseRuntimePanel obj = m_Panel;
			if (obj == null)
			{
				return null;
			}
			return obj.selectableGameObject;
		}
	}

	public override int sortOrderPriority
	{
		get
		{
			BaseRuntimePanel obj = m_Panel;
			return (int)((obj != null) ? obj.sortingPriority : 0f);
		}
	}

	public override int renderOrderPriority
	{
		get
		{
			BaseRuntimePanel obj = m_Panel;
			return ConvertFloatBitsToInt((obj != null) ? obj.sortingPriority : 0f);
		}
	}

	public override Camera eventCamera => null;

	private void RegisterCallbacks()
	{
		if (m_Panel != null)
		{
			m_Panel.destroyed += OnPanelDestroyed;
		}
	}

	private void UnregisterCallbacks()
	{
		if (m_Panel != null)
		{
			m_Panel.destroyed -= OnPanelDestroyed;
		}
	}

	private void OnPanelDestroyed()
	{
		panel = null;
	}

	public override void Raycast(PointerEventData eventData, List<RaycastResult> resultAppendList)
	{
		if (m_Panel == null)
		{
			return;
		}
		Vector3 vector = Display.RelativeMouseAt(eventData.position);
		int targetDisplay = m_Panel.targetDisplay;
		if (vector != Vector3.zero)
		{
			if ((int)vector.z != targetDisplay)
			{
				return;
			}
		}
		else
		{
			vector = eventData.position;
		}
		Vector3 vector2 = vector;
		Vector2 delta = eventData.delta;
		float num = Screen.height;
		if (targetDisplay > 0 && targetDisplay < Display.displays.Length)
		{
			num = Display.displays[targetDisplay].systemHeight;
		}
		vector2.y = num - vector2.y;
		delta.y = 0f - delta.y;
		EventSystem eventSystem = UIElementsRuntimeUtility.activeEventSystem as EventSystem;
		if (eventSystem == null || eventSystem.currentInputModule == null)
		{
			return;
		}
		int num2 = eventSystem.currentInputModule.ConvertUIToolkitPointerId(eventData);
		IEventHandler capturingElement = PointerCaptureHelper.GetCapturingElement((IPanel)(object)m_Panel, num2);
		VisualElement val = (VisualElement)(object)((capturingElement is VisualElement) ? capturingElement : null);
		if (val == null || (object)val.panel == m_Panel)
		{
			IPanel val2 = ((PointerDeviceState.GetPressedButtons(num2) != 0) ? PointerDeviceState.GetPlayerPanelWithSoftPointerCapture(num2) : null);
			Vector2 vector3 = default(Vector2);
			Vector2 vector4 = default(Vector2);
			if ((val2 == null || (object)val2 == m_Panel) && (capturingElement != null || val2 != null || (m_Panel.ScreenToPanel((Vector2)vector2, delta, ref vector3, ref vector4, false) && ((BaseVisualElementPanel)m_Panel).Pick(vector3) != null)))
			{
				resultAppendList.Add(new RaycastResult
				{
					gameObject = selectableGameObject,
					module = this,
					screenPosition = vector,
					displayIndex = m_Panel.targetDisplay
				});
			}
		}
	}

	private static int ConvertFloatBitsToInt(float f)
	{
		FloatIntBits floatIntBits = new FloatIntBits
		{
			f = f
		};
		return floatIntBits.i;
	}
}
