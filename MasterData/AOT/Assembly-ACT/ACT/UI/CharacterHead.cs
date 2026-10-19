using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class CharacterHead : MonoBehaviour
{
	[SerializeField]
	private BetterAnimation animation;

	[SerializeField]
	private BImage headImage;

	[SerializeField]
	public ActButton btn;

	[SerializeField]
	public GameObject isTrialRoot;

	[SerializeField]
	public RedDotItem redDotItem;

	[SerializeField]
	public BImage ImageQuality;

	[SerializeField]
	public GameObject teamPos;

	[SerializeField]
	public TextMeshProUGUI teamText;

	[SerializeField]
	public GameObject inTeamIcon;

	[SerializeField]
	public GameObject selectIcon;

	private int _characterId;

	private Character _character;

	private ImageAssetStation _station;

	public void Init(Character character, ImageAssetStation station, SceneStatus openSceneStatus = SceneStatus.Main)
	{
		_character = character;
		_characterId = character?.Id ?? 0;
		_station = station;
		RefreshIcon();
		EntityCharacterData data = CoreUtils.GetData(_characterId, RuntimeConfigs.data.entityCharacterDatas);
		station.LoadImage(175, data.stars, ImageQuality);
		string text = string.Format(RedDotPathDefine.Character + "|{0}", _characterId);
		Character character2 = _character;
		if ((character2 == null || !character2.IsTrailCharacter) && Singleton<RedDotManager>.instance.GetNode(text) != null)
		{
			redDotItem.InitRedDot(text, RedDotType.New);
		}
		Singleton<RedDotManager>.instance.OnRedDotStateChanged += OnRedDotStateChanged;
		UpdateRedDotDisplay(text);
		int teamIndex = GetTeamIndex(_character, openSceneStatus);
		teamPos.SetActive(teamIndex != -1);
		inTeamIcon.SetActive(teamIndex != -1);
		teamText.text = $"0{teamIndex}".ToString();
		selectIcon.SetActive(MonoECS.instance.MainEntityCharacterId == _characterId);
	}

	private int GetTeamIndex(Character character, SceneStatus openSceneStatus)
	{
		if (character == null)
		{
			return -1;
		}
		if (openSceneStatus == SceneStatus.Abyss)
		{
			if (character.IsTrailCharacter)
			{
				return -1;
			}
			int num = Model<AbyssModel>.Interface.GetTeamIndex(character.Id) % 3;
			if (num < 0)
			{
				return -1;
			}
			return num + 1;
		}
		IReadOnlyList<Character> characters = MPPlayer.local.CurrentRuntimeBattleTeam.Characters;
		for (int i = 0; i < characters.Count; i++)
		{
			if (characters[i] != null && characters[i].UID == character.UID)
			{
				return i + 1;
			}
		}
		return -1;
	}

	public void RefreshIcon()
	{
		int id = _character?.GetCharacterSkinId() ?? _characterId;
		_station.LoadImage(126, id, headImage);
	}

	public void Init(Character character, ImageAssetStation station, bool isSelect, SceneStatus openSceneStatus = SceneStatus.Main)
	{
		Init(character, station, openSceneStatus);
		RefreshSelectState(isSelect);
	}

	public void ActiveTrial(bool isTrial)
	{
		isTrialRoot.SetActive(isTrial);
	}

	public void OnIsNewRedClick()
	{
		Character character = _character;
		if ((character == null || !character.IsTrailCharacter) && G.localPlayer.redPoints.Characters.TryGetValue(_characterId, out var value) && value)
		{
			RedPoints redPoints = new RedPoints();
			int characterid = _characterId;
			redPoints.Characters.Add(characterid, value: false);
			G.service.RefreshRedDot(redPoints, (bool flag) =>
			{
				G.localPlayer.redPoints.Characters[characterid] = false;
				string nodeFullPath = string.Format(RedDotPathDefine.CharacterNew, characterid);
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active: false);
			});
		}
	}

	public void RefreshSelectState(bool isSelect)
	{
		selectIcon.SetActive(isSelect);
		if (isSelect)
		{
			OnIsNewRedClick();
		}
	}

	private void OnDestroy()
	{
		if (Singleton<RedDotManager>.HasInstance())
		{
			Singleton<RedDotManager>.instance.OnRedDotStateChanged -= OnRedDotStateChanged;
		}
	}

	private void OnRedDotStateChanged(string path, bool active)
	{
		string text = string.Format(RedDotPathDefine.CharacterNew, _characterId);
		if (path.StartsWith(text))
		{
			UpdateRedDotDisplay(text);
		}
	}

	private void UpdateRedDotDisplay(string newCharacterPath)
	{
		if (redDotItem == null || _characterId == 0)
		{
			return;
		}
		if (isTrialRoot.gameObject.activeSelf)
		{
			redDotItem.gameObject.SetActive(value: false);
			return;
		}
		string text = string.Format(RedDotPathDefine.Character + "|{0}|Constellation", _characterId);
		string text2 = string.Format(RedDotPathDefine.Character + "|{0}|EliteEntrance", _characterId);
		bool flag = Singleton<RedDotManager>.instance.GeCharacterTabRedpointState(_characterId);
		bool flag2 = Singleton<RedDotManager>.instance.IsNodeActive(text);
		bool flag3 = Singleton<RedDotManager>.instance.IsNodeActive(text2);
		if (flag)
		{
			redDotItem.redDotType = RedDotType.New;
			redDotItem.fullPath = newCharacterPath.Split("|").ToList();
			redDotItem.BindTrieNode();
			redDotItem.UpdateDisplay();
		}
		else if (flag2)
		{
			redDotItem.redDotType = RedDotType.Dot;
			redDotItem.fullPath = text.Split("|").ToList();
			redDotItem.BindTrieNode();
			redDotItem.UpdateDisplay();
		}
		else if (flag3)
		{
			redDotItem.redDotType = RedDotType.Dot;
			redDotItem.fullPath = text2.Split("|").ToList();
			redDotItem.BindTrieNode();
			redDotItem.UpdateDisplay();
		}
		else
		{
			redDotItem.redDotType = RedDotType.Dot;
			redDotItem.gameObject.SetActive(value: false);
		}
	}
}
