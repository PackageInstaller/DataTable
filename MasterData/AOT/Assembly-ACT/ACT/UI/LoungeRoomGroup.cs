using System;
using System.Collections.Generic;
using ACT.Model;
using Bamboo.ImageCenter;
using Fundamental;
using Lumin.LoungeSystem;
using Lumin.LoungeSystem.UI;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class LoungeRoomGroup : MonoBehaviour
{
	public LocalizeStringEvent groupNameLocalize;

	public TextMeshProUGUI roomNameText;

	public BImage roomImage;

	public RectTransform groupRoot;

	public GameObject pointCellPrefab;

	public GameObject selected;

	public GameObject gamePadHandle;

	public BetterAnimation betterAnimation;

	public BImage roomBgImage;

	private RoomData _roomData;

	private Action _action;

	private int _currSelectIndex;

	private bool _isGamepadHighlightVisible;

	public int RoomId => _roomData?.RoomId ?? (-1);

	public void Init(RoomData roomData, ImageAssetStation station, Action btnAction)
	{
		gameObject.SetActive(value: true);
		_roomData = roomData;
		groupNameLocalize.StringReference.TableEntryReference = roomData.RoomName;
		if (roomData.RoomId != 0)
		{
			station.LoadImage(214, roomData.RoomId, roomImage);
			station.LoadImage(214, roomData.RoomId + 1000, roomBgImage);
		}
		RefreshSelect();
		SetGamepadHighlightVisible(visible: false);
		_action = (Action)Delegate.Combine(_action, btnAction);
		if (roomData.RoomType != LoungeDefine.RoomType.doorWay)
		{
			CreatePointGroup(station);
		}
	}

	public void RefreshSelect()
	{
		bool flag = Singleton<LoungeSystemManager>.instance.CurRoomIndex == _roomData.RoomId;
		selected.gameObject.SetActive(flag);
		RefreshSelectAnimation(flag);
	}

	public void PlayShowAnimation()
	{
		betterAnimation.GetSequence("Show")?.Play();
	}

	private void RefreshSelectAnimation(bool isSelect)
	{
		string animationName = (isSelect ? "Select" : "Normal");
		betterAnimation.GetSequence(animationName)?.Play();
	}

	public void SetCurrentRoom()
	{
		_currSelectIndex = _roomData.RoomId;
		if (_currSelectIndex != Singleton<LoungeSystemManager>.instance.CurRoomIndex)
		{
			LoungeUIScene.instance.SetCameraByPosition(_roomData.RoomId);
			_action?.Invoke();
		}
	}

	private void CreatePointGroup(ImageAssetStation station)
	{
		foreach (KeyValuePair<int, Vector3> spawnPoint in _roomData.SpawnPoints)
		{
			if (Model<LoungeModel>.Interface.IndexToCharacter[spawnPoint.Key] == null)
			{
				continue;
			}
			if (Model<LoungeModel>.Interface.IndexToCharacter[spawnPoint.Key].character.Count > 1)
			{
				foreach (int item in Model<LoungeModel>.Interface.IndexToCharacter[spawnPoint.Key].character)
				{
					UnityEngine.Object.Instantiate(pointCellPrefab, groupRoot).GetComponent<LoungePointCell>().Init(spawnPoint.Key, station, item);
				}
			}
			else
			{
				int characterId = ((Model<LoungeModel>.Interface.IndexToCharacter[spawnPoint.Key].character.Count > 0) ? Model<LoungeModel>.Interface.IndexToCharacter[spawnPoint.Key].character[0] : 0);
				UnityEngine.Object.Instantiate(pointCellPrefab, groupRoot).GetComponent<LoungePointCell>().Init(spawnPoint.Key, station, characterId);
			}
		}
	}

	private void DestroyPointGroup()
	{
		if (_roomData.RoomType != LoungeDefine.RoomType.doorWay)
		{
			for (int num = groupRoot.childCount - 1; num >= 0; num--)
			{
				UnityEngine.Object.Destroy(groupRoot.GetChild(num).gameObject);
			}
		}
	}

	public void SetGamepadHighlightVisible(bool visible)
	{
		if (visible && !_isGamepadHighlightVisible)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Tab_Click");
		}
		_isGamepadHighlightVisible = visible;
		if (gamePadHandle != null)
		{
			gamePadHandle.SetActive(visible);
		}
	}

	public void UnInit()
	{
		SetGamepadHighlightVisible(visible: false);
		_action = null;
		DestroyPointGroup();
	}
}
