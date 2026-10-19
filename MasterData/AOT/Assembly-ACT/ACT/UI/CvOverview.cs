using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.RichText;
using ACT.Sound;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using DG.Tweening;
using Fundamental;
using Runtime.Model;
using Runtime.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CvOverview : SubUIView<CvOverviewSubInputController>, ICharacterSubView, ISubUIView, IBaseUIComponent
{
	[Serializable]
	public struct EquipSlotStyle
	{
		public GameObject equipSlotRoot;

		public GameObject emptyRoot;

		public GameObject emptyClickRoot;

		public GameObject equipItemRoot;

		public ItemUIComponentBase equipItemUIComponent;
	}

	[SerializeField]
	private LocalizeStringEvent characterName;

	[SerializeField]
	private ActButton BtnprofessionIcon;

	[SerializeField]
	private CharacterProfessionIcon professionIcon;

	[SerializeField]
	private ActButton BtnElementIcon;

	[SerializeField]
	private BImage elementIcon;

	[SerializeField]
	private CommonDestiny commonDestiny;

	[SerializeField]
	private List<CharacterOverTagtem> _listTag;

	public CharacterMannerItem MannerItem;

	[SerializeField]
	private PropertyCell[] propertyCells;

	[SerializeField]
	private TextMeshProUGUI levelText;

	[SerializeField]
	private TextMeshProUGUI maxLevelText;

	[SerializeField]
	private GameObject CanLevelEffect;

	[SerializeField]
	private BetterAnimation animation;

	[SerializeField]
	private GameObject forbidButton;

	[SerializeField]
	private RedDotItem eliteEntranceRedDot;

	[SerializeField]
	private BImage eliteIcon;

	[SerializeField]
	private TextMeshProUGUI eliteTipsText;

	[SerializeField]
	private GameObject arrow;

	[SerializeField]
	private ActButton eliteBtn;

	[SerializeField]
	private ActButton btnOpenAttribute;

	public ViewControlLayer subViewLayer;

	public GamePadTipsComp gamePadGroup;

	public int[] PropertyList = new int[4] { 100, 200, 300, 400 };

	[SerializeField]
	public EquipSlotStyle[] equipSlotStyles;

	private bool _afterAnimation;

	private ImageAssetStation _station;

	private bool isSnapshotCharacter;

	private Character _character;

	private int equipClickindex = -1;

	private bool isCharacterEliteActive;

	private bool elitistUnlock;

	private bool isOnSelectRefresh;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	public CharacterView CharacterView { get; private set; }

	public int Depth => 1;

	public ICharacterSubView lastSubView { get; set; }

	public CharacterViewScene.CvSceneType SceneType => CharacterViewScene.CvSceneType.Over;

	public new object Context { get; set; }

	public bool AfterAnimation
	{
		get
		{
			return _afterAnimation;
		}
		set
		{
			_afterAnimation = value;
			if (value)
			{
				((ICharacterSubView)this).SendAfterAnimationEvent();
			}
		}
	}

	public void Init(CharacterView characterView)
	{
		CharacterView = characterView;
	}

	public void Show(int characterId, ImageAssetStation station, ICharacterSource characterSource)
	{
		EnsureCommonDestiny();
		gameObject.SetActive(value: true);
		if ((bool)animation)
		{
			animation.GetSequence("Show").OnComplete((AnimationBuilder a) =>
			{
				AfterAnimation = true;
				if (Model<CharacterModel>.Interface.SelectFirstEquipSlotInOverview)
				{
					EquipSlotStyle equipSlotStyle = equipSlotStyles.FirstOrDefault();
					if (equipSlotStyle.equipItemUIComponent.gameObject.activeInHierarchy)
					{
						ACT.ViewControl.SelectableEx component = equipSlotStyle.equipItemUIComponent.GetComponent<ACT.ViewControl.SelectableEx>();
						subViewLayer.DefaultSelect = component;
					}
					else if (equipSlotStyle.emptyClickRoot.activeInHierarchy)
					{
						ACT.ViewControl.SelectableEx component2 = equipSlotStyle.emptyClickRoot.GetComponent<ACT.ViewControl.SelectableEx>();
						subViewLayer.DefaultSelect = component2;
					}
				}
				Model<CharacterModel>.Interface.SelectFirstEquipSlotInOverview = false;
				subViewLayer.Focus();
			}).Play();
		}
		else
		{
			AfterAnimation = true;
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Role/Open");
		_station = station;
		isSnapshotCharacter = characterSource.IsTrailCharacter;
		_character = characterSource as Character;
		Refresh(characterId, isSnapshotCharacter);
		OnGamePadInit();
		ReBindBtnPrompt();
		FocusIn();
	}

	public void OpenDestinyByController()
	{
		commonDestiny.destinyEnter.ControllerClick();
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
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
		_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		gamePadGroup.RegisterInputActions(_tipsActions);
	}

	public void Hide()
	{
		subViewLayer.UnFocus();
		AfterAnimation = false;
		if ((bool)animation)
		{
			animation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				gameObject.SetActive(value: false);
				AfterAnimation = false;
			}).Play();
		}
		else
		{
			AfterAnimation = false;
			gameObject.SetActive(value: false);
		}
		_station = null;
		FocusOut();
	}

	public void Freeze()
	{
		gameObject.SetActive(value: false);
	}

	public void UnFreeze(int characterId)
	{
		gameObject.SetActive(value: true);
	}

	public void OnSelectCharacter(ICharacterSource characterSource)
	{
		int characterId = characterSource.Id();
		if (!_character.Equals(characterSource as Character))
		{
			isOnSelectRefresh = true;
			isSnapshotCharacter = characterSource.IsTrailCharacter;
			_character = characterSource as Character;
			Refresh(characterId, isSnapshotCharacter);
		}
	}

	private void Refresh(int characterId, bool isTrialCharacter = false)
	{
		btnOpenAttribute.SetBtnClick(OpenAttributeDetail);
		BtnElementIcon.SetBtnClick(OpenCharacterTagDetailsView);
		BtnprofessionIcon.SetBtnClick(OpenCharacterTagDetailsView);
		forbidButton.gameObject.SetActive(value: false);
		EntityData data = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityDatas);
		EntityCharacterData data2 = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		int mannerType = data2.mannerType;
		int[] characterTagGroup = data2.characterTagGroup;
		characterName.StringReference.TableEntryReference = data.nameLocal;
		if (elementIcon != null)
		{
			_station.LoadImage(102, data.element, elementIcon);
		}
		professionIcon.UpdateDisPlay(characterId);
		UnityAction openDestiny = ((CharacterView != null) ? new UnityAction(CharacterView.OpenDestiny) : null);
		commonDestiny?.Refresh(characterId, _character, _station, isTrialCharacter, openDestiny);
		if (eliteEntranceRedDot != null && !isTrialCharacter)
		{
			string text = string.Format(RedDotPathDefine.Character + "|{0}|EliteEntrance", characterId);
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(text) && Singleton<RedDotManager>.instance.GetNode(text) == null)
			{
				Singleton<RedDotManager>.instance.DynamicRegisterInitTrieNode(text);
			}
			eliteEntranceRedDot.InitRedDot(text);
		}
		CanLevelEffect.SetActive(CheckNextLevelUp());
		MannerItem.Init(_station, mannerType);
		if (!isTrialCharacter && _character != null && _character.systemProperty == null)
		{
			_character.Refresh();
		}
		Entity entity = default;
		bool flag = EntityHelper.TryGetBattleEntityByCharacter(_character, out entity);
		bool flag2 = entity.IsLogicAvailable();
		CompAbility compAbility = (flag ? entity.GetCompAbility() : null);
		for (int i = 0; i < propertyCells.Length; i++)
		{
			bool flag3 = i < PropertyList.Length;
			propertyCells[i].gameObject.SetActive(flag3);
			if (flag3)
			{
				int key = PropertyList[i];
				PropertyData propertyData = RuntimeConfigs.data.propertyDatas[key];
				float num = 0f;
				num = (flag2 ? compAbility.GetProperty((uint)propertyData.propertyId).PracticalValue : _character.systemProperty.GetResultPropertyValue(propertyData.propertyId));
				float p = (propertyData.judge ? num : ((float)Mathf.FloorToInt(num)));
				int propertyDescId = RuntimeConfigs.data.propertyTypeDatas[propertyData.propertyId].propertyDescId;
				string num2 = p.ToString();
				if (propertyData.judge)
				{
					num2 = GameUtility.TopercentageMathfFloor(p, 1);
				}
				propertyCells[i].InitInNumNeedIcon(propertyData, propertyDescId, _station, num2);
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
					OpenCharacterTagDetailsView();
				});
			}
		}
		Character character = _character;
		if (!isTrialCharacter)
		{
			levelText.text = character.Level + "/" + CoreUtils.GetData(SystemUnlockManager.playerLevel, RuntimeConfigs.data.playerLevelDatas).characterLevel.FastToString();
		}
		else
		{
			levelText.text = character.Level + "/" + RuntimeConfigs.data.game.maxLevel;
		}
		equipClickindex = -1;
		for (int num3 = 1; num3 <= equipSlotStyles.Length; num3++)
		{
			int equipId = character.GetEquipId(num3);
			int i2 = num3;
			equipSlotStyles[num3 - 1].emptyClickRoot.GetComponent<ActButton>().SetBtnClick(() =>
			{
				if (i2 - 1 != equipClickindex)
				{
					OpenEquipmentPanel(i2 - 1);
					GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.EquipOverView);
					equipClickindex = i2 - 1;
				}
			}, "event:/UI/Interface/Equip/Click");
			if (equipId == 0)
			{
				equipSlotStyles[num3 - 1].emptyRoot.SetActive(value: true);
				equipSlotStyles[num3 - 1].equipItemUIComponent.gameObject.SetActive(value: false);
				equipSlotStyles[num3 - 1].equipItemRoot.gameObject.SetActive(value: false);
				continue;
			}
			equipSlotStyles[num3 - 1].emptyRoot.SetActive(value: false);
			equipSlotStyles[num3 - 1].equipItemRoot.gameObject.SetActive(value: true);
			equipSlotStyles[num3 - 1].equipItemUIComponent.gameObject.SetActive(value: true);
			equipSlotStyles[num3 - 1].equipItemUIComponent.Station = _station;
			equipSlotStyles[num3 - 1].equipItemUIComponent.SetData(character.GetEquip(equipId), 0L, ItemUIComponentBase.InitType.CharacterOverViewEquipSlot);
			EquipUIComponent equipUIComponent = equipSlotStyles[num3 - 1].equipItemUIComponent as EquipUIComponent;
			if (!equipUIComponent)
			{
				continue;
			}
			equipUIComponent.IsTrialCharacter = isTrialCharacter;
			equipUIComponent.showDetailPanel = false;
			equipUIComponent.onToggleClick.RemoveAllListeners();
			equipUIComponent.onToggleClick.AddListener(() =>
			{
				if (i2 - 1 != equipClickindex)
				{
					OpenEquipmentPanel(i2 - 1);
					GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.EquipOverView);
					equipClickindex = i2 - 1;
				}
			});
			equipSlotStyles[num3 - 1].equipItemUIComponent.UpdatePerformance();
		}
		RefreshEliteDetail();
		bool flag4 = false;
		for (int num4 = 0; num4 < equipSlotStyles.Length; num4++)
		{
			if (_character != null && _character.GetEquipId(num4 + 1) != 0)
			{
				flag4 = true;
				break;
			}
		}
		if (flag4 && !isOnSelectRefresh)
		{
			PlayEquipSlotShowAnims();
		}
	}

	private void RefreshEliteDetail()
	{
		Character character = _character;
		int level = character.Level;
		int eliteStage1CharacterLevel = RuntimeConfigs.data.game.eliteStage1CharacterLevel;
		int eliteActiveLevel = character.GetEliteActiveLevel();
		int eliteIconByActiveLevel = Model<EliteModel>.Interface.GetEliteIconByActiveLevel(eliteActiveLevel);
		elitistUnlock = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Elitist);
		isCharacterEliteActive = level >= eliteStage1CharacterLevel;
		arrow.SetActive(isCharacterEliteActive);
		if (RuntimeConfigs.data.eliteTrainingStages.TryGetValue(eliteIconByActiveLevel, out var value))
		{
			_station.LoadImage(151, value.icon, eliteIcon);
		}
		StringBuilder stringBuilder = new StringBuilder();
		if (elitistUnlock)
		{
			if (isCharacterEliteActive)
			{
				eliteTipsText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2452);
				stringBuilder.Clear();
				stringBuilder.Append(eliteTipsText.text);
				stringBuilder.Append(":");
				stringBuilder.Append(eliteActiveLevel);
				eliteTipsText.text = stringBuilder.ToString();
			}
			else
			{
				LocalizeStringEvent component = eliteTipsText.gameObject.GetComponent<LocalizeStringEvent>();
				component.SetTable("Common");
				component.StringReference.TableEntryReference = 1779L;
				component.GetVariable<string>("0").Value = eliteStage1CharacterLevel.ToString();
			}
		}
		else
		{
			ACT.Config.Mission data = CoreUtils.GetData(CoreUtils.GetData(1038, RuntimeConfigs.data.systemOpens).missionId, RuntimeConfigs.data.missions);
			string text = CustomTagParser.ReplacePreconditionText(data, data.number, data.param);
			eliteTipsText.text = text;
		}
		eliteBtn.SetBtnClick(OnClickEliteBtn);
	}

	private void EnsureCommonDestiny()
	{
		if (!(commonDestiny != null))
		{
			commonDestiny = GetComponentInChildren<CommonDestiny>(includeInactive: true);
		}
	}

	private void OnClickEliteBtn()
	{
		if (isCharacterEliteActive && elitistUnlock)
		{
			CharacterView characterView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CHARACTER) as CharacterView;
			if (characterView != null)
			{
				characterView.CvMenuItemGroup.Enter(3);
			}
		}
		else
		{
			GameUtility.OpenToolTip(eliteTipsText.text);
		}
	}

	private bool CheckNextLevelUp()
	{
		Character character = _character;
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int exp = character.Exp;
		G.detailUserInfo.Attributes.TryGetValue(2, out var value);
		G.detailUserInfo.Attributes.TryGetValue(1, out var value2);
		int characterLevel = CoreUtils.GetData(SystemUnlockManager.playerLevel, RuntimeConfigs.data.playerLevelDatas).characterLevel;
		bool result = false;
		if (character.Level < characterLevel)
		{
			num = RuntimeConfigs.data.entityCharacterXPDatas[character.GetCharacterXpId()].xpTotal;
			num2 = RuntimeConfigs.data.entityCharacterXPDatas[character.GetCharacterXpId(character.Level + 1)].xpTotal - num - exp;
			num3 = Mathf.CeilToInt((float)num2 / RuntimeConfigs.data.game.expToCoinData);
			result = value2 >= num2 && value >= num3;
		}
		return result;
	}

	public void OpenAttributeDetail()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window", new AudioPlayOptions
		{
			attachTarget = transform
		});
		Character character = _character;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERBATTLEATTRIBUTE, new AttributeData
		{
			character = character
		});
	}

	public void OpenCharacterTagDetailsView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERTAGDETAILS, new CharacterTagDetailsViewData
		{
			characterId = _character.Id
		});
	}

	private void PlayEquipSlotShowAnims()
	{
		Sequence s = DOTween.Sequence();
		for (int i = 0; i < equipSlotStyles.Length; i++)
		{
			int slotIndex = i;
			if (i > 0)
			{
				s.AppendInterval(0.03f);
			}
			s.AppendCallback(() =>
			{
				ItemUIComponentBase equipItemUIComponent = equipSlotStyles[slotIndex].equipItemUIComponent;
				if (equipItemUIComponent != null)
				{
					BetterAnimation component = equipItemUIComponent.GetComponent<BetterAnimation>();
					if (component != null)
					{
						component.GetSequence("OverViewEquipShow").Play();
					}
				}
			});
		}
	}

	private void OpenEquipmentPanel(int equipSlotIndex)
	{
		OverViewClickEquipEvent evt = Singleton<EventManager>.instance.GetEvt<OverViewClickEquipEvent>();
		evt.index = equipSlotIndex;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_OverViewClickEquip, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
