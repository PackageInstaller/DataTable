using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Lumin.LoungeSystem;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CharacterRoomListGroup : MonoBehaviour
{
	[SerializeField]
	private LocalizeStringEvent _roomNameTxt;

	public RectTransform pointCellPrefab;

	public RectTransform groupRoot;

	[SerializeField]
	private GameObject roomRoot;

	[SerializeField]
	private GameObject globalStoryRoot;

	[SerializeField]
	private TextMeshProUGUI globalStoryNameTxt;

	[SerializeField]
	private GameObject highLight;

	private UI_InviteCharacterWithMapView inviteCharacterWithMapView;

	public void Init(int roomListIndex, RoomData roomData, ImageAssetStation station, bool isRoomListInited)
	{
		_roomNameTxt.StringReference.TableEntryReference = roomData.RoomName;
		inviteCharacterWithMapView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_INVITECHARACTERWITHMAP) as UI_InviteCharacterWithMapView;
		if (inviteCharacterWithMapView == null)
		{
			return;
		}
		highLight.SetActive(value: false);
		int num = 0;
		foreach (KeyValuePair<int, Vector3> spawnPoint in roomData.SpawnPoints)
		{
			Model<LoungeModel>.Interface.IndexToCharacter.TryGetValue(spawnPoint.Key, out var value);
			bool flag = (value?.useType ?? LoungeInteractPointUseType.LoungeInteractPointUseEmpty) == LoungeInteractPointUseType.LoungeInteractPointUseGlobal;
			roomRoot.SetActive(!flag);
			globalStoryRoot.SetActive(flag);
			if (flag)
			{
				LoungeStory data = CoreUtils.GetData(value.waitStory, RuntimeConfigs.data.loungeStorys);
				int storyText = data.storyText;
				globalStoryNameTxt.text = LocalizationUtility.GetLocalizeString("longcommon", storyText);
				if (data.characterId.Contains(inviteCharacterWithMapView.currSelectCharacterId))
				{
					highLight.SetActive(value: true);
				}
			}
			else
			{
				int pointId = ((value != null && value.id != 0) ? value.id : spawnPoint.Key);
				if (value != null && value.character.Count > 1)
				{
					foreach (int item in value.character)
					{
						if (!isRoomListInited)
						{
							Object.Instantiate(pointCellPrefab, groupRoot).GetComponent<CharacterCell>().Init(roomListIndex, num, pointId, station, item);
						}
						else
						{
							groupRoot.GetChild(num).transform.GetComponent<CharacterCell>().Init(roomListIndex, num, pointId, station, item);
						}
					}
				}
				else
				{
					int characterId = ((value != null && value.character.Count > 0) ? value.character[0] : 0);
					if (!isRoomListInited)
					{
						Object.Instantiate(pointCellPrefab, groupRoot).GetComponent<CharacterCell>().Init(roomListIndex, num, pointId, station, characterId);
					}
					else
					{
						groupRoot.GetChild(num).transform.GetComponent<CharacterCell>().Init(roomListIndex, num, pointId, station, characterId);
					}
				}
			}
			num++;
		}
	}

	public void RefreshOnePoint(int characterId, int index, int pointId, ImageAssetStation station, bool isInviteRefresh, int roomListIndex)
	{
		groupRoot.GetChild(index).transform.GetComponent<CharacterCell>().RefreshTempRoomState(characterId, pointId, station, isInviteRefresh, roomListIndex, index);
	}
}
