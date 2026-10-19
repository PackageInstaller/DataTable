using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Sound;
using ACT.Sound.Management;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using Runtime.Utility;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TeamCharacterSelectBar : MonoBehaviour
{
	[SerializeField]
	private CommonScrollBagComponent _selectBag;

	[SerializeField]
	private BetterAnimation _selectedBagAnimation;

	[SerializeField]
	private TeamCharacterInfo _selectCharacterInfo;

	[SerializeField]
	private GameObject _emptyTip;

	[SerializeField]
	[Header("关闭按钮")]
	private ActButton _closeBtn;

	[SerializeField]
	private LocalizeStringEvent _closeBtnStringEvent;

	[SerializeField]
	[Header("操作按钮(上阵/换下/替换/交换)")]
	private ActButton _operateBtn;

	[SerializeField]
	private LocalizeStringEvent _operateBtnStringEvent;

	[SerializeField]
	[Header("角色详情按钮")]
	private ActButton _detailBtn;

	[SerializeField]
	private LocalizeStringEvent _detailBtnStringEvent;

	[SerializeField]
	private ActButton _mask;

	private List<ItemUnifierProxy> _itemUnifierProxys;

	private CommonUILifeCycle _lifeCycle;

	private TeamView _parentView;

	private TeamModel _model;

	private int _characterIndex;

	private int _ownCharacterId;

	private uint _playingVoiceUnitId;

	private const int AddLocalize = 774;

	private const int RemoveLocalize = 474;

	private const int ReplaceLocalize = 475;

	private const int SwapLocalize = 915;

	public CommonScrollBagComponent SelectBag => _selectBag;

	public ActButton CloseBtn => _closeBtn;

	public ActButton OperateBtn => _operateBtn;

	public ActButton DetailBtn => _detailBtn;

	public bool IsNormal => _lifeCycle == CommonUILifeCycle.Normal;

	public bool IsHidden => _lifeCycle == CommonUILifeCycle.Hidden;

	public event Action OnBagClosed;

	private void Awake()
	{
		_itemUnifierProxys = ListPool<ItemUnifierProxy>.Get();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, CharacterViewUnLock);
	}

	private void CharacterViewUnLock(BaseEventContent obj)
	{
		if (obj is SystemOpenEvt { systemId: 1017 } systemOpenEvt)
		{
			_detailBtn.gameObject.SetActive(systemOpenEvt.unLock);
		}
	}

	private void OnDestroy()
	{
		ListPool<ItemUnifierProxy>.Release(_itemUnifierProxys);
		_itemUnifierProxys = null;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, CharacterViewUnLock);
	}

	public void InvokeOperate()
	{
		if (_operateBtn != null && _operateBtn.gameObject.activeInHierarchy && _operateBtn.IsInteractable())
		{
			_operateBtn.OnClick?.Invoke();
		}
	}

	public void InvokeDetail()
	{
		if (_detailBtn != null && _detailBtn.gameObject.activeInHierarchy && _detailBtn.IsInteractable())
		{
			_detailBtn.OnClick?.Invoke();
		}
	}

	public void InitData(TeamView parentView)
	{
		_parentView = parentView;
		_model = Model<TeamModel>.Interface;
	}

	public void Open(int characterId, int characterIndex, int ownCharacterId, ImageAssetStation station)
	{
		if (_lifeCycle != CommonUILifeCycle.Hidden)
		{
			return;
		}
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Team_OpenCharacterSelectBag);
		_characterIndex = characterIndex;
		_ownCharacterId = ownCharacterId;
		_selectBag.gameObject.SetActive(value: true);
		_selectBag.OnItemShow = null;
		_selectBag.OnItemSelect = null;
		_selectBag.OnItemUnSelect = null;
		_selectBag.SelectedModels.Clear();
		CommonScrollBagComponent selectBag = _selectBag;
		selectBag.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(selectBag.OnItemSelect, (Action<ItemUIComponentBase>)((ItemUIComponentBase item) =>
		{
			if (item is BagCharacterItemUIComponent { CanChose: not false })
			{
				Character character = item.ItemUnifier.As<Character>();
				OnChooseCharacter(character);
				_emptyTip.SetActive(value: false);
			}
		}));
		_selectBag.ItemShowType = ItemUIComponentBase.InitType.TeamViewBagCharacter;
		_selectBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		ItemUnifierProxy.ItemUnifierPool.Release(_itemUnifierProxys);
		ItemUnifierProxy.ItemUnifierPool.GetList(CharacterDataHelper.GetBagCharacters(), _itemUnifierProxys);
		if (_model.source == TeamProfileSource.Temple)
		{
			_itemUnifierProxys.Sort((ItemUnifierProxy x, ItemUnifierProxy y) => SortUtility.TempleTeamCharacterSort(x.As<Character>(), y.As<Character>()));
		}
		else
		{
			_itemUnifierProxys.Sort((ItemUnifierProxy x, ItemUnifierProxy y) => SortUtility.TeamCharacterSort(x.As<Character>(), y.As<Character>()));
		}
		_selectBag.ItemSource = _itemUnifierProxys;
		_selectBag.Station = station;
		_closeBtn.gameObject.SetActive(value: true);
		_closeBtnStringEvent.StringReference.TableEntryReference = LocalizationCommonData.CommonString.CharacterSelect;
		_closeBtn.SetBtnClick(Close, "event:/UI/Common/Return_Click");
		bool active = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.CharacterView);
		_detailBtn.gameObject.SetActive(active);
		_detailBtnStringEvent.StringReference.TableEntryReference = LocalizationCommonData.CommonString.CharacterDetails;
		_detailBtn.SetBtnClick(OnToCharacterViewBtnEvent);
		_operateBtn.Interactable(active: true);
		_mask.SetBtnClick(Close);
		SelectDefaultCharacter(characterId);
		gameObject.SetActive(value: true);
		_lifeCycle = CommonUILifeCycle.Opening;
		MonoECS.instance.PushPauseAllInput();
		_selectedBagAnimation?.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			ShowEnd();
		}).Play();
	}

	public void Close()
	{
		if (_lifeCycle == CommonUILifeCycle.Normal)
		{
			_lifeCycle = CommonUILifeCycle.Closing;
			MonoECS.instance.PushPauseAllInput();
			_selectedBagAnimation?.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				HideEnd();
			}).Play();
			UISceneRender.instance.ResetCameraPosition(_model.CurSelectedTeamCharacters);
			ResetModel();
			_selectCharacterInfo.UnInit();
			_emptyTip.SetActive(value: false);
		}
	}

	public void ForceUpdatePerformance()
	{
		_selectBag.ForceUpdatePerformance();
	}

	private void OnToCharacterViewBtnEvent()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/Role_Detail");
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_CHARACTER, new CharacterViewData
		{
			defaultCharacterId = _model.singleSelectCharacter,
			OpenSceneStatus = MonoECS.instance.sceneStatus
		}).Forget();
	}

	public ACT.ViewControl.SelectableEx GetDefaultSelectableEx()
	{
		ItemUIComponentBase itemUIComponentBase = _selectBag?.SelectedModels?.FirstOrDefault()?.Context as ItemUIComponentBase;
		if (!(itemUIComponentBase != null))
		{
			return null;
		}
		return itemUIComponentBase.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
	}

	private void ShowEnd()
	{
		MonoECS.instance.PopPauseAllInput();
		_lifeCycle = CommonUILifeCycle.Normal;
	}

	private void HideEnd()
	{
		MonoECS.instance.PopPauseAllInput();
		_selectBag.gameObject.SetActive(value: false);
		gameObject.SetActive(value: false);
		_lifeCycle = CommonUILifeCycle.Hidden;
		OnBagClosed?.Invoke();
	}

	private void SelectDefaultCharacter(int characterId)
	{
		ItemUnifierProxy itemUnifierProxy = null;
		if (characterId == 0)
		{
			if (_model.source == TeamProfileSource.Temple)
			{
				List<int> limitElements = Model<TempleModel>.Interface.GetLimitElements(_model.templeId);
				if (limitElements != null && limitElements.Count > 0)
				{
					foreach (ItemUnifierProxy item in _selectBag.ItemSource)
					{
						if (limitElements.Contains((int)item.As<Character>().element) && !_model.CurSelectedTeamCharacters.Contains(item.Id))
						{
							itemUnifierProxy = item;
							break;
						}
					}
				}
				else
				{
					foreach (ItemUnifierProxy item2 in _selectBag.ItemSource)
					{
						if (!_model.CurSelectedTeamCharacters.Contains(item2.Id))
						{
							itemUnifierProxy = item2;
							break;
						}
					}
				}
				if (itemUnifierProxy == null)
				{
					foreach (ItemUnifierProxy item3 in _selectBag.ItemSource)
					{
						if (G.localPlayer.GetBagCharacter(item3.Id).IsRuntimeAlive())
						{
							itemUnifierProxy = item3;
							break;
						}
					}
				}
			}
			else
			{
				int strongGuideCharacterId = Model<TeamModel>.Interface.StrongGuideCharacterId;
				if (strongGuideCharacterId != 0)
				{
					itemUnifierProxy = _selectBag.ItemSource.FirstOrDefault((ItemUnifierProxy x) => x.Id == strongGuideCharacterId);
					Model<TeamModel>.Interface.ResetGuideDefaultSelectAddCharacterBtn();
					Model<TeamModel>.Interface.ResetGuideDefaultSelectCharacter();
				}
				else
				{
					foreach (ItemUnifierProxy item4 in _selectBag.ItemSource)
					{
						if (!_model.CurSelectedTeamCharacters.Contains(item4.Id))
						{
							itemUnifierProxy = item4;
							break;
						}
					}
					if (itemUnifierProxy == null)
					{
						foreach (ItemUnifierProxy item5 in _selectBag.ItemSource)
						{
							if (_model.CurSelectedTeamCharacters.Contains(item5.Id))
							{
								itemUnifierProxy = item5;
								break;
							}
						}
					}
				}
			}
			_emptyTip.SetActive(itemUnifierProxy == null);
			if (itemUnifierProxy == null)
			{
				return;
			}
			_selectBag.AddSelectedModelWithoutNotify(itemUnifierProxy);
			{
				foreach (ItemUnifierProxy selectedModel in _selectBag.SelectedModels)
				{
					BagCharacterItemUIComponent bagCharacterItemUIComponent = selectedModel.Context as BagCharacterItemUIComponent;
					if (bagCharacterItemUIComponent != null)
					{
						bagCharacterItemUIComponent.IsChosen = true;
					}
				}
				return;
			}
		}
		_selectBag.AddSelectedModelWithoutNotify(_selectBag.ItemSource.FirstOrDefault((ItemUnifierProxy x) => x.Id == characterId));
		foreach (ItemUnifierProxy selectedModel2 in _selectBag.SelectedModels)
		{
			BagCharacterItemUIComponent bagCharacterItemUIComponent2 = selectedModel2.Context as BagCharacterItemUIComponent;
			if (bagCharacterItemUIComponent2 != null)
			{
				bagCharacterItemUIComponent2.IsChosen = true;
			}
		}
	}

	public void OnChooseCharacter(Character character)
	{
		_model.singleSelectCharacter = character.Id;
		OnSelectUpdateCharacterInfo(character);
		UISceneRender.instance.ReplaceModel(_characterIndex, character.Id);
		UpdateBattleBtnForCharacter(character);
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		if (_playingVoiceUnitId == 0 || audioManager == null || !audioManager.IsPlaying(_playingVoiceUnitId))
		{
			_playingVoiceUnitId = Singleton<CharacterVoiceManager>.instance.PlayCharacterVoice(character.Id);
		}
	}

	private void OnSelectUpdateCharacterInfo(Character character)
	{
		if (character.Id != _selectCharacterInfo.CharacterId)
		{
			UpdateCharacterInfo(character);
		}
	}

	private void UpdateCharacterInfo(Character character)
	{
		_selectCharacterInfo.Active(active: true);
		int index = _model.CurSelectedTeamCharacters.IndexOf(character.Id);
		_selectCharacterInfo.Init(character, index, _parentView.Station, _parentView.CurSubControllerType);
	}

	private void UpdateBattleBtnForCharacter(Character character)
	{
		if (_ownCharacterId != 0)
		{
			if (character.Id == _ownCharacterId)
			{
				_operateBtn.gameObject.SetActive(value: true);
				_operateBtnStringEvent.StringReference.TableEntryReference = 474L;
				_operateBtn.SetBtnClick(() =>
				{
					Remove(character.Id, _characterIndex);
				}, "event:/UI/Interface/Team/Role_Remove");
			}
			else if (IsInTeam(character.Id))
			{
				_operateBtn.gameObject.SetActive(value: true);
				_operateBtnStringEvent.StringReference.TableEntryReference = 915L;
				_operateBtn.SetBtnClick(() =>
				{
					SwapTwoCharacterSeat(_ownCharacterId, character.Id);
				}, "event:/UI/Interface/Team/Role_Choist");
			}
			else if (IsDifferentArmor(character.Id))
			{
				_operateBtn.gameObject.SetActive(value: true);
				_operateBtnStringEvent.StringReference.TableEntryReference = 475L;
				_operateBtn.SetBtnClick(() =>
				{
					Replace(character.Id, _characterIndex);
				}, "event:/UI/Interface/Team/Role_Choist");
			}
			else
			{
				_operateBtn.gameObject.SetActive(value: false);
			}
		}
		else if (IsInTeam(character.Id))
		{
			_operateBtn.gameObject.SetActive(value: false);
		}
		else if (IsDifferentArmor(character.Id))
		{
			_operateBtn.gameObject.SetActive(value: true);
			_operateBtnStringEvent.StringReference.TableEntryReference = 774L;
			_operateBtn.SetBtnClick(() =>
			{
				OnAdd(character.Id, _characterIndex);
			}, "event:/UI/Interface/Team/Role_Choist");
		}
		else
		{
			_operateBtn.gameObject.SetActive(value: false);
		}
	}

	private void OnAdd(int id, int index)
	{
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Team_AddBtn);
		int[] characters = Model<TeamModel>.Interface.DeepCopyArray(_model.CurSelectedTeamCharacters);
		bool flag = characters.All((int x) => x == 0);
		characters[index] = id;
		if (_model.curSelectedIndex == _model.curBattleIndex && !_model.CanBattle(characters))
		{
			GameUtility.OpenToolTip(2303);
			return;
		}
		if (flag || index > 0)
		{
			if (index != 0 || characters[0] != 0)
			{
				UISceneRender.instance.ReleaseModel(index);
			}
			if (flag)
			{
				characters[0] = id;
				for (int num = 1; num < characters.Length; num++)
				{
					characters[num] = 0;
				}
				UISceneRender.instance.ResetModel(0, id);
			}
			else
			{
				characters[index] = id;
				_model.RearrangeCharactersArray(ref characters);
				for (int num2 = 0; num2 < characters.Length; num2++)
				{
					if (characters[num2] != 0)
					{
						UISceneRender.instance.ResetModel(num2, characters[num2]);
					}
				}
			}
		}
		else
		{
			characters[index] = id;
			_model.RearrangeCharactersArray(ref characters);
		}
		FireEvent(characters);
	}

	private void Remove(int id, int index)
	{
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Team_AddBtn);
		int[] characters = Model<TeamModel>.Interface.DeepCopyArray(_model.CurSelectedTeamCharacters);
		characters[index] = 0;
		if (_model.curSelectedIndex == _model.curBattleIndex && !_model.CanBattle(characters))
		{
			GameUtility.OpenToolTip(2302);
			return;
		}
		UISceneRender.instance.ReleaseModel(index);
		int[] array = new int[characters.Length];
		for (int i = 0; i < characters.Length; i++)
		{
			array[i] = characters[i];
		}
		bool flag = false;
		for (int j = index + 1; j < characters.Length; j++)
		{
			if (characters[j] != 0)
			{
				flag = true;
				break;
			}
		}
		if (flag)
		{
			for (int k = index + 1; k < characters.Length; k++)
			{
				if (characters[k] != 0)
				{
					UISceneRender.instance.ReleaseModel(k);
				}
			}
		}
		_model.RearrangeCharactersArray(ref characters);
		if (flag)
		{
			for (int l = 0; l < characters.Length; l++)
			{
				if (characters[l] != 0 && (l > index || array[l] != characters[l]))
				{
					UISceneRender.instance.ResetModel(l, characters[l]);
				}
			}
		}
		FireEvent(characters);
	}

	private void Replace(int id, int index)
	{
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Team_AddBtn);
		int[] characters = Model<TeamModel>.Interface.DeepCopyArray(_model.CurSelectedTeamCharacters);
		characters[index] = id;
		if (_model.curSelectedIndex == _model.curBattleIndex && !_model.CanBattle(characters))
		{
			GameUtility.OpenToolTip(2303);
			return;
		}
		_model.RearrangeCharactersArray(ref characters);
		FireEvent(characters);
	}

	private void SwapTwoCharacterSeat(int ownCharacterId, int selectCharacterId)
	{
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Team_AddBtn);
		int[] characters = Model<TeamModel>.Interface.DeepCopyArray(_model.CurSelectedTeamCharacters);
		int num = Array.IndexOf(characters, ownCharacterId);
		int num2 = Array.IndexOf(characters, selectCharacterId);
		if (num < 0 || num2 < 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"SwapTwoCharacterSeatError, ownCharacterIndex->{num}, selectCharacterIndex->{num2}");
			}
			return;
		}
		characters[num] = selectCharacterId;
		characters[num2] = ownCharacterId;
		if (_model.curSelectedIndex == _model.curBattleIndex && !_model.CanBattle(characters))
		{
			GameUtility.OpenToolTip(476);
			return;
		}
		_model.RearrangeCharactersArray(ref characters);
		UISceneRender.instance.ResetModel(num2, ownCharacterId);
		FireEvent(characters);
	}

	private void FireEvent(int[] characters)
	{
		if (_model.source == TeamProfileSource.Temple)
		{
			_model.templeCharactersId = Model<TeamModel>.Interface.DeepCopyArray(characters);
			for (int i = 0; i < characters.Length; i++)
			{
				_model.templeGroundProfiles.CharacterIds[i] = characters[i];
			}
		}
		else if (_model.source == TeamProfileSource.Raid)
		{
			for (int j = 0; j < characters.Length; j++)
			{
				_model.raidTeamProfiles[_model.curSelectedIndex].CharacterIds[j] = characters[j];
			}
		}
		else if (_model.source == TeamProfileSource.Traininground)
		{
			_model.trainingGroudCharactersId = Model<TeamModel>.Interface.DeepCopyArray(characters);
		}
		else
		{
			for (int k = 0; k < characters.Length; k++)
			{
				_model.uiTeamProfiles[_model.curSelectedIndex].CharacterIds[k] = characters[k];
			}
		}
		if (_model.source == TeamProfileSource.World)
		{
			_parentView.UpdateTeamName();
		}
		UISceneRender.instance.ResetCameraPosition(characters);
		Close();
	}

	private bool IsInTeam(int characterId)
	{
		return _model.CurSelectedTeamCharacters.Contains(characterId);
	}

	private bool IsSameArmor(int selectId, int ownId)
	{
		int characterArmorType = RuntimeConfigs.data.entityCharacterDatas[selectId].characterArmorType;
		int characterArmorType2 = RuntimeConfigs.data.entityCharacterDatas[ownId].characterArmorType;
		return characterArmorType == characterArmorType2;
	}

	private bool IsDifferentArmor(int selectId)
	{
		int[] array = Model<TeamModel>.Interface.DeepCopyArray(_model.CurSelectedTeamCharacters);
		int characterArmorType = RuntimeConfigs.data.entityCharacterDatas[selectId].characterArmorType;
		bool result = true;
		for (int i = 0; i < 3; i++)
		{
			if (i != _characterIndex && array[i] != 0 && RuntimeConfigs.data.entityCharacterDatas[array[i]].characterArmorType == characterArmorType)
			{
				result = false;
				break;
			}
		}
		return result;
	}

	public void ResetModel()
	{
		int id = _model.CurSelectedTeamCharacters[_characterIndex];
		UISceneRender.instance.ResetModel(_characterIndex, id);
	}
}
