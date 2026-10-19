using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController.EliteViewController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Fundamental;
using Runtime.UI.CommonComponent;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CvEliteNew : SubUIView<CvEliteNewSubInputController>, ICharacterSubView, ISubUIView, IBaseUIComponent
{
	private const int DEFAULT_SELECT_POINT_ID = 0;

	private const int GAMEPAD_TIP_LOCALIZE_SELECT = 774;

	private const int GAMEPAD_TIP_LOCALIZE_RETURN = 606;

	private const int GAMEPAD_TIP_LOCALIZE_VIEW = 2596;

	private const int LOCALIZATION_ELITE_LIMIT_ID = 1779;

	private bool _afterAnimation;

	[SerializeField]
	private EliteDiscComponent eliteDiscComponent;

	[SerializeField]
	private ActButton openOverviewBtn;

	[SerializeField]
	private PublicToggle emptyPanel;

	[SerializeField]
	private LocalizeStringEvent limitText;

	[SerializeField]
	private CommonCoinComponent hasCommonEliteResource;

	[SerializeField]
	private CommonCoinComponent hasPersonalEliteResource;

	[SerializeField]
	private BetterAnimation anim;

	[Header("手柄控制组")]
	public ViewControlLayer subViewLayer;

	public ViewControlLayer costLayer;

	[SerializeField]
	private GameObject _rightTopGamepadRoot;

	private int _selectCharacterId;

	private Character _selectCharacter;

	private int _selectPointId;

	private int _stage;

	private ImageAssetStation _imageAssetStation;

	private bool isTrialCharacter;

	[SerializeField]
	private TextMeshProUGUI _eliteText;

	[SerializeField]
	private TextMeshProUGUI _eliteConsumeText;

	private readonly List<GamePadTipsAction> _mainEliteTipsActions = new List<GamePadTipsAction>();

	public CharacterView CharacterView { get; private set; }

	public int Depth => 1;

	public ICharacterSubView lastSubView { get; set; }

	public CharacterViewScene.CvSceneType SceneType => CharacterViewScene.CvSceneType.Elite;

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

	public bool NeedBlur => true;

	public EliteDiscComponent EliteDiscComponent
	{
		get
		{
			return eliteDiscComponent;
		}
		set
		{
			eliteDiscComponent = value;
		}
	}

	private GamePadTipsComp MainEliteGamePadTips
	{
		get
		{
			if (!(eliteDiscComponent != null))
			{
				return null;
			}
			return eliteDiscComponent.gamePadTipsComp;
		}
	}

	public bool CanEnterTopMaterialSelection => !isTrialCharacter;

	public void Init(CharacterView characterView)
	{
		CharacterView = characterView;
	}

	public void Show(int characterId, ImageAssetStation station, ICharacterSource characterSource)
	{
		if (characterId <= 0 || station == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("CvElite.Show: Invalid parameters");
			}
			return;
		}
		AfterAnimation = false;
		gameObject.SetActive(value: true);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/Open");
		_imageAssetStation = station;
		PlayAnim("Show", () =>
		{
			AfterAnimation = true;
		});
		isTrialCharacter = characterSource.IsTrailCharacter;
		CheckTalentRedDot(CharacterDataHelper.GetCharacterByCharacterSource(characterSource));
		InitializeCharacterData(characterSource);
		SetupUI();
		openOverviewBtn.SetBtnClick(OpenOverView);
		AddEventListener();
	}

	private new void OnDisable()
	{
		MainEliteGamePadTips?.ClearAllPrompts();
	}

	private void OnMainEliteInputModeChanged(DeviceInputMode mode)
	{
		RefreshMainEliteGamepadTips();
	}

	public void RefreshMainEliteGamepadTips(bool eliteLevelUpNewPopupJustClosed = false)
	{
		RefreshRightTopGamepadRoot();
		GamePadTipsComp mainEliteGamePadTips = MainEliteGamePadTips;
		if (mainEliteGamePadTips == null)
		{
			return;
		}
		mainEliteGamePadTips.ClearAllPrompts();
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad && (eliteLevelUpNewPopupJustClosed || !IsEliteLevelUpNewPopupOpen()))
		{
			CvEliteNewSubInputController controller = GetController();
			bool num = controller != null && controller.ControllerType == CvEliteNewControllerType.SelectTopMaterial;
			_mainEliteTipsActions.Clear();
			if (num)
			{
				_mainEliteTipsActions.Add(GamePadTipHelper.ConfirmAction);
				_mainEliteTipsActions.Add(GamePadTipHelper.BackAction);
			}
			else
			{
				_mainEliteTipsActions.Add(new GamePadTipsAction
				{
					inputAction = "LargeMapView/Select",
					localizeKey = 774,
					localizeTable = "Common"
				});
				_mainEliteTipsActions.Add(new GamePadTipsAction
				{
					inputAction = "LargeMapView/Return",
					localizeKey = 606,
					localizeTable = "Common"
				});
				_mainEliteTipsActions.Add(new GamePadTipsAction
				{
					inputAction = "UI/View",
					localizeKey = 2596,
					localizeTable = "Common"
				});
			}
			mainEliteGamePadTips.RegisterInputActions(_mainEliteTipsActions);
		}
	}

	private void RefreshRightTopGamepadRoot()
	{
		if (!(_rightTopGamepadRoot == null))
		{
			CvEliteNewSubInputController controller = GetController();
			bool flag = controller != null && controller.ControllerType == CvEliteNewControllerType.SelectTopMaterial;
			bool active = !isTrialCharacter && !flag && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
			_rightTopGamepadRoot.SetActive(active);
		}
	}

	private static bool IsEliteLevelUpNewPopupOpen()
	{
		UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_POPUPELITELEVELUPNEW);
		if (firstUIState != UIState.Opening)
		{
			return firstUIState == UIState.Opened;
		}
		return true;
	}

	private void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EliteRefreshDisc, OnRefresh);
		MonoECS.instance.onInputModeChange.AddListener(OnMainEliteInputModeChanged);
	}

	private void OnRefresh(BaseEventContent obj)
	{
		RefreshBottomStageAndLevel();
	}

	private void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EliteRefreshDisc, OnRefresh);
		MonoECS.instance.onInputModeChange.RemoveListener(OnMainEliteInputModeChanged);
		MainEliteGamePadTips?.ClearAllPrompts();
	}

	private void RefreshBottomStageAndLevel()
	{
		_eliteText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1780);
		int costTokenNumPerLevelByStage = Model<EliteModel>.Interface.GetCostTokenNumPerLevelByStage(_selectCharacter);
		_eliteConsumeText.text = costTokenNumPerLevelByStage.ToString();
	}

	private void OpenOverView()
	{
		if (_selectCharacter != null)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ELITEOVERVIEW, new EliteOverviewViewData
			{
				_character = _selectCharacter
			});
		}
	}

	private void InitializeCharacterData(ICharacterSource characterSource)
	{
		CollectCharacterElitePointData(characterSource);
		RefreshEmptyStatus();
	}

	private void CollectCharacterElitePointData(ICharacterSource characterSource)
	{
		_selectCharacterId = characterSource.Id();
		_selectPointId = 0;
		_selectCharacter = CharacterDataHelper.GetCharacterByCharacterSource(characterSource);
		if (_selectCharacter != null)
		{
			_stage = Model<EliteModel>.Interface.GetEliteStage(_selectCharacter);
		}
	}

	private void RefreshEmptyStatus()
	{
		if (_selectCharacter != null)
		{
			bool flag = _selectCharacter.Level >= RuntimeConfigs.data.game.eliteStage1CharacterLevel;
			emptyPanel.isOn = !flag;
			if (!flag)
			{
				limitText.StringReference.TableEntryReference = 1779L;
				limitText.StringReference.GetVariable<string>("0").Value = RuntimeConfigs.data.game.eliteStage1CharacterLevel.ToString();
			}
		}
	}

	private void SetupUI()
	{
		if (_selectCharacter != null)
		{
			eliteDiscComponent.SetDiscParam(isPopupDisplayDisc: false);
			eliteDiscComponent.Init(_selectCharacter, _imageAssetStation, _selectPointId, 0);
			InitEliteTokenInfo(_selectCharacter);
			RefreshTrialCharacterResourceVisibility();
			RefreshBottomStageAndLevel();
			RefreshMainEliteGamepadTips();
		}
	}

	private void RefreshTrialCharacterResourceVisibility()
	{
		bool active = !isTrialCharacter;
		if (hasCommonEliteResource != null)
		{
			hasCommonEliteResource.gameObject.SetActive(active);
		}
		if (hasPersonalEliteResource != null)
		{
			hasPersonalEliteResource.gameObject.SetActive(active);
		}
		RefreshRightTopGamepadRoot();
	}

	public void InitEliteTokenInfo(Character character)
	{
		EntityCharacterData data = CoreUtils.GetData(character.Id, RuntimeConfigs.data.entityCharacterDatas);
		RefreshEliteResource(hasCommonEliteResource, data.eliteElementItem);
		RefreshEliteResource(hasPersonalEliteResource, data.eliteCharacterItem);
	}

	private static void RefreshEliteResource(CommonCoinComponent resource, int itemId)
	{
		if (!(resource == null))
		{
			EliteResourceIconRefresher.Refresh(resource, itemId);
		}
	}

	public void Hide()
	{
		RemoveEventListener();
		PlayAnim("Hide", () =>
		{
			gameObject.SetActive(value: false);
			AfterAnimation = false;
		});
		AfterAnimation = false;
		eliteDiscComponent.SetParticleSystemInVisible();
	}

	public void Freeze()
	{
		PlayAnim("hide", () =>
		{
			gameObject.SetActive(value: false);
		});
	}

	public void UnFreeze(int characterId)
	{
		gameObject.SetActive(value: true);
	}

	public void OnSelectCharacter(ICharacterSource characterSource)
	{
		if (characterSource.Id() > 0)
		{
			isTrialCharacter = characterSource.IsTrailCharacter;
			if (characterSource.IsTrailCharacter)
			{
				GetController()?.HideCostExpDetail();
			}
			CheckTalentRedDot(CharacterDataHelper.GetCharacterByCharacterSource(characterSource));
			CollectCharacterElitePointData(characterSource);
			RefreshEmptyStatus();
			SetupUI();
			if (_selectCharacter != null)
			{
				eliteDiscComponent.OnSelectCharacter();
			}
		}
	}

	public void PlayAnim(string animName, Action onComplete = null)
	{
		if (animName == string.Empty)
		{
			return;
		}
		if (anim == null)
		{
			AfterAnimation = true;
		}
		else if (onComplete != null)
		{
			anim?.GetSequence(animName).OnComplete((AnimationBuilder _) =>
			{
				onComplete();
			}).Play();
		}
		else
		{
			anim?.GetSequence(animName).Play();
		}
	}

	public void CheckTalentRedDot(Character character)
	{
		if (character != null && !character.IsTrailCharacter && Model<EliteModel>.Interface.eliteTalentRedDotDic.TryGetValue(character.Id, out var value) && value)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPELITEBREAK, new PopupEliteBreakViewData
			{
				stageId = Model<EliteModel>.Interface.GetEliteStage(character) + 1,
				character = character
			});
			Model<EliteModel>.Interface.eliteTalentRedDotDic[character.Id] = false;
			string path = string.Format(RedDotPathDefine.Character + "|{0}|EliteEntrance", character.Id);
			Model<EliteModel>.Interface.SetCharacterEliteRedDot(path, isShow: false);
		}
	}
}
