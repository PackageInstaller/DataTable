using System;
using System.Collections.Generic;
using UnityEngine.UIElements;

namespace UnityEngine.EventSystems;

[RequireComponent(typeof(EventSystem))]
public abstract class BaseInputModule : UIBehaviour
{
	[NonSerialized]
	protected List<RaycastResult> m_RaycastResultCache = new List<RaycastResult>();

	[SerializeField]
	private bool m_SendPointerHoverToParent = true;

	private AxisEventData m_AxisEventData;

	private EventSystem m_EventSystem;

	private BaseEventData m_BaseEventData;

	protected BaseInput m_InputOverride;

	private BaseInput m_DefaultInput;

	internal bool sendPointerHoverToParent
	{
		get
		{
			return m_SendPointerHoverToParent;
		}
		set
		{
			m_SendPointerHoverToParent = value;
		}
	}

	public BaseInput input
	{
		get
		{
			if (m_InputOverride != null)
			{
				return m_InputOverride;
			}
			if (m_DefaultInput == null)
			{
				BaseInput[] components = GetComponents<BaseInput>();
				foreach (BaseInput baseInput in components)
				{
					if (baseInput != null && baseInput.GetType() == typeof(BaseInput))
					{
						m_DefaultInput = baseInput;
						break;
					}
				}
				if (m_DefaultInput == null)
				{
					m_DefaultInput = base.gameObject.AddComponent<BaseInput>();
				}
			}
			return m_DefaultInput;
		}
	}

	public BaseInput inputOverride
	{
		get
		{
			return m_InputOverride;
		}
		set
		{
			m_InputOverride = value;
		}
	}

	protected EventSystem eventSystem => m_EventSystem;

	protected override void OnEnable()
	{
		base.OnEnable();
		m_EventSystem = GetComponent<EventSystem>();
		m_EventSystem.UpdateModules();
	}

	protected override void OnDisable()
	{
		m_EventSystem.UpdateModules();
		base.OnDisable();
	}

	public abstract void Process();

	protected static RaycastResult FindFirstRaycast(List<RaycastResult> candidates)
	{
		int count = candidates.Count;
		for (int i = 0; i < count; i++)
		{
			if (!(candidates[i].gameObject == null))
			{
				return candidates[i];
			}
		}
		return default(RaycastResult);
	}

	protected static MoveDirection DetermineMoveDirection(float x, float y)
	{
		return DetermineMoveDirection(x, y, 0.6f);
	}

	protected static MoveDirection DetermineMoveDirection(float x, float y, float deadZone)
	{
		if (new Vector2(x, y).sqrMagnitude < deadZone * deadZone)
		{
			return MoveDirection.None;
		}
		if (Mathf.Abs(x) > Mathf.Abs(y))
		{
			if (!(x > 0f))
			{
				return MoveDirection.Left;
			}
			return MoveDirection.Right;
		}
		if (!(y > 0f))
		{
			return MoveDirection.Down;
		}
		return MoveDirection.Up;
	}

	protected static GameObject FindCommonRoot(GameObject g1, GameObject g2)
	{
		if (g1 == null || g2 == null)
		{
			return null;
		}
		Transform parent = g1.transform;
		while (parent != null)
		{
			Transform parent2 = g2.transform;
			while (parent2 != null)
			{
				if (parent == parent2)
				{
					return parent.gameObject;
				}
				parent2 = parent2.parent;
			}
			parent = parent.parent;
		}
		return null;
	}

	protected void HandlePointerExitAndEnter(PointerEventData currentPointerData, GameObject newEnterTarget)
	{
		if (newEnterTarget == null || currentPointerData.pointerEnter == null)
		{
			int count = currentPointerData.hovered.Count;
			for (int i = 0; i < count; i++)
			{
				currentPointerData.fullyExited = true;
				ExecuteEvents.Execute(currentPointerData.hovered[i], currentPointerData, ExecuteEvents.pointerMoveHandler);
				ExecuteEvents.Execute(currentPointerData.hovered[i], currentPointerData, ExecuteEvents.pointerExitHandler);
			}
			currentPointerData.hovered.Clear();
			if (newEnterTarget == null)
			{
				currentPointerData.pointerEnter = null;
				return;
			}
		}
		if (currentPointerData.pointerEnter == newEnterTarget && (bool)newEnterTarget)
		{
			if (currentPointerData.IsPointerMoving())
			{
				int count2 = currentPointerData.hovered.Count;
				for (int j = 0; j < count2; j++)
				{
					ExecuteEvents.Execute(currentPointerData.hovered[j], currentPointerData, ExecuteEvents.pointerMoveHandler);
				}
			}
			return;
		}
		GameObject gameObject = FindCommonRoot(currentPointerData.pointerEnter, newEnterTarget);
		GameObject gameObject2 = ((Component)newEnterTarget.GetComponentInParent<IPointerExitHandler>())?.gameObject;
		if (currentPointerData.pointerEnter != null)
		{
			Transform parent = currentPointerData.pointerEnter.transform;
			while (parent != null && (!m_SendPointerHoverToParent || !(gameObject != null) || !(gameObject.transform == parent)) && (m_SendPointerHoverToParent || !(gameObject2 == parent.gameObject)))
			{
				currentPointerData.fullyExited = parent.gameObject != gameObject && currentPointerData.pointerEnter != newEnterTarget;
				ExecuteEvents.Execute(parent.gameObject, currentPointerData, ExecuteEvents.pointerMoveHandler);
				ExecuteEvents.Execute(parent.gameObject, currentPointerData, ExecuteEvents.pointerExitHandler);
				currentPointerData.hovered.Remove(parent.gameObject);
				if (m_SendPointerHoverToParent)
				{
					parent = parent.parent;
				}
				if (gameObject != null && gameObject.transform == parent)
				{
					break;
				}
				if (!m_SendPointerHoverToParent)
				{
					parent = parent.parent;
				}
			}
		}
		GameObject pointerEnter = currentPointerData.pointerEnter;
		currentPointerData.pointerEnter = newEnterTarget;
		if (!(newEnterTarget != null))
		{
			return;
		}
		Transform parent2 = newEnterTarget.transform;
		while (parent2 != null)
		{
			currentPointerData.reentered = parent2.gameObject == gameObject && parent2.gameObject != pointerEnter;
			if (!m_SendPointerHoverToParent || !currentPointerData.reentered)
			{
				ExecuteEvents.Execute(parent2.gameObject, currentPointerData, ExecuteEvents.pointerEnterHandler);
				ExecuteEvents.Execute(parent2.gameObject, currentPointerData, ExecuteEvents.pointerMoveHandler);
				currentPointerData.hovered.Add(parent2.gameObject);
				if (m_SendPointerHoverToParent || parent2.gameObject.GetComponent<IPointerEnterHandler>() == null)
				{
					if (m_SendPointerHoverToParent)
					{
						parent2 = parent2.parent;
					}
					if (!(gameObject != null) || !(gameObject.transform == parent2))
					{
						if (!m_SendPointerHoverToParent)
						{
							parent2 = parent2.parent;
						}
						continue;
					}
					break;
				}
				break;
			}
			break;
		}
	}

	protected virtual AxisEventData GetAxisEventData(float x, float y, float moveDeadZone)
	{
		if (m_AxisEventData == null)
		{
			m_AxisEventData = new AxisEventData(eventSystem);
		}
		m_AxisEventData.Reset();
		m_AxisEventData.moveVector = new Vector2(x, y);
		m_AxisEventData.moveDir = DetermineMoveDirection(x, y, moveDeadZone);
		return m_AxisEventData;
	}

	protected virtual BaseEventData GetBaseEventData()
	{
		if (m_BaseEventData == null)
		{
			m_BaseEventData = new BaseEventData(eventSystem);
		}
		m_BaseEventData.Reset();
		return m_BaseEventData;
	}

	public virtual bool IsPointerOverGameObject(int pointerId)
	{
		return false;
	}

	public virtual bool ShouldActivateModule()
	{
		if (base.enabled)
		{
			return base.gameObject.activeInHierarchy;
		}
		return false;
	}

	public virtual void DeactivateModule()
	{
	}

	public virtual void ActivateModule()
	{
	}

	public virtual void UpdateModule()
	{
	}

	public virtual bool IsModuleSupported()
	{
		return true;
	}

	public virtual int ConvertUIToolkitPointerId(PointerEventData sourcePointerData)
	{
		if (sourcePointerData.pointerId >= 0)
		{
			return PointerId.touchPointerIdBase + sourcePointerData.pointerId;
		}
		return PointerId.mousePointerId;
	}
}
