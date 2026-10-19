using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Sound;
using ACT.Sound.Management;
using ACT.UI.DataProxy;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class AbyssTeamSubView : MonoBehaviour
{
	public enum TeamInfoTab
	{
		Character,
		Preset
	}

	[SerializeField]
	private ActButton _closeButton;

	[Space]
	[SerializeField]
	public PublicToggle _characterTab;

	[SerializeField]
	private CommonScrollBagComponent _characterCommonScrollBagComponent;

	[SerializeField]
	public PublicToggle _presetTab;

	[SerializeField]
	private LoopScrollRect _presetLoopScrollRect;

	[Space]
	[SerializeField]
	private TextMeshProUGUI _abyssTitle;

	[Header("深渊任务")]
	[SerializeField]
	private List<GameObject> _challenges;

	[SerializeField]
	private List<LocalizeStringEvent> _challengeDescriptions;

	[SerializeField]
	private List<GameObject> _finished;

	[Header("怪物信息")]
	[SerializeField]
	private List<AbyssTeamInfoItem> _abyssTeamInfoItems;

	[SerializeField]
	private GameObject _abyssTeamInfoLB;

	[SerializeField]
	private GameObject _abyssTeamInfoRB;

	[SerializeField]
	private ActButton _deleteButton;

	[SerializeField]
	private ActButton _characterInfoButton;

	[SerializeField]
	private ActButton _gotoButton;

	[SerializeField]
	private GameObject _tips;

	[SerializeField]
	private TextMeshProUGUI _tipContent;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private TeamInfoTab _curTeamInfoTab;

	private int _chooseIndex;

	private AbyssData _abyssData;

	private AbyssStage _abyssStage;

	private List<AbyssMonsterItem> MonsterUpItems = new List<AbyssMonsterItem>(8);

	private List<AbyssMonsterItem> MonsterDownItems = new List<AbyssMonsterItem>(8);

	public RepeatedField<PresetTeam> PresetTeamProfiles = new RepeatedField<PresetTeam>();

	private MonoAbyssListView _monoAbyssListView;

	private uint _playingVoiceUnitId;

	private List<TeamUsage> _teamUsages => Model<AbyssModel>.Interface.AbyssModifyData;

	public int CurSelectTeam
	{
		get
		{
			return Model<AbyssModel>.Interface.curOperateTeam;
		}
		set
		{
			Model<AbyssModel>.Interface.curOperateTeam = value;
			SetSelectTeam(Model<AbyssModel>.Interface.curOperateTeam);
		}
	}

	public TeamInfoTab CurTeamInfoTab => _curTeamInfoTab;

	public void Initialize(MonoAbyssListView monoAbyssListView, int abyssGroupId, int chooseIndex)
	{
		_monoAbyssListView = monoAbyssListView;
		_chooseIndex = chooseIndex;
		CurSelectTeam = 1;
		_closeButton.SetBtnClick(_monoAbyssListView.CloseAbyssTeamPanel);
		_deleteButton.SetBtnClick(OnClickDeleteButtonHandle);
		_characterInfoButton.SetBtnClick(OpenCharacterDetailView);
		_gotoButton.SetBtnClick(OnClickGotoButtonHandle, "event:/UI/Interface/Abyss/Challenge");
		_characterTab.onValueChanged.RemoveAllListeners();
		_presetTab.onValueChanged.RemoveAllListeners();
		_characterTab.onValueChanged.AddListener(OnClickCharacterTabHandle);
		_presetTab.onValueChanged.AddListener(OnClickPresetTabHandle);
		_characterTab.InitToggle();
		_presetTab.InitToggle();
		_characterTab.isOn = true;
		RefreshUI(abyssGroupId);
		_betterAnimation.GetSequence("Show").Play();
	}

	public void UnInitialize()
	{
		_characterTab.onValueChanged.RemoveAllListeners();
		_presetTab.onValueChanged.RemoveAllListeners();
	}

	public void OnPushStack()
	{
	}

	public async void OnPopStack()
	{
		await RefreshTeamInfo();
	}

	private async void OnClickCharacterTabHandle(bool value)
	{
		if (value)
		{
			_curTeamInfoTab = TeamInfoTab.Character;
			await RefreshTeamInfo();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Item_Click");
		}
	}

	private async void OnClickPresetTabHandle(bool value)
	{
		if (value)
		{
			_curTeamInfoTab = TeamInfoTab.Preset;
			await RefreshTeamInfo();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Item_Click");
		}
	}

	public async void OnClickDeleteButtonHandle()
	{
		for (int i = 0; i < _teamUsages.Count; i++)
		{
			for (int j = 0; j < _teamUsages[i].CharacterUsage.Count; j++)
			{
				_teamUsages[i].CharacterUsage[j].CharacterId = 0;
			}
			_teamUsages[i].EquipPotionId = 0;
		}
		if (_curTeamInfoTab == TeamInfoTab.Preset)
		{
			_presetLoopScrollRect.RefreshCells();
		}
		else
		{
			await RefreshTeamInfo();
			_monoAbyssListView.ControlLayerDic[AbyssListViewControllerType.AbyssTeamCharacter].Focus();
		}
		RefreshCharacterConfiguration();
	}

	public void OpenAbyssBloodBottlePopup()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSBLOODBOTTLE);
	}

	public void OpenCharacterDetailView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTER, new CharacterViewData
		{
			OpenSceneStatus = SceneStatus.Abyss,
			defaultCharacterId = GetDefaultCharacterId()
		});
	}

	private int GetDefaultCharacterId()
	{
		foreach (TeamUsage teamUsage in _teamUsages)
		{
			for (int i = 0; i < teamUsage.CharacterUsage.Count; i++)
			{
				int characterId = teamUsage.CharacterUsage[i].CharacterId;
				if (characterId != 0)
				{
					return characterId;
				}
			}
		}
		return -1;
	}

	public void OnClickGotoButtonHandle()
	{
		if (CheckAbyssIsExpired())
		{
			return;
		}
		if (CheckTeamIsEmpty())
		{
			GameUtility.OpenToolTip(2137);
			return;
		}
		MonoECS.instance.SyncGameInfos();
		for (int i = 0; i < _teamUsages.Count; i++)
		{
			for (int j = 0; j < _teamUsages[i].CharacterUsage.Count - 1; j++)
			{
				if (_teamUsages[i].CharacterUsage[j].CharacterId != 0)
				{
					continue;
				}
				int num = -1;
				for (int k = j + 1; k < _teamUsages[i].CharacterUsage.Count; k++)
				{
					if (_teamUsages[i].CharacterUsage[k].CharacterId != 0)
					{
						num = k;
						break;
					}
				}
				if (num != -1)
				{
					_teamUsages[i].CharacterUsage[j].CharacterId = _teamUsages[i].CharacterUsage[num].CharacterId;
					_teamUsages[i].CharacterUsage[num].CharacterId = 0;
				}
			}
			_teamUsages[i].BattleCharacterIdx = 0;
		}
		G.service.AbyssEnter(_chooseIndex, Model<AbyssModel>.Interface.GroupId, _teamUsages, async (bool r) =>
		{
			if (r)
			{
				_monoAbyssListView.CloseAbyssTeamPanel();
				_monoAbyssListView.Close();
				await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Abyss);
			}
		});
	}

	private bool CheckTeamIsEmpty()
	{
		foreach (TeamUsage teamUsage in _teamUsages)
		{
			bool flag = true;
			foreach (TeamCharacterUsage item in teamUsage.CharacterUsage)
			{
				if (item.CharacterId != 0)
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				return true;
			}
		}
		return false;
	}

	private bool CheckAbyssIsExpired()
	{
		if (Model<AbyssModel>.Interface.CheckCurrentAbyssIsExpired())
		{
			GameUtility.OpenToolTip(2901);
			_monoAbyssListView.CloseAbyssTeamPanel();
			return true;
		}
		return false;
	}

	private async void RefreshUI(int abyssGroupID)
	{
		if (!RuntimeConfigs.data.abyssGroupDatas.TryGetValue(abyssGroupID, out var value) || _chooseIndex >= value.abyssInclude.Length || !RuntimeConfigs.data.abyssDatas.TryGetValue(value.abyssInclude[_chooseIndex], out var value2))
		{
			return;
		}
		foreach (AbyssStage abyssStage in Model<AbyssModel>.Interface.AbyssStages)
		{
			if (abyssStage.Index == _chooseIndex)
			{
				_abyssStage = abyssStage;
				break;
			}
		}
		_abyssData = value2;
		InitCharacterConfiguration();
		await RefreshTeamInfo();
		_abyssTitle.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, _abyssData.abyssNameLocal);
		RefreshAbyssTaskTarget();
		RefreshMonsterList();
		SetSelectTeam(1);
		RefreshPrompts();
	}

	private void InitCharacterConfiguration()
	{
		_teamUsages.Clear();
		for (int i = 0; i < ((!GetIsHasSecondHalf()) ? 1 : 2); i++)
		{
			TeamUsage teamUsage = new TeamUsage();
			for (int j = 0; j < 3; j++)
			{
				teamUsage.CharacterUsage.Add(new TeamCharacterUsage
				{
					CharacterId = 0
				});
			}
			teamUsage.EquipPotionId = 0;
			_teamUsages.Add(teamUsage);
		}
		RepeatedField<AbyssTeamInfo> teams = Model<AbyssModel>.Interface.AbyssStages[Model<AbyssModel>.Interface.LastChallengeStageIndex].Teams;
		List<BloodBottleData> list = Model<BloodBottleModel>.Interface.GetMainAlreadyHaveBottles().ToList();
		list.Sort(SortBloodBottle);
		for (int k = 0; k < 2 && (GetIsHasSecondHalf() || k < 1); k++)
		{
			AbyssTeamInfo abyssTeamInfo = ((k >= teams.Count) ? null : teams[k]);
			int num = ((list.Count > k) ? list[k].id : 0);
			if (abyssTeamInfo != null)
			{
				if (abyssTeamInfo.CharacterIds.Count != 0)
				{
					for (int l = 0; l < 3; l++)
					{
						_teamUsages[k].CharacterUsage[l].CharacterId = ((l < abyssTeamInfo.CharacterIds.Count) ? abyssTeamInfo.CharacterIds[l] : 0);
					}
				}
				_teamUsages[k].EquipPotionId = ((abyssTeamInfo.Potion != null) ? abyssTeamInfo.Potion.Id : num);
			}
			else
			{
				_teamUsages[k].EquipPotionId = num;
			}
		}
	}

	private int SortBloodBottle(BloodBottleData left, BloodBottleData right)
	{
		return -left.curLevel.CompareTo(right.curLevel);
	}

	private async UniTask RefreshTeamInfo()
	{
		if (_curTeamInfoTab == TeamInfoTab.Character)
		{
			_characterCommonScrollBagComponent.OnItemShow = null;
			_characterCommonScrollBagComponent.OnItemSelect = null;
			_characterCommonScrollBagComponent.OnItemUnSelect = null;
			CommonScrollBagComponent characterCommonScrollBagComponent = _characterCommonScrollBagComponent;
			characterCommonScrollBagComponent.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(characterCommonScrollBagComponent.OnItemSelect, (Action<ItemUIComponentBase>)((ItemUIComponentBase item) =>
			{
				if (item is AbyssBagCharacterItemUIComponent item2)
				{
					ChooseCharacterListItem(item2);
				}
			}));
			_characterCommonScrollBagComponent.SelectMode = CommonScrollBagComponent.SelectModeType.MultipleUnique;
			_characterCommonScrollBagComponent.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
			_characterCommonScrollBagComponent.ItemShowType = ItemUIComponentBase.InitType.CharacterViewBagCharacter;
			CommonScrollBagComponent characterCommonScrollBagComponent2 = _characterCommonScrollBagComponent;
			characterCommonScrollBagComponent2.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(characterCommonScrollBagComponent2.OnItemShow, (Action<ItemUIComponentBase>)((ItemUIComponentBase item) =>
			{
				if (item is AbyssBagCharacterItemUIComponent abyssBagCharacterItemUIComponent)
				{
					int num3 = 0;
					for (int i = 0; i < _teamUsages[0].CharacterUsage.Count; i++)
					{
						if (_teamUsages[0].CharacterUsage[i].CharacterId == abyssBagCharacterItemUIComponent.ItemUnifier.Id)
						{
							num3 = 1;
							break;
						}
					}
					if (num3 == 0 && _teamUsages.Count > 1)
					{
						for (int j = 0; j < _teamUsages[1].CharacterUsage.Count; j++)
						{
							if (_teamUsages[1].CharacterUsage[j].CharacterId == abyssBagCharacterItemUIComponent.ItemUnifier.Id)
							{
								num3 = 2;
								break;
							}
						}
					}
					abyssBagCharacterItemUIComponent.TeamIndex = num3;
					abyssBagCharacterItemUIComponent.CanChose = num3 == 0;
				}
			}));
			List<ItemUnifierProxy> list = ListPool<ItemUnifierProxy>.Get();
			ItemUnifierProxy.ItemUnifierPool.GetList(CharacterDataHelper.GetBagCharacters(), list);
			list.Sort((ItemUnifierProxy x, ItemUnifierProxy y) =>
			{
				Character character = x.As<Character>();
				Character character2 = y.As<Character>();
				int num3 = character2.Level - character.Level;
				return (num3 != 0) ? num3 : (character2.GetQuality() - character.GetQuality());
			});
			_characterCommonScrollBagComponent.ItemSource = list;
			_characterCommonScrollBagComponent.Station = _monoAbyssListView.Station;
			return;
		}
		_characterCommonScrollBagComponent.ClearBag();
		PresetTeamProfiles.Clear();
		for (int num = 0; num < G.localPlayer.teamInfo.PresetTeams.Count; num++)
		{
			bool flag = true;
			for (int num2 = 0; num2 < G.localPlayer.teamInfo.PresetTeams[num].CharacterIds.Count; num2++)
			{
				if (G.localPlayer.teamInfo.PresetTeams[num].CharacterIds[num2] != 0)
				{
					flag = false;
					break;
				}
			}
			if (!flag)
			{
				PresetTeamProfiles.Add(G.localPlayer.teamInfo.PresetTeams[num].Clone());
			}
		}
		_presetLoopScrollRect.totalCount = PresetTeamProfiles.Count;
		await UniTask.DelayFrame(1);
		_presetLoopScrollRect.RefreshCells();
	}

	private void ChooseCharacterListItem(AbyssBagCharacterItemUIComponent item)
	{
		if (item.TeamIndex != 0)
		{
			int num = (CurSelectTeam = item.TeamIndex);
			TeamUsage teamUsage = _teamUsages[num - 1];
			for (int i = 0; i < teamUsage.CharacterUsage.Count; i++)
			{
				if (teamUsage.CharacterUsage[i].CharacterId == item.ItemUnifier.Id)
				{
					DeleteCharacter(i);
					break;
				}
			}
			return;
		}
		int teamEmptyIndex = GetTeamEmptyIndex();
		if (GetIsHasSecondHalf())
		{
			if (teamEmptyIndex == -1)
			{
				int num2 = ((CurSelectTeam != 1) ? 1 : 2);
				Model<AbyssModel>.Interface.curOperateTeam = num2;
				if (GetTeamEmptyIndex() == -1)
				{
					Model<AbyssModel>.Interface.curOperateTeam = ((Model<AbyssModel>.Interface.curOperateTeam != 1) ? 1 : 2);
					GameUtility.OpenToolTip(LocalizationCommonData.CommonString.TeamCharacterIsFull);
				}
				else
				{
					SetSelectTeam(num2);
				}
			}
		}
		else if (teamEmptyIndex == -1)
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.TeamCharacterIsFull);
			return;
		}
		int id = item.ItemUnifier.As<Character>().Id;
		if (ConfigurationCharacter(id) != -1)
		{
			item.TeamIndex = Model<AbyssModel>.Interface.curOperateTeam;
			item.CanChose = false;
		}
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		if (_playingVoiceUnitId == 0 || audioManager == null || !audioManager.IsPlaying(_playingVoiceUnitId))
		{
			_playingVoiceUnitId = Singleton<CharacterVoiceManager>.instance.PlayCharacterVoice(id);
		}
	}

	private void RefreshAbyssTaskTarget()
	{
		if (_abyssData == null)
		{
			return;
		}
		int num = 0;
		for (int num2 = _challenges.Count - 1; num2 >= 0; num2--)
		{
			_challenges[num2].SetActive(num2 < _abyssData.abyssGoal.Length + 1);
			if (num2 < _abyssData.abyssGoal.Length + 1)
			{
				if (num2 == _abyssData.abyssGoal.Length)
				{
					_challengeDescriptions[num2].StringReference.TableEntryReference = 2287L;
				}
				else
				{
					int num3 = _abyssData.abyssGoal.Length - 1 - num2;
					int num4 = _abyssData.abyssGoal[num3];
					int value = num4 / 60;
					int value2 = num4 % 60;
					_challengeDescriptions[num2].StringReference.TableEntryReference = 615L;
					_challengeDescriptions[num2].StringReference.GetVariable<int>("0").Value = value;
					_challengeDescriptions[num2].StringReference.GetVariable<int>("1").Value = value2;
				}
				num++;
				_finished[num2].SetActive(num <= _abyssStage.CompletedTargetsNum);
			}
		}
	}

	private void RefreshMonsterList()
	{
		if (_abyssData == null)
		{
			return;
		}
		for (int i = 0; i < _abyssTeamInfoItems.Count; i++)
		{
			_abyssTeamInfoItems[i].RefreshUI(_abyssData, i, _chooseIndex);
			if (i < _teamUsages.Count)
			{
				_abyssTeamInfoItems[i].RefreshCharacters(_teamUsages[i]);
			}
		}
	}

	private void RefreshCharacterConfiguration()
	{
		for (int i = 0; i < _teamUsages.Count; i++)
		{
			_abyssTeamInfoItems[i].RefreshCharacters(_teamUsages[i]);
		}
	}

	private void SetSelectTeam(int index)
	{
		for (int i = 0; i < _abyssTeamInfoItems.Count; i++)
		{
			_abyssTeamInfoItems[i].SetSelect(index - 1);
		}
	}

	public bool GetIsHasSecondHalf()
	{
		if (_abyssData == null)
		{
			return false;
		}
		return _abyssData.subabyss.Count() > 1;
	}

	public int ConfigurationCharacter(int characterId)
	{
		if (characterId <= 0)
		{
			return -1;
		}
		TeamUsage teamUsage = _teamUsages[Model<AbyssModel>.Interface.curOperateTeam - 1];
		if (teamUsage.CharacterUsage.Any((TeamCharacterUsage u) => u.CharacterId == characterId))
		{
			return -1;
		}
		int teamEmptyIndex = GetTeamEmptyIndex();
		if (teamEmptyIndex == -1)
		{
			return -1;
		}
		if (GetIsHasSecondHalf())
		{
			int num = ((Model<AbyssModel>.Interface.curOperateTeam != 1) ? 1 : 2);
			TeamUsage teamUsage2 = _teamUsages[num - 1];
			for (int num2 = 0; num2 < teamUsage2.CharacterUsage.Count; num2++)
			{
				if (teamUsage2.CharacterUsage[num2].CharacterId == characterId)
				{
					teamUsage2.CharacterUsage[num2].CharacterId = 0;
					break;
				}
			}
			_abyssTeamInfoItems[num - 1].RefreshCharacters(teamUsage2);
		}
		teamUsage.CharacterUsage[teamEmptyIndex].CharacterId = characterId;
		_abyssTeamInfoItems[Model<AbyssModel>.Interface.curOperateTeam - 1].RefreshCharacters(teamUsage);
		return teamEmptyIndex;
	}

	public void DeleteCharacter(int index)
	{
		TeamUsage teamUsage = _teamUsages[Model<AbyssModel>.Interface.curOperateTeam - 1];
		if (teamUsage.CharacterUsage[index].CharacterId == 0)
		{
			return;
		}
		int deleteCharacterId = teamUsage.CharacterUsage[index].CharacterId;
		GetIsHasSecondHalf();
		teamUsage.CharacterUsage[index].CharacterId = 0;
		_abyssTeamInfoItems[Model<AbyssModel>.Interface.curOperateTeam - 1].RefreshCharacters(teamUsage);
		if (_curTeamInfoTab == TeamInfoTab.Preset)
		{
			_presetLoopScrollRect.RefreshCells();
			return;
		}
		int id = _characterCommonScrollBagComponent.ItemSource.ToList().FindIndex((ItemUnifierProxy c) => c.Id == deleteCharacterId);
		AbyssBagCharacterItemUIComponent abyssBagCharacterItemUIComponent = _characterCommonScrollBagComponent.GetItem(id) as AbyssBagCharacterItemUIComponent;
		if (abyssBagCharacterItemUIComponent != null)
		{
			abyssBagCharacterItemUIComponent.TeamIndex = 0;
			abyssBagCharacterItemUIComponent.CanChose = true;
		}
	}

	public void OnClickPresetItem(int index, RepeatedField<int> characterIds)
	{
		ConfigurationPreset(characterIds);
	}

	public void ConfigurationPreset(RepeatedField<int> characterIds)
	{
		bool isHasSecondHalf = GetIsHasSecondHalf();
		TeamUsage teamUsage = _teamUsages[Model<AbyssModel>.Interface.curOperateTeam - 1];
		for (int i = 0; i < characterIds.Count; i++)
		{
			if (characterIds[i] <= 0)
			{
				teamUsage.CharacterUsage[i].CharacterId = characterIds[i];
				continue;
			}
			if (isHasSecondHalf)
			{
				int num = ((Model<AbyssModel>.Interface.curOperateTeam != 1) ? 1 : 2);
				TeamUsage teamUsage2 = _teamUsages[num - 1];
				for (int j = 0; j < teamUsage2.CharacterUsage.Count; j++)
				{
					if (teamUsage2.CharacterUsage[j].CharacterId == characterIds[i])
					{
						teamUsage2.CharacterUsage[j].CharacterId = 0;
						break;
					}
				}
			}
			teamUsage.CharacterUsage[i].CharacterId = characterIds[i];
		}
		for (int k = 0; k < _abyssTeamInfoItems.Count; k++)
		{
			if (k < _teamUsages.Count)
			{
				_abyssTeamInfoItems[k].RefreshCharacters(_teamUsages[k]);
			}
		}
		_presetLoopScrollRect.RefreshCells();
	}

	private int GetTeamEmptyIndex()
	{
		if (Model<AbyssModel>.Interface.curOperateTeam < 0)
		{
			return -1;
		}
		TeamUsage teamUsage = _teamUsages[Model<AbyssModel>.Interface.curOperateTeam - 1];
		for (int i = 0; i < teamUsage.CharacterUsage.Count; i++)
		{
			if (teamUsage.CharacterUsage[i].CharacterId == 0)
			{
				return i;
			}
		}
		return -1;
	}

	public void ConfigurationBloodBottle(int bloodBottleId)
	{
		if (GetIsHasSecondHalf())
		{
			TeamUsage teamUsage = ((Model<AbyssModel>.Interface.curOperateTeam == 1) ? _teamUsages[1] : _teamUsages[0]);
			if (teamUsage.EquipPotionId == bloodBottleId)
			{
				teamUsage.EquipPotionId = 0;
				int index = ((Model<AbyssModel>.Interface.curOperateTeam == 1) ? 1 : 0);
				_abyssTeamInfoItems[index].RefreshBloodBottle(0);
			}
		}
		((Model<AbyssModel>.Interface.curOperateTeam == 1) ? _teamUsages[0] : _teamUsages[1]).EquipPotionId = bloodBottleId;
		_abyssTeamInfoItems[Model<AbyssModel>.Interface.curOperateTeam - 1].RefreshBloodBottle(bloodBottleId);
	}

	public void SetDownButtonState(bool value)
	{
		_characterInfoButton.gameObject.SetActive(value);
		_gotoButton.gameObject.SetActive(value);
	}

	public void OpenMonsterDetailView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_MONOABYSSTEAMMONSTER, new MonoAbyssTeamMonsterViewData
		{
			abyssId = _abyssData.id
		});
	}

	public Vector3 GetBloodBottlePosition(int index)
	{
		return _abyssTeamInfoItems[index].GetBloodBottlePosition();
	}

	public void LT()
	{
		if (CurSelectTeam == 2)
		{
			CurSelectTeam = 1;
		}
	}

	public void RT()
	{
		if (CurSelectTeam == 1 && GetIsHasSecondHalf())
		{
			CurSelectTeam = 2;
		}
	}

	public void Select()
	{
		OpenAbyssBloodBottlePopup();
	}

	public void OnStart()
	{
		OpenMonsterDetailView();
	}

	public void RefreshPrompts()
	{
		_abyssTeamInfoLB.SetActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad && GetIsHasSecondHalf());
		_abyssTeamInfoRB.SetActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad && GetIsHasSecondHalf());
	}
}
