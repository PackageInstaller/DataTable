using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class ElitePointComponent : MonoBehaviour
{
	[SerializeField]
	private ActButton btn;

	[SerializeField]
	private PublicToggle unlockToggle;

	[SerializeField]
	private GameObject activeLevelRoot;

	[SerializeField]
	private TextMeshProUGUI levelText;

	[SerializeField]
	private TextMeshProUGUI maxLevelText;

	[SerializeField]
	private GameObject notActiveLevelRoot;

	[SerializeField]
	private TextMeshProUGUI notActiveLevelText;

	[SerializeField]
	private TextMeshProUGUI notActiveMaxLevelText;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private BImage enabledIcon;

	[SerializeField]
	private RectTransform disabledRoot;

	[SerializeField]
	private RectTransform disabledIconRoot;

	[SerializeField]
	private BImage disabledIcon;

	[SerializeField]
	private RectTransform disabledIcon2Root;

	[SerializeField]
	private BImage disabledIcon2;

	[SerializeField]
	private Image iconColor;

	[SerializeField]
	private Image disabledIconColor;

	[SerializeField]
	private Image disabledIcon2Color;

	[SerializeField]
	private CanvasGroup _canvasGroup;

	[SerializeField]
	private RectTransform _elementEffectRoot;

	[SerializeField]
	private List<EliteElementEffectView> _elementEffectPrefabs;

	[SerializeField]
	private Image levelBoardColor;

	[SerializeField]
	private Image line01;

	[SerializeField]
	private Image line02;

	[SerializeField]
	private ParticleSystem _particleSystem;

	[SerializeField]
	private GameObject _gamePadHighLightRoot;

	private int _elitePointId;

	private int _curLevel;

	private int _maxLevel;

	private int _stage;

	private ImageAssetStation m_ImageAssetStation;

	private int _pointStageIndex = -1;

	private int _displayLevel;

	private int _displayMaxLevel;

	private PointStateEnum _pointStateEnum;

	private int _indexOfThreeProgress;

	private ElitePointGroupV2.ElitePointGroupDataV2 m_ElitePointGroupData;

	private BetterAnimation _betterAnimation;

	private EliteElementEffectPool _elementEffectPool;

	private EliteElementEffectView _elementEffectView;

	private int _loadedElementId = -1;

	private int _curSelectElitePointId;

	private int _curSelectIndexOfThreeProgress;

	private bool isLevelMax;

	private bool _isLevelUp;

	private Character _selectCharacter;

	private Action<int, int> _onSelectPoint;

	private bool _hasBoundClickListener;

	private int _loadedIconPointId = -1;

	private ImageAssetStation _loadedIconStation;

	public void SetData(int elitePointId, int curLevel, int displayLevel, int displayMaxLevel, int pointStageIndex, ElitePointGroupV2.ElitePointGroupDataV2 data, int colorIndex, Action<int, int> onSelectPoint, PointStateEnum pointStateEnum, int indexOfThreeProgress, bool hasEnoughUpgradeMaterials, bool isLevelUp)
	{
		EnsureRuntimeBindings();
		_isLevelUp = isLevelUp;
		_elitePointId = elitePointId;
		_curLevel = curLevel;
		_maxLevel = data.maxLevel;
		_stage = data.curStage;
		_pointStageIndex = pointStageIndex;
		_displayLevel = displayLevel;
		_displayMaxLevel = displayMaxLevel;
		isLevelMax = _displayLevel == _displayMaxLevel;
		EnsureElementEffect(colorIndex);
		m_ElitePointGroupData = data;
		m_ImageAssetStation = data.m_ImageAssetStation;
		_pointStateEnum = pointStateEnum;
		_indexOfThreeProgress = indexOfThreeProgress;
		_selectCharacter = data.character;
		_onSelectPoint = onSelectPoint;
		_gamePadHighLightRoot?.SetActive(value: false);
		Color color = ColorParseUtility.HexToColor(RuntimeConfigs.data.elementConfigs.TryGetValue(colorIndex, out var value) ? value.elementColour : "#ff00ff");
		iconColor.color = color;
		Color color2 = ColorParseUtility.HexToColor("#CFD8DA");
		PrepareElementEffect(_displayLevel == _displayMaxLevel);
		if (_displayLevel == _displayMaxLevel)
		{
			levelBoardColor.color = color;
			line01.color = color;
			line02.color = color;
		}
		else
		{
			levelBoardColor.color = color2;
			line01.color = color2;
			line02.color = color2;
		}
		iconColor.color = ((_pointStateEnum == PointStateEnum.IsMax) ? color : Color.white);
		unlockToggle.isOn = true;
		_canvasGroup.alpha = 1f;
		RefreshIconAndLevel();
		RefreshConsumeEnoughEffect(hasEnoughUpgradeMaterials);
		if (isLevelUp && isLevelMax && _curSelectElitePointId == _elitePointId && _curSelectIndexOfThreeProgress == _indexOfThreeProgress && selected.activeInHierarchy)
		{
			CheckElitePointMaxLevelAnimation();
		}
		CheckElitePointActivationAnimation();
	}

	public void RefreshConsumeEnoughEffect(bool hasEnoughUpgradeMaterials)
	{
		bool consumeEnoughEffectVisible = hasEnoughUpgradeMaterials && _displayLevel != _displayMaxLevel;
		SetConsumeEnoughEffectVisible(consumeEnoughEffectVisible);
	}

	private void EnsureRuntimeBindings()
	{
		if (_betterAnimation == null)
		{
			_betterAnimation = GetComponent<BetterAnimation>();
		}
		if (!_hasBoundClickListener)
		{
			btn.OnClick.RemoveAllListeners();
			btn.OnClick.AddListener(OnPointClicked);
			_hasBoundClickListener = true;
		}
	}

	private void OnPointClicked()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/Talent");
		_onSelectPoint?.Invoke(_elitePointId, _indexOfThreeProgress);
		Model<EliteModel>.Interface.IsTalentPoint = false;
		if (Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_POPUPELITELEVELUPNEW) != UIState.Opened)
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPELITELEVELUPNEW, new PopupEliteLevelUpNewViewData
			{
				elitePointId = _elitePointId,
				character = m_ElitePointGroupData.character,
				isTalentPoint = false,
				indexOfThreeProgress = _indexOfThreeProgress,
				pointStageIndex = _pointStageIndex
			});
			CharacterViewCanvasGroupRefreshEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterViewCanvasGroupRefreshEvt>();
			evt.alphaValue = 0f;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SetCharacterViewCanvasGroup, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		else
		{
			EliteSelectPointRefresh evt2 = Singleton<EventManager>.instance.GetEvt<EliteSelectPointRefresh>();
			evt2.elitePointId = _elitePointId;
			evt2.isTalent = false;
			evt2.indexOfThreeProgress = _indexOfThreeProgress;
			evt2.pointStageIndex = _pointStageIndex;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.EliteRefreshSelectPoint, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
		}
	}

	private void CheckElitePointMaxLevelAnimation()
	{
		_betterAnimation.GetSequence("Max")?.Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/ElitistPoint_Max");
	}

	private void CheckElitePointActivationAnimation()
	{
		if (!_isLevelUp)
		{
			return;
		}
		int eliteActiveLevel = _selectCharacter.GetEliteActiveLevel();
		switch (_stage)
		{
		case 2:
			if (_pointStageIndex == 2 && eliteActiveLevel == RuntimeConfigs.data.game.eliteSkill1Num)
			{
				_betterAnimation.GetSequence("Activation")?.Play();
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/ElitistPoint");
			}
			break;
		case 3:
			if (_pointStageIndex == 3 && eliteActiveLevel == RuntimeConfigs.data.game.eliteSkill2Num)
			{
				_betterAnimation.GetSequence("Activation")?.Play();
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/ElitistPoint");
			}
			break;
		case 1:
			break;
		}
	}

	private void RefreshIconAndLevel()
	{
		if (_loadedIconPointId != _elitePointId || _loadedIconStation != m_ImageAssetStation)
		{
			int uIName = RuntimeConfigs.data.eliteTrainingPoints[_elitePointId].UIName;
			m_ImageAssetStation.LoadImage(151, uIName, enabledIcon);
			m_ImageAssetStation.LoadImage(151, uIName, disabledIcon);
			m_ImageAssetStation.LoadImage(151, uIName, disabledIcon2);
			_loadedIconPointId = _elitePointId;
			_loadedIconStation = m_ImageAssetStation;
		}
		levelText.SetText("{0:0}", _displayLevel);
		maxLevelText.SetText("{0:0}", _displayMaxLevel);
		notActiveLevelText.SetText("{0:0}", _displayLevel);
		notActiveMaxLevelText.SetText("{0:0}", _displayMaxLevel);
		disabledIconRoot.gameObject.SetActive(value: false);
		disabledIcon2Root.gameObject.SetActive(value: false);
		disabledRoot.gameObject.SetActive(value: false);
		activeLevelRoot.gameObject.SetActive(value: true);
		notActiveLevelRoot.gameObject.SetActive(value: false);
		switch (_pointStateEnum)
		{
		case PointStateEnum.Lock:
			disabledRoot.gameObject.SetActive(value: true);
			disabledIconRoot.gameObject.SetActive(value: true);
			activeLevelRoot.gameObject.SetActive(value: false);
			notActiveLevelRoot.gameObject.SetActive(value: true);
			enabledIcon.icon.gameObject.SetActive(value: false);
			break;
		case PointStateEnum.UnlockedPrerequisites:
			disabledRoot.gameObject.SetActive(value: true);
			disabledIcon2Root.gameObject.SetActive(value: true);
			activeLevelRoot.gameObject.SetActive(value: false);
			notActiveLevelRoot.gameObject.SetActive(value: true);
			enabledIcon.icon.gameObject.SetActive(value: false);
			SetElementEffectRootVisible(visible: true);
			break;
		case PointStateEnum.CanUpgrade:
			SetElementEffectRootVisible(visible: true);
			enabledIcon.icon.gameObject.SetActive(value: true);
			break;
		case PointStateEnum.IsMax:
			enabledIcon.icon.gameObject.SetActive(value: true);
			break;
		}
	}

	internal void SetElementEffectPool(EliteElementEffectPool elementEffectPool)
	{
		_elementEffectPool = elementEffectPool;
	}

	private void EnsureElementEffect(int elementId)
	{
		if (_elementEffectRoot == null || _elementEffectPrefabs == null || elementId <= 0 || elementId > _elementEffectPrefabs.Count || _elementEffectPrefabs[elementId - 1] == null || (_loadedElementId == elementId && _elementEffectView != null))
		{
			return;
		}
		EliteElementEffectView eliteElementEffectView = _elementEffectPrefabs[elementId - 1];
		EliteElementEffectView elementEffectView = _elementEffectView;
		EliteElementEffectView loadedElementEffectPrefab = GetLoadedElementEffectPrefab();
		_elementEffectView = ((_elementEffectPool != null) ? _elementEffectPool.Rent(eliteElementEffectView, _elementEffectRoot) : UnityEngine.Object.Instantiate(eliteElementEffectView, _elementEffectRoot, worldPositionStays: false));
		_loadedElementId = elementId;
		if (!(elementEffectView == null))
		{
			if (_elementEffectPool != null && loadedElementEffectPrefab != null)
			{
				_elementEffectPool.Recycle(loadedElementEffectPrefab, elementEffectView);
				return;
			}
			elementEffectView.SetRootVisible(visible: false);
			UnityEngine.Object.Destroy(elementEffectView.gameObject);
		}
	}

	private EliteElementEffectView GetLoadedElementEffectPrefab()
	{
		if (_elementEffectPrefabs == null || _loadedElementId <= 0 || _loadedElementId > _elementEffectPrefabs.Count)
		{
			return null;
		}
		return _elementEffectPrefabs[_loadedElementId - 1];
	}

	private void PrepareElementEffect(bool isMaxLevel)
	{
		_elementEffectView?.PrepareForRefresh(isMaxLevel);
	}

	private void SetElementEffectRootVisible(bool visible)
	{
		if (_elementEffectView != null)
		{
			_elementEffectView.SetRootVisible(visible);
		}
	}

	private void SetConsumeEnoughEffectVisible(bool visible)
	{
		if (_elementEffectView != null)
		{
			_elementEffectView.SetConsumeEnoughVisible(visible);
		}
	}

	public void RefreshSelect(int pointId, int indexOfThreeProgress, bool gamePadShowPreviousTrail = false, bool prevWasTalent = false, int prevPointId = -1, int prevIndexOfThreeProgress = -1)
	{
		bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		bool flag2 = (gamePadShowPreviousTrail & flag) && !prevWasTalent && prevPointId >= 0 && prevPointId == _elitePointId && prevIndexOfThreeProgress == _indexOfThreeProgress;
		if (!RuntimeConfigs.data.eliteTrainingPoints.TryGetValue(pointId, out var _))
		{
			selected.SetActive(value: false);
			RefreshGamePadHighlight(isCurrentSelection: false, flag2);
			return;
		}
		bool flag3 = pointId == _elitePointId && indexOfThreeProgress == _indexOfThreeProgress;
		UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_POPUPELITELEVELUPNEW);
		bool flag4 = firstUIState == UIState.Opening || firstUIState == UIState.Opened;
		bool flag5 = flag & flag3;
		selected.SetActive(flag5 || (flag4 & flag3));
		_curSelectElitePointId = (flag3 ? pointId : (-1));
		_curSelectIndexOfThreeProgress = (flag3 ? indexOfThreeProgress : (-1));
		RefreshGamePadHighlight(flag3 & flag, flag2 && !flag3);
	}

	private void RefreshGamePadHighlight(bool isCurrentSelection, bool isPreviousGamePadStep)
	{
		if (!(_gamePadHighLightRoot == null))
		{
			bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
			_gamePadHighLightRoot.SetActive(flag & isCurrentSelection);
		}
	}
}
