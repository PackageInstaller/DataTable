using System.Collections;
using System.Collections.Generic;
using ACT.Battle;
using ACT.UI.InputController;
using Com.ForbiddenByte.OSA.Core;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.ViewControl;

public sealed class SelectionUGUI : MonoBehaviour, ISelectHandler, IEventSystemHandler, IDeselectHandler, ISubmitHandler, ICancelHandler, IMoveHandler
{
	private const float LoopEdgeRevealFraction = 0.4f;

	private static readonly Dictionary<int, int> s_LoopLogicalSelectedIndices = new Dictionary<int, int>();

	private static readonly HashSet<int> s_LoopPendingMoveSet = new HashSet<int>();

	public List<Component> SelectionResolvers = new List<Component>();

	public GameObject Selected;

	public GameObject gamePadArrow;

	public bool ShowSelectedInKeyBoardMode;

	public bool ShowSelectedInKeyBoardModeNav;

	public bool ScrollToShow = true;

	public float ScrollToShowOffset;

	public int loopDataSourceParentLevel;

	private Coroutine _loopMoveCoroutine;

	private LoopScrollRect _pendingLoopScrollRect;

	private int _pendingLoopTargetIndex = -1;

	private MoveDirection _pendingLoopMoveDirection = MoveDirection.None;

	private LoopScrollRect _preparedLoopSelectionRect;

	private int _preparedLoopSelectionIndex = -1;

	private void Awake()
	{
		if ((bool)MonoECS.instance)
		{
			MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
			OnInputModeChanged(MonoECS.instance.InputMode);
		}
	}

	private void OnDestroy()
	{
		if ((bool)MonoECS.instance)
		{
			MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		}
	}

	private void OnEnable()
	{
		if (Selected != null)
		{
			Selected.SetActive(EventSystemHelper.CurrentSelected == gameObject);
		}
		if (gamePadArrow != null)
		{
			gamePadArrow.SetActive(EventSystemHelper.CurrentSelected == gameObject && MonoECS.instance.IsGamePadMode());
		}
	}

	private void OnDisable()
	{
		if (Selected != null)
		{
			Selected.SetActive(value: false);
		}
		if (gamePadArrow != null)
		{
			gamePadArrow.SetActive(value: false);
		}
	}

	void ISelectHandler.OnSelect(BaseEventData eventData)
	{
		if (!TryApplyPreparedLoopSelection())
		{
			SyncLoopLogicalIndexFromParent();
		}
		if (Selected != null)
		{
			if (ShowSelectedInKeyBoardModeNav && !(eventData is PointerEventData))
			{
				Selected.transform.localScale = Vector3.one;
			}
			Selected.SetActive(value: true);
		}
		if (gamePadArrow != null)
		{
			gamePadArrow.SetActive(EventSystemHelper.CurrentSelected == gameObject && MonoECS.instance.IsGamePadMode());
		}
		if (ScrollToShow)
		{
			ScrollTargetToShow(transform as RectTransform);
		}
	}

	void IDeselectHandler.OnDeselect(BaseEventData eventData)
	{
		if (Selected != null)
		{
			Selected.SetActive(value: false);
		}
		if (gamePadArrow != null)
		{
			gamePadArrow.SetActive(value: false);
		}
	}

	public bool HasEvent<T>() where T : IEventSystemHandler
	{
		foreach (Component selectionResolver in SelectionResolvers)
		{
			if ((bool)selectionResolver && selectionResolver is T)
			{
				return true;
			}
		}
		return false;
	}

	void ISubmitHandler.OnSubmit(BaseEventData eventData)
	{
		foreach (Component selectionResolver in SelectionResolvers)
		{
			if ((bool)selectionResolver && !(selectionResolver.gameObject == gameObject) && selectionResolver is ISubmitHandler submitHandler)
			{
				submitHandler.OnSubmit(eventData);
			}
		}
	}

	void ICancelHandler.OnCancel(BaseEventData eventData)
	{
		foreach (Component selectionResolver in SelectionResolvers)
		{
			if ((bool)selectionResolver && !(selectionResolver.gameObject == gameObject) && selectionResolver is ICancelHandler cancelHandler)
			{
				cancelHandler.OnCancel(eventData);
			}
		}
	}

	void IMoveHandler.OnMove(AxisEventData eventData)
	{
		if (TryHandleLoopScrollMove(eventData))
		{
			return;
		}
		foreach (Component selectionResolver in SelectionResolvers)
		{
			if (!selectionResolver || selectionResolver.gameObject == gameObject)
			{
				continue;
			}
			if (selectionResolver is Slider slider)
			{
				bool flag = slider.direction == Slider.Direction.RightToLeft || slider.direction == Slider.Direction.TopToBottom;
				switch (eventData.moveDir)
				{
				case MoveDirection.Left:
				case MoveDirection.Right:
					slider.value = (flag ? (slider.value + eventData.moveVector.x) : (slider.value - eventData.moveVector.x));
					break;
				case MoveDirection.Up:
				case MoveDirection.Down:
					slider.value = (flag ? (slider.value + eventData.moveVector.y) : (slider.value - eventData.moveVector.y));
					break;
				}
			}
			else if (selectionResolver is IMoveHandler moveHandler)
			{
				moveHandler?.OnMove(eventData);
			}
		}
	}

	private bool TryHandleLoopScrollMove(AxisEventData eventData)
	{
		if (eventData == null)
		{
			return false;
		}
		LoopScrollRect componentInParent = GetComponentInParent<LoopScrollRect>();
		ILoopScrollDataSource componentInParent2 = GetComponentInParent<ILoopScrollDataSource>();
		if (componentInParent == null || componentInParent2 == null)
		{
			return false;
		}
		int num = Mathf.Max(1, componentInParent.contentConstraintCount);
		int loopLogicalIndex = GetLoopLogicalIndex(componentInParent, componentInParent2);
		int num2 = -1;
		if (componentInParent.vertical)
		{
			switch (eventData.moveDir)
			{
			case MoveDirection.Up:
				num2 = loopLogicalIndex - num;
				break;
			case MoveDirection.Down:
				num2 = loopLogicalIndex + num;
				break;
			}
		}
		else if (componentInParent.horizontal)
		{
			switch (eventData.moveDir)
			{
			case MoveDirection.Left:
				num2 = loopLogicalIndex - num;
				break;
			case MoveDirection.Right:
				num2 = loopLogicalIndex + num;
				break;
			}
		}
		if (num2 < 0 || (componentInParent.totalCount >= 0 && num2 >= componentInParent.totalCount))
		{
			return false;
		}
		if (TrySelectLoopItem(componentInParent, num2))
		{
			ClearPendingLoopMove();
			eventData.Use();
			return true;
		}
		if (_pendingLoopScrollRect == componentInParent && _pendingLoopTargetIndex == num2 && _pendingLoopMoveDirection == eventData.moveDir && _loopMoveCoroutine != null)
		{
			eventData.Use();
			return true;
		}
		componentInParent.StopMovement();
		ApplyLoopMoveStep(componentInParent, eventData.moveDir, transform as RectTransform);
		if (_loopMoveCoroutine != null)
		{
			StopCoroutine(_loopMoveCoroutine);
		}
		_pendingLoopScrollRect = componentInParent;
		_pendingLoopTargetIndex = num2;
		_pendingLoopMoveDirection = eventData.moveDir;
		s_LoopPendingMoveSet.Add(componentInParent.GetInstanceID());
		_loopMoveCoroutine = StartCoroutine(SelectLoopItemWhenReady(componentInParent, num2, eventData.moveDir, transform as RectTransform));
		eventData.Use();
		return true;
	}

	private bool TrySelectLoopItem(LoopScrollRect loopScrollRect, int targetIndex)
	{
		if (loopScrollRect == null)
		{
			return false;
		}
		Component component = loopScrollRect.GetItem(targetIndex) as Component;
		if (component == null)
		{
			return false;
		}
		SelectionUGUI componentInChildren = component.GetComponentInChildren<SelectionUGUI>(includeInactive: true);
		if (componentInChildren != null && componentInChildren.gameObject.activeInHierarchy)
		{
			componentInChildren.PrepareLoopSelection(loopScrollRect, targetIndex);
			if (TrySetSelectedGameObject(componentInChildren.gameObject))
			{
				SetLoopLogicalIndex(loopScrollRect, targetIndex);
				return true;
			}
			componentInChildren.ClearPreparedLoopSelection();
			return false;
		}
		Selectable componentInChildren2 = component.GetComponentInChildren<Selectable>(includeInactive: true);
		if (componentInChildren2 != null && componentInChildren2.IsInteractable() && componentInChildren2.gameObject.activeInHierarchy)
		{
			SelectionUGUI selectionUGUI = componentInChildren2.GetComponent<SelectionUGUI>() ?? componentInChildren2.GetComponentInParent<SelectionUGUI>();
			if (selectionUGUI != null && selectionUGUI.gameObject == componentInChildren2.gameObject)
			{
				selectionUGUI.PrepareLoopSelection(loopScrollRect, targetIndex);
			}
			if (TrySetSelectedGameObject(componentInChildren2.gameObject))
			{
				if (selectionUGUI != null)
				{
					SetLoopLogicalIndex(loopScrollRect, targetIndex);
				}
				return true;
			}
			selectionUGUI?.ClearPreparedLoopSelection();
			return false;
		}
		return false;
	}

	private IEnumerator SelectLoopItemWhenReady(LoopScrollRect loopScrollRect, int targetIndex, MoveDirection moveDirection, RectTransform currentRect)
	{
		for (int i = 0; i < 10; i++)
		{
			yield return null;
			if (loopScrollRect == null)
			{
				yield break;
			}
			if (TrySelectLoopItem(loopScrollRect, targetIndex))
			{
				ClearPendingLoopMove();
				_loopMoveCoroutine = null;
				yield break;
			}
			if (i == 1 || i == 3 || i == 5)
			{
				ApplyLoopMoveStep(loopScrollRect, moveDirection, currentRect);
			}
		}
		ClearPendingLoopMove();
		_loopMoveCoroutine = null;
	}

	private void OnInputModeChanged(DeviceInputMode arg0)
	{
		if (InputModeUtility.ShowSelection())
		{
			if (Selected != null)
			{
				Selected.transform.localScale = Vector3.one;
			}
			if (gamePadArrow != null)
			{
				gamePadArrow.transform.localScale = Vector3.one;
			}
			return;
		}
		if (Selected != null && !ShowSelectedInKeyBoardMode)
		{
			Selected.transform.localScale = Vector3.zero;
		}
		if (gamePadArrow != null)
		{
			gamePadArrow.transform.localScale = Vector3.zero;
		}
		if (EventSystemHelper.RawSelected == gameObject)
		{
			EventSystemHelper.SetSelectedGameObject(null);
		}
	}

	public void ScrollTargetToShow(Transform target)
	{
		Transform target2 = target;
		while (target2 != null)
		{
			LoopScrollRectBase componentInParent = target2.GetComponentInParent<LoopScrollRectBase>();
			if (componentInParent != null)
			{
				RectTransform viewport = ((componentInParent.viewport != null) ? componentInParent.viewport : componentInParent.GetComponent<RectTransform>());
				RectTransform content = componentInParent.content;
				ILoopScrollDataSource loopScrollDataSource = GetLoopScrollDataSource(target2, loopDataSourceParentLevel);
				ILoopScrollDataSource loopScrollDirectDataSource = GetLoopScrollDirectDataSource(target2, componentInParent);
				Transform target3 = GetLoopScrollBoundsTarget(target2, componentInParent, loopScrollDataSource) ?? target2;
				if (TryScrollLoopBoundaryItem(target3, componentInParent, viewport, loopScrollDataSource, loopScrollDirectDataSource))
				{
					target2 = componentInParent.transform.parent;
					continue;
				}
				Vector2 anchoredPosition = content.anchoredPosition;
				ScrollTarget(ref target3, componentInParent.transform, viewport, content, componentInParent.vertical, componentInParent.horizontal, revealLoopEdge: true, loopScrollDirectDataSource);
				target2 = target3;
				if ((content.anchoredPosition - anchoredPosition).sqrMagnitude > 0.001f)
				{
					componentInParent.UpdateBounds(updateItems: true);
				}
				continue;
			}
			IOSA iOSA = FindOSAInParents(target2);
			if (iOSA != null)
			{
				ScrollOsaTarget(target, iOSA);
				Transform transform = ((iOSA.AsMonoBehaviour != null) ? iOSA.AsMonoBehaviour.transform : null);
				target2 = ((transform != null) ? transform.parent : null);
				continue;
			}
			ScrollRect componentInParent2 = target2.GetComponentInParent<ScrollRect>();
			if (componentInParent2 != null)
			{
				RectTransform viewport2 = ((componentInParent2.viewport != null) ? componentInParent2.viewport : componentInParent2.GetComponent<RectTransform>());
				RectTransform content2 = componentInParent2.content;
				ScrollTarget(ref target2, componentInParent2.transform, viewport2, content2, componentInParent2.vertical, componentInParent2.horizontal, revealLoopEdge: false);
				continue;
			}
			break;
		}
	}

	private static Transform GetLoopScrollBoundsTarget(Transform target, LoopScrollRectBase loopScrollRect, ILoopScrollDataSource dataSource)
	{
		if (target == null || loopScrollRect == null)
		{
			return target;
		}
		Transform transform = ((dataSource is Component component) ? component.transform : null);
		if (transform == null || !transform.IsChildOf(loopScrollRect.content))
		{
			return target;
		}
		return transform;
	}

	private void ScrollTarget(ref Transform target, Transform scrollRect, RectTransform viewport, RectTransform content, bool vertical, bool horizontal, bool revealLoopEdge, ILoopScrollDataSource loopDataSource = null)
	{
		RectTransform component = target.GetComponent<RectTransform>();
		if (component == null || viewport == null || content == null)
		{
			target = scrollRect.parent;
			return;
		}
		Bounds boundsInRect = GetBoundsInRect(viewport, component);
		LoopScrollRectBase loopScrollRectBase = (revealLoopEdge ? scrollRect.GetComponent<LoopScrollRectBase>() : null);
		bool suppressStartEdgePadding = false;
		bool suppressEndEdgePadding = false;
		if (loopScrollRectBase != null)
		{
			GetLoopEdgePaddingSuppressions(loopScrollRectBase, loopDataSource, out suppressStartEdgePadding, out suppressEndEdgePadding);
		}
		Vector2 zero = Vector2.zero;
		if (vertical)
		{
			float num = (revealLoopEdge ? Mathf.Max(ScrollToShowOffset, boundsInRect.size.y * 0.4f) : ScrollToShowOffset);
			float num2 = (suppressStartEdgePadding ? 0f : num);
			float num3 = (suppressEndEdgePadding ? 0f : num);
			if (loopScrollRectBase != null && loopScrollRectBase.reverseDirection)
			{
				num2 = (suppressEndEdgePadding ? 0f : num);
				num3 = (suppressStartEdgePadding ? 0f : num);
			}
			float num4 = viewport.rect.yMax - num2;
			float num5 = viewport.rect.yMin + num3;
			if (boundsInRect.max.y > num4)
			{
				zero.y = boundsInRect.max.y - num4;
			}
			else if (boundsInRect.min.y < num5)
			{
				zero.y = boundsInRect.min.y - num5;
			}
		}
		if (horizontal)
		{
			float num6 = (revealLoopEdge ? Mathf.Max(ScrollToShowOffset, boundsInRect.size.x * 0.4f) : ScrollToShowOffset);
			float num7 = (suppressStartEdgePadding ? 0f : num6);
			float num8 = (suppressEndEdgePadding ? 0f : num6);
			if (loopScrollRectBase != null && loopScrollRectBase.reverseDirection)
			{
				num7 = (suppressEndEdgePadding ? 0f : num6);
				num8 = (suppressStartEdgePadding ? 0f : num6);
			}
			float num9 = viewport.rect.xMin + num7;
			float num10 = viewport.rect.xMax - num8;
			if (boundsInRect.min.x < num9)
			{
				zero.x = boundsInRect.min.x - num9;
			}
			else if (boundsInRect.max.x > num10)
			{
				zero.x = boundsInRect.max.x - num10;
			}
		}
		content.anchoredPosition -= zero;
		target = scrollRect.parent;
	}

	private static void GetLoopEdgePaddingSuppressions(LoopScrollRectBase loopScrollRect, ILoopScrollDataSource dataSource, out bool suppressStartEdgePadding, out bool suppressEndEdgePadding)
	{
		suppressStartEdgePadding = false;
		suppressEndEdgePadding = false;
		if (!(loopScrollRect == null) && dataSource != null)
		{
			int index = dataSource.GetIndex();
			int num = Mathf.Max(1, loopScrollRect.contentConstraintCount);
			suppressStartEdgePadding = index < num;
			suppressEndEdgePadding = loopScrollRect.totalCount >= 0 && index >= GetLastGridRowStartIndex(loopScrollRect.totalCount, num);
		}
	}

	private bool TryScrollLoopBoundaryItem(Transform target, LoopScrollRectBase loopScrollRect, RectTransform viewport, ILoopScrollDataSource dataSource, ILoopScrollDataSource directDataSource)
	{
		if (target == null || loopScrollRect == null || viewport == null || directDataSource == null)
		{
			return false;
		}
		if (loopScrollRect.velocity != Vector2.zero)
		{
			return true;
		}
		if (dataSource == null)
		{
			return false;
		}
		int index = directDataSource.GetIndex();
		int num = Mathf.Max(1, loopScrollRect.contentConstraintCount);
		bool flag = index < num;
		bool flag2 = loopScrollRect.totalCount >= 0 && index >= GetLastGridRowStartIndex(loopScrollRect.totalCount, num);
		if ((!flag && !flag2) || !IsLoopBoundaryDataSource(dataSource, directDataSource, flag, flag2))
		{
			return false;
		}
		RectTransform rectTransform = target as RectTransform;
		if (rectTransform == null)
		{
			return false;
		}
		Bounds boundsInRect = GetBoundsInRect(viewport, rectTransform);
		bool flag3 = false;
		bool reverseDirection = loopScrollRect.reverseDirection;
		if (loopScrollRect.vertical)
		{
			flag3 = boundsInRect.max.y > viewport.rect.yMax + 0.1f || boundsInRect.min.y < viewport.rect.yMin - 0.1f;
		}
		if (!flag3 && loopScrollRect.horizontal)
		{
			flag3 = boundsInRect.min.x < viewport.rect.xMin - 0.1f || boundsInRect.max.x > viewport.rect.xMax + 0.1f;
		}
		if (!flag3)
		{
			return false;
		}
		loopScrollRect.StopMovement();
		if (flag)
		{
			if (loopScrollRect.vertical)
			{
				loopScrollRect.verticalNormalizedPosition = (reverseDirection ? 0f : 1f);
			}
			if (loopScrollRect.horizontal)
			{
				loopScrollRect.horizontalNormalizedPosition = (reverseDirection ? 1f : 0f);
			}
		}
		else
		{
			if (loopScrollRect.vertical)
			{
				loopScrollRect.verticalNormalizedPosition = (reverseDirection ? 1f : 0f);
			}
			if (loopScrollRect.horizontal)
			{
				loopScrollRect.horizontalNormalizedPosition = (reverseDirection ? 0f : 1f);
			}
		}
		return true;
	}

	private static int GetLastGridRowStartIndex(int totalCount, int columnCount)
	{
		if (totalCount <= 0)
		{
			return 0;
		}
		return totalCount - ((totalCount - 1) % Mathf.Max(1, columnCount) + 1);
	}

	private static bool IsLoopBoundaryDataSource(ILoopScrollDataSource dataSource, ILoopScrollDataSource directDataSource, bool isFirst, bool isLast)
	{
		if (dataSource == null || directDataSource == null)
		{
			return false;
		}
		if (dataSource == directDataSource)
		{
			return true;
		}
		if (!(dataSource is Component component) || !(directDataSource is Component component2))
		{
			return false;
		}
		if (!component.transform.IsChildOf(component2.transform))
		{
			return false;
		}
		int siblingIndex = component.transform.GetSiblingIndex();
		int childCount = component.transform.parent.childCount;
		if (isFirst && siblingIndex <= 0)
		{
			return true;
		}
		if (isLast && siblingIndex >= childCount - 1)
		{
			return true;
		}
		return false;
	}

	private static ILoopScrollDataSource GetLoopScrollDataSource(Transform target, int parentLevel)
	{
		if (target == null)
		{
			return null;
		}
		int num = Mathf.Max(0, parentLevel);
		Transform transform = target;
		while (transform != null)
		{
			ILoopScrollDataSource component = transform.GetComponent<ILoopScrollDataSource>();
			if (component != null)
			{
				if (num <= 0)
				{
					return component;
				}
				num--;
			}
			transform = transform.parent;
		}
		return null;
	}

	private static ILoopScrollDataSource GetLoopScrollDirectDataSource(Transform target, LoopScrollRectBase loopScrollRect)
	{
		if (target == null || loopScrollRect == null || loopScrollRect.content == null)
		{
			return null;
		}
		ILoopScrollDataSource result = null;
		Transform transform = target;
		while (transform != null && !(transform == loopScrollRect.content))
		{
			if (transform.IsChildOf(loopScrollRect.content))
			{
				ILoopScrollDataSource component = transform.GetComponent<ILoopScrollDataSource>();
				if (component != null)
				{
					result = component;
				}
			}
			transform = transform.parent;
		}
		return result;
	}

	private static IOSA FindOSAInParents(Transform startTransform)
	{
		Transform transform = startTransform;
		while (transform != null)
		{
			Component[] components = transform.GetComponents<Component>();
			for (int i = 0; i < components.Length; i++)
			{
				if (components[i] is IOSA result)
				{
					return result;
				}
			}
			transform = transform.parent;
		}
		return null;
	}

	private void ScrollOsaTarget(Transform target, IOSA osa)
	{
		if (target == null || osa == null)
		{
			return;
		}
		BaseParams baseParameters = osa.BaseParameters;
		if (baseParameters == null)
		{
			return;
		}
		RectTransform content = baseParameters.Content;
		RectTransform rectTransform = ((baseParameters.Viewport != null) ? baseParameters.Viewport : baseParameters.ScrollViewRT);
		if (content == null || rectTransform == null)
		{
			return;
		}
		RectTransform rectTransform2 = FindOsaItemRoot(target, content);
		if (rectTransform2 == null)
		{
			return;
		}
		BaseItemViewsHolder baseItemViewsHolderIfVisible = osa.GetBaseItemViewsHolderIfVisible(rectTransform2);
		if (baseItemViewsHolderIfVisible == null)
		{
			return;
		}
		int itemIndex = baseItemViewsHolderIfVisible.ItemIndex;
		int itemsCount = osa.GetItemsCount();
		int num;
		int num2;
		if (baseParameters.effects != null)
		{
			num = (baseParameters.effects.LoopItems ? 1 : 0);
			if (num != 0)
			{
				num2 = 0;
				goto IL_00a4;
			}
		}
		else
		{
			num = 0;
		}
		num2 = ((itemIndex <= 0) ? 1 : 0);
		goto IL_00a4;
		IL_00a4:
		bool flag = (byte)num2 != 0;
		bool flag2 = num == 0 && itemsCount > 0 && itemIndex >= itemsCount - 1;
		Bounds boundsInRect = GetBoundsInRect(rectTransform, rectTransform2);
		float num3 = (baseParameters.IsHorizontal ? Mathf.Max(ScrollToShowOffset, boundsInRect.size.x * 0.4f) : Mathf.Max(ScrollToShowOffset, boundsInRect.size.y * 0.4f));
		float value = ((flag | flag2) ? 0f : num3);
		osa.BringToView(itemIndex, value);
	}

	private static RectTransform FindOsaItemRoot(Transform leaf, RectTransform content)
	{
		if (leaf == null || content == null)
		{
			return null;
		}
		Transform transform = leaf;
		while (transform != null && transform.parent != content)
		{
			transform = transform.parent;
		}
		return transform as RectTransform;
	}

	private int GetLoopLogicalIndex(LoopScrollRect loopScrollRect, ILoopScrollDataSource dataSource)
	{
		if (loopScrollRect != null && s_LoopLogicalSelectedIndices.TryGetValue(loopScrollRect.GetInstanceID(), out var value))
		{
			return value;
		}
		int index = dataSource.GetIndex();
		if (loopScrollRect != null)
		{
			s_LoopLogicalSelectedIndices[loopScrollRect.GetInstanceID()] = index;
		}
		return index;
	}

	public static bool TryGetLoopLogicalIndex(LoopScrollRect loopScrollRect, out int index)
	{
		if (loopScrollRect != null && s_LoopLogicalSelectedIndices.TryGetValue(loopScrollRect.GetInstanceID(), out index))
		{
			return true;
		}
		index = -1;
		return false;
	}

	public static bool IsLoopMovePending(LoopScrollRect loopScrollRect)
	{
		if (loopScrollRect != null)
		{
			return s_LoopPendingMoveSet.Contains(loopScrollRect.GetInstanceID());
		}
		return false;
	}

	private void SyncLoopLogicalIndexFromParent()
	{
		LoopScrollRect componentInParent = GetComponentInParent<LoopScrollRect>();
		ILoopScrollDataSource componentInParent2 = GetComponentInParent<ILoopScrollDataSource>();
		if (!(componentInParent == null) && componentInParent2 != null)
		{
			SetLoopLogicalIndex(componentInParent, componentInParent2.GetIndex());
		}
	}

	private static void SetLoopLogicalIndex(LoopScrollRect loopScrollRect, int index)
	{
		if (!(loopScrollRect == null))
		{
			s_LoopLogicalSelectedIndices[loopScrollRect.GetInstanceID()] = index;
		}
	}

	private void PrepareLoopSelection(LoopScrollRect loopScrollRect, int index)
	{
		_preparedLoopSelectionRect = loopScrollRect;
		_preparedLoopSelectionIndex = index;
	}

	private bool TryApplyPreparedLoopSelection()
	{
		if (_preparedLoopSelectionRect == null || _preparedLoopSelectionIndex < 0)
		{
			return false;
		}
		SetLoopLogicalIndex(_preparedLoopSelectionRect, _preparedLoopSelectionIndex);
		ClearPreparedLoopSelection();
		return true;
	}

	private void ClearPreparedLoopSelection()
	{
		_preparedLoopSelectionRect = null;
		_preparedLoopSelectionIndex = -1;
	}

	private void ClearPendingLoopMove()
	{
		if (_pendingLoopScrollRect != null)
		{
			s_LoopPendingMoveSet.Remove(_pendingLoopScrollRect.GetInstanceID());
		}
		_pendingLoopScrollRect = null;
		_pendingLoopTargetIndex = -1;
		_pendingLoopMoveDirection = MoveDirection.None;
	}

	private static bool TrySetSelectedGameObject(GameObject target)
	{
		if (target == null)
		{
			return false;
		}
		EventSystemHelper.SetSelectedGameObject(target);
		return EventSystemHelper.RawSelected == target;
	}

	private static void ApplyLoopMoveStep(LoopScrollRectBase loopScrollRect, MoveDirection moveDirection, RectTransform currentRect)
	{
		if (loopScrollRect == null || currentRect == null)
		{
			return;
		}
		RectTransform rectTransform = ((loopScrollRect.viewport != null) ? loopScrollRect.viewport : (loopScrollRect.transform as RectTransform));
		if (!(rectTransform == null))
		{
			Bounds boundsInRect = GetBoundsInRect(rectTransform, currentRect);
			float num = Mathf.Max(1f, boundsInRect.size.x * 0.4f);
			float num2 = Mathf.Max(1f, boundsInRect.size.y * 0.4f);
			switch (moveDirection)
			{
			case MoveDirection.Up:
				ApplyLoopScrollDelta(loopScrollRect, 0f, 0f - num2);
				break;
			case MoveDirection.Down:
				ApplyLoopScrollDelta(loopScrollRect, 0f, num2);
				break;
			case MoveDirection.Left:
				ApplyLoopScrollDelta(loopScrollRect, 0f - num, 0f);
				break;
			case MoveDirection.Right:
				ApplyLoopScrollDelta(loopScrollRect, num, 0f);
				break;
			}
		}
	}

	private static void ApplyLoopScrollDelta(LoopScrollRectBase loopScrollRect, float deltaX, float deltaY)
	{
		if (!(loopScrollRect == null) && EventSystemHelper.Available)
		{
			loopScrollRect.velocity = Vector2.zero;
			float num = Mathf.Max(0.0001f, loopScrollRect.scrollSensitivity);
			PointerEventData data = new PointerEventData(EventSystemHelper.Shared)
			{
				scrollDelta = new Vector2(deltaX / num, (0f - deltaY) / num)
			};
			loopScrollRect.OnScroll(data);
			loopScrollRect.UpdateBounds(updateItems: true);
		}
	}

	private static Bounds GetBoundsInRect(RectTransform root, RectTransform target)
	{
		Vector3[] array = new Vector3[4];
		target.GetWorldCorners(array);
		Vector3 center = root.InverseTransformPoint(array[0]);
		Bounds result = new Bounds(center, Vector3.zero);
		for (int i = 1; i < array.Length; i++)
		{
			result.Encapsulate(root.InverseTransformPoint(array[i]));
		}
		return result;
	}
}
