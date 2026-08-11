using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine.Rendering;
using UnityEngine.Serialization;
using UnityEngine.UIElements;

namespace UnityEngine.EventSystems;

[AddComponentMenu("Event/Event System")]
[DisallowMultipleComponent]
public class EventSystem : UIBehaviour
{
	private struct UIToolkitOverrideConfig
	{
		public EventSystem activeEventSystem;

		public bool sendEvents;

		public bool createPanelGameObjectsOnStart;
	}

	private List<BaseInputModule> m_SystemInputModules = new List<BaseInputModule>();

	private BaseInputModule m_CurrentInputModule;

	private static List<EventSystem> m_EventSystems = new List<EventSystem>();

	[SerializeField]
	[FormerlySerializedAs("m_Selected")]
	private GameObject m_FirstSelected;

	[SerializeField]
	private bool m_sendNavigationEvents = true;

	[SerializeField]
	private int m_DragThreshold = 10;

	private GameObject m_CurrentSelected;

	private bool m_HasFocus = true;

	private bool m_SelectionGuard;

	private BaseEventData m_DummyData;

	private static readonly Comparison<RaycastResult> s_RaycastComparer = RaycastComparer;

	private static UIToolkitOverrideConfig s_UIToolkitOverride = new UIToolkitOverrideConfig
	{
		activeEventSystem = null,
		sendEvents = true,
		createPanelGameObjectsOnStart = true
	};

	public static EventSystem current
	{
		get
		{
			if (m_EventSystems.Count <= 0)
			{
				return null;
			}
			return m_EventSystems[0];
		}
		set
		{
			int num = m_EventSystems.IndexOf(value);
			if (num > 0)
			{
				m_EventSystems.RemoveAt(num);
				m_EventSystems.Insert(0, value);
			}
			else if (num < 0)
			{
				Debug.LogError("Failed setting EventSystem.current to unknown EventSystem " + value);
			}
		}
	}

	public bool sendNavigationEvents
	{
		get
		{
			return m_sendNavigationEvents;
		}
		set
		{
			m_sendNavigationEvents = value;
		}
	}

	public int pixelDragThreshold
	{
		get
		{
			return m_DragThreshold;
		}
		set
		{
			m_DragThreshold = value;
		}
	}

	public BaseInputModule currentInputModule => m_CurrentInputModule;

	public GameObject firstSelectedGameObject
	{
		get
		{
			return m_FirstSelected;
		}
		set
		{
			m_FirstSelected = value;
		}
	}

	public GameObject currentSelectedGameObject => m_CurrentSelected;

	[Obsolete("lastSelectedGameObject is no longer supported")]
	public GameObject lastSelectedGameObject => null;

	public bool isFocused => m_HasFocus;

	public bool alreadySelecting => m_SelectionGuard;

	private BaseEventData baseEventDataCache
	{
		get
		{
			if (m_DummyData == null)
			{
				m_DummyData = new BaseEventData(this);
			}
			return m_DummyData;
		}
	}

	private bool isUIToolkitActiveEventSystem
	{
		get
		{
			if (!(s_UIToolkitOverride.activeEventSystem == this))
			{
				return s_UIToolkitOverride.activeEventSystem == null;
			}
			return true;
		}
	}

	private bool sendUIToolkitEvents
	{
		get
		{
			if (s_UIToolkitOverride.sendEvents)
			{
				return isUIToolkitActiveEventSystem;
			}
			return false;
		}
	}

	private bool createUIToolkitPanelGameObjectsOnStart
	{
		get
		{
			if (s_UIToolkitOverride.createPanelGameObjectsOnStart)
			{
				return isUIToolkitActiveEventSystem;
			}
			return false;
		}
	}

	protected EventSystem()
	{
	}

	public void UpdateModules()
	{
		GetComponents(m_SystemInputModules);
		for (int num = m_SystemInputModules.Count - 1; num >= 0; num--)
		{
			if (!m_SystemInputModules[num] || !m_SystemInputModules[num].IsActive())
			{
				m_SystemInputModules.RemoveAt(num);
			}
		}
	}

	public void SetSelectedGameObject(GameObject selected, BaseEventData pointer)
	{
		if (m_SelectionGuard)
		{
			Debug.LogError("Attempting to select " + selected?.ToString() + "while already selecting an object.");
			return;
		}
		m_SelectionGuard = true;
		if (selected == m_CurrentSelected)
		{
			m_SelectionGuard = false;
			return;
		}
		ExecuteEvents.Execute(m_CurrentSelected, pointer, ExecuteEvents.deselectHandler);
		m_CurrentSelected = selected;
		ExecuteEvents.Execute(m_CurrentSelected, pointer, ExecuteEvents.selectHandler);
		m_SelectionGuard = false;
	}

	public void SetSelectedGameObject(GameObject selected)
	{
		SetSelectedGameObject(selected, baseEventDataCache);
	}

	private static int RaycastComparer(RaycastResult lhs, RaycastResult rhs)
	{
		if (lhs.module != rhs.module)
		{
			Camera eventCamera = lhs.module.eventCamera;
			Camera eventCamera2 = rhs.module.eventCamera;
			if (eventCamera != null && eventCamera2 != null && eventCamera.depth != eventCamera2.depth)
			{
				if (eventCamera.depth < eventCamera2.depth)
				{
					return 1;
				}
				if (eventCamera.depth == eventCamera2.depth)
				{
					return 0;
				}
				return -1;
			}
			if (lhs.module.sortOrderPriority != rhs.module.sortOrderPriority)
			{
				return rhs.module.sortOrderPriority.CompareTo(lhs.module.sortOrderPriority);
			}
			if (lhs.module.renderOrderPriority != rhs.module.renderOrderPriority)
			{
				return rhs.module.renderOrderPriority.CompareTo(lhs.module.renderOrderPriority);
			}
		}
		if (lhs.sortingLayer != rhs.sortingLayer)
		{
			int layerValueFromID = SortingLayer.GetLayerValueFromID(rhs.sortingLayer);
			int layerValueFromID2 = SortingLayer.GetLayerValueFromID(lhs.sortingLayer);
			return layerValueFromID.CompareTo(layerValueFromID2);
		}
		if (lhs.sortingOrder != rhs.sortingOrder)
		{
			return rhs.sortingOrder.CompareTo(lhs.sortingOrder);
		}
		if (lhs.depth != rhs.depth && lhs.module.rootRaycaster == rhs.module.rootRaycaster)
		{
			return rhs.depth.CompareTo(lhs.depth);
		}
		if (lhs.distance != rhs.distance)
		{
			return lhs.distance.CompareTo(rhs.distance);
		}
		if (lhs.sortingGroupID != SortingGroup.invalidSortingGroupID && rhs.sortingGroupID != SortingGroup.invalidSortingGroupID)
		{
			if (lhs.sortingGroupID != rhs.sortingGroupID)
			{
				return lhs.sortingGroupID.CompareTo(rhs.sortingGroupID);
			}
			if (lhs.sortingGroupOrder != rhs.sortingGroupOrder)
			{
				return rhs.sortingGroupOrder.CompareTo(lhs.sortingGroupOrder);
			}
		}
		return lhs.index.CompareTo(rhs.index);
	}

	public void RaycastAll(PointerEventData eventData, List<RaycastResult> raycastResults)
	{
		raycastResults.Clear();
		List<BaseRaycaster> raycasters = RaycasterManager.GetRaycasters();
		int count = raycasters.Count;
		for (int i = 0; i < count; i++)
		{
			BaseRaycaster baseRaycaster = raycasters[i];
			if (!(baseRaycaster == null) && baseRaycaster.IsActive())
			{
				baseRaycaster.Raycast(eventData, raycastResults);
			}
		}
		raycastResults.Sort(s_RaycastComparer);
	}

	public bool IsPointerOverGameObject()
	{
		return IsPointerOverGameObject(-1);
	}

	public bool IsPointerOverGameObject(int pointerId)
	{
		if (m_CurrentInputModule != null)
		{
			return m_CurrentInputModule.IsPointerOverGameObject(pointerId);
		}
		return false;
	}

	public static void SetUITookitEventSystemOverride(EventSystem activeEventSystem, bool sendEvents = true, bool createPanelGameObjectsOnStart = true)
	{
		UIElementsRuntimeUtility.UnregisterEventSystem(UIElementsRuntimeUtility.activeEventSystem);
		s_UIToolkitOverride = new UIToolkitOverrideConfig
		{
			activeEventSystem = activeEventSystem,
			sendEvents = sendEvents,
			createPanelGameObjectsOnStart = createPanelGameObjectsOnStart
		};
		if (sendEvents && ((activeEventSystem != null) ? activeEventSystem : current).isActiveAndEnabled)
		{
			UIElementsRuntimeUtility.RegisterEventSystem((Object)activeEventSystem);
		}
	}

	private void CreateUIToolkitPanelGameObject(BaseRuntimePanel panel)
	{
		if (panel.selectableGameObject == null)
		{
			GameObject go = new GameObject(((Panel)panel).name, typeof(PanelEventHandler), typeof(PanelRaycaster));
			go.transform.SetParent(base.transform);
			panel.selectableGameObject = go;
			panel.destroyed += delegate
			{
				Object.DestroyImmediate(go);
			};
		}
	}

	protected override void Start()
	{
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Expected O, but got Unknown
		base.Start();
		if (!createUIToolkitPanelGameObjectsOnStart)
		{
			return;
		}
		foreach (BaseRuntimePanel sortedPlayerPanel in UIElementsRuntimeUtility.GetSortedPlayerPanels())
		{
			BaseRuntimePanel panel = sortedPlayerPanel;
			CreateUIToolkitPanelGameObject(panel);
		}
		UIElementsRuntimeUtility.onCreatePanel += CreateUIToolkitPanelGameObject;
	}

	protected override void OnDestroy()
	{
		UIElementsRuntimeUtility.onCreatePanel -= CreateUIToolkitPanelGameObject;
		base.OnDestroy();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		m_EventSystems.Add(this);
		if (sendUIToolkitEvents)
		{
			UIElementsRuntimeUtility.RegisterEventSystem((Object)this);
		}
	}

	protected override void OnDisable()
	{
		UIElementsRuntimeUtility.UnregisterEventSystem((Object)this);
		if (m_CurrentInputModule != null)
		{
			m_CurrentInputModule.DeactivateModule();
			m_CurrentInputModule = null;
		}
		m_EventSystems.Remove(this);
		base.OnDisable();
	}

	private void TickModules()
	{
		int count = m_SystemInputModules.Count;
		for (int i = 0; i < count; i++)
		{
			if (m_SystemInputModules[i] != null)
			{
				m_SystemInputModules[i].UpdateModule();
			}
		}
	}

	protected virtual void OnApplicationFocus(bool hasFocus)
	{
		m_HasFocus = hasFocus;
		if (!m_HasFocus)
		{
			TickModules();
		}
	}

	protected virtual void Update()
	{
		if (current != this)
		{
			return;
		}
		TickModules();
		bool flag = false;
		int count = m_SystemInputModules.Count;
		for (int i = 0; i < count; i++)
		{
			BaseInputModule baseInputModule = m_SystemInputModules[i];
			if (baseInputModule.IsModuleSupported() && baseInputModule.ShouldActivateModule())
			{
				if (m_CurrentInputModule != baseInputModule)
				{
					ChangeEventModule(baseInputModule);
					flag = true;
				}
				break;
			}
		}
		if (m_CurrentInputModule == null)
		{
			for (int j = 0; j < count; j++)
			{
				BaseInputModule baseInputModule2 = m_SystemInputModules[j];
				if (baseInputModule2.IsModuleSupported())
				{
					ChangeEventModule(baseInputModule2);
					flag = true;
					break;
				}
			}
		}
		if (!flag && m_CurrentInputModule != null)
		{
			m_CurrentInputModule.Process();
		}
	}

	private void ChangeEventModule(BaseInputModule module)
	{
		if (!(m_CurrentInputModule == module))
		{
			if (m_CurrentInputModule != null)
			{
				m_CurrentInputModule.DeactivateModule();
			}
			if (module != null)
			{
				module.ActivateModule();
			}
			m_CurrentInputModule = module;
		}
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine("<b>Selected:</b>" + currentSelectedGameObject);
		stringBuilder.AppendLine();
		stringBuilder.AppendLine();
		stringBuilder.AppendLine((m_CurrentInputModule != null) ? m_CurrentInputModule.ToString() : "No module");
		return stringBuilder.ToString();
	}
}
