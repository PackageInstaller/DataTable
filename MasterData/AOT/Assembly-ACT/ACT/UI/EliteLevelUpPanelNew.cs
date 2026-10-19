using System;
using System.Collections.Generic;
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
using ACT.UI.InputController;
using ACT.UI.InputController.EliteViewController;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.Pool;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class EliteLevelUpPanelNew : LevelUpPanel<EliteLevelUpPanelDataNew>
{
	private const int LocalizeSelect = 774;

	private const int LocalizeReturn = 606;

	[SerializeField]
	private GameObject costRoot;

	[SerializeField]
	private LiteItemUIComponent hasCommonEliteResource;

	[SerializeField]
	private LiteItemUIComponent hasPersonalEliteResource;

	[SerializeField]
	private LocalizeStringEvent localizeEliteMaxText;

	[SerializeField]
	private BImage attrImg;

	[SerializeField]
	private LocalizeStringEvent attrNameLocalize;

	[SerializeField]
	private GameObject unlockTips;

	[SerializeField]
	private LocalizeStringEvent txt_unlockTips;

	private string[] pointIndex = new string[9] { "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" };

	private int selectPointIndex;

	private const int LOCALIZATION_INDEXNAME = 1812;

	private Action _action;

	[SerializeField]
	private GameObject rightRoot;

	private EliteDiscComponent _eliteDiscComponent;

	[SerializeField]
	private ActButton _btn_reset;

	[SerializeField]
	private ActButton _btn_preview;

	[SerializeField]
	private TextMeshProUGUI _eliteText;

	[SerializeField]
	private TextMeshProUGUI _eliteConsumeText;

	[SerializeField]
	private RectTransform _stageGroup;

	[SerializeField]
	private RectTransform _elitePointStrengthenGroup;

	[SerializeField]
	private RectTransform _curLevelRoot;

	[SerializeField]
	private TextMeshProUGUI _curLevelText;

	[SerializeField]
	private TextMeshProUGUI _maxLevelText;

	[SerializeField]
	private BImage _currPropertyImg;

	[SerializeField]
	private LocalizeStringEvent _currPropertyNameLocalize;

	[SerializeField]
	private TextMeshProUGUI _currPropertyValue;

	[SerializeField]
	private BetterAnimation _propertyBetterAnimation;

	[SerializeField]
	private RectTransform _arrow;

	[SerializeField]
	private RectTransform _preLevelRoot;

	[SerializeField]
	private TextMeshProUGUI _nextLevelText;

	[SerializeField]
	private TextMeshProUGUI _next_maxLevelText;

	[SerializeField]
	private RectTransform _preLevelPropertyRoot;

	[SerializeField]
	private BImage _nextPropertyImg;

	[SerializeField]
	private LocalizeStringEvent _nextPropertyNameLocalize;

	[SerializeField]
	private TextMeshProUGUI _nextPropertyValue;

	[SerializeField]
	private RectTransform _backRoot;

	[SerializeField]
	private ActButton _btn_back;

	[Header("手柄提示(分散显示) ")]
	[SerializeField]
	private OperateBtnPrompt promptL_ItemDetail;

	[SerializeField]
	private OperateBtnPrompt promptY_Upgrade;

	[SerializeField]
	private OperateBtnPrompt promptA;

	[SerializeField]
	private OperateBtnPrompt promptB;

	[SerializeField]
	private ActButton _upgradeBtn;

	[SerializeField]
	private TextMeshProUGUI _upgradeBtnText;

	[SerializeField]
	private BImage _stagePointImg;

	[SerializeField]
	private TextMeshProUGUI _stagePointText;

	[SerializeField]
	private TextMeshProUGUI _stagePointDescText;

	[SerializeField]
	private TextMeshProUGUI _stagePointDescText2;

	[SerializeField]
	private GameObject _stagePointDescText2GO;

	[SerializeField]
	private LocalizeStringEvent skillNameLocalize;

	[SerializeField]
	private TextMeshProUGUI skillDescLocalize;

	[SerializeField]
	private TextMeshProUGUI _tipsText;

	[SerializeField]
	private GameObject _breakConditionGroup;

	[SerializeField]
	private TextMeshProUGUI _playerLevelText;

	[SerializeField]
	private TextMeshProUGUI _activeText1;

	[SerializeField]
	private BImage _playerLevelBoard;

	[SerializeField]
	private GameObject _playerLevelGO;

	[SerializeField]
	private TextMeshProUGUI _eliteLevelText;

	[SerializeField]
	private TextMeshProUGUI _activeText2;

	[SerializeField]
	private BImage _eliteLevelBoard;

	[SerializeField]
	private GameObject _tipBoard;

	private int elitePointId;

	private Character _selectCharacter;

	private int _selectCharacterId;

	private bool isTalentPoint;

	private ImageAssetStation _station;

	private int _stage;

	private int curLevel;

	private new EliteLevelUpPanelDataNew _panelData;

	private int _indexOfThreeProgress;

	private int _pointStageIndex;

	private int _displayLevel;

	private int _displayMaxLevel;

	private int normalBoard = 30;

	private int activeBoard = 31;

	private BetterAnimation _betterAnimation;

	private PopupEliteLevelUpNewView _popupView;

	private EliteViewSubControllerType _lastPromptControllerType = EliteViewSubControllerType.ElitePointUpGarde;

	private bool _lastPromptHasMaterialSlots;

	public void InitPanel(PopupEliteLevelUpNewViewData popupEliteLevelUpNewViewData, ImageAssetStation station)
	{
		elitePointId = popupEliteLevelUpNewViewData.elitePointId;
		_selectCharacter = popupEliteLevelUpNewViewData.character;
		_selectCharacterId = _selectCharacter.Id;
		isTalentPoint = popupEliteLevelUpNewViewData.isTalentPoint;
		_station = station;
		_indexOfThreeProgress = popupEliteLevelUpNewViewData.indexOfThreeProgress;
		_stage = Model<EliteModel>.Interface.GetEliteStage(_selectCharacter);
		_pointStageIndex = popupEliteLevelUpNewViewData.pointStageIndex;
		_betterAnimation = gameObject.GetComponent<BetterAnimation>();
		_popupView = GetComponentInParent<PopupEliteLevelUpNewView>();
		_btn_reset.SetBtnClick(ResetElitePoint);
		_btn_preview.SetBtnClick(OpenOverView);
		_btn_back.SetBtnClick(BackElitePoint);
		_upgradeBtn.SetBtnClick(ClickUpgrade);
		RefreshBottomStageAndLevel();
		RefreshRightLevelUpPanel();
		SetupDiscreteOperatePromptContent();
		RefreshDiscreteOperatePrompts(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		SetRightRootVisible(b: true);
	}

	public void PlayShowAnimation()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/Elitist_Open");
		_betterAnimation.GetSequence("RightSideShow")?.Play();
	}

	public void OnEnable()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EliteRefreshSelectPoint, OnRefreshView);
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		RefreshDiscreteOperatePrompts(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	public void OnDisable()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EliteRefreshSelectPoint, OnRefreshView);
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		RefreshDiscreteOperatePrompts(gamepadActive: false);
	}

	public void PlayHideAnimation()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/Elitist_Close");
		_betterAnimation.GetSequence("RightSideHide")?.Play();
	}

	private void OnRefreshView(BaseEventContent obj)
	{
		if (obj is EliteSelectPointRefresh eliteSelectPointRefresh)
		{
			elitePointId = eliteSelectPointRefresh.elitePointId;
			isTalentPoint = eliteSelectPointRefresh.isTalent;
			_indexOfThreeProgress = eliteSelectPointRefresh.indexOfThreeProgress;
			selectPointIndex = Model<EliteModel>.Interface.GetElitePointIndex(_selectCharacter, elitePointId);
			_pointStageIndex = eliteSelectPointRefresh.pointStageIndex;
			_stage = Model<EliteModel>.Interface.GetEliteStage(_selectCharacter);
			RefreshBottomStageAndLevel();
			RefreshRightLevelUpPanel();
			SetRightRootVisible(b: true);
		}
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		if (mode != DeviceInputMode.Gamepad)
		{
			RefreshDiscreteOperatePrompts(gamepadActive: false);
		}
		else
		{
			RefreshDiscreteOperatePrompts(gamepadActive: true);
		}
	}

	private void Update()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad && isActiveAndEnabled)
		{
			EliteViewSubControllerType eliteViewSubControllerType = ResolveCurrentControllerType();
			bool flag = HasReinforcedMaterialSlotsVisible();
			if (eliteViewSubControllerType != _lastPromptControllerType || flag != _lastPromptHasMaterialSlots)
			{
				RefreshDiscreteOperatePrompts(gamepadActive: true);
			}
		}
	}

	private static void ConfigureDiscreteOperatePrompt(OperateBtnPrompt prompt, string bindingAction, int localizeKey)
	{
		if (!(prompt == null))
		{
			prompt.SetBindingAction(bindingAction);
			prompt.SetLocalizeString(localizeKey);
			prompt.RefreshIcon();
		}
	}

	private void SetupDiscreteOperatePromptContent()
	{
		ConfigureDiscreteOperatePrompt(promptL_ItemDetail, "UI/SelectItemCell", 0);
		ConfigureDiscreteOperatePrompt(promptY_Upgrade, "LargeMapView/Select", 0);
		ConfigureDiscreteOperatePrompt(promptA, "LargeMapView/Select", 774);
		ConfigureDiscreteOperatePrompt(promptB, "LargeMapView/Return", 606);
	}

	private void RefreshDiscreteOperatePrompts(bool gamepadActive)
	{
		if (!gamepadActive)
		{
			promptL_ItemDetail?.SetVisible(vis: false);
			promptY_Upgrade?.SetVisible(vis: false);
			promptA?.SetVisible(vis: false);
			promptB?.SetVisible(vis: false);
			return;
		}
		EliteViewSubControllerType eliteViewSubControllerType = ResolveCurrentControllerType();
		bool flag = HasReinforcedMaterialSlotsVisible();
		_lastPromptControllerType = eliteViewSubControllerType;
		_lastPromptHasMaterialSlots = flag;
		bool flag2 = eliteViewSubControllerType == EliteViewSubControllerType.SelectReinforcedMaterial;
		bool flag3 = eliteViewSubControllerType == EliteViewSubControllerType.SelectEliteCurrency;
		bool flag4 = eliteViewSubControllerType == EliteViewSubControllerType.ElitePointUpGarde;
		bool flag5 = _upgradeBtn != null && _upgradeBtn.gameObject.activeInHierarchy && _upgradeBtn.interactable;
		promptL_ItemDetail?.SetVisible(flag4 & flag);
		promptY_Upgrade?.SetVisible(flag4 & flag5);
		promptA?.SetVisible(flag2 | flag3);
		promptB?.SetVisible(flag2 | flag3);
	}

	private EliteViewSubControllerType ResolveCurrentControllerType()
	{
		if (_popupView?.EliteDisc == null)
		{
			return EliteViewSubControllerType.ElitePointUpGarde;
		}
		return _popupView.GetCurrentPromptControllerType();
	}

	public bool HasReinforcedMaterialSlotsVisible()
	{
		if (!isTalentPoint && costRoot != null)
		{
			return costRoot.activeInHierarchy;
		}
		return false;
	}

	public bool TryFocusMaterialSelectable()
	{
		Selectable selectable = ResolveMaterialSelectable();
		if (selectable == null)
		{
			return false;
		}
		selectable.Select();
		EventSystemHelper.SetSelectedGameObject(selectable.gameObject);
		return true;
	}

	public void ForceRefreshOperatePrompts()
	{
		_lastPromptControllerType = (EliteViewSubControllerType)(-1);
		_lastPromptHasMaterialSlots = !_lastPromptHasMaterialSlots;
		RefreshDiscreteOperatePrompts(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	private Selectable ResolveMaterialSelectable()
	{
		Selectable selectable = ((hasCommonEliteResource != null) ? hasCommonEliteResource.GetComponentInChildren<Selectable>(includeInactive: true) : null);
		if (selectable != null && selectable.gameObject.activeInHierarchy)
		{
			return selectable;
		}
		Selectable selectable2 = ((hasPersonalEliteResource != null) ? hasPersonalEliteResource.GetComponentInChildren<Selectable>(includeInactive: true) : null);
		if (selectable2 != null && selectable2.gameObject.activeInHierarchy)
		{
			return selectable2;
		}
		return selectable ?? selectable2;
	}

	public void HandleGamepadUpgradeShortcut()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad && ResolveCurrentControllerType() == EliteViewSubControllerType.ElitePointUpGarde && !(_upgradeBtn == null) && _upgradeBtn.gameObject.activeInHierarchy && _upgradeBtn.interactable)
		{
			ClickUpgrade();
		}
	}

	private bool TryBlockTrialCharacterOperation()
	{
		if (_selectCharacter == null || !_selectCharacter.IsTrailCharacter)
		{
			return false;
		}
		GameUtility.OpenToolTip(1814);
		return true;
	}

	private void RefreshBottomStageAndLevel()
	{
		_eliteText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1780);
		int costTokenNumPerLevelByStage = Model<EliteModel>.Interface.GetCostTokenNumPerLevelByStage(_selectCharacter);
		_eliteConsumeText.text = costTokenNumPerLevelByStage.ToString();
	}

	private void RefreshRightLevelUpPanel()
	{
		_stage = Model<EliteModel>.Interface.GetEliteStage(_selectCharacter);
		_stageGroup.gameObject.SetActive(isTalentPoint);
		_elitePointStrengthenGroup.gameObject.SetActive(!isTalentPoint);
		if (isTalentPoint)
		{
			RefreshStagePointDetail();
			return;
		}
		EliteLevelUpPanelDataNew eliteLevelUpPanelDataNew = CreateElitePanelData(elitePointId);
		if (eliteLevelUpPanelDataNew != null)
		{
			RefreshPointPanel(eliteLevelUpPanelDataNew);
		}
	}

	private void RefreshStagePointDetail()
	{
		int eliteActiveLevel = _selectCharacter.GetEliteActiveLevel();
		(int, int, int) selectPointStageId = Model<EliteModel>.Interface.GetSelectPointStageId(_selectCharacterId, elitePointId);
		int item = selectPointStageId.Item1;
		int item2 = selectPointStageId.Item2;
		bool flag = Model<EliteModel>.Interface.IsTalentActive(item, eliteActiveLevel, _selectCharacter != null && _selectCharacter.IsTrailCharacter);
		if (RuntimeConfigs.data.eliteTrainingStages.TryGetValue(item + 1, out var value))
		{
			_stagePointText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.name);
			_station.LoadImage(151, value.icon, _stagePointImg);
			if (item != 3)
			{
				_stagePointDescText.gameObject.SetActive(value: true);
				_stagePointDescText2GO.gameObject.SetActive(value: true);
				_stagePointDescText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, value.commonId[0]);
				_stagePointDescText2.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, value.commonId[1]);
			}
			else
			{
				_stagePointDescText.gameObject.SetActive(value: true);
				_stagePointDescText2GO.gameObject.SetActive(value: false);
				_stagePointDescText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, value.commonId[0]);
			}
		}
		int[] skillMessageId = CoreUtils.GetSkillMessageId(item2);
		if (skillMessageId != null && skillMessageId.Length != 0)
		{
			int num = skillMessageId[0];
			SkillDetailMessageData data = CoreUtils.GetData(num, RuntimeConfigs.data.skillDetailMessageDatas);
			skillNameLocalize.SetReference(LocalizeTable.ShortCommon, data.nameLocal);
			skillDescLocalize.text = CustomTagParser.ReplaceSkillMessageText(num, "longcommon", isBrief: false);
		}
		costRoot.gameObject.SetActive(value: false);
		_backRoot.gameObject.SetActive(value: false);
		_upgradeBtn.gameObject.SetActive(value: false);
		_tipsText.gameObject.SetActive(value: true);
		_tipsText.text = (flag ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2244) : LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2378));
		int playerLevel = SystemUnlockManager.playerLevel;
		switch (item)
		{
		case 1:
			_breakConditionGroup.SetActive(value: true);
			_playerLevelGO.gameObject.SetActive(value: true);
			RefreshBreakGroup(playerLevel, RuntimeConfigs.data.game.eliteStage2PlayerLevel, eliteActiveLevel, RuntimeConfigs.data.game.eliteSkill1Num);
			break;
		case 2:
			_breakConditionGroup.SetActive(value: true);
			_playerLevelGO.gameObject.SetActive(value: true);
			RefreshBreakGroup(playerLevel, RuntimeConfigs.data.game.eliteStage3PlayerLevel, eliteActiveLevel, RuntimeConfigs.data.game.eliteSkill2Num);
			break;
		case 3:
			_breakConditionGroup.SetActive(value: true);
			_playerLevelGO.gameObject.SetActive(value: false);
			RefreshBreakGroup(playerLevel, RuntimeConfigs.data.game.eliteStage3PlayerLevel, eliteActiveLevel, RuntimeConfigs.data.game.eliteSkill3Num);
			break;
		}
	}

	private void RefreshBreakGroup(int playerLevel, int needPlayerLevel, int eliteLevel, int needEliteLevel)
	{
		_playerLevelText.text = string.Empty;
		LocalizeStringEvent component = _playerLevelText.gameObject.GetComponent<LocalizeStringEvent>();
		component.SetTable("Common");
		component.StringReference.TableEntryReference = 2372L;
		component.GetVariable<string>("0").Value = needPlayerLevel.ToString();
		component.RefreshString();
		string value = $"({playerLevel}/{needPlayerLevel})";
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Clear();
		stringBuilder.Append(_playerLevelText.text);
		stringBuilder.Append(value);
		_playerLevelText.text = stringBuilder.ToString();
		_eliteLevelText.text = string.Empty;
		LocalizeStringEvent component2 = _eliteLevelText.gameObject.GetComponent<LocalizeStringEvent>();
		component2.SetTable("Common");
		component2.StringReference.TableEntryReference = 2373L;
		component2.GetVariable<string>("0").Value = needEliteLevel.ToString();
		component2.RefreshString();
		bool flag = playerLevel >= needPlayerLevel;
		bool flag2 = eliteLevel >= needEliteLevel;
		string value2 = $"({eliteLevel}/{needEliteLevel})";
		StringBuilder stringBuilder2 = new StringBuilder();
		stringBuilder2.Clear();
		stringBuilder2.Append(_eliteLevelText.text);
		stringBuilder2.Append(value2);
		_eliteLevelText.text = stringBuilder2.ToString();
		_activeText1.text = (flag ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1472) : LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 981));
		_activeText2.text = (flag2 ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1472) : LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 981));
		if (flag)
		{
			_station.LoadImage(151, activeBoard, _playerLevelBoard);
		}
		else
		{
			_station.LoadImage(151, normalBoard, _playerLevelBoard);
		}
		if (flag2)
		{
			_station.LoadImage(151, activeBoard, _eliteLevelBoard);
		}
		else
		{
			_station.LoadImage(151, normalBoard, _eliteLevelBoard);
		}
		ColorUtility.TryParseHtmlString(flag ? Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.BrightChartreuse) : Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.Dark), out var color);
		_activeText1.color = color;
		ColorUtility.TryParseHtmlString(flag2 ? Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.BrightChartreuse) : Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.Dark), out var color2);
		_activeText2.color = color2;
	}

	private void RefreshPointPanel(EliteLevelUpPanelDataNew elitePanelData)
	{
		_selectCharacter.GetElitePointLevel(elitePointId);
		curLevel = elitePanelData.CurLevel;
		int pointIndexOfList = Model<EliteModel>.Interface.GetPointIndexOfList(_selectCharacterId, elitePointId);
		int eliteStage = Model<EliteModel>.Interface.GetEliteStage(_selectCharacter);
		_displayLevel = Model<EliteModel>.Interface.GetDisPlayLevel(curLevel, _indexOfThreeProgress + 1, eliteStage, pointIndexOfList);
		_displayMaxLevel = Model<EliteModel>.Interface.GetEachStageMaxLevel(_indexOfThreeProgress + 1, pointIndexOfList);
		bool flag = _displayLevel >= _displayMaxLevel;
		EliteTrainingPoint data = CoreUtils.GetData(elitePointId, RuntimeConfigs.data.eliteTrainingPoints);
		_station.LoadImage(151, data.UIName, attrImg);
		attrNameLocalize.StringReference.TableEntryReference = 1812L;
		attrNameLocalize.StringReference.GetVariable<string>("0").Value = ((pointIndex[selectPointIndex - 1] != null) ? GetPointName(pointIndex[selectPointIndex - 1], _indexOfThreeProgress + 1) : pointIndex[0]);
		_curLevelRoot.gameObject.SetActive(value: true);
		_curLevelText.text = _displayLevel.ToString();
		_maxLevelText.text = _displayMaxLevel.ToString();
		List<Properties> properties = elitePanelData.Properties;
		PropertyData data2 = CoreUtils.GetData(properties[0].property, RuntimeConfigs.data.propertyDatas);
		_station.LoadImage(146, data2.icon, _currPropertyImg);
		_currPropertyNameLocalize.StringReference.TableEntryReference = data2.descLocal;
		float curPropertyVal = GetCurPropertyVal(properties[0]);
		string text = (data2.judge ? GameUtility.TopercentageMathfFloor(curPropertyVal, 1) : Mathf.FloorToInt(curPropertyVal).ToString());
		_currPropertyValue.text = text;
		_arrow.gameObject.SetActive(!flag);
		_preLevelRoot.gameObject.SetActive(!flag);
		_preLevelPropertyRoot.gameObject.SetActive(!flag);
		if (!flag)
		{
			_nextLevelText.text = (_displayLevel + 1).ToString();
			_next_maxLevelText.text = _displayMaxLevel.ToString();
			_station.LoadImage(146, data2.icon, _nextPropertyImg);
			_nextPropertyNameLocalize.StringReference.TableEntryReference = data2.descLocal;
			float num = (float)_selectCharacter.GetElitePointLevel(elitePointId) * data.attrIncreaseNum[0] + GetAddPropertyVal(properties[0], 1);
			string text2 = (data2.judge ? GameUtility.TopercentageMathfFloor(num, 1) : Mathf.FloorToInt(num).ToString());
			_nextPropertyValue.text = text2;
		}
		RefreshUpgradeButtonAndText(flag);
		RefreshBacktrackButton(flag);
		RefreshConsumeItem(flag);
	}

	private void RefreshConsumeItem(bool isMax)
	{
		_tipsText.gameObject.SetActive(value: false);
		if (_pointStageIndex > _stage)
		{
			SetUpgradeButtonInteractable(active: false);
			_tipsText.gameObject.SetActive(value: true);
			costRoot.gameObject.SetActive(value: false);
			_upgradeBtn.gameObject.SetActive(value: false);
			_backRoot.gameObject.SetActive(value: false);
			_btn_back.gameObject.SetActive(value: false);
			LocalizeStringEvent component = _tipsText.gameObject.GetComponent<LocalizeStringEvent>();
			component.SetTable("Common");
			component.StringReference.TableEntryReference = 2240L;
			EliteTrainingStage data = CoreUtils.GetData(_pointStageIndex + 1, RuntimeConfigs.data.eliteTrainingStages);
			component.GetVariable<string>("0").Value = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data.name);
			return;
		}
		_tipsText.gameObject.SetActive(value: true);
		if (_indexOfThreeProgress == 1 && curLevel < RuntimeConfigs.data.game.eliteStage1AttrLevel && Model<EliteModel>.Interface.GetPointIndexOfList(_selectCharacterId, elitePointId) <= 2)
		{
			_tipsText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2239);
			SetUpgradeButtonInteractable(active: false);
			costRoot.gameObject.SetActive(value: false);
			_upgradeBtn.gameObject.SetActive(value: false);
			_backRoot.gameObject.SetActive(value: false);
			_btn_back.gameObject.SetActive(value: false);
			return;
		}
		if (_indexOfThreeProgress == 2 && curLevel < RuntimeConfigs.data.game.eliteStage2AttrLevel && Model<EliteModel>.Interface.GetPointIndexOfList(_selectCharacterId, elitePointId) <= 5)
		{
			_tipsText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2239);
			SetUpgradeButtonInteractable(active: false);
			costRoot.gameObject.SetActive(value: false);
			_upgradeBtn.gameObject.SetActive(value: false);
			_backRoot.gameObject.SetActive(value: false);
			_btn_back.gameObject.SetActive(value: false);
			return;
		}
		if (isMax)
		{
			costRoot.gameObject.SetActive(value: false);
			_tipsText.gameObject.SetActive(value: false);
			return;
		}
		_tipsText.gameObject.SetActive(value: false);
		costRoot.gameObject.SetActive(value: true);
		int genericCharacterEliteItem = _selectCharacter.GetGenericCharacterEliteItem();
		int itemCount = G.localPlayer.Inventory.GetItemCount(genericCharacterEliteItem);
		int characterEliteItem = _selectCharacter.GetCharacterEliteItem();
		int itemCount2 = G.localPlayer.Inventory.GetItemCount(characterEliteItem);
		int costTokeNumPerLevel = _panelData.CostTokeNumPerLevel;
		SetUpgradeButtonInteractable(itemCount2 + itemCount >= costTokeNumPerLevel);
		if (itemCount2 >= costTokeNumPerLevel)
		{
			hasCommonEliteResource.gameObject.SetActive(value: false);
			hasPersonalEliteResource.gameObject.SetActive(value: true);
			RefreshCharacterItem(characterEliteItem, itemCount2, costTokeNumPerLevel);
		}
		else if (itemCount2 > 0 && itemCount > 0)
		{
			hasCommonEliteResource.gameObject.SetActive(value: true);
			hasPersonalEliteResource.gameObject.SetActive(value: true);
			int num = Mathf.Min(itemCount2, costTokeNumPerLevel);
			RefreshCharacterItem(characterEliteItem, itemCount2, num);
			RefreshGenericItem(genericCharacterEliteItem, itemCount, Mathf.Max(0, costTokeNumPerLevel - num));
		}
		else if (itemCount2 == 0 && itemCount > 0)
		{
			hasCommonEliteResource.gameObject.SetActive(value: true);
			hasPersonalEliteResource.gameObject.SetActive(value: false);
			RefreshGenericItem(genericCharacterEliteItem, itemCount, costTokeNumPerLevel);
		}
		else if (itemCount2 == 0)
		{
			hasCommonEliteResource.gameObject.SetActive(value: true);
			hasPersonalEliteResource.gameObject.SetActive(value: false);
			RefreshGenericItem(genericCharacterEliteItem, itemCount, costTokeNumPerLevel);
		}
		else
		{
			hasCommonEliteResource.gameObject.SetActive(value: false);
			hasPersonalEliteResource.gameObject.SetActive(value: true);
			RefreshCharacterItem(characterEliteItem, itemCount2, costTokeNumPerLevel);
		}
	}

	private void RefreshGenericItem(int id, int num, int costNum)
	{
		Item item = new Item();
		item.Id = id;
		item.Count = costNum;
		hasCommonEliteResource.Station = _station;
		hasCommonEliteResource.SetData(item, num, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.Both);
		hasCommonEliteResource.gameObject.SetActive(value: true);
		hasCommonEliteResource.UpdatePerformance();
		hasCommonEliteResource.showDetailPanel = true;
	}

	private void RefreshCharacterItem(int id, int num, int costNum)
	{
		Item item = new Item();
		item.Id = id;
		item.Count = costNum;
		hasPersonalEliteResource.Station = _station;
		hasPersonalEliteResource.SetData(item, num, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.Both);
		hasPersonalEliteResource.gameObject.SetActive(value: true);
		hasPersonalEliteResource.UpdatePerformance();
		hasPersonalEliteResource.showDetailPanel = true;
	}

	private void RefreshBacktrackButton(bool isMax)
	{
		if (_pointStageIndex > _stage)
		{
			_backRoot.gameObject.SetActive(value: false);
			_btn_back.gameObject.SetActive(value: false);
			return;
		}
		_backRoot.gameObject.SetActive(value: true);
		_btn_back.gameObject.SetActive(value: true);
		if (_displayLevel == 0)
		{
			_btn_back.gameObject.SetActive(value: false);
		}
	}

	private void BackElitePoint()
	{
		if (!TryBlockTrialCharacterOperation())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/Talent");
			int eliteActiveLevel = _selectCharacter.GetEliteActiveLevel();
			int elitePointLevel = _selectCharacter.GetElitePointLevel(elitePointId);
			(int, int) backLevel = Model<EliteModel>.Interface.GetBackLevel(_selectCharacter, eliteActiveLevel, elitePointLevel, _indexOfThreeProgress, elitePointId);
			int item = backLevel.Item1;
			int item2 = backLevel.Item2;
			int num = 0;
			(bool, int) tuple = Model<EliteModel>.Interface.IsTriggerStageDown(item, eliteActiveLevel);
			bool item3 = tuple.Item1;
			num = tuple.Item2;
			int characterEliteItem = _selectCharacter.GetCharacterEliteItem();
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPELITEBACKPOINT, new PopupEliteBackPointViewData
			{
				activeLevel = eliteActiveLevel,
				isTriggerStageDown = item3,
				stageId = _stage,
				indexOfThreeProgress = _indexOfThreeProgress,
				backLevel = item,
				backCostCount = item2,
				characterEliteItemId = characterEliteItem,
				backStage = num,
				OnConfirm = OnBackConfirmed
			});
		}
	}

	public void HandleGamepadBacktrackShortcut()
	{
		if ((_selectCharacter == null || !_selectCharacter.IsTrailCharacter) && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && !(_btn_back == null) && _btn_back.gameObject.activeInHierarchy)
		{
			BackElitePoint();
		}
	}

	public void HandleGamepadResetShortcut()
	{
		if ((_selectCharacter == null || !_selectCharacter.IsTrailCharacter) && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && !(_btn_reset == null) && _btn_reset.gameObject.activeInHierarchy)
		{
			ResetElitePoint();
		}
	}

	private void OnBackConfirmed()
	{
		if (!TryBlockTrialCharacterOperation())
		{
			G.service.CharacterEliteReset(_selectCharacterId, elitePointId, _indexOfThreeProgress + 1, OnResetCompleted);
		}
	}

	private void RefreshUpgradeButtonAndText(bool isMax)
	{
		if (_pointStageIndex > _stage)
		{
			SetUpgradeButtonInteractable(active: false);
			_upgradeBtn.gameObject.SetActive(value: false);
		}
		else
		{
			_upgradeBtn.gameObject.SetActive(value: true);
			SetUpgradeButtonInteractable(!isMax);
			_upgradeBtnText.text = (isMax ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1785) : LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1778));
		}
	}

	private void SetUpgradeButtonInteractable(bool active)
	{
		if (!(_upgradeBtn == null) && _upgradeBtn.Interactable(active))
		{
			ForceRefreshOperatePrompts();
		}
	}

	private EliteLevelUpPanelDataNew CreateElitePanelData(int elitePointId)
	{
		int elitePointMaxLevel = ElitePointGroup.GetElitePointMaxLevel(_stage);
		curLevel = _selectCharacter.GetElitePointLevel(elitePointId);
		EliteTrainingPoint data = CoreUtils.GetData(elitePointId, RuntimeConfigs.data.eliteTrainingPoints);
		if (data == null || data.attrId == null || data.attrId.Length == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Invalid elite point data for ID: {elitePointId}");
			}
			return null;
		}
		List<Properties> properties = Model<EliteModel>.Interface.CreatePropertiesList(data.attrId[0]);
		(int, int, int) tokenData = Model<EliteModel>.Interface.GetTokenData(_selectCharacter);
		EliteLevelUpPanelDataNew eliteLevelUpPanelDataNew = RecyclePool<EliteLevelUpPanelDataNew>.Default.Get();
		int num = Model<EliteModel>.Interface.CalculateItemEnoughLevel(tokenData.Item1, tokenData.Item2, tokenData.Item3, curLevel);
		eliteLevelUpPanelDataNew.FinallyMaxLevel = RuntimeConfigs.data.game.eliteStage3AttrLevel;
		num = ((num > elitePointMaxLevel) ? elitePointMaxLevel : num);
		eliteLevelUpPanelDataNew.SeGenericVal((!Model<EliteModel>.Interface.IsTrialCharacter) ? 1 : 0, elitePointMaxLevel, curLevel, (!Model<EliteModel>.Interface.IsTrialCharacter) ? 1 : 0, (!Model<EliteModel>.Interface.IsTrialCharacter) ? num : 0, properties);
		eliteLevelUpPanelDataNew.SetEliteVal(_selectCharacter, elitePointId, _selectCharacter.GetGenericCharacterEliteItem(), tokenData.Item1, _selectCharacter.GetCharacterEliteItem(), tokenData.Item2, tokenData.Item3, _station, Model<EliteModel>.Interface.IsTrialCharacter);
		_panelData = eliteLevelUpPanelDataNew;
		return eliteLevelUpPanelDataNew;
	}

	private void OpenOverView()
	{
		if (_selectCharacter != null)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/Talent");
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ELITEOVERVIEW, new EliteOverviewViewData
			{
				_character = _selectCharacter
			});
		}
	}

	private void ResetElitePoint()
	{
		if (TryBlockTrialCharacterOperation() || _selectCharacterId <= 0 || _selectCharacter == null)
		{
			return;
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/Talent");
		EntityCharacterData data = CoreUtils.GetData(_selectCharacterId, RuntimeConfigs.data.entityCharacterDatas);
		ItemData data2 = CoreUtils.GetData(_selectCharacter.GetCharacterEliteItem(), RuntimeConfigs.data.itemDatas);
		if (data == null || data2 == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("Failed to get character or item config data");
			}
		}
		else
		{
			int allElitePointCost = _selectCharacter.GetAllElitePointCost();
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPELITERESET, new PopupEliteResetViewData
			{
				allCost = allElitePointCost,
				itemData = data2,
				OnConfirm = OnResetConfirmed
			});
		}
	}

	private void OnResetConfirmed()
	{
		if (!TryBlockTrialCharacterOperation())
		{
			G.service.CharacterEliteReset(_selectCharacterId, 0, OnResetCompleted);
		}
	}

	private void OnResetCompleted(bool success)
	{
		if (success)
		{
			RefreshBottomStageAndLevel();
			RefreshRightLevelUpPanel();
			ElitePointLevelChange evt = Singleton<EventManager>.instance.GetEvt<ElitePointLevelChange>();
			evt.isLevelUp = false;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.EliteRefreshDisc, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void InitPointIndex(int index)
	{
		selectPointIndex = index;
	}

	protected override float GetCurPropertyVal(Properties properties)
	{
		return CoreUtils.GetData(_panelData.ElitePointId, RuntimeConfigs.data.eliteTrainingPoints).attrIncreaseNum[0] * (float)curLevel;
	}

	protected override float GetAddPropertyVal(Properties properties, int addLevel)
	{
		return CoreUtils.GetData(_panelData.ElitePointId, RuntimeConfigs.data.eliteTrainingPoints).attrIncreaseNum[0] * (float)addLevel;
	}

	protected override void Upgrade()
	{
	}

	private void ClickUpgrade()
	{
		if (TryBlockTrialCharacterOperation())
		{
			return;
		}
		int costTokeNumPerLevel = _panelData.CostTokeNumPerLevel;
		if (_panelData.RemainTokenNum + _panelData.AvailableTokenNum < costTokeNumPerLevel)
		{
			return;
		}
		if (costTokeNumPerLevel > _panelData.AvailableTokenNum && _panelData.RemainTokenNum + _panelData.AvailableTokenNum >= costTokeNumPerLevel)
		{
			int changeNumber = costTokeNumPerLevel - _panelData.AvailableTokenNum;
			Character character = _panelData.character;
			ItemData data = CoreUtils.GetData(character.GetCharacterEliteItem(), RuntimeConfigs.data.itemDatas);
			ItemData data2 = CoreUtils.GetData(character.GetGenericCharacterEliteItem(), RuntimeConfigs.data.itemDatas);
			if (Model<PlayerModel>.Interface.CommonTipsDic.TryGetValue("Elite", out var value) && value)
			{
				CommonUpgrade();
				return;
			}
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPELITELEVELUP, new PopupEliteLevelUpViewData
			{
				OnConfirm = () =>
				{
					CommonUpgrade();
				},
				showSilence = true,
				OnClickSilence = (bool b) =>
				{
					Model<PlayerModel>.Interface.CommonTipsDic["Elite"] = b;
				},
				item_character = data,
				item_generic = data2,
				changeNumber = changeNumber
			});
		}
		else
		{
			CommonUpgrade();
		}
	}

	public void CommonUpgrade()
	{
		if (TryBlockTrialCharacterOperation())
		{
			return;
		}
		G.service.CharacterEliteLevelUp(_selectCharacterId, elitePointId, curLevel + 1, (bool b) =>
		{
			if (b)
			{
				OnUpgradeSuccessRefresh();
				_action?.Invoke();
			}
		});
	}

	private void OnUpgradeSuccessRefresh()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/ElitistLevel", new AudioPlayOptions
		{
			attachTarget = transform
		});
		RefreshBottomStageAndLevel();
		_propertyBetterAnimation.GetSequence("LvUp")?.Play();
		RefreshRightLevelUpPanel();
		ElitePointLevelChange evt = Singleton<EventManager>.instance.GetEvt<ElitePointLevelChange>();
		evt.isLevelUp = true;
		evt.elitePointId = elitePointId;
		evt.indexOfThreeProgress = _indexOfThreeProgress;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.EliteRefreshDisc, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void RegisterCallBack(Action action)
	{
		_action = (Action)Delegate.Combine(_action, action);
	}

	public void RemoveCallBack(Action action)
	{
		_action = (Action)Delegate.Remove(_action, action);
	}

	public override void UnInit()
	{
		base.UnInit();
		_action = null;
	}

	private string GetPointName(string leftName, int indexOfThreeProgress)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(leftName);
		stringBuilder.Append("-");
		stringBuilder.Append(indexOfThreeProgress);
		return stringBuilder.ToString();
	}

	public void BindEliteDiscComponent(EliteDiscComponent eliteDiscComponent)
	{
		_eliteDiscComponent = eliteDiscComponent;
	}

	public void SetRightRootVisible(bool b)
	{
		rightRoot.SetActive(b);
		RefreshTrialCharacterOperationUI();
		_eliteDiscComponent?.OnRightPanelVisibilityChanged(b);
	}

	private void RefreshTrialCharacterOperationUI()
	{
		if (_selectCharacter != null)
		{
			_tipBoard.SetActive(!_selectCharacter.IsTrailCharacter);
			if (_selectCharacter.IsTrailCharacter)
			{
				costRoot.SetActive(value: false);
				_btn_reset.gameObject.SetActive(value: false);
				_backRoot.gameObject.SetActive(value: false);
				_btn_back.gameObject.SetActive(value: false);
				_upgradeBtn.gameObject.SetActive(value: false);
			}
		}
	}
}
