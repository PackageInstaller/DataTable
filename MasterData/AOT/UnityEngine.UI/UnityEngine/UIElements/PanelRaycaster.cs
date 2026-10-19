using System.Collections.Generic;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace UnityEngine.UIElements;

[AddComponentMenu("UI Toolkit/Panel Raycaster (UI Toolkit)")]
public class PanelRaycaster : BaseRaycaster, IRuntimePanelComponent
{
	private BaseRuntimePanel m_Panel;

	public IPanel panel
	{
		get
		{
			return m_Panel;
		}
		set
		{
			BaseRuntimePanel baseRuntimePanel = (BaseRuntimePanel)value;
			if (m_Panel != baseRuntimePanel)
			{
				UnregisterCallbacks();
				m_Panel = baseRuntimePanel;
				RegisterCallbacks();
			}
		}
	}

	private GameObject selectableGameObject => m_Panel?.selectableGameObject;

	public override int sortOrderPriority => Mathf.FloorToInt(m_Panel?.sortingPriority ?? 0f);

	public override int renderOrderPriority => int.MaxValue - (UIElementsRuntimeUtility.s_ResolvedSortingIndexMax - (m_Panel?.resolvedSortingIndex ?? 0));

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
		int targetDisplay = m_Panel.targetDisplay;
		Vector3 relativeMousePositionForRaycast = MultipleDisplayUtilities.GetRelativeMousePositionForRaycast(eventData);
		if ((int)relativeMousePositionForRaycast.z != targetDisplay)
		{
			return;
		}
		Vector3 vector = relativeMousePositionForRaycast;
		Vector2 delta = eventData.delta;
		float num = Screen.height;
		if (targetDisplay > 0 && targetDisplay < Display.displays.Length)
		{
			num = Display.displays[targetDisplay].renderingHeight;
		}
		vector.y = num - vector.y;
		delta.y = 0f - delta.y;
		EventSystem eventSystem = UIElementsRuntimeUtility.activeEventSystem as EventSystem;
		if (eventSystem == null || eventSystem.currentInputModule == null)
		{
			return;
		}
		int pointerId = eventSystem.currentInputModule.ConvertUIToolkitPointerId(eventData);
		IEventHandler capturingElement = m_Panel.GetCapturingElement(pointerId);
		if (!(capturingElement is VisualElement visualElement) || visualElement.panel == m_Panel)
		{
			IPanel playerPanelWithSoftPointerCapture = PointerDeviceState.GetPlayerPanelWithSoftPointerCapture(pointerId);
			if ((playerPanelWithSoftPointerCapture == null || playerPanelWithSoftPointerCapture == m_Panel) && (capturingElement != null || playerPanelWithSoftPointerCapture != null || (m_Panel.ScreenToPanel(vector, delta, out var panelPosition, out var _) && m_Panel.Pick(panelPosition) != null)))
			{
				resultAppendList.Add(new RaycastResult
				{
					gameObject = selectableGameObject,
					module = this,
					screenPosition = relativeMousePositionForRaycast,
					displayIndex = m_Panel.targetDisplay
				});
			}
		}
	}
}
