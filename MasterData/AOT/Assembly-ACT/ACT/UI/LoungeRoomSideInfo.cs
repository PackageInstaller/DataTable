using System.Collections.Generic;
using ACT.Battle;
using ACT.Utility;
using Fundamental;
using Lumin.LoungeSystem;
using UnityEngine;

namespace ACT.UI;

public class LoungeRoomSideInfo : MonoBehaviour, ILifeCycleUIComponent
{
	public LoungeMainView view;

	public RectTransform groupRoot;

	public GameObject roomGroupPrefab;

	public GameObject doorWayPrefab;

	public BetterAnimation betterAnimation;

	public GameObject highLightHandle;

	public CommonUILifeCycle lifeCycle;

	private int _gamepadSelectedIndex = -1;

	public bool IsOperating
	{
		get
		{
			CommonUILifeCycle commonUILifeCycle = lifeCycle;
			return commonUILifeCycle == CommonUILifeCycle.Opening || commonUILifeCycle == CommonUILifeCycle.Closing;
		}
	}

	public bool IsOpening => lifeCycle == CommonUILifeCycle.Opening;

	public bool IsClosing => lifeCycle == CommonUILifeCycle.Closing;

	public bool IsNormal => lifeCycle == CommonUILifeCycle.Normal;

	public bool IsHidden => lifeCycle == CommonUILifeCycle.Hidden;

	public bool IsSidePanelVisible
	{
		get
		{
			if (gameObject.activeSelf)
			{
				return !IsHidden;
			}
			return false;
		}
	}

	public void Show()
	{
		CreateRoomGroup();
		view.btnGroup.gameObject.SetActive(value: false);
		view.switchGroup.gameObject.SetActive(value: false);
		PlayShowAnimation();
		SelectFirstRoomGroupForGamepad();
	}

	public void PlayShowAnimation()
	{
		betterAnimation.GetSequence("Show")?.Play();
		gameObject.SetActive(value: true);
		lifeCycle = CommonUILifeCycle.Normal;
	}

	public void Hide()
	{
		DestroyRoomGroup();
		SetHighlightVisible(visible: false);
		view.btnGroup.gameObject.SetActive(value: true);
		view.switchGroup.gameObject.SetActive(value: true);
		PlayHideAnimation();
	}

	public void PlayHideAnimation()
	{
		betterAnimation.GetSequence("Hide")?.Play();
		lifeCycle = CommonUILifeCycle.Hidden;
		gameObject.SetActive(value: false);
	}

	public void HideImmediately()
	{
		DestroyRoomGroup();
		SetHighlightVisible(visible: false);
		gameObject.SetActive(value: false);
		view.btnGroup.gameObject.SetActive(value: true);
		view.switchGroup.gameObject.SetActive(value: true);
		lifeCycle = CommonUILifeCycle.Hidden;
	}

	void ILifeCycleUIComponent.ShowStart()
	{
		lifeCycle = CommonUILifeCycle.Opening;
	}

	void ILifeCycleUIComponent.ShowEnd()
	{
		lifeCycle = CommonUILifeCycle.Normal;
	}

	void ILifeCycleUIComponent.HideStart()
	{
		lifeCycle = CommonUILifeCycle.Closing;
	}

	void ILifeCycleUIComponent.HideEnd()
	{
		lifeCycle = CommonUILifeCycle.Hidden;
		gameObject.SetActive(value: false);
	}

	private void CreateRoomGroup()
	{
		List<RoomData> unlockedRooms = Singleton<LoungeSystemManager>.instance.RoomManager.GetUnlockedRooms();
		unlockedRooms.Sort((RoomData a, RoomData b) => (a.RoomType.CompareTo(b.RoomType) == 0) ? a.RoomId.CompareTo(b.RoomId) : a.RoomType.CompareTo(b.RoomType));
		foreach (RoomData item in unlockedRooms)
		{
			LoungeRoomGroup loungeRoomGroup = ((item.RoomType != LoungeDefine.RoomType.doorWay) ? Object.Instantiate(roomGroupPrefab, groupRoot).GetComponent<LoungeRoomGroup>() : Object.Instantiate(doorWayPrefab, groupRoot).GetComponent<LoungeRoomGroup>());
			loungeRoomGroup.Init(item, view.Station, RefreshAllGroups);
			loungeRoomGroup.PlayShowAnimation();
		}
		SelectFirstRoomGroupForGamepad();
	}

	private void RefreshAllGroups()
	{
		for (int num = groupRoot.childCount - 1; num >= 0; num--)
		{
			groupRoot.GetChild(num).gameObject.GetComponent<LoungeRoomGroup>()?.RefreshSelect();
		}
	}

	private void DestroyRoomGroup()
	{
		for (int num = groupRoot.childCount - 1; num >= 0; num--)
		{
			groupRoot.GetChild(num).gameObject.GetComponent<LoungeRoomGroup>()?.UnInit();
			Object.Destroy(groupRoot.GetChild(num).gameObject);
		}
		_gamepadSelectedIndex = -1;
	}

	public void SelectFirstRoomGroupForGamepad()
	{
		if (groupRoot == null || groupRoot.childCount == 0)
		{
			_gamepadSelectedIndex = -1;
			SetHighlightVisible(visible: false);
		}
		else
		{
			_gamepadSelectedIndex = FindGamepadIndexForRoom(Singleton<LoungeSystemManager>.instance.CurRoomIndex);
			RefreshGamepadSelectionVisual();
		}
	}

	private int FindGamepadIndexForRoom(int roomId)
	{
		if (groupRoot == null || groupRoot.childCount == 0)
		{
			return -1;
		}
		for (int i = 0; i < groupRoot.childCount; i++)
		{
			LoungeRoomGroup component = groupRoot.GetChild(i).GetComponent<LoungeRoomGroup>();
			if (component != null && component.RoomId == roomId)
			{
				return i;
			}
		}
		return 0;
	}

	public void MoveGamepadSelection(int direction)
	{
		if (groupRoot == null || groupRoot.childCount == 0 || direction == 0)
		{
			return;
		}
		if (_gamepadSelectedIndex < 0)
		{
			_gamepadSelectedIndex = FindGamepadIndexForRoom(Singleton<LoungeSystemManager>.instance.CurRoomIndex);
		}
		else
		{
			_gamepadSelectedIndex += ((direction > 0) ? 1 : (-1));
			if (_gamepadSelectedIndex >= groupRoot.childCount)
			{
				_gamepadSelectedIndex = groupRoot.childCount - 1;
			}
			else if (_gamepadSelectedIndex < 0)
			{
				_gamepadSelectedIndex = 0;
			}
		}
		RefreshGamepadSelectionVisual();
		ConfirmGamepadSelection();
	}

	public void ConfirmGamepadSelection()
	{
		if (!(groupRoot == null) && _gamepadSelectedIndex >= 0 && _gamepadSelectedIndex < groupRoot.childCount)
		{
			groupRoot.GetChild(_gamepadSelectedIndex).GetComponent<LoungeRoomGroup>()?.SetCurrentRoom();
			RefreshGamepadSelectionVisual();
		}
	}

	private void RefreshGamepadSelectionVisual()
	{
		if (groupRoot == null)
		{
			SetHighlightVisible(visible: false);
			return;
		}
		bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		bool flag2 = _gamepadSelectedIndex >= 0 && _gamepadSelectedIndex < groupRoot.childCount;
		for (int i = 0; i < groupRoot.childCount; i++)
		{
			groupRoot.GetChild(i).GetComponent<LoungeRoomGroup>()?.SetGamepadHighlightVisible((flag2 && i == _gamepadSelectedIndex) & flag);
		}
		SetHighlightVisible(visible: false);
	}

	private void SetHighlightVisible(bool visible)
	{
		if (highLightHandle != null)
		{
			highLightHandle.SetActive(visible);
		}
	}
}
