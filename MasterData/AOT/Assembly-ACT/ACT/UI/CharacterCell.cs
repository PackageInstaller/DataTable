using ACT.Battle;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Runtime.Model;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterCell : LoopScrollBaseItem
{
	[SerializeField]
	private Image _inviteImage;

	[SerializeField]
	private Image _emptyImage;

	[SerializeField]
	private Image _plotImage;

	[SerializeField]
	private Image _forbidImage;

	[SerializeField]
	private Image _selectImage;

	[SerializeField]
	private Image _chatBoard;

	[SerializeField]
	private Image _chatAndPlotBoard;

	[SerializeField]
	private BImage _characterImage;

	[SerializeField]
	private Image _characterImageBoard;

	[SerializeField]
	private Image _characterPlotImage;

	[SerializeField]
	private Image _characterPlotDarkImage;

	[SerializeField]
	private Image _chatImage;

	[SerializeField]
	private Image _chatDarkImage;

	[SerializeField]
	private Image _chatAndPlotImage;

	[SerializeField]
	private Image _chatAndPlotDarkImage;

	[SerializeField]
	private ActButton emptyButton;

	[SerializeField]
	private ActButton inviteButton;

	[SerializeField]
	private ActButton plotButton;

	[SerializeField]
	private ActButton forbidButton;

	[SerializeField]
	private ActButton characterButton;

	[SerializeField]
	private ActButton chatButton;

	[SerializeField]
	private ActButton chatAndPlotButton;

	[SerializeField]
	private GameObject gamePadSelect;

	private int _pointId;

	private UI_InviteCharacterWithMapView inviteCharacterWithMapView;

	private ImageAssetStation _station;

	private int _roomListIndex;

	private int _cellIndex;

	private int _displayCharacterId;

	public int PointId => _pointId;

	public void Init(int roomListIndex, int cellIndex, int pointId, ImageAssetStation station, int characterId = 0)
	{
		_station = station;
		inviteCharacterWithMapView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_INVITECHARACTERWITHMAP) as UI_InviteCharacterWithMapView;
		if (!(inviteCharacterWithMapView == null))
		{
			_roomListIndex = roomListIndex;
			_cellIndex = cellIndex;
			_displayCharacterId = 0;
			_pointId = pointId;
			SetGamepadSelectVisible(visible: false);
			if (pointId != 0)
			{
				gameObject.SetActive(value: true);
				int num = ((inviteCharacterWithMapView.currSelectCharacterId != 0) ? inviteCharacterWithMapView.currSelectCharacterId : characterId);
				InviteCharacterRoomPointEnum characterRoomPointState = Model<InviteCharacterModel>.Interface.GetCharacterRoomPointState(num, _pointId);
				SetSelectImageVisible(visible: false);
				RefreshRoomPointState(characterRoomPointState, num, _pointId);
				int occupantId = ((characterId > 0) ? characterId : GetTempInviteCharacterIdAtPoint(_pointId));
				RefreshOccupantAvatar(occupantId, num, station, roomListIndex, cellIndex);
				BindPointButtons(roomListIndex, cellIndex);
			}
		}
	}

	public void SetGamepadSelectVisible(bool visible)
	{
		if (gamePadSelect != null)
		{
			gamePadSelect.SetActive(visible);
		}
	}

	public bool TriggerGamepadConfirm()
	{
		if (inviteCharacterWithMapView == null || _pointId == 0)
		{
			return false;
		}
		if (characterButton != null && characterButton.gameObject.activeInHierarchy)
		{
			characterButton.OnSubmit(null);
			inviteCharacterWithMapView.OnCharacterButtonClick(_roomListIndex, _cellIndex, _pointId, _displayCharacterId);
			return true;
		}
		if (inviteButton != null && inviteButton.gameObject.activeInHierarchy)
		{
			inviteButton.OnSubmit(null);
			inviteCharacterWithMapView.OnInviteButtonClick(_roomListIndex, _cellIndex, _pointId, inviteCharacterWithMapView.currSelectCharacterId);
			return true;
		}
		if (plotButton != null && plotButton.gameObject.activeInHierarchy)
		{
			plotButton.OnSubmit(null);
			inviteCharacterWithMapView.OnPlotButtonClick(_roomListIndex, _cellIndex, _pointId, inviteCharacterWithMapView.currSelectCharacterId);
			return true;
		}
		if (forbidButton != null && forbidButton.gameObject.activeInHierarchy)
		{
			forbidButton.OnSubmit(null);
			inviteCharacterWithMapView.OnForbidButtonClick(_roomListIndex, _cellIndex, _pointId, inviteCharacterWithMapView.currSelectCharacterId);
			return true;
		}
		if (chatButton != null && chatButton.gameObject.activeInHierarchy)
		{
			chatButton.OnSubmit(null);
			inviteCharacterWithMapView.OnInviteButtonClick(_roomListIndex, _cellIndex, _pointId, inviteCharacterWithMapView.currSelectCharacterId);
			return true;
		}
		if (chatAndPlotButton != null && chatAndPlotButton.gameObject.activeInHierarchy)
		{
			chatAndPlotButton.OnSubmit(null);
			inviteCharacterWithMapView.OnPlotButtonClick(_roomListIndex, _cellIndex, _pointId, inviteCharacterWithMapView.currSelectCharacterId);
			return true;
		}
		if (emptyButton != null && emptyButton.gameObject.activeInHierarchy)
		{
			emptyButton.OnSubmit(null);
			inviteCharacterWithMapView.OnInviteButtonClick(_roomListIndex, _cellIndex, _pointId, inviteCharacterWithMapView.currSelectCharacterId);
			return true;
		}
		return false;
	}

	public void RefreshTempRoomState(int characterId, int pointId, ImageAssetStation station, bool isInviteRefresh, int roomListIndex, int cellIndex)
	{
		if (!isInviteRefresh)
		{
			RefreshRemovedTempState(characterId, pointId);
		}
		else
		{
			if (Model<InviteCharacterModel>.Interface.TempInviteCharacterList.Count <= 0)
			{
				return;
			}
			foreach (TempInviteCharacter tempInviteCharacter in Model<InviteCharacterModel>.Interface.TempInviteCharacterList)
			{
				if (tempInviteCharacter.pointId == pointId)
				{
					ShowTempInvitedCharacter(tempInviteCharacter.characterId, pointId, roomListIndex, cellIndex);
					break;
				}
			}
		}
	}

	private void RefreshRoomPointState(InviteCharacterRoomPointEnum state, int characterId, int pointId)
	{
		ResetRoomPointVisualState();
		switch (state)
		{
		case InviteCharacterRoomPointEnum.Empty:
			_emptyImage.gameObject.SetActive(value: true);
			emptyButton.gameObject.SetActive(value: true);
			break;
		case InviteCharacterRoomPointEnum.Forbid:
			forbidButton.gameObject.SetActive(value: true);
			break;
		case InviteCharacterRoomPointEnum.Story:
			plotButton.gameObject.SetActive(value: true);
			_plotImage.gameObject.SetActive(value: true);
			break;
		case InviteCharacterRoomPointEnum.Invite:
			inviteButton.gameObject.SetActive(value: true);
			break;
		case InviteCharacterRoomPointEnum.GlobalStory:
			characterButton.gameObject.SetActive(value: true);
			_plotImage.gameObject.SetActive(value: true);
			break;
		case InviteCharacterRoomPointEnum.ExistCharacter:
			if (GetPointOccupantId(pointId) > 0 || GetTempInviteCharacterIdAtPoint(pointId) > 0)
			{
				characterButton.gameObject.SetActive(value: true);
			}
			break;
		case InviteCharacterRoomPointEnum.Chat:
			chatButton.gameObject.SetActive(value: true);
			_chatBoard.gameObject.SetActive(value: true);
			break;
		case InviteCharacterRoomPointEnum.ChatAndStory:
			chatAndPlotButton.gameObject.SetActive(value: true);
			_chatAndPlotBoard.gameObject.SetActive(value: true);
			break;
		}
		int characterId2 = ResolveSideIconCharacterId(state, characterId, pointId);
		RefreshSideIconDisplay(characterId2, pointId, characterId);
	}

	private static int ResolveSideIconCharacterId(InviteCharacterRoomPointEnum state, int selectedCharacterId, int pointId)
	{
		int pointOccupantId = GetPointOccupantId(pointId);
		if (pointOccupantId > 0)
		{
			return pointOccupantId;
		}
		int tempInviteCharacterIdAtPoint = GetTempInviteCharacterIdAtPoint(pointId);
		if (tempInviteCharacterIdAtPoint <= 0)
		{
			return selectedCharacterId;
		}
		return tempInviteCharacterIdAtPoint;
	}

	private static int GetPointOccupantId(int pointId)
	{
		if (Model<LoungeModel>.Interface.IndexToCharacter.TryGetValue(pointId, out var value) && value.character.Count > 0)
		{
			return value.character[0];
		}
		return 0;
	}

	private static int GetTempInviteCharacterIdAtPoint(int pointId)
	{
		foreach (TempInviteCharacter tempInviteCharacter in Model<InviteCharacterModel>.Interface.TempInviteCharacterList)
		{
			if (tempInviteCharacter.pointId == pointId)
			{
				return tempInviteCharacter.characterId;
			}
		}
		return 0;
	}

	private void RefreshOccupantAvatar(int occupantId, int currSelectCharacterId, ImageAssetStation station, int roomListIndex, int cellIndex)
	{
		bool flag = occupantId > 0;
		_displayCharacterId = (flag ? occupantId : 0);
		_characterImage.icon.gameObject.SetActive(flag);
		if (!flag)
		{
			characterButton.gameObject.SetActive(value: false);
			return;
		}
		station.LoadImage(126, CharacterSkinRuntimeUtility.ResolveBagCharacterSkinId(occupantId), _characterImage);
		characterButton.gameObject.SetActive(value: true);
		int tempInviteCharacterIdAtPoint = GetTempInviteCharacterIdAtPoint(_pointId);
		bool num = tempInviteCharacterIdAtPoint > 0 && tempInviteCharacterIdAtPoint == currSelectCharacterId && occupantId == tempInviteCharacterIdAtPoint;
		bool flag2 = inviteCharacterWithMapView.IsSelectedRoomCharacter(_pointId, occupantId);
		bool selectImageVisible = num | flag2;
		SetSelectImageVisible(selectImageVisible);
		inviteButton.gameObject.SetActive(value: false);
		plotButton.gameObject.SetActive(value: false);
		chatButton.gameObject.SetActive(value: false);
		chatAndPlotButton.gameObject.SetActive(value: false);
		_chatBoard.gameObject.SetActive(value: false);
		_chatAndPlotBoard.gameObject.SetActive(value: false);
		_emptyImage.gameObject.SetActive(value: false);
		forbidButton.gameObject.SetActive(value: false);
		BindCharacterButtonClick(roomListIndex, cellIndex, _pointId, occupantId);
	}

	private void BindPointButtons(int roomListIndex, int cellIndex)
	{
		inviteButton.SetBtnClick(() =>
		{
			inviteCharacterWithMapView.OnInviteButtonClick(roomListIndex, cellIndex, _pointId, inviteCharacterWithMapView.currSelectCharacterId);
		});
		plotButton.SetBtnClick(() =>
		{
			inviteCharacterWithMapView.OnPlotButtonClick(roomListIndex, cellIndex, _pointId, inviteCharacterWithMapView.currSelectCharacterId);
		});
		forbidButton.SetBtnClick(() =>
		{
			inviteCharacterWithMapView.OnForbidButtonClick(roomListIndex, cellIndex, _pointId, inviteCharacterWithMapView.currSelectCharacterId);
		});
		chatButton.SetBtnClick(() =>
		{
			inviteCharacterWithMapView.OnInviteButtonClick(roomListIndex, cellIndex, _pointId, inviteCharacterWithMapView.currSelectCharacterId);
		});
		chatAndPlotButton.SetBtnClick(() =>
		{
			inviteCharacterWithMapView.OnPlotButtonClick(roomListIndex, cellIndex, _pointId, inviteCharacterWithMapView.currSelectCharacterId);
		});
		emptyButton.SetBtnClick(() =>
		{
			inviteCharacterWithMapView.OnInviteButtonClick(roomListIndex, cellIndex, _pointId, inviteCharacterWithMapView.currSelectCharacterId);
		});
	}

	private void ShowTempInvitedCharacter(int tempCharacterId, int pointId, int roomListIndex, int cellIndex)
	{
		_displayCharacterId = tempCharacterId;
		_characterImage.icon.gameObject.SetActive(value: true);
		_station.LoadImage(126, CharacterSkinRuntimeUtility.ResolveBagCharacterSkinId(_displayCharacterId), _characterImage);
		characterButton.gameObject.SetActive(value: true);
		int currSelectCharacterId = inviteCharacterWithMapView.currSelectCharacterId;
		SetSelectImageVisible(tempCharacterId == currSelectCharacterId);
		_emptyImage.gameObject.SetActive(value: false);
		inviteButton.gameObject.SetActive(value: false);
		plotButton.gameObject.SetActive(value: false);
		chatButton.gameObject.SetActive(value: false);
		chatAndPlotButton.gameObject.SetActive(value: false);
		_chatBoard.gameObject.SetActive(value: false);
		_chatAndPlotBoard.gameObject.SetActive(value: false);
		forbidButton.gameObject.SetActive(value: false);
		ResetSideIcons();
		RefreshSideIconDisplay(tempCharacterId, pointId, currSelectCharacterId);
		BindCharacterButtonClick(roomListIndex, cellIndex, pointId, tempCharacterId);
	}

	private void BindCharacterButtonClick(int roomListIndex, int cellIndex, int pointId, int characterId)
	{
		characterButton.SetBtnClick(() =>
		{
			inviteCharacterWithMapView.OnCharacterButtonClick(roomListIndex, cellIndex, pointId, characterId);
		});
		ActButton component = _characterImage.icon.GetComponent<ActButton>();
		if (component != null && component != characterButton)
		{
			component.SetBtnClick(() =>
			{
				inviteCharacterWithMapView.OnCharacterButtonClick(roomListIndex, cellIndex, pointId, characterId);
			});
		}
	}

	private void RefreshRemovedTempState(int characterId, int pointId)
	{
		InviteCharacterRoomPointEnum characterRoomPointState = Model<InviteCharacterModel>.Interface.GetCharacterRoomPointState(characterId, pointId);
		RefreshRoomPointState(characterRoomPointState, characterId, pointId);
		int num = GetPointOccupantId(pointId);
		if (num == 0)
		{
			num = GetTempInviteCharacterIdAtPoint(pointId);
		}
		_displayCharacterId = num;
		_characterImage.icon.gameObject.SetActive(num > 0);
		if (num == 0)
		{
			characterButton.gameObject.SetActive(value: false);
		}
		SetSelectImageVisible(visible: false);
	}

	private void ResetRoomPointVisualState()
	{
		_emptyImage.gameObject.SetActive(value: false);
		emptyButton.gameObject.SetActive(value: false);
		characterButton.gameObject.SetActive(value: false);
		inviteButton.gameObject.SetActive(value: false);
		plotButton.gameObject.SetActive(value: false);
		forbidButton.gameObject.SetActive(value: false);
		chatButton.gameObject.SetActive(value: false);
		chatAndPlotButton.gameObject.SetActive(value: false);
		_plotImage.gameObject.SetActive(value: false);
		_chatBoard.gameObject.SetActive(value: false);
		_chatAndPlotBoard.gameObject.SetActive(value: false);
		ResetSideIcons();
		SetSelectImageVisible(visible: false);
	}

	private void RefreshSideIconDisplay(int characterId, int pointId, int selectedCharacterId)
	{
		if (!Model<InviteCharacterModel>.Interface.CanShowSideIconForCharacter(characterId))
		{
			ResetSideIcons();
			return;
		}
		if (GetPointOccupantId(pointId) == 0 && GetTempInviteCharacterIdAtPoint(pointId) == 0)
		{
			ResetSideIcons();
			return;
		}
		if (!IsCharacterCheckedIn(characterId) && Model<InviteCharacterModel>.Interface.TryGetTempInvitePointId(characterId, out var pointId2) && pointId != pointId2)
		{
			ResetSideIcons();
			return;
		}
		int characterLoungePointId = Model<InviteCharacterModel>.Interface.GetCharacterLoungePointId(selectedCharacterId);
		if (characterId == selectedCharacterId && IsCharacterCheckedIn(selectedCharacterId) && pointId != characterLoungePointId)
		{
			ResetSideIcons();
			return;
		}
		Model<InviteCharacterModel>.Interface.GetSideIconDisplay(characterId, pointId, out var plotBright, out var plotDark, out var chatBright, out var chatDark);
		ApplySideIconVisual(plotBright, plotDark, chatBright, chatDark);
	}

	private static bool IsCharacterCheckedIn(int characterId)
	{
		LoungeInteractPointUseType characterStateInLounge = Model<InviteCharacterModel>.Interface.GetCharacterStateInLounge(characterId);
		if (characterStateInLounge != LoungeInteractPointUseType.LoungeInteractPointUseInvite)
		{
			return characterStateInLounge == LoungeInteractPointUseType.LoungeInteractPointUseRand;
		}
		return true;
	}

	private void ApplySideIconVisual(bool plotBright, bool plotDark, bool chatBright, bool chatDark)
	{
		ResetSideIcons();
		if (plotBright & chatBright)
		{
			_chatAndPlotImage.gameObject.SetActive(value: true);
			return;
		}
		if (plotDark & chatDark)
		{
			_chatAndPlotDarkImage.gameObject.SetActive(value: true);
			return;
		}
		if (plotBright)
		{
			_characterPlotImage.gameObject.SetActive(value: true);
		}
		if (plotDark)
		{
			_characterPlotDarkImage.gameObject.SetActive(value: true);
		}
		if (chatBright)
		{
			_chatImage.gameObject.SetActive(value: true);
		}
		if (chatDark)
		{
			_chatDarkImage.gameObject.SetActive(value: true);
		}
	}

	private void ResetSideIcons()
	{
		_characterPlotImage.gameObject.SetActive(value: false);
		_characterPlotDarkImage.gameObject.SetActive(value: false);
		_chatImage.gameObject.SetActive(value: false);
		_chatDarkImage.gameObject.SetActive(value: false);
		_chatAndPlotImage.gameObject.SetActive(value: false);
		_chatAndPlotDarkImage.gameObject.SetActive(value: false);
	}

	private void SetSelectImageVisible(bool visible)
	{
		_selectImage.gameObject.SetActive(visible && MonoECS.instance.InputMode != DeviceInputMode.Gamepad);
	}
}
