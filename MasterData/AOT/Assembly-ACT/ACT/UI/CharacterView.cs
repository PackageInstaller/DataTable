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
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using Runtime.Utility;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterView : BaseUIView<CharacterViewInputController>
{
	private enum CvMenuItem
	{
		None,
		Overview,
		Equipment,
		Skill,
		Elite
	}

	[SerializeField]
	private ActButton BtnClose;

	[SerializeField]
	private CharactersOSA charactersOSA;

	public CommonScrollBagComponent charactersVerticalDetail;

	[SerializeField]
	private ActButton BtnCharacterBag;

	[SerializeField]
	private ActButton BtnCharacterBagClose;

	[SerializeField]
	private CvMenuItemGroup cvMenuItemGroup;

	[SerializeField]
	private GameObject returnButton;

	[SerializeField]
	private LocalizeStringEvent tabIntro;

	[SerializeField]
	private CvOverview overView;

	[SerializeField]
	private Button Btnobserve;

	[SerializeField]
	private Button BtnTraining;

	[SerializeField]
	private GameObject GoTagTrainFinsh;

	[SerializeField]
	private GameObject GoTagTrainLock;

	[SerializeField]
	private ActButton BtnLevelUp;

	[SerializeField]
	private CvEliteNew elite;

	[SerializeField]
	private CvSkill skill;

	[SerializeField]
	private CvEquipment equipment;

	[SerializeField]
	private GameObject rayCastBlocker;

	[SerializeField]
	private List<UIEffectRendering> UIEffect = new List<UIEffectRendering>();

	private CvMenuItem _selectCvMenuItem;

	[SerializeField]
	private CanvasGroup _CharacterViewCanvasGroup;

	private bool israyCastBlocker;

	[SerializeField]
	private CharacterLevelUpSubView characterLevelUpSubView;

	public DestinySubView destinySubView;

	[SerializeField]
	public EquipmentSubView equipmentSubView;

	[SerializeField]
	private CharacterBagShowSubView CharacterBagShowSubView;

	[SerializeField]
	private DisplayModelShowSubView _DisplayModelShowSubView;

	[SerializeField]
	private List<RedDotItem> _redDotItems;

	private const int EliteMenuRedDotIndex = 3;

	private ICharacterSubView _CurrentCharacterSubView;

	private ICharacterSubView _LastFirstCharacterSubView;

	private Character _selectCharacter;

	private List<ItemUnifierProxy> allCharacter = new List<ItemUnifierProxy>();

	private ICharacterSubView[] _activeSubViews;

	private CharacterViewData m_Data;

	private int _ToggleIndex;

	public bool IsRayCastBlocker
	{
		get
		{
			return israyCastBlocker;
		}
		set
		{
			if (israyCastBlocker != value)
			{
				rayCastBlocker.SetActive(value);
				israyCastBlocker = value;
			}
		}
	}

	public CvMenuItemGroup CvMenuItemGroup => cvMenuItemGroup;

	public ICharacterSubView currentCharacterSubView => _CurrentCharacterSubView;

	public Character CurrentSelectCharacter => _selectCharacter;

	private int CurrentCharacterIndex { get; set; }

	private bool CanShowCharacterSubView
	{
		get
		{
			if (UIController != null && UIController.ExpectedState == UIExpectedState.Open)
			{
				UIState state = UIController.State;
				return state == UIState.Opening || state == UIState.Opened || state == UIState.PoppingStack;
			}
			return false;
		}
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_Data = uiViewData as CharacterViewData;
		await Singleton<UISceneManager>.instance.LoadScene<CharacterViewScene>(GameLoader.meta.characterViewV3SceneReferenceAssetID.GUID);
		BtnLevelUp.SetBtnClick(OpenLevelUpPanel, "event:/UI/Interface/Role/Upgrade_Entrance");
		BtnClose.SetBtnClick(Close, "event:/UI/Common/Return_Click");
		BtnCharacterBag.SetBtnClick(OpenBagShowView);
		BtnCharacterBagClose.SetBtnClick(CloseBagShowView);
		Btnobserve.SetBtnClick(OpenSkinView);
		BtnTraining.SetBtnClick(EnterTraining);
		charactersVerticalDetail.gameObject.SetActive(value: false);
		SetAallViewInitActive(active: false);
	}

	private void EnterTraining()
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Training) || _selectCharacter == null)
		{
			return;
		}
		if (Model<CharacterTutorialModel>.Interface.GetCharacterTutorialRaidInfoByCharacterId(_selectCharacter.Id) == null)
		{
			Debug.LogError($"[CharacterView] Character {_selectCharacter.Id} has no tutorial raid configuration.");
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			OnConfirm = () =>
			{
				Model<CharacterTutorialModel>.Interface.EnterCharacterTutorialRaid(_selectCharacter.Id);
				Close();
			},
			commonId = 2813,
			texts = new string[1] { LocalizationUtility.GetLocalizeString("shortcommon", _selectCharacter.GetLocalizationName()) }
		});
	}

	private void RefreshTrainingButtonState()
	{
		GoTagTrainLock.SetActive(!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Training));
		GoTagTrainFinsh.SetActive(Model<CharacterTutorialModel>.Interface.IsCharacterTutorialCompleted(_selectCharacter.Id));
		BtnTraining.gameObject.SetActive(Model<CharacterTutorialModel>.Interface.GetCharacterTutorialRaidInfoByCharacterId(_selectCharacter.Id) != null && !IsTrialCharacter(_selectCharacter));
	}

	private void OnTrainingSystemOpen(BaseEventContent eventContent)
	{
		if (eventContent is SystemOpenEvt { systemId: 1024 })
		{
			RefreshTrainingButtonState();
		}
	}

	private void SetAallViewInitActive(bool active)
	{
		returnButton.gameObject.SetActive(value: true);
		overView.gameObject.SetActive(active);
		elite.gameObject.SetActive(active);
		equipment.gameObject.SetActive(active);
		skill.gameObject.SetActive(active);
	}

	public void OpenLevelUpPanelByController()
	{
		BtnLevelUp.ControllerClick();
	}

	public void OpenBagShowViewByController()
	{
		BtnCharacterBag.ControllerClick();
	}

	public void OpenSkinByController()
	{
		Btnobserve.ControllerClick();
	}

	public void EnterTrainTipsByController()
	{
		if (Model<CharacterTutorialModel>.Interface.GetCharacterTutorialRaidInfoByCharacterId(_selectCharacter.Id) != null)
		{
			BtnTraining.ControllerClick();
		}
	}

	protected override void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_OverViewClickEquip, OnClickEquip);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_CharacterJumpToEquip, OnCharacterJumpToEquip);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SetCharacterViewCanvasGroup, OnSetCharacterViewCanvasGroup);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnTrainingSystemOpen);
		base.AddEventListener();
	}

	protected override void Init()
	{
		base.Init();
		Singleton<RedDotManager>.instance.RefreshUnLockSystemRedDot(1017);
		_selectCvMenuItem = CvMenuItem.Overview;
		_activeSubViews = new ICharacterSubView[5];
		InitToggleGroup();
		allCharacter = new List<ItemUnifierProxy>();
		foreach (Character curAllCharacter in GetCurAllCharacters())
		{
			allCharacter.Add(ItemUnifierProxy.ItemUnifierPool.Get(curAllCharacter));
		}
		if (allCharacter.Count == 0)
		{
			Debug.LogError("[CharacterView] No valid characters were supplied for display.", this);
			Close();
			return;
		}
		_selectCharacter = ResolveInitialSelectedCharacter() ?? allCharacter[0].As<Character>();
		RefreshEliteMenuRedDot();
		CharacterViewData data = m_Data;
		if (data == null || !data.HasDisplayCharacters)
		{
			allCharacter.Sort((ItemUnifierProxy x, ItemUnifierProxy y) => SortTeam(x.As<Character>(), y.As<Character>()));
		}
		int characterIndex = GetCharacterIndex(_selectCharacter);
		if (characterIndex >= 0)
		{
			CurrentCharacterIndex = characterIndex;
		}
		if (charactersOSA.isActiveAndEnabled)
		{
			charactersOSA.Reload(Station, allCharacter.Select((ItemUnifierProxy x) => x.As<Character>()).ToList(), _selectCharacter, SelectCharacter, (m_Data != null) ? m_Data.OpenSceneStatus : SceneStatus.Main);
		}
		int index = 0;
		if (m_Data != null && m_Data.PageIndex != -1)
		{
			index = m_Data.PageIndex;
		}
		cvMenuItemGroup.Enter(index);
		try
		{
			CharacterViewScene.Default.ShowCharacterModel(_selectCharacter);
			Singleton<CharacterVoiceManager>.instance.PlayCharacterVoice(_selectCharacter.Id);
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		InitCharacterBag(IsTrialCharacter(_selectCharacter));
		RefreshTrainingButtonState();
	}

	protected override void ReInit()
	{
		base.ReInit();
		int index = 0;
		if (m_Data != null && m_Data.PageIndex != -1)
		{
			index = m_Data.PageIndex;
		}
		cvMenuItemGroup.Enter(index);
		RefreshEliteMenuRedDot();
	}

	private List<Character> GetCurAllCharacters()
	{
		CharacterViewData data = m_Data;
		if (data != null && data.HasDisplayCharacters)
		{
			return m_Data.DisplayCharacters;
		}
		if (Model<TrialCharacterModel>.HasInstance() && Model<TrialCharacterModel>.Interface.IsTrialMode)
		{
			List<Character> curAllCharacters = CharacterDataHelper.GetCurAllCharacters();
			curAllCharacters.AddRange((List<Character>)Model<TrialCharacterModel>.Interface.TrialCharacters);
			return curAllCharacters;
		}
		if (m_Data != null && (m_Data.OpenSceneStatus == SceneStatus.Abyss || m_Data.OpenSceneStatus == SceneStatus.Raid || m_Data.OpenSceneStatus == SceneStatus.Temple))
		{
			return CharacterDataHelper.GetAllCharactersByRepositoyIndex(0);
		}
		return CharacterDataHelper.GetCurAllCharacters();
	}

	private void BtnToggleClick(int index)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Role/Right_Click", new AudioPlayOptions
		{
			attachTarget = transform
		});
		string nodeFullPath = "";
		GuideConsts.GuideType guideType = GuideConsts.GuideType.None;
		switch (index)
		{
		case 0:
			OpenOverview();
			nodeFullPath = RedDotPathDefine.CharacterOver;
			guideType = GuideConsts.GuideType.CharacterOver;
			break;
		case 1:
			OpenSkill();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Skill/Open");
			nodeFullPath = RedDotPathDefine.CharacterSkill;
			guideType = GuideConsts.GuideType.CharacterSkill;
			break;
		case 2:
			OpenEquipment();
			nodeFullPath = RedDotPathDefine.CharacterEquipment;
			guideType = GuideConsts.GuideType.CharacterEquip;
			break;
		case 3:
			nodeFullPath = RedDotPathDefine.CharacterElite;
			guideType = GuideConsts.GuideType.CharacterElite;
			OpenElite();
			break;
		}
		GameUtility.SendFinshStepGuideEvent(guideType);
		Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active: false);
		_ToggleIndex = index;
	}

	private void InitToggleGroup()
	{
		for (int i = 0; i < cvMenuItemGroup.toggleGroup.ToggleCount; i++)
		{
			RedDotItem menuRedDotItem = GetMenuRedDotItem(i);
			string text = string.Empty;
			switch (i)
			{
			case 0:
				text = RedDotPathDefine.CharacterOver;
				break;
			case 1:
				text = RedDotPathDefine.CharacterEquipment;
				break;
			case 2:
				text = RedDotPathDefine.CharacterSkill;
				break;
			case 3:
				text = RedDotPathDefine.CharacterElite;
				break;
			}
			if (!string.IsNullOrEmpty(text) && i != 3 && menuRedDotItem != null)
			{
				menuRedDotItem.fullPath = text.Split("|").ToList();
				menuRedDotItem.BindTrieNode();
				menuRedDotItem.UpdateDisplay();
			}
			cvMenuItemGroup.toggleGroup.SetToggleOnCall(i, (int index) =>
			{
				BtnToggleClick(index);
			});
		}
	}

	private RedDotItem GetMenuRedDotItem(int index)
	{
		if (index < 0)
		{
			return null;
		}
		ActToggle actToggle = cvMenuItemGroup?.toggleGroup?.GetToggleByIndex(index);
		if (_redDotItems != null && index < _redDotItems.Count)
		{
			RedDotItem redDotItem = _redDotItems[index];
			if (redDotItem != null && (actToggle == null || redDotItem.transform.IsChildOf(actToggle.transform)))
			{
				return redDotItem;
			}
		}
		RedDotItem redDotItem2 = ((actToggle != null) ? actToggle.GetComponentInChildren<RedDotItem>(includeInactive: true) : null);
		if (redDotItem2 == null)
		{
			return null;
		}
		if (_redDotItems == null)
		{
			_redDotItems = new List<RedDotItem>();
		}
		while (_redDotItems.Count <= index)
		{
			_redDotItems.Add(null);
		}
		_redDotItems[index] = redDotItem2;
		return redDotItem2;
	}

	private void RefreshEliteMenuRedDot()
	{
		RedDotItem menuRedDotItem = GetMenuRedDotItem(3);
		if (menuRedDotItem == null)
		{
			return;
		}
		if (_selectCharacter == null || IsTrialCharacter(_selectCharacter))
		{
			menuRedDotItem.gameObject.SetActive(value: false);
			return;
		}
		string text = string.Format(RedDotPathDefine.Character + "|{0}|EliteEntrance", _selectCharacter.Id);
		if (!Singleton<RedDotManager>.instance.IsPathRegistered(text) && Singleton<RedDotManager>.instance.GetNode(text) == null)
		{
			Singleton<RedDotManager>.instance.DynamicRegisterInitTrieNode(text);
		}
		menuRedDotItem.InitRedDot(text);
	}

	private static bool IsTrialCharacter(Character character)
	{
		return character?.IsTrailCharacter ?? false;
	}

	private int GetCharacterIndex(Character character)
	{
		return allCharacter.FindIndex((ItemUnifierProxy x) => x.As<Character>() == character);
	}

	private Character FindDisplayCharacterByUID(CharacterUID characterUID)
	{
		return allCharacter.Select((ItemUnifierProxy x) => x.As<Character>()).FirstOrDefault((Character character) => character != null && character.UID == characterUID);
	}

	private Character FindDisplayCharacterById(int characterId)
	{
		return allCharacter.FirstOrDefault((ItemUnifierProxy x) => x.Id == characterId)?.As<Character>();
	}

	private Character ResolveInitialSelectedCharacter()
	{
		CharacterViewData data = m_Data;
		if (data != null && data.HasDisplayCharacters && !m_Data.defaultCharacterUID.HasValue && m_Data.defaultCharacterId == -1)
		{
			m_Data.defaultCharacterUID = allCharacter[0].As<Character>().UID;
		}
		CharacterUID? characterUID = m_Data?.defaultCharacterUID;
		if (characterUID.HasValue)
		{
			CharacterUID valueOrDefault = characterUID.GetValueOrDefault();
			Character character = FindDisplayCharacterByUID(valueOrDefault);
			if (character != null)
			{
				return character;
			}
		}
		CharacterViewData data2 = m_Data;
		if (data2 != null && data2.defaultCharacterId > 0)
		{
			Character character2 = FindDisplayCharacterById(m_Data.defaultCharacterId);
			if (character2 != null)
			{
				return character2;
			}
		}
		ICharacterSource characterSource = MonoECS.instance.mainEntity.GetCompCharacter().characterSource;
		Character characterByCharacterSource = CharacterDataHelper.GetCharacterByCharacterSource(characterSource);
		Character character3;
		if (GetCharacterIndex(characterByCharacterSource) < 0)
		{
			character3 = FindDisplayCharacterByUID(characterSource.GetUID());
			if (character3 == null)
			{
				return FindDisplayCharacterById(characterSource.Id());
			}
		}
		else
		{
			character3 = characterByCharacterSource;
		}
		return character3;
	}

	private void UnInitToggleGroup()
	{
		for (int i = 0; i < cvMenuItemGroup.toggleGroup.ToggleCount; i++)
		{
			cvMenuItemGroup.toggleGroup.SetToggleRemoveOnCall(i);
		}
	}

	private int SortTeam(Character x, Character y)
	{
		if (x.IsTrailCharacter != y.IsTrailCharacter)
		{
			if (!x.IsTrailCharacter)
			{
				return 1;
			}
			return -1;
		}
		Func<Character, Character, int>[] array = null;
		array = ((m_Data == null || m_Data.OpenSceneStatus != SceneStatus.Abyss) ? SortUtility.CompareBaseCharacter[0] : SortUtility.CompareBaseCharacter[8]);
		for (int i = 0; i < array.Length; i++)
		{
			int num = array[i](x, y);
			if (num != 0)
			{
				return num * -1;
			}
		}
		return 0;
	}

	private void InitCharacterBag(bool isTrialCharacter)
	{
		BtnCharacterBag.gameObject.SetActive(!isTrialCharacter);
		if (isTrialCharacter)
		{
			return;
		}
		int num = 0;
		foreach (int characterId in G.localPlayer.teamInfo.PresetTeams[G.localPlayer.teamInfo.MainTeamIdx].CharacterIds)
		{
			if (characterId != 0)
			{
				num++;
			}
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	public override async void Close()
	{
		if (IsRayCastBlocker || _CurrentCharacterSubView == null)
		{
			return;
		}
		if (_CurrentCharacterSubView.Depth == 1)
		{
			if (_CurrentCharacterSubView != null)
			{
				CloseSubView(_CurrentCharacterSubView);
			}
			base.Close();
			_CurrentCharacterSubView = null;
			_LastFirstCharacterSubView = null;
		}
		else
		{
			CloseCurrentCharacterSubView();
		}
	}

	public void CloseCurrentCharacterSubView()
	{
		tabIntro.StringReference.TableEntryReference = CoreUtils.GetData(1017, RuntimeConfigs.data.systemOpens).localNameId;
		ICharacterSubView characterSubView = _CurrentCharacterSubView;
		if (!(characterSubView is DestinySubView))
		{
			if (!(characterSubView is CharacterLevelUpSubView))
			{
				if (!(characterSubView is EquipmentSubView))
				{
					if (!(characterSubView is DisplayModelShowSubView))
					{
						if (!(characterSubView is CharacterBagShowSubView))
						{
							if (!(characterSubView is CvSkill))
							{
								if (characterSubView is CvEliteNew)
								{
									CloseElite();
								}
							}
							else
							{
								CloseSkill();
							}
						}
						else
						{
							CloseBagShowView();
						}
					}
					else
					{
						Singleton<NewUIManager>.instance.CharacterFullScreenAni.Open();
						CloseDisPlayModel();
					}
				}
				else
				{
					CloseEquipSubView();
				}
			}
			else
			{
				CloseLevelUpPanel();
			}
		}
		else
		{
			CloseDestiny();
		}
	}

	public void CloseSubView()
	{
		CloseCurrentCharacterSubView();
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_OverViewClickEquip, OnClickEquip);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_CharacterJumpToEquip, OnCharacterJumpToEquip);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SetCharacterViewCanvasGroup, OnSetCharacterViewCanvasGroup);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnTrainingSystemOpen);
		base.RemoveEventListener();
	}

	protected override async void UnInit()
	{
		SetSubViewBlur(enabled: false);
		base.UnInit();
		if (_CurrentCharacterSubView != null)
		{
			CloseCurrentCharacterSubView();
		}
		_CurrentCharacterSubView = null;
		ItemUnifierProxy.ItemUnifierPool.Release(allCharacter);
		charactersOSA.Unload();
	}

	protected override void OnPushStack()
	{
		base.OnPushStack();
		SetSubViewBlur(enabled: false);
		_CurrentCharacterSubView?.OnPushStack();
	}

	protected override void CloseComplete()
	{
		Singleton<UISceneManager>.instance.ReleaseScene<CharacterViewScene>();
	}

	public void CycleToggle(bool forward)
	{
		if (IsRayCastBlocker)
		{
			return;
		}
		ICharacterSubView characterSubView = _CurrentCharacterSubView;
		if (characterSubView != null && characterSubView.Depth == 2)
		{
			return;
		}
		int toggleCount = cvMenuItemGroup.toggleGroup.ToggleCount;
		if (toggleCount <= 1)
		{
			return;
		}
		int num = _ToggleIndex;
		for (int i = 0; i < toggleCount - 1; i++)
		{
			num = (forward ? ((num + 1) % toggleCount) : ((num - 1 + toggleCount) % toggleCount));
			ActToggle toggleByIndex = cvMenuItemGroup.toggleGroup.GetToggleByIndex(num);
			if (toggleByIndex != null && toggleByIndex.IsActive() && toggleByIndex.IsInteractable() && !toggleByIndex.isLock)
			{
				break;
			}
			if (num == _ToggleIndex)
			{
				return;
			}
		}
		if (num != _ToggleIndex)
		{
			cvMenuItemGroup.toggleGroup.SetToggleOn(num);
		}
	}

	public void CycleCharacter(bool forward)
	{
		if (IsRayCastBlocker || allCharacter.Count <= 1)
		{
			return;
		}
		ICharacterSubView characterSubView = _CurrentCharacterSubView;
		if (characterSubView != null && characterSubView.Depth == 2)
		{
			ICharacterSubView characterSubView2 = _CurrentCharacterSubView;
			if (characterSubView2 != null && characterSubView2.FreezeCharacterOSA)
			{
				return;
			}
		}
		int characterIndex = GetCharacterIndex(_selectCharacter);
		int newIndex = (forward ? ((characterIndex + 1) % allCharacter.Count) : ((characterIndex - 1 + allCharacter.Count) % allCharacter.Count));
		CycleToCharacter(newIndex);
	}

	private void CycleToCharacter(int newIndex)
	{
		CurrentCharacterIndex = newIndex;
		charactersOSA.ChangeSelectCharacter(newIndex);
		SelectCharacter(allCharacter[newIndex].As<Character>());
	}

	private void SelectCharacter(ICharacterSource characterSource)
	{
		Character characterByCharacterSource = CharacterDataHelper.GetCharacterByCharacterSource(characterSource);
		if (characterByCharacterSource == null)
		{
			return;
		}
		int characterIndex = GetCharacterIndex(characterByCharacterSource);
		if (characterIndex >= 0)
		{
			CurrentCharacterIndex = characterIndex;
		}
		if (_selectCharacter == characterByCharacterSource)
		{
			return;
		}
		_selectCharacter = characterByCharacterSource;
		RefreshEliteMenuRedDot();
		try
		{
			CharacterViewScene.Default.ShowCharacterModel(_selectCharacter);
			Singleton<CharacterVoiceManager>.instance.PlayCharacterVoice(_selectCharacter.Id);
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		if (!IsTrialCharacter(_selectCharacter))
		{
			OnIsNewRedClick(_selectCharacter.Id);
		}
		_CurrentCharacterSubView?.OnSelectCharacter(_selectCharacter);
		if (_CurrentCharacterSubView.SceneType == CharacterViewScene.CvSceneType.Over)
		{
			SetBtnLevelUpState(IsTrialCharacter(_selectCharacter));
		}
		RefreshTrainingButtonState();
		BtnTraining.gameObject.SetActive(Model<CharacterTutorialModel>.Interface.GetCharacterTutorialRaidInfoByCharacterId(_selectCharacter.Id) != null && !IsTrialCharacter(_selectCharacter));
	}

	public void OnIsNewRedClick(int _characterId)
	{
		if (G.localPlayer.redPoints.Characters.TryGetValue(_characterId, out var value) && value)
		{
			RedPoints redPoints = new RedPoints();
			redPoints.Characters.Add(_characterId, value: false);
			G.service.RefreshRedDot(redPoints, (bool flag) =>
			{
				G.localPlayer.redPoints.Characters[_characterId] = false;
				string nodeFullPath = string.Format(RedDotPathDefine.CharacterNew, _characterId);
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active: false);
			});
		}
	}

	private void SetBtnLevelUpState(bool isTrialCharacter = false)
	{
		Btnobserve.gameObject.SetActive(!isTrialCharacter);
		if (Singleton<SystemUnlockManager>.instance.IsUnlock(4005) && !isTrialCharacter)
		{
			BtnLevelUp.gameObject.SetActive(value: true);
		}
		else
		{
			BtnLevelUp.gameObject.SetActive(value: false);
		}
	}

	private void SetSubViewBlur(bool enabled)
	{
		if (enabled && CanShowCharacterSubView)
		{
			Singleton<NewUIManager>.instance.PushUIEffectRenderingList(UIController, UIEffect);
		}
		else
		{
			Singleton<NewUIManager>.instance.PopUIEffectRenderingList(UIController, UIEffect);
		}
	}

	private void OpenSubView(ICharacterSubView subView)
	{
		if (!CanShowCharacterSubView)
		{
			return;
		}
		if (_CurrentCharacterSubView != null)
		{
			if (_CurrentCharacterSubView == subView)
			{
				return;
			}
			CloseSubView(_CurrentCharacterSubView);
		}
		SetSubViewBlur(subView.NeedBlur);
		BtnCharacterBag.gameObject.SetActive(subView.Depth == 1 && !IsTrialCharacter(_selectCharacter));
		if (subView.Context == null)
		{
			subView.Context = this;
		}
		subView.FocusIn();
		subView.Show(_selectCharacter.Id, Station, _selectCharacter);
		try
		{
			CharacterViewScene.Default.ToType(subView.SceneType);
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		_CurrentCharacterSubView = subView;
		if (subView.Depth == 2)
		{
			if (subView.FreezeCharacterOSA)
			{
				charactersOSA.Freeze();
			}
			cvMenuItemGroup.Freeze();
		}
		if (subView.SceneType == CharacterViewScene.CvSceneType.Over)
		{
			SetBtnLevelUpState(IsTrialCharacter(_selectCharacter));
		}
	}

	private void CloseSubView(ICharacterSubView subView, bool isAllClose = false)
	{
		SetSubViewBlur(enabled: false);
		if (subView.Depth == 1)
		{
			_LastFirstCharacterSubView = subView;
		}
		try
		{
			if (!isAllClose)
			{
				subView.FocusOut();
				subView.Hide();
			}
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		_CurrentCharacterSubView = null;
		if (_LastFirstCharacterSubView != null)
		{
			_LastFirstCharacterSubView.lastSubView = subView;
		}
		if (!CanShowCharacterSubView)
		{
			return;
		}
		if (subView.Depth > 1)
		{
			ICharacterSubView lastFirstCharacterSubView = _LastFirstCharacterSubView;
			if (lastFirstCharacterSubView != null)
			{
				OpenSubView(lastFirstCharacterSubView);
				try
				{
					CharacterViewScene.Default.ToType(lastFirstCharacterSubView.SceneType);
				}
				catch (Exception exception2)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogException(exception2);
					}
				}
			}
		}
		if (subView.Depth == 2)
		{
			if (subView.FreezeCharacterOSA)
			{
				charactersOSA.UnFreeze();
			}
			cvMenuItemGroup.UnFreeze();
			CycleToCharacter(CurrentCharacterIndex);
		}
	}

	public void OpenOverview()
	{
		tabIntro.StringReference.TableEntryReference = CoreUtils.GetData(1017, RuntimeConfigs.data.systemOpens).localNameId;
		EnsureCvOverviewSubControllerBound();
		OpenSubView(overView);
		charactersOSA.Refresh();
	}

	public void OpenElite()
	{
		tabIntro.StringReference.TableEntryReference = CoreUtils.GetData(1038, RuntimeConfigs.data.systemOpens).localNameId;
		EnsureEliteSubControllerBound();
		OpenSubView(elite);
	}

	public void CloseElite()
	{
		CloseSubView(elite);
	}

	public void OpenLevelUpPanel()
	{
		tabIntro.StringReference.TableEntryReference = CoreUtils.GetData(1001, RuntimeConfigs.data.systemOpens).localNameId;
		EnsureCvCharacterLvUpSubControllerBound();
		OpenSubView(characterLevelUpSubView);
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.CharacterLevelUp);
	}

	public void CloseLevelUpPanel()
	{
		CloseSubView(characterLevelUpSubView);
	}

	public void OpenDestiny()
	{
		tabIntro.StringReference.TableEntryReference = CoreUtils.GetData(1010, RuntimeConfigs.data.systemOpens).localNameId;
		OpenSubView(destinySubView);
	}

	public void CloseDestiny()
	{
		CloseSubView(destinySubView);
	}

	public void OpenSkill()
	{
		tabIntro.StringReference.TableEntryReference = CoreUtils.GetData(4003, RuntimeConfigs.data.systemOpens).localNameId;
		EnsureCvSkillSubControllerBound();
		OpenSubView(skill);
	}

	public void CloseSkill()
	{
		CloseSubView(skill);
	}

	public void OpenEquipment()
	{
		tabIntro.StringReference.TableEntryReference = CoreUtils.GetData(1009, RuntimeConfigs.data.systemOpens).localNameId;
		EnsureCvEquipmentSubControllerBound();
		OpenSubView(equipment);
	}

	public void CloseEquipment()
	{
		CloseSubView(equipment);
	}

	public void OpenEquipSubView()
	{
		tabIntro.StringReference.TableEntryReference = CoreUtils.GetData(1009, RuntimeConfigs.data.systemOpens).localNameId;
		returnButton.SetActive(value: false);
		EnsureEquipmentSubControllerBound();
		OpenSubView(equipmentSubView);
	}

	public void CloseEquipSubView()
	{
		CloseSubView(equipmentSubView);
		returnButton.SetActive(value: true);
	}

	private void EnsureEquipmentSubControllerBound()
	{
		if (!(equipmentSubView == null) && UIController != null)
		{
			equipmentSubView.Init(this);
		}
	}

	private void EnsureCvEquipmentSubControllerBound()
	{
		if (!(equipment == null) && UIController != null)
		{
			equipment.Init(this);
		}
	}

	private void EnsureCvOverviewSubControllerBound()
	{
		if (!(overView == null) && UIController != null)
		{
			overView.Init(this);
		}
	}

	private void EnsureCvSkillSubControllerBound()
	{
		if (!(skill == null) && UIController != null)
		{
			skill.Init(this);
		}
	}

	private void EnsureCvCharacterLvUpSubControllerBound()
	{
		if (!(characterLevelUpSubView == null) && UIController != null)
		{
			characterLevelUpSubView.Init(this);
		}
	}

	private void EnsureEliteSubControllerBound()
	{
		if (!(elite == null) && UIController != null)
		{
			elite.Init(this);
		}
	}

	public void OpenBagShowView()
	{
		int index = GetCharacterIndex(_selectCharacter);
		if (index < 0)
		{
			return;
		}
		charactersVerticalDetail.ClearBag();
		charactersVerticalDetail.Station = Station;
		charactersVerticalDetail.gameObject.SetActive(value: true);
		charactersVerticalDetail.SelectedModels.Clear();
		charactersVerticalDetail.ItemSource = allCharacter;
		charactersVerticalDetail.ItemShowType = ItemUIComponentBase.InitType.CharacterViewBagCharacter;
		charactersVerticalDetail.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		charactersVerticalDetail.OnItemSelect = null;
		CommonScrollBagComponent commonScrollBagComponent = charactersVerticalDetail;
		commonScrollBagComponent.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent.OnItemSelect, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			if (l.gameObject.activeInHierarchy)
			{
				SelectCharacter(l.ItemUnifier.Source as Character);
			}
		}));
		charactersVerticalDetail.SelectedModels.Add(allCharacter[index]);
		charactersVerticalDetail.OnUpdateEnd = null;
		charactersVerticalDetail.OnItemShow = null;
		CommonScrollBagComponent commonScrollBagComponent2 = charactersVerticalDetail;
		commonScrollBagComponent2.OnUpdateEnd = (Action)Delegate.Combine(commonScrollBagComponent2.OnUpdateEnd, (Action)(() =>
		{
			charactersVerticalDetail.ScrollToIndex(index);
			charactersVerticalDetail.OnUpdateEnd = null;
		}));
		CommonScrollBagComponent commonScrollBagComponent3 = charactersVerticalDetail;
		commonScrollBagComponent3.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent3.OnItemShow, (Action<ItemUIComponentBase>)((ItemUIComponentBase x) =>
		{
			bool flag = x.ItemUnifier.Source is Character character && !IsTrialCharacter(character) && Singleton<RedDotManager>.instance.GeCharacterTabRedpointState(character.Id);
			string redPointPath = string.Format(RedDotPathDefine.Character + "|{0}", x.ItemUnifier.Id);
			x.RedDotType = (flag ? RedDotType.New : RedDotType.Dot);
			x.RedPointPath = redPointPath;
			if (flag)
			{
				Singleton<RedDotManager>.instance.OnRedDotStateChanged += instanceOnOnRedDotStateChanged(x);
			}
		}));
		CommonScrollBagComponent commonScrollBagComponent4 = charactersVerticalDetail;
		commonScrollBagComponent4.OnItemUnLoad = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent4.OnItemUnLoad, (Action<ItemUIComponentBase>)((ItemUIComponentBase x) =>
		{
			Singleton<RedDotManager>.instance.OnRedDotStateChanged -= instanceOnOnRedDotStateChanged(x);
		}));
		OpenSubView(CharacterBagShowSubView);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Role/List", new AudioPlayOptions
		{
			attachTarget = transform
		});
		charactersVerticalDetail.GetComponent<BetterAnimation>().GetSequence("ShowIn").Play();
		returnButton.SetActive(value: false);
		static Action<string, bool> instanceOnOnRedDotStateChanged(ItemUIComponentBase x)
		{
			return (string a, bool b) =>
			{
				if (a.StartsWith(x.RedPointPath))
				{
					x.RedDotType = RedDotType.Dot;
				}
			};
		}
	}

	public void OpenDisPlayModel()
	{
		Singleton<NewUIManager>.instance.CharacterFullScreenAni.Open();
		OpenSubView(_DisplayModelShowSubView);
	}

	public void OpenSkinView()
	{
		if (!IsTrialCharacter(_selectCharacter))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERSKIN, new CharacterSkinViewData
			{
				RoleId = _selectCharacter.Id,
				FormType = OpenForm.Other
			});
		}
	}

	public void CloseDisPlayModel()
	{
		CloseSubView(_DisplayModelShowSubView);
	}

	public void CloseBagShowView()
	{
		charactersVerticalDetail.gameObject.SetActive(value: false);
		charactersVerticalDetail.GetComponent<BetterAnimation>().GetSequence("Hide").Play();
		CloseSubView(CharacterBagShowSubView);
		int characterIndex = GetCharacterIndex(_selectCharacter);
		if (characterIndex >= 0)
		{
			charactersOSA.ChangeSelectCharacter(characterIndex);
		}
		returnButton.SetActive(value: true);
	}

	public void OpenEquipSubViewExternal(EquipmentSubView.EquipData data)
	{
		equipmentSubView.Context = data;
		OpenEquipSubView();
	}

	private void OnClickEquip(BaseEventContent obj)
	{
		if (obj is OverViewClickEquipEvent)
		{
			if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Equip))
			{
				cvMenuItemGroup.Enter(2);
			}
			else
			{
				GameUtility.OpenToolTip(LocalizationCommonData.CommonString.SystemLock);
			}
		}
	}

	private void OnCharacterJumpToEquip(BaseEventContent obj)
	{
		if (obj is CharacterJumpToEquipEvent characterJumpToEquipEvent)
		{
			IsRayCastBlocker = characterJumpToEquipEvent.isinjump;
		}
	}

	public bool GetSecondViewAniState(CharacterViewScene.CvSceneType type)
	{
		bool flag = false;
		return type switch
		{
			CharacterViewScene.CvSceneType.Over => overView.AfterAnimation, 
			CharacterViewScene.CvSceneType.Elite => elite.AfterAnimation, 
			CharacterViewScene.CvSceneType.Skill => skill.AfterAnimation, 
			CharacterViewScene.CvSceneType.Level => characterLevelUpSubView.AfterAnimation, 
			CharacterViewScene.CvSceneType.Equipment => equipment.AfterAnimation, 
			CharacterViewScene.CvSceneType.EquipmentSubview => equipmentSubView.AfterAnimation, 
			_ => true, 
		};
	}

	public Transform GetCharacterSubView(CharacterViewScene.CvSceneType type)
	{
		Transform result = null;
		switch (type)
		{
		case CharacterViewScene.CvSceneType.None:
			result = overView.transform.parent;
			break;
		case CharacterViewScene.CvSceneType.Over:
			result = overView.transform;
			break;
		case CharacterViewScene.CvSceneType.Elite:
			result = elite.transform;
			break;
		case CharacterViewScene.CvSceneType.Skill:
			result = skill.transform;
			break;
		case CharacterViewScene.CvSceneType.Level:
			result = characterLevelUpSubView.transform;
			break;
		case CharacterViewScene.CvSceneType.Equipment:
			result = equipment.transform;
			break;
		case CharacterViewScene.CvSceneType.EquipmentSubview:
			result = equipmentSubView.transform;
			break;
		}
		return result;
	}

	public void RefreshEliteMainGamepadTips(bool eliteLevelUpNewPopupJustClosed = false)
	{
		elite?.RefreshMainEliteGamepadTips(eliteLevelUpNewPopupJustClosed);
	}

	protected override void OnMoveToShow()
	{
		Singleton<UISceneManager>.instance.OpenScene<CharacterViewScene>();
	}

	protected override void OnPopStack()
	{
		Singleton<UISceneManager>.instance.GetScene<CharacterViewScene>().ResetCharcterAni();
		charactersOSA.RefreshIcon();
		SetSubViewBlur(_CurrentCharacterSubView?.NeedBlur ?? false);
		_CurrentCharacterSubView?.OnPopStack();
	}

	protected override void OnMoveToHide()
	{
		SetSubViewBlur(enabled: false);
		Singleton<UISceneManager>.instance.CloseScene<CharacterViewScene>();
	}

	private void OnSetCharacterViewCanvasGroup(BaseEventContent obj)
	{
		if (obj is CharacterViewCanvasGroupRefreshEvt characterViewCanvasGroupRefreshEvt)
		{
			_CharacterViewCanvasGroup.alpha = characterViewCanvasGroupRefreshEvt.alphaValue;
		}
	}

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		UnInitToggleGroup();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (_CurrentCharacterSubView != null && currentCharacterSubView.SceneType == CharacterViewScene.CvSceneType.Destiny)
		{
			destinySubView?.OnDeviceChange(type);
		}
	}
}
