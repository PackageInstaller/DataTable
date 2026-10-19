using System;
using System.Collections.Generic;
using UnityEngine.EventSystems;
using UnityEngine.Serialization;

namespace UnityEngine.UI;

[AddComponentMenu("UI/Selectable", 35)]
[ExecuteAlways]
[SelectionBase]
[DisallowMultipleComponent]
public class Selectable : UIBehaviour, IMoveHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler, IPointerEnterHandler, IPointerExitHandler, ISelectHandler, IDeselectHandler
{
	public enum Transition
	{
		None,
		ColorTint,
		SpriteSwap,
		Animation
	}

	[Flags]
	private enum CanvasGroupFieldChange
	{
		None = 0,
		Enabled = 1,
		Interactable = 2,
		IgnoreParentGroups = 4
	}

	protected enum SelectionState
	{
		Normal,
		Highlighted,
		Pressed,
		Selected,
		Disabled,
		Locked
	}

	protected static Selectable[] s_Selectables = new Selectable[10];

	protected static int s_SelectableCount = 0;

	private bool m_EnableCalled;

	[SerializeField]
	[FormerlySerializedAs("navigation")]
	private Navigation m_Navigation = Navigation.defaultNavigation;

	[FormerlySerializedAs("transition")]
	[SerializeField]
	private Transition m_Transition = Transition.ColorTint;

	[FormerlySerializedAs("colors")]
	[SerializeField]
	private ColorBlock m_Colors = ColorBlock.defaultColorBlock;

	[FormerlySerializedAs("spriteState")]
	[SerializeField]
	private SpriteState m_SpriteState;

	[FormerlySerializedAs("animationTriggers")]
	[SerializeField]
	private AnimationTriggers m_AnimationTriggers = new AnimationTriggers();

	[SerializeField]
	[Tooltip("Can the Selectable be interacted with?")]
	private bool m_Interactable = true;

	[FormerlySerializedAs("highlightGraphic")]
	[SerializeField]
	[FormerlySerializedAs("m_HighlightGraphic")]
	private Graphic m_TargetGraphic;

	private bool m_GroupsAllowInteraction = true;

	protected int m_CurrentIndex = -1;

	private readonly List<CanvasGroup> m_CanvasGroupCache = new List<CanvasGroup>();

	private CanvasGroup m_WatchGroup0;

	private CanvasGroup m_WatchGroup1;

	private CanvasGroup m_WatchGroup2;

	private CanvasGroup m_WatchGroup3;

	private int m_WatchCount;

	private bool m_WatchOverflow;

	private bool m_WatchedCanvasGroupsInitialized;

	public static Selectable[] allSelectablesArray
	{
		get
		{
			Selectable[] array = new Selectable[s_SelectableCount];
			Array.Copy(s_Selectables, array, s_SelectableCount);
			return array;
		}
	}

	public static int allSelectableCount => s_SelectableCount;

	[Obsolete("Replaced with allSelectablesArray to have better performance when disabling a element", false)]
	public static List<Selectable> allSelectables => new List<Selectable>(allSelectablesArray);

	public Navigation navigation
	{
		get
		{
			return m_Navigation;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_Navigation, value))
			{
				OnSetProperty();
			}
		}
	}

	public Transition transition
	{
		get
		{
			return m_Transition;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_Transition, value))
			{
				OnSetProperty();
			}
		}
	}

	public ColorBlock colors
	{
		get
		{
			return m_Colors;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_Colors, value))
			{
				OnSetProperty();
			}
		}
	}

	public SpriteState spriteState
	{
		get
		{
			return m_SpriteState;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_SpriteState, value))
			{
				OnSetProperty();
			}
		}
	}

	public AnimationTriggers animationTriggers
	{
		get
		{
			return m_AnimationTriggers;
		}
		set
		{
			if (SetPropertyUtility.SetClass(ref m_AnimationTriggers, value))
			{
				OnSetProperty();
			}
		}
	}

	public Graphic targetGraphic
	{
		get
		{
			return m_TargetGraphic;
		}
		set
		{
			if (SetPropertyUtility.SetClass(ref m_TargetGraphic, value))
			{
				OnSetProperty();
			}
		}
	}

	public bool interactable
	{
		get
		{
			return m_Interactable;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_Interactable, value))
			{
				if (!m_Interactable && EventSystem.current != null && EventSystem.current.currentSelectedGameObject == gameObject)
				{
					EventSystem.current.SetSelectedGameObject(null);
				}
				OnSetProperty();
			}
		}
	}

	private bool isPointerInside { get; set; }

	private bool isPointerDown { get; set; }

	private bool hasSelection { get; set; }

	public Image image
	{
		get
		{
			return m_TargetGraphic as Image;
		}
		set
		{
			m_TargetGraphic = value;
		}
	}

	public Animator animator => GetComponent<Animator>();

	protected SelectionState currentSelectionState
	{
		get
		{
			if (!IsInteractable())
			{
				return SelectionState.Disabled;
			}
			if (isPointerDown)
			{
				return SelectionState.Pressed;
			}
			if (hasSelection)
			{
				return SelectionState.Selected;
			}
			if (isPointerInside)
			{
				return SelectionState.Highlighted;
			}
			return SelectionState.Normal;
		}
	}

	public ICustomFindSelectable CustomFindSelectable { get; set; }

	public static int AllSelectablesNoAlloc(Selectable[] selectables)
	{
		int num = ((selectables.Length < s_SelectableCount) ? selectables.Length : s_SelectableCount);
		Array.Copy(s_Selectables, selectables, num);
		return num;
	}

	protected Selectable()
	{
	}

	protected override void Awake()
	{
		if (m_TargetGraphic == null)
		{
			m_TargetGraphic = GetComponent<Graphic>();
		}
	}

	internal static int PackCanvasGroupNonAlphaState(CanvasGroup group)
	{
		int num = 0;
		if (group.enabled)
		{
			num |= 1;
		}
		if (group.interactable)
		{
			num |= 2;
		}
		if (group.ignoreParentGroups)
		{
			num |= 4;
		}
		return num;
	}

	internal static void NotifyCanvasGroupNonAlphaChanged(CanvasGroup group)
	{
		for (int i = 0; i < s_SelectableCount; i++)
		{
			Selectable selectable = s_Selectables[i];
			if (selectable != null)
			{
				selectable.HandleAncestorCanvasGroupNonAlphaChanged(group);
			}
		}
	}

	private void HandleAncestorCanvasGroupNonAlphaChanged(CanvasGroup group)
	{
		if (m_EnableCalled && (!m_WatchedCanvasGroupsInitialized || m_WatchOverflow || WatchesCanvasGroup(group)))
		{
			RefreshParentGroupInteraction();
		}
	}

	private bool WatchesCanvasGroup(CanvasGroup group)
	{
		if (group == null)
		{
			return false;
		}
		if (!(group == m_WatchGroup0) && !(group == m_WatchGroup1) && !(group == m_WatchGroup2))
		{
			return group == m_WatchGroup3;
		}
		return true;
	}

	private void RefreshParentGroupInteraction()
	{
		bool flag = ParentGroupAllowsInteraction();
		if (flag != m_GroupsAllowInteraction)
		{
			m_GroupsAllowInteraction = flag;
			OnSetProperty();
		}
	}

	private void InvalidateWatchedCanvasGroups()
	{
		m_WatchedCanvasGroupsInitialized = false;
		m_WatchOverflow = false;
		m_WatchCount = 0;
		m_WatchGroup0 = null;
		m_WatchGroup1 = null;
		m_WatchGroup2 = null;
		m_WatchGroup3 = null;
	}

	private void RecordWatchedCanvasGroup(CanvasGroup group)
	{
		CanvasGroupSelectableNotifier.Ensure(group);
		switch (m_WatchCount)
		{
		case 0:
			m_WatchGroup0 = group;
			break;
		case 1:
			m_WatchGroup1 = group;
			break;
		case 2:
			m_WatchGroup2 = group;
			break;
		case 3:
			m_WatchGroup3 = group;
			break;
		default:
			m_WatchOverflow = true;
			return;
		}
		m_WatchCount++;
	}

	private bool ParentGroupAllowsInteraction()
	{
		m_WatchCount = 0;
		m_WatchOverflow = false;
		m_WatchGroup0 = null;
		m_WatchGroup1 = null;
		m_WatchGroup2 = null;
		m_WatchGroup3 = null;
		Transform parent = transform;
		while (parent != null)
		{
			parent.GetComponents(m_CanvasGroupCache);
			for (int i = 0; i < m_CanvasGroupCache.Count; i++)
			{
				CanvasGroup canvasGroup = m_CanvasGroupCache[i];
				RecordWatchedCanvasGroup(canvasGroup);
				if (canvasGroup.enabled && !canvasGroup.interactable)
				{
					m_WatchedCanvasGroupsInitialized = true;
					return false;
				}
				if (canvasGroup.ignoreParentGroups)
				{
					m_WatchedCanvasGroupsInitialized = true;
					return true;
				}
			}
			parent = parent.parent;
		}
		m_WatchedCanvasGroupsInitialized = true;
		return true;
	}

	public virtual bool IsInteractable()
	{
		if (m_GroupsAllowInteraction)
		{
			return m_Interactable;
		}
		return false;
	}

	protected override void OnDidApplyAnimationProperties()
	{
		OnSetProperty();
	}

	protected override void OnEnable()
	{
		if (!m_EnableCalled)
		{
			base.OnEnable();
			if (s_SelectableCount == s_Selectables.Length)
			{
				Selectable[] destinationArray = new Selectable[s_Selectables.Length * 2];
				Array.Copy(s_Selectables, destinationArray, s_Selectables.Length);
				s_Selectables = destinationArray;
			}
			if ((bool)EventSystem.current && EventSystem.current.currentSelectedGameObject == gameObject)
			{
				hasSelection = true;
			}
			m_CurrentIndex = s_SelectableCount;
			s_Selectables[m_CurrentIndex] = this;
			s_SelectableCount++;
			isPointerDown = false;
			m_GroupsAllowInteraction = ParentGroupAllowsInteraction();
			DoStateTransition(currentSelectionState, instant: true);
			m_EnableCalled = true;
		}
	}

	protected override void OnTransformParentChanged()
	{
		base.OnTransformParentChanged();
		InvalidateWatchedCanvasGroups();
		if (m_EnableCalled)
		{
			RefreshParentGroupInteraction();
		}
	}

	private void OnSetProperty()
	{
		DoStateTransition(currentSelectionState, instant: false);
	}

	protected override void OnDisable()
	{
		if (m_EnableCalled)
		{
			s_SelectableCount--;
			s_Selectables[s_SelectableCount].m_CurrentIndex = m_CurrentIndex;
			s_Selectables[m_CurrentIndex] = s_Selectables[s_SelectableCount];
			s_Selectables[s_SelectableCount] = null;
			InstantClearState();
			base.OnDisable();
			m_EnableCalled = false;
		}
	}

	private void OnApplicationFocus(bool hasFocus)
	{
		if (!hasFocus && IsPressed())
		{
			InstantClearState();
		}
	}

	protected virtual void InstantClearState()
	{
		string normalTrigger = m_AnimationTriggers.normalTrigger;
		isPointerInside = false;
		isPointerDown = false;
		hasSelection = false;
		switch (m_Transition)
		{
		case Transition.ColorTint:
			StartColorTween(Color.white, instant: true);
			break;
		case Transition.SpriteSwap:
			DoSpriteSwap(null);
			break;
		case Transition.Animation:
			TriggerAnimation(normalTrigger);
			break;
		}
	}

	protected virtual void DoStateTransition(SelectionState state, bool instant)
	{
		if (gameObject.activeInHierarchy)
		{
			Color color;
			Sprite newSprite;
			string triggername;
			switch (state)
			{
			case SelectionState.Normal:
				color = m_Colors.normalColor;
				newSprite = null;
				triggername = m_AnimationTriggers.normalTrigger;
				break;
			case SelectionState.Highlighted:
				color = m_Colors.highlightedColor;
				newSprite = m_SpriteState.highlightedSprite;
				triggername = m_AnimationTriggers.highlightedTrigger;
				break;
			case SelectionState.Pressed:
				color = m_Colors.pressedColor;
				newSprite = m_SpriteState.pressedSprite;
				triggername = m_AnimationTriggers.pressedTrigger;
				break;
			case SelectionState.Selected:
				color = m_Colors.selectedColor;
				newSprite = m_SpriteState.selectedSprite;
				triggername = m_AnimationTriggers.selectedTrigger;
				break;
			case SelectionState.Disabled:
				color = m_Colors.disabledColor;
				newSprite = m_SpriteState.disabledSprite;
				triggername = m_AnimationTriggers.disabledTrigger;
				break;
			default:
				color = Color.black;
				newSprite = null;
				triggername = string.Empty;
				break;
			}
			switch (m_Transition)
			{
			case Transition.ColorTint:
				StartColorTween(color * m_Colors.colorMultiplier, instant);
				break;
			case Transition.SpriteSwap:
				DoSpriteSwap(newSprite);
				break;
			case Transition.Animation:
				TriggerAnimation(triggername);
				break;
			}
		}
	}

	public Selectable FindSelectable(Vector3 dir)
	{
		if (CustomFindSelectable != null)
		{
			return CustomFindSelectable.FindSelectable(dir);
		}
		dir = dir.normalized;
		Vector3 vector = Quaternion.Inverse(transform.rotation) * dir;
		Vector3 vector2 = transform.TransformPoint(GetPointOnRectEdge(transform as RectTransform, vector));
		float num = float.NegativeInfinity;
		float num2 = float.NegativeInfinity;
		float num3 = 0f;
		bool flag = navigation.wrapAround && (m_Navigation.mode == Navigation.Mode.Vertical || m_Navigation.mode == Navigation.Mode.Horizontal);
		Selectable selectable = null;
		Selectable result = null;
		for (int i = 0; i < s_SelectableCount; i++)
		{
			Selectable selectable2 = s_Selectables[i];
			if (selectable2 == this || !selectable2.IsInteractable() || selectable2.navigation.mode == Navigation.Mode.None)
			{
				continue;
			}
			RectTransform rectTransform = selectable2.transform as RectTransform;
			Vector3 position = ((rectTransform != null) ? ((Vector3)rectTransform.rect.center) : Vector3.zero);
			Vector3 rhs = selectable2.transform.TransformPoint(position) - vector2;
			float num4 = Vector3.Dot(dir, rhs);
			if (flag && num4 < 0f)
			{
				num3 = (0f - num4) * rhs.sqrMagnitude;
				if (num3 > num2)
				{
					num2 = num3;
					result = selectable2;
				}
			}
			else if (!(num4 <= 0f))
			{
				num3 = num4 / rhs.sqrMagnitude;
				if (num3 > num)
				{
					num = num3;
					selectable = selectable2;
				}
			}
		}
		if (flag && null == selectable)
		{
			return result;
		}
		return selectable;
	}

	private static Vector3 GetPointOnRectEdge(RectTransform rect, Vector2 dir)
	{
		if (rect == null)
		{
			return Vector3.zero;
		}
		if (dir != Vector2.zero)
		{
			dir /= Mathf.Max(Mathf.Abs(dir.x), Mathf.Abs(dir.y));
		}
		dir = rect.rect.center + Vector2.Scale(rect.rect.size, dir * 0.5f);
		return dir;
	}

	private void Navigate(AxisEventData eventData, Selectable sel)
	{
		if (sel != null && sel.IsActive())
		{
			eventData.selectedObject = sel.gameObject;
		}
	}

	public virtual Selectable FindSelectableOnLeft()
	{
		if (m_Navigation.mode == Navigation.Mode.Explicit)
		{
			return m_Navigation.selectOnLeft;
		}
		if (CustomFindSelectable != null)
		{
			return CustomFindSelectable.FindSelectableOnLeft();
		}
		if ((m_Navigation.mode & Navigation.Mode.Horizontal) != 0)
		{
			return FindSelectable(transform.rotation * Vector3.left);
		}
		return null;
	}

	public virtual Selectable FindSelectableOnRight()
	{
		if (m_Navigation.mode == Navigation.Mode.Explicit)
		{
			return m_Navigation.selectOnRight;
		}
		if (CustomFindSelectable != null)
		{
			return CustomFindSelectable.FindSelectableOnRight();
		}
		if ((m_Navigation.mode & Navigation.Mode.Horizontal) != 0)
		{
			return FindSelectable(transform.rotation * Vector3.right);
		}
		return null;
	}

	public virtual Selectable FindSelectableOnUp()
	{
		if (m_Navigation.mode == Navigation.Mode.Explicit)
		{
			return m_Navigation.selectOnUp;
		}
		if (CustomFindSelectable != null)
		{
			return CustomFindSelectable.FindSelectableOnUp();
		}
		if ((m_Navigation.mode & Navigation.Mode.Vertical) != 0)
		{
			return FindSelectable(transform.rotation * Vector3.up);
		}
		return null;
	}

	public virtual Selectable FindSelectableOnDown()
	{
		if (m_Navigation.mode == Navigation.Mode.Explicit)
		{
			return m_Navigation.selectOnDown;
		}
		if (CustomFindSelectable != null)
		{
			return CustomFindSelectable.FindSelectableOnDown();
		}
		if ((m_Navigation.mode & Navigation.Mode.Vertical) != 0)
		{
			return FindSelectable(transform.rotation * Vector3.down);
		}
		return null;
	}

	public virtual void OnMove(AxisEventData eventData)
	{
		switch (eventData.moveDir)
		{
		case MoveDirection.Right:
			Navigate(eventData, FindSelectableOnRight());
			break;
		case MoveDirection.Up:
			Navigate(eventData, FindSelectableOnUp());
			break;
		case MoveDirection.Left:
			Navigate(eventData, FindSelectableOnLeft());
			break;
		case MoveDirection.Down:
			Navigate(eventData, FindSelectableOnDown());
			break;
		}
	}

	private void StartColorTween(Color targetColor, bool instant)
	{
		if (!(m_TargetGraphic == null))
		{
			m_TargetGraphic.CrossFadeColor(targetColor, instant ? 0f : m_Colors.fadeDuration, ignoreTimeScale: true, useAlpha: true);
		}
	}

	private void DoSpriteSwap(Sprite newSprite)
	{
		if (!(image == null))
		{
			image.overrideSprite = newSprite;
		}
	}

	private void TriggerAnimation(string triggername)
	{
		if (transition == Transition.Animation && !(animator == null) && animator.isActiveAndEnabled && animator.hasBoundPlayables && !string.IsNullOrEmpty(triggername))
		{
			animator.ResetTrigger(m_AnimationTriggers.normalTrigger);
			animator.ResetTrigger(m_AnimationTriggers.highlightedTrigger);
			animator.ResetTrigger(m_AnimationTriggers.pressedTrigger);
			animator.ResetTrigger(m_AnimationTriggers.selectedTrigger);
			animator.ResetTrigger(m_AnimationTriggers.disabledTrigger);
			animator.SetTrigger(triggername);
		}
	}

	protected bool IsHighlighted()
	{
		if (!IsActive() || !IsInteractable())
		{
			return false;
		}
		if (isPointerInside && !isPointerDown)
		{
			return !hasSelection;
		}
		return false;
	}

	protected bool IsPressed()
	{
		if (!IsActive() || !IsInteractable())
		{
			return false;
		}
		return isPointerDown;
	}

	private void EvaluateAndTransitionToSelectionState()
	{
		if (IsActive() && IsInteractable())
		{
			DoStateTransition(currentSelectionState, instant: false);
		}
	}

	public virtual void OnPointerDown(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			if (IsInteractable() && navigation.mode != Navigation.Mode.None && EventSystem.current != null)
			{
				EventSystem.current.SetSelectedGameObject(gameObject, eventData);
			}
			isPointerDown = true;
			EvaluateAndTransitionToSelectionState();
		}
	}

	public virtual void OnPointerUp(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			isPointerDown = false;
			EvaluateAndTransitionToSelectionState();
		}
	}

	public virtual void OnPointerEnter(PointerEventData eventData)
	{
		isPointerInside = true;
		EvaluateAndTransitionToSelectionState();
	}

	public virtual void OnPointerExit(PointerEventData eventData)
	{
		isPointerInside = false;
		EvaluateAndTransitionToSelectionState();
	}

	public virtual void OnSelect(BaseEventData eventData)
	{
		hasSelection = true;
		EvaluateAndTransitionToSelectionState();
	}

	public virtual void OnDeselect(BaseEventData eventData)
	{
		hasSelection = false;
		EvaluateAndTransitionToSelectionState();
	}

	public virtual void Select()
	{
		if (!(EventSystem.current == null) && !EventSystem.current.alreadySelecting)
		{
			EventSystem.current.SetSelectedGameObject(gameObject);
		}
	}
}
