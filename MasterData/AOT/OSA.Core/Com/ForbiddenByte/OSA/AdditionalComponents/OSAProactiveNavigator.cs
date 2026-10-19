using System;
using System.Collections.Generic;
using Com.ForbiddenByte.OSA.Core;
using Com.ForbiddenByte.OSA.Core.SubComponents;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Com.ForbiddenByte.OSA.AdditionalComponents;

[RequireComponent(typeof(IOSA))]
public class OSAProactiveNavigator : Selectable
{
	[SerializeField]
	[Tooltip("Note that if the OSA has looping active, you'll only be able to reach the transversal selectables (i.e. left/right for a vertical ScrollView)")]
	private Selectables _Selectables = new Selectables();

	[Tooltip("What to do when the user navigates to a direction for which you didn't specify a selectable?")]
	[SerializeField]
	private OnNoSelectableSpecifiedEnum _OnNoSelectableSpecified;

	[Tooltip("This is a workaround to prevent the navigation from skipping the first item when entering OSA from outside, in case your items also contain an inner navigation logic using Unity's built-in system. Default is 0.4")]
	[SerializeField]
	private float _JoystickInputMultiplier = 0.3f;

	[SerializeField]
	[Tooltip("See description of 'JoystickInputMultiplier'. The same thing applies here, but for arrows")]
	private float _ArrowsInputMultiplier = 1f;

	[Tooltip("If at extremity and moving futher, the item at the other extremity will be selected. This will supersede the selectables you set in your item or in the Selectables section of this script")]
	[SerializeField]
	private bool _LoopAtExtremity;

	private IOSA _OSA;

	private SelectionWatcher _SelectionWatcher;

	private BaseNavigationManager _NavManager;

	private bool _Initialized;

	private float _LastInputProcessingUnscaledTime;

	private Vector2 _ScrollStartInputVec;

	private float _ScrollStartInputVecUnscaledTime;

	private NavEvents _LastNav = new NavEvents();

	private ScrollStateEnum _ScrollState;

	private ViewsHolderFinder ViewsHolderFinder => _NavManager.ViewsHolderFinder;

	private ScrollStateEnum ScrollState
	{
		get
		{
			return _ScrollState;
		}
		set
		{
			_ScrollState = value;
		}
	}

	protected override void Awake()
	{
		base.Awake();
		_OSA = GetComponent(typeof(IOSA)) as IOSA;
		if (_OSA == null)
		{
			throw new OSAException("OSAProactiveNavigatior: OSA component not found on this game object");
		}
		SetNotInteractable();
	}

	private void Update()
	{
		if (!Application.isPlaying)
		{
			return;
		}
		if (!_Initialized)
		{
			if (_OSA.IsInitialized)
			{
				InitializeOnOSAReady();
			}
			return;
		}
		bool flag = _OSA.BaseParameters.Navigation.Enabled;
		_SelectionWatcher.Enabled = flag;
		_SelectionWatcher.OnUpdate();
		if (flag)
		{
			CheckNav();
		}
		else
		{
			EnterState_NoneIfNeeded();
		}
	}

	private void InitializeOnOSAReady()
	{
		SetNotInteractable();
		_NavManager = _OSA.GetBaseNavigationManager();
		if (_Selectables.SyncAllProvidedSelectables)
		{
			_Selectables.SyncProvidedSelectables(this);
		}
		_SelectionWatcher = new SelectionWatcher();
		_SelectionWatcher.NewObjectSelected += SelectionWatcher_NewObjectSelected;
		_Initialized = true;
	}

	private void SelectionWatcher_NewObjectSelected(GameObject lastGO, GameObject newGO)
	{
		if (newGO != gameObject)
		{
			if (!_LastNav.New.Selectable || !(_LastNav.New.Selectable.gameObject == newGO))
			{
				HandleUnityBuiltinNavSelection(lastGO, newGO);
			}
		}
		else
		{
			HandleOnOSASelected(lastGO);
		}
	}

	private void HandleOnOSASelected(GameObject lastSelectedGO)
	{
		if (_OSA.VisibleItemsCount != 0 && GetClosestSelectableFromOSAsVHs(lastSelectedGO, out var selectable, out var _))
		{
			Selectable component = lastSelectedGO.GetComponent<Selectable>();
			AbstractViewsHolder viewsHolderFromSelectedGameObject = ViewsHolderFinder.GetViewsHolderFromSelectedGameObject(lastSelectedGO);
			SetOrFindNextSelectable(selectable, Vector3.one, component, viewsHolderFromSelectedGameObject);
			EnterState_WaitingForInitial();
		}
	}

	private void HandleUnityBuiltinNavSelection(GameObject _, GameObject newGO)
	{
		Selectable component = newGO.GetComponent<Selectable>();
		AbstractViewsHolder viewsHolderFromSelectedGameObject = ViewsHolderFinder.GetViewsHolderFromSelectedGameObject(newGO);
		_LastNav.OnNewEvent_UnityBuiltinNav(component, viewsHolderFromSelectedGameObject, NavMoveType.UNKNOWN);
	}

	private void EnterState_NoneIfNeeded()
	{
		if (ScrollState != ScrollStateEnum.NONE)
		{
			_ScrollStartInputVec = Vector3.zero;
			ScrollState = ScrollStateEnum.NONE;
		}
	}

	private void EnterState_WaitingForInitial()
	{
		_ScrollStartInputVecUnscaledTime = Time.unscaledTime;
		_ScrollStartInputVec = GetCurrentInputVector();
		ScrollState = ScrollStateEnum.WAITING_FOR_FIRST_DELAY;
	}

	private void CheckNav()
	{
		if (!NavPreChecks(out var curSelectable, out var curSelectableVH))
		{
			return;
		}
		Vector3 currentInputVector = GetCurrentInputVector();
		bool flag = curSelectable.navigation.mode == Navigation.Mode.Explicit;
		float num = Math.Abs(currentInputVector.y);
		float num2 = Math.Abs(currentInputVector.x);
		bool flag2 = num >= num2;
		bool flag3 = curSelectableVH != null;
		NavEvent navEvent = _LastNav.New;
		if ((bool)navEvent.Selectable)
		{
			if (navEvent.Type == NavMoveType.ENTER_OSA || navEvent.Type == NavMoveType.EXIT_OSA)
			{
				if (navEvent.Selectable == curSelectable && !DidEnoughTimePassSinceBoundaryCrossinEventOrPreEvent(navEvent))
				{
					return;
				}
			}
			else if (navEvent.IsUnityBuiltinEvent && !DidEnoughTimePassSinceBoundaryCrossinEventOrPreEvent(navEvent))
			{
				return;
			}
		}
		if (!_OSA.IsVertical)
		{
			return;
		}
		Vector3 findNextSelectableAuto_Vector;
		Selectable nextSelectable;
		if (flag2)
		{
			int num3 = -Math.Sign(currentInputVector.y);
			bool flag4 = num3 < 0;
			Selectable selectable;
			Selectable selectable2;
			if (flag4)
			{
				selectable = curSelectable.navigation.selectOnUp;
				selectable2 = _Selectables.Up;
				findNextSelectableAuto_Vector = Vector3.up;
			}
			else
			{
				selectable = curSelectable.navigation.selectOnDown;
				selectable2 = _Selectables.Down;
				findNextSelectableAuto_Vector = Vector3.down;
			}
			if (flag3)
			{
				if (flag && (bool)selectable)
				{
					return;
				}
				int num4 = _OSA.GetItemsCount() - 1;
				int num5 = ((!flag4) ? num4 : 0);
				int itemIndex = curSelectableVH.ItemIndex;
				if (itemIndex == num5)
				{
					if (_LoopAtExtremity)
					{
						int num6 = num4 - num5;
						nextSelectable = FindVHSelectableInDirectionOrDefault(num6 - num3, num3, num5, this, selectable2);
					}
					else
					{
						nextSelectable = selectable2;
					}
				}
				else
				{
					nextSelectable = FindVHSelectableInDirectionOrDefault(itemIndex, num3, num5, this, selectable2);
				}
			}
			else
			{
				if (!flag || !selectable || selectable != this)
				{
					return;
				}
				nextSelectable = null;
			}
		}
		else
		{
			int num3 = Math.Sign(currentInputVector.x);
			Selectable selectable3;
			Selectable selectable4;
			if (num3 < 0)
			{
				selectable3 = curSelectable.navigation.selectOnLeft;
				selectable4 = _Selectables.Left;
				findNextSelectableAuto_Vector = Vector3.left;
			}
			else
			{
				selectable3 = curSelectable.navigation.selectOnRight;
				selectable4 = _Selectables.Right;
				findNextSelectableAuto_Vector = Vector3.right;
			}
			if (flag3)
			{
				if (flag && (bool)selectable3)
				{
					return;
				}
				nextSelectable = selectable4;
			}
			else
			{
				if (!flag || !selectable3 || selectable3 != this)
				{
					return;
				}
				nextSelectable = null;
			}
		}
		SetOrFindNextSelectable(nextSelectable, findNextSelectableAuto_Vector, curSelectable, curSelectableVH);
	}

	private Selectable FindVHSelectableInDirectionOrDefault(int itemIndex, int nextOSAItemDirSign, int extremityItemIndex, Selectable curSelectable, Selectable defaultSelectable)
	{
		Selectable selectable = null;
		int num = 1000;
		for (int i = 0; i < num; i++)
		{
			if ((bool)selectable)
			{
				break;
			}
			if (itemIndex == extremityItemIndex)
			{
				selectable = defaultSelectable;
				break;
			}
			itemIndex += nextOSAItemDirSign;
			_OSA.BringToView(itemIndex);
			_OSA.BringToView(itemIndex);
			BaseItemViewsHolder baseItemViewsHolderIfVisible = _OSA.GetBaseItemViewsHolderIfVisible(itemIndex);
			if (baseItemViewsHolderIfVisible == null)
			{
				selectable = defaultSelectable;
				break;
			}
			List<Selectable> list = new List<Selectable>();
			baseItemViewsHolderIfVisible.root.GetComponentsInChildren(list);
			selectable = GetClosestActiveSelectable(list, curSelectable.gameObject);
		}
		return selectable;
	}

	private bool NavPreChecks(out Selectable curSelectable, out AbstractViewsHolder curSelectableVH)
	{
		if (_OSA.BaseParameters.effects.LoopItems)
		{
			throw new NotImplementedException("loop items nav");
		}
		curSelectable = null;
		curSelectableVH = null;
		if (_OSA.VisibleItemsCount == 0)
		{
			EnterState_NoneIfNeeded();
			return false;
		}
		if (!EventSystem.current)
		{
			EnterState_NoneIfNeeded();
			return false;
		}
		curSelectable = GetCurrentSelectable();
		if (!curSelectable)
		{
			EnterState_NoneIfNeeded();
			return false;
		}
		Vector3 currentInputVector = GetCurrentInputVector();
		if (!CheckInputStrength(currentInputVector))
		{
			return false;
		}
		curSelectableVH = ViewsHolderFinder.GetViewsHolderFromSelectedGameObject(curSelectable.gameObject);
		if (!CheckScrollState(curSelectable, currentInputVector, curSelectableVH))
		{
			return false;
		}
		return true;
	}

	private bool CheckInputStrength(Vector2 inputVec)
	{
		float num = Math.Abs(inputVec.y);
		float num2 = Math.Abs(inputVec.x);
		if (num < 0.15f && num2 < 0.15f)
		{
			EnterState_NoneIfNeeded();
			return false;
		}
		return true;
	}

	private bool CheckScrollState(Selectable curSelectable, Vector2 inputVec, AbstractViewsHolder curSelectableVH)
	{
		Navigation.Mode mode = curSelectable.navigation.mode;
		if (mode == Navigation.Mode.Automatic || mode == Navigation.Mode.Horizontal || mode == Navigation.Mode.Vertical)
		{
			EnterState_NoneIfNeeded();
			return false;
		}
		int num = Math.Sign(inputVec.y);
		int num2 = Math.Sign(inputVec.x);
		bool flag = Math.Abs(_ScrollStartInputVec.y) > Math.Abs(_ScrollStartInputVec.x);
		bool flag2 = Math.Abs(inputVec.y) > Math.Abs(inputVec.x);
		bool flag3 = flag == flag2;
		bool flag4 = ((!flag2) ? (Math.Sign(_ScrollStartInputVec.x) == num2) : (Math.Sign(_ScrollStartInputVec.y) == num));
		bool flag5 = flag3 & flag4;
		switch (ScrollState)
		{
		case ScrollStateEnum.NONE:
			EnterState_WaitingForInitial();
			break;
		case ScrollStateEnum.WAITING_FOR_FIRST_DELAY:
			if (!flag5)
			{
				EnterState_NoneIfNeeded();
				return false;
			}
			if (Time.unscaledTime - _ScrollStartInputVecUnscaledTime < 0.4f)
			{
				return false;
			}
			ScrollState = ScrollStateEnum.SCROLLING;
			break;
		case ScrollStateEnum.SCROLLING:
			if (!flag5)
			{
				ScrollState = ScrollStateEnum.NONE;
			}
			else if (!CheckAndUpdateInputFrequency())
			{
				return false;
			}
			break;
		}
		return true;
	}

	private bool CheckAndUpdateInputFrequency()
	{
		float num = _NavManager.GetMaxInputModuleActionsPerSecondToExpect();
		if (num == 0f)
		{
			num = 10f;
		}
		float num2 = 1f / num;
		if (Time.unscaledTime - _LastInputProcessingUnscaledTime < num2)
		{
			return false;
		}
		_LastInputProcessingUnscaledTime = Time.unscaledTime;
		return true;
	}

	private void SetOrFindNextSelectable(Selectable nextSelectable, Vector3 findNextSelectableAuto_Vector, Selectable curSelectable, AbstractViewsHolder curSelectableVH)
	{
		EventSystem current = EventSystem.current;
		bool flag = curSelectableVH != null;
		AbstractViewsHolder containingVH;
		if ((bool)nextSelectable)
		{
			containingVH = ViewsHolderFinder.GetViewsHolderFromSelectedGameObject(nextSelectable.gameObject);
		}
		else
		{
			OnNoSelectableSpecifiedEnum onNoSelectableSpecified = _OnNoSelectableSpecified;
			if (onNoSelectableSpecified != OnNoSelectableSpecifiedEnum.KEEP_CURRENTLY_SELECTED && onNoSelectableSpecified == OnNoSelectableSpecifiedEnum.AUTO_FIND)
			{
				if (flag)
				{
					nextSelectable = curSelectable.FindSelectable(findNextSelectableAuto_Vector);
					containingVH = ((!nextSelectable) ? null : ViewsHolderFinder.GetViewsHolderFromSelectedGameObject(nextSelectable.gameObject));
				}
				else
				{
					GetClosestSelectableFromOSAsVHs(curSelectable.gameObject, out nextSelectable, out containingVH);
				}
				if ((bool)nextSelectable)
				{
				}
			}
			else
			{
				nextSelectable = null;
				containingVH = null;
			}
		}
		if (curSelectable != _LastNav.New.Selectable)
		{
			throw new OSAException("[Please report this full error] Expecting curSelectable == _LastNavCommand.New.Selectable; curSelectable = " + curSelectable?.ToString() + ", _LastNav.New.Selectable = " + _LastNav.New.Selectable?.ToString() + ", _LastNav.New = " + _LastNav.New.ToString());
		}
		if (!nextSelectable)
		{
			return;
		}
		bool flag2 = containingVH != null;
		NavMoveType navMoveType = NavMoveType.UNKNOWN;
		if (flag)
		{
			if (!flag2)
			{
				navMoveType = NavMoveType.EXIT_OSA;
			}
		}
		else if (flag2)
		{
			navMoveType = NavMoveType.ENTER_OSA;
		}
		if (navMoveType != NavMoveType.ENTER_OSA)
		{
			bool flag3 = false;
			if (flag)
			{
				if (_LastNav.New.IsUnityBuiltinEvent && !flag2)
				{
					flag3 = true;
				}
			}
			else if (!_LastNav.New.IsUnityBuiltinEvent && flag2)
			{
				flag3 = true;
			}
			if (flag3 && ScrollState != ScrollStateEnum.SCROLLING && !DidEnoughTimePassSinceBoundaryCrossinEventOrPreEvent(_LastNav.New))
			{
				return;
			}
		}
		current.SetSelectedGameObject(nextSelectable.gameObject);
		_LastNav.OnNewEvent_OSANav(nextSelectable, containingVH, navMoveType);
	}

	private void SetNotInteractable()
	{
		targetGraphic = null;
		image = null;
		Navigation navigation = base.navigation;
		navigation.mode = Navigation.Mode.None;
		base.navigation = navigation;
	}

	private bool GetClosestSelectableFromOSAsVHs(GameObject fromGO, out Selectable selectable, out AbstractViewsHolder containingVH)
	{
		List<Selectable> list = new List<Selectable>();
		Dictionary<Selectable, AbstractViewsHolder> dictionary = new Dictionary<Selectable, AbstractViewsHolder>();
		for (int i = 0; i < _OSA.VisibleItemsCount; i++)
		{
			BaseItemViewsHolder baseItemViewsHolder = _OSA.GetBaseItemViewsHolder(i);
			Selectable[] componentsInChildren = baseItemViewsHolder.root.GetComponentsInChildren<Selectable>();
			foreach (Selectable selectable2 in componentsInChildren)
			{
				list.Add(selectable2);
				dictionary[selectable2] = baseItemViewsHolder;
			}
		}
		Selectable closestActiveSelectable = GetClosestActiveSelectable(list, fromGO);
		if ((bool)closestActiveSelectable)
		{
			selectable = closestActiveSelectable;
			containingVH = dictionary[closestActiveSelectable];
			return true;
		}
		selectable = null;
		containingVH = null;
		return false;
	}

	private Selectable GetClosestActiveSelectable(List<Selectable> selectables, GameObject fromGO)
	{
		Selectable result;
		if (selectables.Count == 0)
		{
			Vector3 currentInputVector = GetCurrentInputVector();
			result = fromGO.GetComponent<Selectable>().FindSelectable(currentInputVector);
		}
		else
		{
			Vector3 fromPos = fromGO.transform.position;
			selectables.Sort((Selectable a, Selectable b) => Mathf.RoundToInt((Vector3.Distance(fromPos, a.transform.position) - Vector3.Distance(fromPos, b.transform.position)) * 50f));
			result = null;
			for (int num = 0; num < selectables.Count; num++)
			{
				Selectable selectable = selectables[num];
				if (CanSelect(selectable))
				{
					result = selectable;
					break;
				}
			}
		}
		return result;
	}

	private bool CanSelect(Selectable s)
	{
		return s.interactable;
	}

	private Vector3 GetCurrentInputVector()
	{
		bool num = Input.GetKey(KeyCode.DownArrow) || Input.GetKeyUp(KeyCode.DownArrow);
		bool flag = Input.GetKey(KeyCode.UpArrow) || Input.GetKeyUp(KeyCode.UpArrow);
		bool flag2 = num | flag;
		bool num2 = Input.GetKey(KeyCode.LeftArrow) || Input.GetKeyUp(KeyCode.LeftArrow);
		bool flag3 = Input.GetKey(KeyCode.RightArrow) || Input.GetKeyUp(KeyCode.RightArrow);
		bool flag4 = num2 | flag3;
		string[] joystickNames = Input.GetJoystickNames();
		float num3 = ((joystickNames != null && joystickNames.Length != 0) ? _JoystickInputMultiplier : _ArrowsInputMultiplier);
		float y = Input.GetAxis("Vertical") * (flag2 ? _ArrowsInputMultiplier : num3);
		float x = Input.GetAxis("Horizontal") * (flag4 ? _ArrowsInputMultiplier : num3);
		return new Vector3(x, y);
	}

	private Selectable GetCurrentSelectable()
	{
		EventSystem current = EventSystem.current;
		if (!current.currentSelectedGameObject)
		{
			return null;
		}
		Selectable component = current.currentSelectedGameObject.GetComponent<Selectable>();
		if (!component)
		{
			return null;
		}
		return component;
	}

	private bool DidEnoughTimePassSinceBoundaryCrossinEventOrPreEvent(NavEvent ev)
	{
		float val = Time.unscaledDeltaTime * 5f;
		float num = Math.Max(0.05f, val);
		return ev.ElapsedUnscaledTime >= num;
	}
}
