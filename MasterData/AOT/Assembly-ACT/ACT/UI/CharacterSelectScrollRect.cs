using System;
using System.Collections.Generic;
using ACT.Game;
using ACT.Game.Data;
using Bamboo.ImageCenter;
using Google.Protobuf.Collections;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

[Obsolete]
public class CharacterSelectScrollRect : MonoBehaviour
{
	[SerializeReference]
	private LoopVerticalScrollRect _scrollRect;

	private ImageAssetStation _imageAssetStation;

	private List<int> _allCharacterIds;

	private Action<int> _onSelectCharacter;

	private int _selectedCharacterId;

	public int SelectedCharacterId => _selectedCharacterId;

	public void Init(ImageAssetStation imageAssetStation, int selectCharacterId, Action<int> onSelectCharacter)
	{
		_allCharacterIds = new List<int>();
		foreach (Character curAllCharacter in CharacterDataHelper.GetCurAllCharacters())
		{
			_allCharacterIds.Add(curAllCharacter.Id);
		}
		_allCharacterIds.Sort((int x, int y) =>
		{
			RepeatedField<int> characterIds = G.localPlayer.teamInfo.PresetTeams[G.localPlayer.teamInfo.MainTeamIdx].CharacterIds;
			int num = characterIds.IndexOf(x);
			int num2 = characterIds.IndexOf(y);
			if (num == -1 && num2 == -1)
			{
				return 0;
			}
			if (num != -1 && num2 == -1)
			{
				return -1;
			}
			return (num == -1 && num2 != -1) ? 1 : (num - num2);
		});
		_imageAssetStation = imageAssetStation;
		_selectedCharacterId = selectCharacterId;
		_onSelectCharacter = onSelectCharacter;
		_scrollRect.totalCount = _allCharacterIds.Count;
		_scrollRect.RefillCells();
		_scrollRect.ScrollToCell(_allCharacterIds.IndexOf(selectCharacterId), 0f);
		SelectCharacterImply(selectCharacterId);
	}

	public int GetCharacterId(int idx)
	{
		if (idx < 0 || idx >= _allCharacterIds.Count)
		{
			return -1;
		}
		return _allCharacterIds[idx];
	}

	private int GetCharacterIndex(int characterId)
	{
		return _allCharacterIds.IndexOf(characterId);
	}

	public void OnHeadSculptureLoad(CharacterHeadSculpture headSculpture)
	{
		headSculpture.Register(this, _imageAssetStation, SelectCharacter);
	}

	private void SelectCharacter(int characterId)
	{
		if (_selectedCharacterId != characterId)
		{
			SelectCharacterImply(characterId);
		}
	}

	private void SelectCharacterImply(int characterId)
	{
		CharacterHeadSculpture characterHeadSculpture = _scrollRect.GetItem(GetCharacterIndex(_selectedCharacterId)) as CharacterHeadSculpture;
		if (characterHeadSculpture != null)
		{
			characterHeadSculpture.ToNormal();
		}
		CharacterHeadSculpture characterHeadSculpture2 = _scrollRect.GetItem(GetCharacterIndex(characterId)) as CharacterHeadSculpture;
		if (characterHeadSculpture2 != null)
		{
			characterHeadSculpture2.ToSelect();
		}
		_selectedCharacterId = characterId;
		_onSelectCharacter(_selectedCharacterId);
	}
}
