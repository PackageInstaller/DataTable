using System.Collections.Generic;
using ACT.Battle;
using ACT.Game.Data;
using ACT.Model;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class CommonWorldSettlementCharacter : MonoBehaviour
{
	[SerializeField]
	[Header("父布局中的单队占位高度")]
	private float _singleTeamLayoutHeight = 116f;

	[SerializeField]
	[Header("父布局中的多队占位高度")]
	private float _multipleTeamLayoutHeight = 240f;

	public GameObject SingleTeam;

	public List<BImage> LeftCharacterInfo;

	[SerializeField]
	[Header("单队伍没有角色时打开黑色蒙版")]
	private GameObject[] _singleTeamBlacks;

	[SerializeField]
	[Header("单队伍角色框")]
	private GameObject[] _singleTeamFrame;

	public GameObject MultipleTeam;

	public List<BImage> MultipleTeam1;

	[SerializeField]
	[Header("多队伍1没有角色时打开黑色蒙版")]
	private GameObject[] _multipleTeam1Blacks;

	[SerializeField]
	[Header("多队伍1角色框")]
	private GameObject[] _multipleTeam1Frame;

	public List<BImage> MultipleTeam2;

	[SerializeField]
	[Header("多队伍2没有角色时打开黑色蒙版")]
	private GameObject[] _multipleTeam2Blacks;

	[SerializeField]
	[Header("多队伍2角色框")]
	private GameObject[] _multipleTeam2Frame;

	private ImageAssetStation Station;

	private SceneStatus _sceneStatus;

	private LayoutElement _layoutElement;

	public void Refresh(SceneStatus sceneStatus, ImageAssetStation Station)
	{
		_sceneStatus = sceneStatus;
		this.Station = Station;
		if (_sceneStatus == SceneStatus.Raid || _sceneStatus == SceneStatus.Temple)
		{
			SingleTeam.SetActive(value: true);
			MultipleTeam.SetActive(value: false);
			UpdateLayoutHeight(multipleTeams: false);
			List<int> teamCharacterSkinIds = MonoECS.instance.localPlayer.GetTeamCharacterSkinIds();
			SetCharacterInfo(LeftCharacterInfo, teamCharacterSkinIds);
			for (int i = 0; i < _singleTeamBlacks.Length; i++)
			{
				_singleTeamBlacks[i].SetActive(i >= teamCharacterSkinIds.Count || teamCharacterSkinIds[i] <= 0);
				_singleTeamFrame[i].SetActive(i < teamCharacterSkinIds.Count && teamCharacterSkinIds[i] > 0);
			}
		}
		else if (_sceneStatus == SceneStatus.Abyss)
		{
			RefreshLeftAbyssCharacters();
		}
	}

	private void SetCharacterInfo(List<BImage> characterInfo, List<int> characterIds)
	{
		if (characterInfo == null)
		{
			return;
		}
		for (int i = 0; i < characterInfo.Count; i++)
		{
			if (i >= characterIds.Count || characterIds[i] <= 0)
			{
				characterInfo[i].icon.gameObject.SetActive(value: false);
				continue;
			}
			int id = characterIds[i];
			characterInfo[i].icon.gameObject.SetActive(value: true);
			Station.LoadImage(148, id, characterInfo[i]);
		}
	}

	private void RefreshLeftAbyssCharacters()
	{
		List<TeamUsage> lastChangeTeamUsages = Model<AbyssModel>.Interface.lastChangeTeamUsages;
		if (lastChangeTeamUsages == null || lastChangeTeamUsages.Count <= 0)
		{
			return;
		}
		SingleTeam.SetActive(lastChangeTeamUsages.Count <= 1);
		MultipleTeam.SetActive(lastChangeTeamUsages.Count > 1);
		UpdateLayoutHeight(lastChangeTeamUsages.Count > 1);
		List<int> characterIdsByTeamUsage = GetCharacterIdsByTeamUsage(lastChangeTeamUsages[0]);
		if (lastChangeTeamUsages.Count == 1)
		{
			SetCharacterInfo(LeftCharacterInfo, characterIdsByTeamUsage);
			for (int i = 0; i < _singleTeamBlacks.Length; i++)
			{
				_singleTeamBlacks[i].SetActive(i >= characterIdsByTeamUsage.Count || characterIdsByTeamUsage[i] <= 0);
				_singleTeamFrame[i].SetActive(i < characterIdsByTeamUsage.Count && characterIdsByTeamUsage[i] > 0);
			}
			return;
		}
		List<int> characterIdsByTeamUsage2 = GetCharacterIdsByTeamUsage(lastChangeTeamUsages[1]);
		SetCharacterInfo(MultipleTeam1, characterIdsByTeamUsage);
		for (int j = 0; j < _multipleTeam1Blacks.Length; j++)
		{
			_multipleTeam1Blacks[j].SetActive(j >= characterIdsByTeamUsage.Count || characterIdsByTeamUsage[j] <= 0);
			_multipleTeam1Frame[j].SetActive(j < characterIdsByTeamUsage.Count && characterIdsByTeamUsage[j] > 0);
		}
		SetCharacterInfo(MultipleTeam2, characterIdsByTeamUsage2);
		for (int k = 0; k < _multipleTeam2Blacks.Length; k++)
		{
			_multipleTeam2Blacks[k].SetActive(k >= characterIdsByTeamUsage2.Count || characterIdsByTeamUsage2[k] <= 0);
			_multipleTeam2Frame[k].SetActive(k < characterIdsByTeamUsage2.Count && characterIdsByTeamUsage2[k] > 0);
		}
	}

	private List<int> GetCharacterIdsByTeamUsage(TeamUsage teamUsage)
	{
		List<int> list = new List<int>();
		for (int i = 0; i < teamUsage.CharacterUsage.Count; i++)
		{
			int characterId = teamUsage.CharacterUsage[i].CharacterId;
			if (characterId != 0)
			{
				list.Add(characterId);
			}
		}
		return list;
	}

	private void UpdateLayoutHeight(bool multipleTeams)
	{
		if (_layoutElement == null)
		{
			_layoutElement = GetComponent<LayoutElement>();
		}
		if (_layoutElement != null)
		{
			_layoutElement.preferredHeight = (multipleTeams ? _multipleTeamLayoutHeight : _singleTeamLayoutHeight);
		}
	}
}
