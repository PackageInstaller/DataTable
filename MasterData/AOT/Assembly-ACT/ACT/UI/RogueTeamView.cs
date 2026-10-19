using System;
using System.Collections.Generic;
using ACT.CharacterProperty;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.RichText;
using ACT.Sound;
using ACT.Sound.Management;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Model;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class RogueTeamView : BaseUIView<RogueTeamViewInputController>
{
	private RogueTeamViewData m_data;

	public CommonScrollBagComponent charactersVerticalDetail;

	public LocalizeStringEvent TextName;

	public LocalizeStringEvent TextDes;

	public BImage ImageCharacter;

	public ActButton BtnNext;

	public ActButton BtnClose;

	[SerializeField]
	private LocalizeStringEvent characterName;

	[SerializeField]
	private CharacterProfessionIcon professionIcon;

	[SerializeField]
	private List<CharacterOverTagtem> _listTag;

	public CharacterMannerItem MannerItem;

	[SerializeField]
	private PropertyCell[] propertyCells;

	[SerializeField]
	private TextMeshProUGUI levelText;

	[SerializeField]
	private ActButton btnOpenAttribute;

	[SerializeField]
	private LocalizeStringEvent characterTraitsDes;

	[SerializeField]
	private Transform TfEliteDes;

	[SerializeField]
	private RogueEliteDescriptionItem eliteDescriptionPrefab;

	[SerializeField]
	private ActButton BtnprofessionIcon;

	public Transform TfTalenNodeDes;

	public GameObject TextTalenDes;

	public ActButton BtnTalenNode;

	public GameObject TalenNodeTips;

	public GameObject TalenNodeEmptyTips;

	public GameObject TalenNodeDescription;

	public int[] PropertyList = new int[4] { 100, 200, 300, 400 };

	private List<ItemUnifierProxy> allCharacter = new List<ItemUnifierProxy>();

	private readonly List<RogueEliteDescriptionItem> _eliteDescriptionInstances = new List<RogueEliteDescriptionItem>();

	private readonly List<GameObject> _talentDescriptionInstances = new List<GameObject>();

	private readonly List<Character> _trialCharacters = new List<Character>();

	private static readonly Color PlayerHigherLevelColor = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue);

	private static readonly Color ConfiguredLevelColor = new Color32(byte.MaxValue, 201, 85, byte.MaxValue);

	private int _selectCharacterId;

	private int _selectCharacterProbationId;

	private Character _selectCharacter;

	public ScrollRect ScrollRect;

	public RightStickScrollSupport RightStickScrollSupport;

	[Header("Input Binding")]
	public ViewControlLayer viewControlLayer;

	public ViewControlLayer rightPanelControlLayer;

	public GamePadTipsComp gamePadGroup;

	private bool m_canRightStickScroll;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	public bool IsTalentNodeTipsActive
	{
		get
		{
			if (TalenNodeTips != null)
			{
				return TalenNodeTips.activeSelf;
			}
			return false;
		}
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		m_data = uiViewData as RogueTeamViewData;
		await base.PreInit();
		await Singleton<UISceneManager>.instance.LoadScene<RogueTeamViewScene>(GameLoader.meta.rogueTeamViewSceneReferenceAssetID.GUID);
		BtnClose.SetBtnClick(Close);
		BtnNext.SetBtnClick(OnNext);
		BtnprofessionIcon.SetBtnClick(OpenCharacterTagDetailsView);
		if (BtnTalenNode != null)
		{
			BtnTalenNode.SetBtnClick(ToggleTalentNodeTips);
		}
		_selectCharacterId = 0;
		_selectCharacterProbationId = 0;
	}

	protected override void OnMoveToShow()
	{
		Singleton<UISceneManager>.instance.OpenScene<RogueTeamViewScene>();
	}

	protected override void OnPopStack()
	{
		RogueTeamViewScene.Default?.ResetCharcterAni();
	}

	protected override void OnMoveToHide()
	{
		Singleton<UISceneManager>.instance.CloseScene<RogueTeamViewScene>();
	}

	protected override void Init()
	{
		base.Init();
		InitPanel();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Rogue/RoleSelect_Open");
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		ClearEliteDescriptions();
		ClearTalentDescriptions();
		ClearTrialCharacters();
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	protected override void CloseComplete()
	{
		Singleton<UISceneManager>.instance.ReleaseScene<RogueTeamViewScene>();
	}

	public override void Close()
	{
		base.Close();
	}

	private void InitPanel()
	{
		if (TalenNodeTips != null)
		{
			TalenNodeTips.SetActive(value: false);
		}
		InitCharacterBag();
		RefreshSelectCharacter();
		RefreshTalentDescriptions();
		RogueMode data = CoreUtils.GetData(m_data.ModeId, RuntimeConfigs.data.rogueModes);
		if (data != null)
		{
			TextName.StringReference.TableEntryReference = data.name;
			TextDes.StringReference.TableEntryReference = data.description;
		}
		viewControlLayer.Focus();
		OnGamePadInit();
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
	}

	private void InitCharacterList()
	{
		ClearTrialCharacters();
		allCharacter.Clear();
		RogueMode data = CoreUtils.GetData(m_data.ModeId, RuntimeConfigs.data.rogueModes);
		if (data?.entityCharacterProbationIds == null)
		{
			return;
		}
		List<Character> list = CharacterDataHelper.CreateRogueCharacterTeamByProbationIds(data.entityCharacterProbationIds);
		list.Sort(SortTeam);
		foreach (Character item in list)
		{
			_trialCharacters.Add(item);
			allCharacter.Add(ItemUnifierProxy.ItemUnifierPool.Get(item));
		}
	}

	private void ClearTrialCharacters()
	{
		foreach (Character trialCharacter in _trialCharacters)
		{
			CharacterDataHelper.ReleaseCharacter(0, trialCharacter);
		}
		_trialCharacters.Clear();
	}

	private int SortTeam(Character x, Character y)
	{
		for (int i = 0; i < SortUtility.CompareBaseCharacter[0].Length; i++)
		{
			int num = SortUtility.CompareBaseCharacter[0][i](x, y);
			if (num != 0)
			{
				return num * -1;
			}
		}
		return 0;
	}

	private void InitCharacterBag()
	{
		InitCharacterList();
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
				SelectCharacter(l.ItemUnifier.Source as Character, needsound: true);
			}
		}));
		charactersVerticalDetail.OnUpdateEnd = null;
		charactersVerticalDetail.OnItemShow = null;
		CommonScrollBagComponent commonScrollBagComponent2 = charactersVerticalDetail;
		commonScrollBagComponent2.OnUpdateEnd = (Action)Delegate.Combine(commonScrollBagComponent2.OnUpdateEnd, (Action)(() =>
		{
			charactersVerticalDetail.OnUpdateEnd = null;
			if (allCharacter.Count > 0)
			{
				SelectCharacter(allCharacter[0].Source as Character);
				Component component = charactersVerticalDetail.GetComponentInChildren<LoopScrollRect>()?.GetItem(0) as Component;
				if (component != null)
				{
					EventSystemHelper.SetSelectedGameObject(component.gameObject);
				}
			}
		}));
		CommonScrollBagComponent commonScrollBagComponent3 = charactersVerticalDetail;
		commonScrollBagComponent3.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent3.OnItemShow, (Action<ItemUIComponentBase>)((ItemUIComponentBase x) =>
		{
			RefreshTrialCharacterItem(x);
			string redPointPath = string.Format(RedDotPathDefine.Character + "|{0}", x.ItemUnifier.Id);
			x.RedDotType = (Singleton<RedDotManager>.instance.GeCharacterTabRedpointState(x.ItemUnifier.Id) ? RedDotType.New : RedDotType.Dot);
			x.RedPointPath = redPointPath;
			if (Singleton<RedDotManager>.instance.GeCharacterTabRedpointState(x.ItemUnifier.Id))
			{
				Singleton<RedDotManager>.instance.OnRedDotStateChanged += instanceOnOnRedDotStateChanged(x);
			}
		}));
		CommonScrollBagComponent commonScrollBagComponent4 = charactersVerticalDetail;
		commonScrollBagComponent4.OnItemUnLoad = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent4.OnItemUnLoad, (Action<ItemUIComponentBase>)((ItemUIComponentBase x) =>
		{
			Singleton<RedDotManager>.instance.OnRedDotStateChanged -= instanceOnOnRedDotStateChanged(x);
		}));
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

	private static void RefreshTrialCharacterItem(ItemUIComponentBase item)
	{
		if (item is BagCharacterItemUIComponent bagCharacterItemUIComponent && item.ItemUnifier?.Source is Character character)
		{
			bool flag = character.TrialProbationId > 0;
			bool flag2 = CharacterDataHelper.TryGetBagCharacterById(character.Id, out var character2);
			int num = character.Level;
			if (flag && RuntimeConfigs.data.entityCharacterProbations.TryGetValue(character.TrialProbationId, out var value))
			{
				num = value.characterLv;
			}
			Color levelColor = ((!flag || (flag2 && character2.Level > num)) ? PlayerHigherLevelColor : ConfiguredLevelColor);
			bagCharacterItemUIComponent.SetLevelColor(levelColor);
			bagCharacterItemUIComponent.SetTrialIconActive(flag && !flag2);
		}
	}

	private void SelectCharacter(ICharacterSource characterSource, bool needsound = false)
	{
		if (characterSource != null && _selectCharacterId != characterSource.Id())
		{
			_selectCharacterId = characterSource.Id();
			_selectCharacter = characterSource as Character;
			_selectCharacterProbationId = _selectCharacter?.TrialProbationId ?? 0;
			RogueTeamViewScene.Default?.ShowCharacterModel(characterSource);
			RefreshCharacterOverview(characterSource);
			RefreshSelectCharacter();
			if (needsound)
			{
				Singleton<CharacterVoiceManager>.instance.PlayCharacterVoice(characterSource.Id());
			}
		}
	}

	private void RefreshCharacterOverview(ICharacterSource characterSource)
	{
		ClearEliteDescriptions();
		if (_selectCharacter == null)
		{
			return;
		}
		btnOpenAttribute.SetBtnClick(OpenAttributeDetail);
		int characterId = characterSource.Id();
		bool isTrailCharacter = characterSource.IsTrailCharacter;
		EntityData data = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityDatas);
		EntityCharacterData data2 = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		int mannerType = data2.mannerType;
		int[] characterTagGroup = data2.characterTagGroup;
		characterName.StringReference.TableEntryReference = data.nameLocal;
		professionIcon.UpdateDisPlay(characterId);
		MannerItem.Init(Station, mannerType);
		RuntimeCharacterProperty systemProperty = _selectCharacter.systemProperty;
		for (int i = 0; i < propertyCells.Length; i++)
		{
			bool flag = i < PropertyList.Length;
			propertyCells[i].gameObject.SetActive(flag);
			if (flag)
			{
				int key = PropertyList[i];
				PropertyData propertyData = RuntimeConfigs.data.propertyDatas[key];
				float resultPropertyValue = systemProperty.GetResultPropertyValue(propertyData.propertyId);
				float p = (propertyData.judge ? resultPropertyValue : ((float)Mathf.FloorToInt(resultPropertyValue)));
				int propertyDescId = RuntimeConfigs.data.propertyTypeDatas[propertyData.propertyId].propertyDescId;
				string num = (propertyData.judge ? GameUtility.TopercentageNoSpace(p, 1) : p.ToString());
				propertyCells[i].InitInNumNeedIcon(propertyData, propertyDescId, Station, num);
			}
		}
		for (int j = 0; j < _listTag.Count; j++)
		{
			_listTag[j].gameObject.SetActive(characterTagGroup.Length > j);
			if (characterTagGroup.Length > j)
			{
				_listTag[j].Init(characterTagGroup[j]);
				_listTag[j].BtnClick.SetBtnClick(() =>
				{
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERTAGDETAILS, new CharacterTagDetailsViewData
					{
						characterId = characterId
					});
				});
			}
		}
		if (!isTrailCharacter)
		{
			_ = CoreUtils.GetData(SystemUnlockManager.playerLevel, RuntimeConfigs.data.playerLevelDatas).characterLevel;
		}
		else
		{
			_ = RuntimeConfigs.data.game.maxLevel;
		}
		levelText.text = _selectCharacter.Level.ToString();
		if (_selectCharacter.TrialProbationId > 0 && RuntimeConfigs.data.entityCharacterProbations.TryGetValue(_selectCharacter.TrialProbationId, out var value))
		{
			characterTraitsDes.StringReference.TableEntryReference = value.showText;
		}
		RefreshEliteDescriptions(characterId);
	}

	private void RefreshEliteDescriptions(int characterId)
	{
		if (TfEliteDes == null || eliteDescriptionPrefab == null)
		{
			return;
		}
		EliteTrainingMap data = CoreUtils.GetData(characterId, RuntimeConfigs.data.eliteTrainingMaps);
		if (data?.characterSkill != null)
		{
			int eliteActiveLevel = _selectCharacter.GetEliteActiveLevel();
			int num = Math.Min(3, data.characterSkill.Length);
			for (int i = 0; i < num; i++)
			{
				bool flag = Model<EliteModel>.Interface.IsTalentActive(i + 1, eliteActiveLevel, _selectCharacter != null && _selectCharacter.IsTrailCharacter);
				int[] skillMessageId = CoreUtils.GetSkillMessageId(data.characterSkill[i]);
				string description = ((skillMessageId != null && skillMessageId.Length > 0) ? CustomTagParser.ReplaceSkillMessageText(skillMessageId[0], "longcommon", isBrief: false) : string.Empty);
				string unlockCondition = (flag ? string.Empty : GetEliteUnlockCondition(i));
				RogueEliteDescriptionItem rogueEliteDescriptionItem = UnityEngine.Object.Instantiate(eliteDescriptionPrefab, TfEliteDes, worldPositionStays: false);
				rogueEliteDescriptionItem.gameObject.SetActive(value: true);
				rogueEliteDescriptionItem.Init(flag, description, unlockCondition);
				_eliteDescriptionInstances.Add(rogueEliteDescriptionItem);
			}
		}
	}

	private static string GetEliteUnlockCondition(int index)
	{
		int num = index switch
		{
			0 => RuntimeConfigs.data.game.eliteSkill1Num, 
			1 => RuntimeConfigs.data.game.eliteSkill2Num, 
			2 => RuntimeConfigs.data.game.eliteSkill3Num, 
			_ => 0, 
		};
		if (num <= 0)
		{
			return string.Empty;
		}
		LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2373, new object[1] { num });
		int num2 = ((index == 0) ? RuntimeConfigs.data.game.eliteStage2PlayerLevel : RuntimeConfigs.data.game.eliteStage3PlayerLevel);
		string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2372, new object[1] { num2 });
		return "(" + localizeString + ")";
	}

	private void ClearEliteDescriptions()
	{
		foreach (RogueEliteDescriptionItem eliteDescriptionInstance in _eliteDescriptionInstances)
		{
			if (!(eliteDescriptionInstance == null))
			{
				eliteDescriptionInstance.gameObject.SetActive(value: false);
				UnityEngine.Object.Destroy(eliteDescriptionInstance.gameObject);
			}
		}
		_eliteDescriptionInstances.Clear();
	}

	private void RefreshTalentDescriptions()
	{
		ClearTalentDescriptions();
		SetTalentNodeActiveState(hasActiveTalentNode: false);
		MapField<int, RogueTalentTreeNode> mapField = Model<RogueNewModel>.Interface.Info?.TalentTree?.Nodes;
		if (mapField == null)
		{
			return;
		}
		bool talentNodeActiveState = false;
		Dictionary<int, float> dictionary = new Dictionary<int, float>();
		foreach (RogueTalentTreeNode value6 in mapField.Values)
		{
			if (value6 == null || value6.Level <= 0)
			{
				continue;
			}
			talentNodeActiveState = true;
			TalentNodeLevelData talentNodeLevelDataByLevel = Model<RogueNewModel>.Interface.GetTalentNodeLevelDataByLevel(value6.NodeId, value6.Level);
			if (talentNodeLevelDataByLevel == null || talentNodeLevelDataByLevel.propertyBonus.Count == 0)
			{
				continue;
			}
			foreach (Properties propertyBonu in talentNodeLevelDataByLevel.propertyBonus)
			{
				if (propertyBonu != null)
				{
					dictionary.TryGetValue(propertyBonu.property, out var value);
					dictionary[propertyBonu.property] = value + propertyBonu.value;
				}
			}
		}
		SetTalentNodeActiveState(talentNodeActiveState);
		if (TfTalenNodeDes == null || TextTalenDes == null)
		{
			return;
		}
		List<KeyValuePair<int, float>> list = new List<KeyValuePair<int, float>>(dictionary);
		list.Sort((KeyValuePair<int, float> left, KeyValuePair<int, float> right) =>
		{
			int num = (RuntimeConfigs.data.propertyDatas.TryGetValue(left.Key, out var value3) ? value3.sort : int.MaxValue);
			int value4 = (RuntimeConfigs.data.propertyDatas.TryGetValue(right.Key, out var value5) ? value5.sort : int.MaxValue);
			int num2 = num.CompareTo(value4);
			return (num2 == 0) ? left.Key.CompareTo(right.Key) : num2;
		});
		foreach (KeyValuePair<int, float> item in list)
		{
			if (RuntimeConfigs.data.propertyDatas.TryGetValue(item.Key, out var value2))
			{
				string text = (value2.judge ? GameUtility.TopercentageNoSpace(item.Value, 1) : Mathf.FloorToInt(item.Value).ToString());
				if (item.Value > 0f)
				{
					text = "+" + text;
				}
				TalentNodeDes talentNodeDes = UIUtility.AddWidget<TalentNodeDes>(TfTalenNodeDes, TextTalenDes);
				talentNodeDes.gameObject.SetActive(value: true);
				talentNodeDes.Init(value2.descLocal, text);
				_talentDescriptionInstances.Add(talentNodeDes.gameObject);
			}
		}
	}

	private void ClearTalentDescriptions()
	{
		foreach (GameObject talentDescriptionInstance in _talentDescriptionInstances)
		{
			if (!(talentDescriptionInstance == null))
			{
				talentDescriptionInstance.SetActive(value: false);
				UnityEngine.Object.Destroy(talentDescriptionInstance);
			}
		}
		_talentDescriptionInstances.Clear();
	}

	private void SetTalentNodeActiveState(bool hasActiveTalentNode)
	{
		if (TalenNodeEmptyTips != null)
		{
			TalenNodeEmptyTips.SetActive(!hasActiveTalentNode);
		}
		if (TalenNodeDescription != null)
		{
			TalenNodeDescription.SetActive(hasActiveTalentNode);
		}
	}

	private void ToggleTalentNodeTips()
	{
		if (!(TalenNodeTips == null))
		{
			if (TalenNodeTips.activeSelf)
			{
				betterAnimation.GetSequence("SkillTreeHide").Play();
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Rogue/Return_Click");
			}
			else
			{
				betterAnimation.GetSequence("SkillTreeShow").Play();
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Rogue/TalentTree/Role_Open");
			}
			TalenNodeTips.SetActive(!TalenNodeTips.activeSelf);
			ReBindBtnPrompt();
		}
	}

	public void HideTalentNodeTips()
	{
		if (!(TalenNodeTips == null) && TalenNodeTips.activeSelf)
		{
			TalenNodeTips.SetActive(value: false);
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Rogue/Return_Click");
			ReBindBtnPrompt();
		}
	}

	public void OpenAttributeDetail()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window", new AudioPlayOptions
		{
			attachTarget = transform
		});
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERBATTLEATTRIBUTE, new AttributeData
		{
			character = _selectCharacter
		});
	}

	private void RefreshSelectCharacter()
	{
		BtnNext.Interactable(_selectCharacterProbationId != 0);
		ImageCharacter.rawIcon.gameObject.SetActive(value: false);
	}

	public void OnNext()
	{
		TeamUsage teamUsage = new TeamUsage();
		teamUsage.CharacterUsage.Add(new TeamCharacterUsage
		{
			CharacterId = _selectCharacterProbationId,
			IsTrial = false
		});
		Model<RogueNewModel>.Interface.RogueChallengeInfo.character = teamUsage;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUESELECTCARD);
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/RSUpDownSelect"] = new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/UISpecial3"] = new GamePadTipsAction
			{
				inputAction = "UI/UISpecial3",
				localizeKey = 41000087,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			},
			["UI/UISpecial2"] = new GamePadTipsAction
			{
				inputAction = "UI/UISpecial2",
				localizeKey = 41000001,
				localizeTable = "Common"
			}
		};
	}

	private void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		if (IsTalentNodeTipsActive)
		{
			_tipsActions.Add(_allInputPrompt["UI/UISpecial2"]);
			_tipsActions.Add(_allInputPrompt["UI/Back"]);
			gamePadGroup.RegisterInputActions(_tipsActions);
			return;
		}
		if (rightPanelControlLayer != null && rightPanelControlLayer.IsFocused)
		{
			_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
		}
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		if (m_canRightStickScroll)
		{
			_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
		}
		gamePadGroup.RegisterInputActions(_tipsActions);
	}

	public void RefreshGamePadPrompt()
	{
		if (_allInputPrompt.Count != 0 && !(gamePadGroup == null))
		{
			ReBindBtnPrompt();
		}
	}

	private void RefreshRightStickScrollForbid()
	{
		ScrollRect scrollRect = ScrollRect;
		RightStickScrollSupport rightStickScrollSupport = RightStickScrollSupport;
		if (rightStickScrollSupport == null || scrollRect == null)
		{
			m_canRightStickScroll = scrollRect != null && scrollRect.content != null && scrollRect.viewport != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
			return;
		}
		Canvas.ForceUpdateCanvases();
		if (scrollRect.content != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(scrollRect.content);
		}
		bool flag = scrollRect.content != null && scrollRect.viewport != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
		rightStickScrollSupport.SetForbidScroll(!flag);
		m_canRightStickScroll = flag;
	}

	public void Scroll(Vector2 value)
	{
		if (m_canRightStickScroll)
		{
			ScrollRect scrollRect = ScrollRect;
			if (!(scrollRect == null))
			{
				scrollRect.velocity = new Vector2(0f, value.y * scrollRect.scrollSensitivity);
			}
		}
	}

	public void OpenCharacterTagDetailsView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERTAGDETAILS, new CharacterTagDetailsViewData
		{
			characterId = _selectCharacter.Id
		});
	}
}
