using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerCanvas : MonoBehaviour
{
	private int m_DebugTreeState;

	private Dictionary<Type, Transform> m_PrefabsMap;

	public Transform panelPrefab;

	public List<DebugUIPrefabBundle> prefabs;

	private List<DebugUIHandlerPanel> m_UIPanels;

	private int m_SelectedPanel;

	private DebugUIHandlerWidget m_SelectedWidget;

	private string m_CurrentQueryPath;

	private void OnEnable()
	{
		if (prefabs == null)
		{
			prefabs = new List<DebugUIPrefabBundle>();
		}
		if (m_PrefabsMap == null)
		{
			m_PrefabsMap = new Dictionary<Type, Transform>();
		}
		if (m_UIPanels == null)
		{
			m_UIPanels = new List<DebugUIHandlerPanel>();
		}
		DebugManager.instance.RegisterRootCanvas(this);
	}

	private void Update()
	{
		int state = DebugManager.instance.GetState();
		if (m_DebugTreeState != state)
		{
			ResetAllHierarchy();
		}
		HandleInput();
		if (m_UIPanels != null && m_SelectedPanel < m_UIPanels.Count && m_UIPanels[m_SelectedPanel] != null)
		{
			m_UIPanels[m_SelectedPanel].UpdateScroll();
		}
	}

	internal void RequestHierarchyReset()
	{
		m_DebugTreeState = -1;
	}

	private void ResetAllHierarchy()
	{
		foreach (Transform item in base.transform)
		{
			CoreUtils.Destroy(item.gameObject);
		}
		Rebuild();
	}

	private void Rebuild()
	{
		m_PrefabsMap.Clear();
		foreach (DebugUIPrefabBundle prefab in prefabs)
		{
			Type type = Type.GetType(prefab.type);
			if (type != null && prefab.prefab != null)
			{
				m_PrefabsMap.Add(type, prefab.prefab);
			}
		}
		m_UIPanels.Clear();
		m_DebugTreeState = DebugManager.instance.GetState();
		ReadOnlyCollection<DebugUI.Panel> panels = DebugManager.instance.panels;
		Rect rect = GetComponentInParent<RectTransform>().rect;
		float num = Math.Min(rect.width, rect.height) / (float)Math.Min(Screen.height, Screen.width);
		Rect safeArea = Screen.safeArea;
		Vector2 vector = new Vector2(5f, 5f);
		float x = safeArea.xMin * num;
		float num2 = (0f - safeArea.yMin) * num;
		Vector2 anchoredPosition = new Vector2(x, num2) + vector;
		DebugUIHandlerWidget selectedWidget = null;
		foreach (DebugUI.Panel item in panels)
		{
			if (!item.isEditorOnly && item.children.Count((DebugUI.Widget widget) => !widget.isEditorOnly && !widget.isHidden) != 0)
			{
				GameObject obj = Object.Instantiate(panelPrefab, base.transform, worldPositionStays: false).gameObject;
				obj.name = item.displayName;
				RectTransform component = obj.GetComponent<RectTransform>();
				component.anchoredPosition = anchoredPosition;
				component.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, safeArea.height * num + 2f * num2);
				DebugUIHandlerPanel component2 = obj.GetComponent<DebugUIHandlerPanel>();
				component2.SetPanel(item);
				component2.Canvas = this;
				m_UIPanels.Add(component2);
				DebugUIHandlerContainer component3 = obj.GetComponent<DebugUIHandlerContainer>();
				DebugUIHandlerWidget selectedHandler = null;
				Traverse(item, component3.contentHolder, null, ref selectedHandler);
				if (selectedHandler != null && selectedHandler.GetWidget().queryPath.Contains(item.queryPath))
				{
					selectedWidget = selectedHandler;
				}
			}
		}
		ActivatePanel(m_SelectedPanel, selectedWidget);
	}

	private void Traverse(DebugUI.IContainer container, Transform parentTransform, DebugUIHandlerWidget parentUIHandler, ref DebugUIHandlerWidget selectedHandler)
	{
		DebugUIHandlerWidget debugUIHandlerWidget = null;
		for (int i = 0; i < container.children.Count; i++)
		{
			DebugUI.Widget widget = container.children[i];
			if (widget.isEditorOnly || widget.isHidden)
			{
				continue;
			}
			if (!m_PrefabsMap.TryGetValue(widget.GetType(), out var value))
			{
				Debug.LogWarning("DebugUI widget doesn't have a prefab: " + widget.GetType());
				continue;
			}
			GameObject gameObject = Object.Instantiate(value, parentTransform, worldPositionStays: false).gameObject;
			gameObject.name = widget.displayName;
			DebugUIHandlerWidget component = gameObject.GetComponent<DebugUIHandlerWidget>();
			if (component == null)
			{
				Debug.LogWarning("DebugUI prefab is missing a DebugUIHandler for: " + widget.GetType());
				continue;
			}
			if (!string.IsNullOrEmpty(m_CurrentQueryPath) && widget.queryPath.Equals(m_CurrentQueryPath))
			{
				selectedHandler = component;
			}
			if (debugUIHandlerWidget != null)
			{
				debugUIHandlerWidget.nextUIHandler = component;
			}
			component.previousUIHandler = debugUIHandlerWidget;
			debugUIHandlerWidget = component;
			component.parentUIHandler = parentUIHandler;
			component.SetWidget(widget);
			DebugUIHandlerContainer component2 = gameObject.GetComponent<DebugUIHandlerContainer>();
			if (component2 != null && widget is DebugUI.IContainer container2)
			{
				Traverse(container2, component2.contentHolder, component, ref selectedHandler);
			}
		}
	}

	private DebugUIHandlerWidget GetWidgetFromPath(string queryPath)
	{
		if (string.IsNullOrEmpty(queryPath))
		{
			return null;
		}
		return m_UIPanels[m_SelectedPanel].GetComponentsInChildren<DebugUIHandlerWidget>().FirstOrDefault((DebugUIHandlerWidget w) => w.GetWidget().queryPath == queryPath);
	}

	private void ActivatePanel(int index, DebugUIHandlerWidget selectedWidget = null)
	{
		if (m_UIPanels.Count != 0)
		{
			if (index >= m_UIPanels.Count)
			{
				index = m_UIPanels.Count - 1;
			}
			m_UIPanels.ForEach(delegate(DebugUIHandlerPanel p)
			{
				p.gameObject.SetActive(value: false);
			});
			m_UIPanels[index].gameObject.SetActive(value: true);
			m_SelectedPanel = index;
			if (selectedWidget == null)
			{
				selectedWidget = m_UIPanels[index].GetFirstItem();
			}
			ChangeSelection(selectedWidget, fromNext: true);
		}
	}

	internal void ChangeSelection(DebugUIHandlerWidget widget, bool fromNext)
	{
		if (widget == null)
		{
			return;
		}
		if (m_SelectedWidget != null)
		{
			m_SelectedWidget.OnDeselection();
		}
		DebugUIHandlerWidget selectedWidget = m_SelectedWidget;
		m_SelectedWidget = widget;
		SetScrollTarget(widget);
		if (!m_SelectedWidget.OnSelection(fromNext, selectedWidget))
		{
			if (fromNext)
			{
				SelectNextItem();
			}
			else
			{
				SelectPreviousItem();
			}
		}
		else if (m_SelectedWidget == null || m_SelectedWidget.GetWidget() == null)
		{
			m_CurrentQueryPath = string.Empty;
		}
		else
		{
			m_CurrentQueryPath = m_SelectedWidget.GetWidget().queryPath;
		}
	}

	internal void SelectPreviousItem()
	{
		if (!(m_SelectedWidget == null))
		{
			DebugUIHandlerWidget debugUIHandlerWidget = m_SelectedWidget.Previous();
			if (debugUIHandlerWidget != null)
			{
				ChangeSelection(debugUIHandlerWidget, fromNext: false);
			}
		}
	}

	internal void SelectNextPanel()
	{
		int num = m_SelectedPanel + 1;
		if (num >= m_UIPanels.Count)
		{
			num = 0;
		}
		num = Mathf.Clamp(num, 0, m_UIPanels.Count - 1);
		ActivatePanel(num);
	}

	internal void SelectPreviousPanel()
	{
		int num = m_SelectedPanel - 1;
		if (num < 0)
		{
			num = m_UIPanels.Count - 1;
		}
		num = Mathf.Clamp(num, 0, m_UIPanels.Count - 1);
		ActivatePanel(num);
	}

	internal void SelectNextItem()
	{
		if (!(m_SelectedWidget == null))
		{
			DebugUIHandlerWidget debugUIHandlerWidget = m_SelectedWidget.Next();
			if (debugUIHandlerWidget != null)
			{
				ChangeSelection(debugUIHandlerWidget, fromNext: true);
			}
		}
	}

	private void ChangeSelectionValue(float multiplier)
	{
		if (!(m_SelectedWidget == null))
		{
			bool fast = DebugManager.instance.GetAction(DebugAction.Multiplier) != 0f;
			if (multiplier < 0f)
			{
				m_SelectedWidget.OnDecrement(fast);
			}
			else
			{
				m_SelectedWidget.OnIncrement(fast);
			}
		}
	}

	private void ActivateSelection()
	{
		if (!(m_SelectedWidget == null))
		{
			m_SelectedWidget.OnAction();
		}
	}

	private void HandleInput()
	{
		if (DebugManager.instance.GetAction(DebugAction.PreviousDebugPanel) != 0f)
		{
			SelectPreviousPanel();
		}
		if (DebugManager.instance.GetAction(DebugAction.NextDebugPanel) != 0f)
		{
			SelectNextPanel();
		}
		if (DebugManager.instance.GetAction(DebugAction.Action) != 0f)
		{
			ActivateSelection();
		}
		if (DebugManager.instance.GetAction(DebugAction.MakePersistent) != 0f && m_SelectedWidget != null)
		{
			DebugManager.instance.TogglePersistent(m_SelectedWidget.GetWidget());
		}
		float action = DebugManager.instance.GetAction(DebugAction.MoveHorizontal);
		if (action != 0f)
		{
			ChangeSelectionValue(action);
		}
		float action2 = DebugManager.instance.GetAction(DebugAction.MoveVertical);
		if (action2 != 0f)
		{
			if (action2 < 0f)
			{
				SelectNextItem();
			}
			else
			{
				SelectPreviousItem();
			}
		}
	}

	internal void SetScrollTarget(DebugUIHandlerWidget widget)
	{
		if (m_UIPanels != null && m_SelectedPanel < m_UIPanels.Count && m_UIPanels[m_SelectedPanel] != null)
		{
			m_UIPanels[m_SelectedPanel].SetScrollTarget(widget);
		}
	}
}
