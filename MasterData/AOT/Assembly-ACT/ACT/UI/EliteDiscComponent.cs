using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.UI.InputController.EliteViewController;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class EliteDiscComponent : MonoBehaviour
{
	private const bool LEFT_STICK_Y_POSITIVE_IS_UP = true;

	[SerializeField]
	private Image stage1Image;

	[SerializeField]
	private Image stage2Image;

	[SerializeField]
	private Image stage3Image;

	[SerializeField]
	private TextMeshProUGUI levelText;

	[SerializeField]
	private TextMeshProUGUI levelText2;

	[SerializeField]
	private EliteProgress eliteProgress;

	[SerializeField]
	private ElitePointGroupV2 elitePointGroup;

	[SerializeField]
	private elitePointProgressGroup elitePointProgressGroup;

	[SerializeField]
	private List<GameObject> _firstStageCompleteGO;

	[SerializeField]
	private List<GameObject> _secondStageCompleteGO;

	[SerializeField]
	private List<GameObject> _thirdStageCompleteGO;

	[SerializeField]
	private List<GameObject> _allElitePointMaxLevelGO;

	[SerializeField]
	private List<GameObject> _allElitePointMaxLevelSweepLightGO;

	[SerializeField]
	private List<GameObject> _firstStageMaxLevelSweepLightGO;

	[SerializeField]
	private List<GameObject> _secondStageMaxLevelSweepLightGO;

	[SerializeField]
	private List<GameObject> _thirdStageMaxLevelSweepLightGO;

	private ImageAssetStation _imageAssetStation;

	private Character _selectCharacter;

	private int _selectPointId;

	private int _stage;

	private Color _color;

	[SerializeField]
	private ScrollRect scrollRect;

	private RightStickScrollSupport _rightStickScrollSupport;

	private RectTransform _scrollViewRect;

	private Vector2 _scrollViewExpandedAnchoredPosition;

	private bool _hasCachedScrollViewExpandedAnchoredPosition;

	private Vector2 _contentExpandedAnchoredPosition;

	private bool _hasCachedContentExpandedAnchoredPosition;

	private bool _isRightPanelHiddenLayoutApplied;

	[SerializeField]
	private RectTransform bgRT;

	public float minX = -400f;

	public float maxX = -150f;

	[SerializeField]
	private float hiddenModeContentPosX = -200f;

	[SerializeField]
	private RectTransform contentRT;

	[SerializeField]
	private RectTransform viewportRT;

	private bool _isPopupDisplayDisc;

	private BetterAnimation _betterAnimation;

	[SerializeField]
	private ParticleSystem _particleSystem;

	public GamePadTipsComp gamePadTipsComp;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	private EliteViewSubControllerType _runtimeControllerType;

	private bool _isItemConversionSelectMode;

	private bool _moveHorizontalForward = true;

	private bool _moveVerticalForward = true;

	private bool _suppressNextMainReturn;

	private EliteNodeId _currentSelectedNode = EliteNodeId.Invalid;

	private float _eliteNavigateCooldownUntilUnscaled;

	private const float EliteNavigateCooldownSeconds = 0.22f;

	private bool _gamePadNavTrailActiveForNextRefresh;

	private bool _gamePadNavPrevValid;

	private bool _gamePadNavPrevIsTalent;

	private int _gamePadNavPrevId;

	private int _gamePadNavPrevSub;

	public bool IsSelectedTrialCharacter
	{
		get
		{
			if (_selectCharacter != null)
			{
				return _selectCharacter.IsTrailCharacter;
			}
			return false;
		}
	}

	private void LateUpdate()
	{
		if (scrollRect.horizontal)
		{
			RectTransform content = scrollRect.content;
			Vector2 anchoredPosition = content.anchoredPosition;
			float num = Mathf.Clamp(anchoredPosition.x, minX, maxX);
			if (anchoredPosition.x != num)
			{
				anchoredPosition.x = num;
				content.anchoredPosition = anchoredPosition;
			}
		}
	}

	public void OnEnable()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EliteRefreshDisc, OnRefreshView);
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		if (_isPopupDisplayDisc)
		{
			RefreshGamepadComp();
		}
	}

	public void OnDisable()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EliteRefreshDisc, OnRefreshView);
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		if (_isPopupDisplayDisc)
		{
			gamePadTipsComp?.ClearAllPrompts();
		}
	}

	private void OnRefreshView(BaseEventContent obj)
	{
		if (obj is ElitePointLevelChange elitePointLevelChange)
		{
			bool flag = ShouldPlayUpgradeVisual(elitePointLevelChange.isLevelUp);
			int stage = _stage;
			if (_selectCharacter != null)
			{
				_stage = Model<EliteModel>.Interface.GetEliteStage(_selectCharacter);
			}
			bool flag2 = _selectCharacter != null && stage != _stage;
			if (elitePointLevelChange.isLevelUp && elitePointLevelChange.elitePointId > 0 && !flag2)
			{
				elitePointGroup.RefreshPoint(elitePointLevelChange.elitePointId, elitePointLevelChange.indexOfThreeProgress, elitePointLevelChange.isLevelUp);
				elitePointGroup.RefreshConsumeEnoughEffects();
			}
			else
			{
				elitePointGroup.Init(PrepareGroupData(_selectCharacter, _stage), !flag2 && elitePointLevelChange.isLevelUp);
			}
			eliteProgress.Init(_selectCharacter, _imageAssetStation, OnSelectTalentPoint, elitePointLevelChange.isLevelUp);
			elitePointProgressGroup.SetData(_selectCharacter);
			RefreshThreeStageBoardColor();
			if (flag)
			{
				PlayLevelUpAnimation();
			}
			RefreshPanelEffect(flag);
			RefreshEliteLevel();
			ResyncDiscSelectionHighlightsWithoutTrail();
		}
	}

	private void PlayLevelUpAnimation()
	{
		levelText2.SetText("{0:0}", _selectCharacter.GetEliteActiveLevel());
		levelText.gameObject.SetActive(value: true);
		_betterAnimation.GetSequence("LvUp")?.OnComplete((AnimationBuilder _) =>
		{
			levelText.gameObject.SetActive(value: false);
		}).Play();
	}

	public void Init(Character selectCharacter, ImageAssetStation imageAssetStation, int elitePointId, int indexOfThreeProgress)
	{
		_betterAnimation = gameObject.GetComponent<BetterAnimation>();
		_selectCharacter = selectCharacter;
		_imageAssetStation = imageAssetStation;
		_hasCachedScrollViewExpandedAnchoredPosition = false;
		_hasCachedContentExpandedAnchoredPosition = false;
		_isRightPanelHiddenLayoutApplied = false;
		_eliteNavigateCooldownUntilUnscaled = 0f;
		_gamePadNavTrailActiveForNextRefresh = false;
		_gamePadNavPrevValid = false;
		_currentSelectedNode = EliteNodeId.Invalid;
		if (_selectCharacter != null)
		{
			_stage = Model<EliteModel>.Interface.GetEliteStage(_selectCharacter);
		}
		elitePointGroup.Init(PrepareGroupData(_selectCharacter, _stage), isLevelUp: false);
		eliteProgress.Init(_selectCharacter, _imageAssetStation, OnSelectTalentPoint, isLevelChange: false);
		elitePointProgressGroup.SetData(_selectCharacter);
		RefreshThreeStageBoardColor();
		RefreshEliteLevel();
		RefreshSelectPoint(elitePointId, indexOfThreeProgress);
		if (_isPopupDisplayDisc)
		{
			if (!TrySelectNodeByElitePointId(elitePointId, indexOfThreeProgress))
			{
				TrySelectNode(EliteModel.CreatePointNode(0));
			}
		}
		else
		{
			TrySelectNode(EliteModel.CreatePointNode(0));
		}
		RefreshPanelEffect(isUpGrade: false);
		_isItemConversionSelectMode = false;
		_runtimeControllerType = (_isPopupDisplayDisc ? EliteViewSubControllerType.ElitePointUpGarde : EliteViewSubControllerType.Main);
		RefreshGamepadComp();
	}

	private void RefreshSelectPoint(int elitePointId, int indexOfThreeProgress)
	{
		if (_selectCharacter != null)
		{
			elitePointGroup.RefreshSelectedPoint(elitePointId, indexOfThreeProgress);
			eliteProgress.RefreshSelectedPoint(elitePointId, indexOfThreeProgress + 1);
		}
	}

	private void RefreshDiscSelectionAfterSelect(int pointIdForGroup, int indexForGroup, int talentCellIndexForProgress)
	{
		bool gamePadShowPreviousTrail = _gamePadNavTrailActiveForNextRefresh && _gamePadNavPrevValid;
		elitePointGroup.RefreshSelectedPoint(pointIdForGroup, indexForGroup, gamePadShowPreviousTrail, _gamePadNavPrevIsTalent, _gamePadNavPrevId, _gamePadNavPrevSub);
		eliteProgress.RefreshSelectedPoint(pointIdForGroup, talentCellIndexForProgress, gamePadShowPreviousTrail, _gamePadNavPrevIsTalent, _gamePadNavPrevId, _gamePadNavPrevSub);
		_gamePadNavTrailActiveForNextRefresh = false;
	}

	private void CacheGamePadNavigationPrevious(EliteNodeId fromNode)
	{
		_gamePadNavTrailActiveForNextRefresh = false;
		_gamePadNavPrevValid = false;
		if (!fromNode.IsValid || _selectCharacter == null)
		{
			return;
		}
		if (fromNode.NodeType == EliteNodeType.Point)
		{
			if (Model<EliteModel>.Interface.pointsDic.TryGetValue(_selectCharacter.Id, out var value) && fromNode.Index >= 0 && fromNode.Index < value.Count)
			{
				PointData pointData = value[fromNode.Index];
				_gamePadNavPrevValid = true;
				_gamePadNavPrevIsTalent = false;
				_gamePadNavPrevId = pointData.pointId;
				_gamePadNavPrevSub = pointData.indexOfThreeProgress;
				_gamePadNavTrailActiveForNextRefresh = true;
			}
		}
		else
		{
			int[] characterSkill = Model<EliteModel>.Interface.GetEliteTrainingMap(_selectCharacter.Id).characterSkill;
			if (fromNode.Index >= 0 && fromNode.Index < characterSkill.Length)
			{
				_gamePadNavPrevValid = true;
				_gamePadNavPrevIsTalent = true;
				_gamePadNavPrevId = characterSkill[fromNode.Index];
				_gamePadNavPrevSub = fromNode.Index + 1;
				_gamePadNavTrailActiveForNextRefresh = true;
			}
		}
	}

	private void RefreshThreeStageBoardColor()
	{
		_color = Model<EliteModel>.Interface.GetBoardColorByCharacterId(_selectCharacter.Id);
		stage1Image.gameObject.SetActive(_stage >= 1);
		stage2Image.gameObject.SetActive(_stage >= 2);
		stage3Image.gameObject.SetActive(_stage >= 3);
		stage1Image.color = ((_stage >= 1) ? _color : Color.white);
		stage2Image.color = ((_stage >= 2) ? _color : Color.white);
		stage3Image.color = ((_stage >= 3) ? _color : Color.white);
	}

	private void RefreshEliteLevel()
	{
		levelText.SetText("{0:0}", _selectCharacter.GetEliteActiveLevel());
		levelText2.SetText("{0:0}", _selectCharacter.GetEliteActiveLevel());
	}

	public void OnSelectCharacter()
	{
		elitePointGroup.OnSelectCharacter(PrepareGroupData(_selectCharacter, _stage));
		_currentSelectedNode = EliteNodeId.Invalid;
		TrySelectNode(EliteModel.CreatePointNode(0));
	}

	private ElitePointGroupV2.ElitePointGroupDataV2 PrepareGroupData(Character character, int stage)
	{
		if (character == null)
		{
			return null;
		}
		int[] pointList = Model<EliteModel>.Interface.GetEliteTrainingMap(character.Id).pointList;
		return new ElitePointGroupV2.ElitePointGroupDataV2(character, pointList, stage, _imageAssetStation, SelectElitePoint);
	}

	private void SelectElitePoint(int elitePointId, int indexOfThreeProgress)
	{
		if (_selectCharacter != null)
		{
			_selectPointId = elitePointId;
			Model<EliteModel>.Interface.IsTalentPoint = false;
			if (TryGetPointNodeRuntimeIndex(elitePointId, indexOfThreeProgress, out var runtimeIndex))
			{
				_currentSelectedNode = EliteModel.CreatePointNode(runtimeIndex);
			}
			RefreshDiscSelectionAfterSelect(elitePointId, indexOfThreeProgress, indexOfThreeProgress);
			NotifyPopupSelectChanged(elitePointId, isTalent: false, indexOfThreeProgress, indexOfThreeProgress + 1);
			RefreshGamepadComp();
		}
	}

	private void OnSelectTalentPoint(int elitePointId, int indexOfThreeProgress)
	{
		if (_selectCharacter != null)
		{
			_selectPointId = elitePointId;
			Model<EliteModel>.Interface.IsTalentPoint = true;
			int num = Mathf.Clamp(indexOfThreeProgress - 1, 0, 2);
			_currentSelectedNode = EliteModel.CreateTalentNode(num);
			RefreshDiscSelectionAfterSelect(elitePointId, indexOfThreeProgress, indexOfThreeProgress);
			NotifyPopupSelectChanged(elitePointId, isTalent: true, num, indexOfThreeProgress);
			RefreshGamepadComp();
		}
	}

	private void NotifyPopupSelectChanged(int elitePointId, bool isTalent, int indexOfThreeProgress, int pointStageIndex)
	{
		UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_POPUPELITELEVELUPNEW);
		if (firstUIState == UIState.Opening || firstUIState == UIState.Opened)
		{
			EliteSelectPointRefresh evt = Singleton<EventManager>.instance.GetEvt<EliteSelectPointRefresh>();
			evt.elitePointId = elitePointId;
			evt.isTalent = isTalent;
			evt.indexOfThreeProgress = indexOfThreeProgress;
			evt.pointStageIndex = pointStageIndex;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.EliteRefreshSelectPoint, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void SetParticleSystemInVisible()
	{
		_particleSystem.gameObject.SetActive(value: false);
	}

	public void OnRightPanelVisibilityChanged(bool isVisible)
	{
		EnsureScrollViewRuntimeReferences();
		RectTransform effectiveContentRect = GetEffectiveContentRect();
		if (scrollRect == null || _scrollViewRect == null || effectiveContentRect == null)
		{
			return;
		}
		if (!_hasCachedScrollViewExpandedAnchoredPosition)
		{
			_scrollViewExpandedAnchoredPosition = _scrollViewRect.anchoredPosition;
			_hasCachedScrollViewExpandedAnchoredPosition = true;
		}
		if (!_hasCachedContentExpandedAnchoredPosition)
		{
			_contentExpandedAnchoredPosition = effectiveContentRect.anchoredPosition;
			_hasCachedContentExpandedAnchoredPosition = true;
		}
		if (isVisible && !_isRightPanelHiddenLayoutApplied)
		{
			_scrollViewExpandedAnchoredPosition = _scrollViewRect.anchoredPosition;
		}
		if (isVisible)
		{
			if (_isRightPanelHiddenLayoutApplied)
			{
				effectiveContentRect.anchoredPosition = (_hasCachedContentExpandedAnchoredPosition ? _contentExpandedAnchoredPosition : effectiveContentRect.anchoredPosition);
				_scrollViewRect.anchoredPosition = _scrollViewExpandedAnchoredPosition;
			}
			SetScrollInteractionEnabled(enabled: true);
			_isRightPanelHiddenLayoutApplied = false;
		}
		else
		{
			ApplyHiddenModeContentAnchoredPosition();
			_scrollViewRect.anchoredPosition = GetCenteredScrollViewAnchoredPosition();
			SetScrollInteractionEnabled(enabled: false);
			_isRightPanelHiddenLayoutApplied = true;
		}
	}

	public void SetDiscParam(bool isPopupDisplayDisc)
	{
		_isPopupDisplayDisc = isPopupDisplayDisc;
		if (_isPopupDisplayDisc)
		{
			_runtimeControllerType = EliteViewSubControllerType.ElitePointUpGarde;
		}
		else
		{
			_runtimeControllerType = EliteViewSubControllerType.Main;
		}
		if (isActiveAndEnabled)
		{
			RefreshGamepadComp();
		}
	}

	private bool ShouldPlayUpgradeVisual(bool isUpgrade)
	{
		if (!isUpgrade)
		{
			return false;
		}
		if (_isPopupDisplayDisc)
		{
			return true;
		}
		UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_POPUPELITELEVELUPNEW);
		if (firstUIState != UIState.Opening)
		{
			return firstUIState != UIState.Opened;
		}
		return false;
	}

	private void RefreshPanelEffect(bool isUpGrade)
	{
		int element = RuntimeConfigs.data.entityDatas[_selectCharacter.Id].element;
		RefreshStageEffect(1, _firstStageCompleteGO, element, isUpGrade);
		RefreshStageEffect(2, _secondStageCompleteGO, element, isUpGrade);
		RefreshStageEffect(3, _thirdStageCompleteGO, element, isUpGrade);
		RefreshStageEffect(3, _allElitePointMaxLevelGO, element, isUpGrade);
		RefreshStageEffect(3, _allElitePointMaxLevelSweepLightGO, element, isUpGrade);
		RefreshStageEffect(1, _firstStageMaxLevelSweepLightGO, element, isUpGrade);
		RefreshStageEffect(2, _secondStageMaxLevelSweepLightGO, element, isUpGrade);
		RefreshStageEffect(3, _thirdStageMaxLevelSweepLightGO, element, isUpGrade);
		int num = RuntimeConfigs.data.game.eliteStage3AttrNum * RuntimeConfigs.data.game.eliteStage3AttrLevel;
		int eliteActiveLevel = _selectCharacter.GetEliteActiveLevel();
		if (num == eliteActiveLevel)
		{
			SetEffectActiveByElement(_firstStageCompleteGO, element, isActive: true);
			SetEffectActiveByElement(_secondStageCompleteGO, element, isActive: true);
			SetEffectActiveByElement(_thirdStageCompleteGO, element, isActive: true);
			SetEffectActiveByElement(_allElitePointMaxLevelGO, element, isActive: true);
		}
	}

	public void RefreshStageEffect(int stageId, List<GameObject> listGo, int element, bool isUpgrade)
	{
		int num = RuntimeConfigs.data.game.eliteStage3AttrNum * RuntimeConfigs.data.game.eliteStage3AttrLevel;
		int eliteActiveLevel = _selectCharacter.GetEliteActiveLevel();
		bool flag = num == eliteActiveLevel;
		if (listGo != null && listGo.Count > 0)
		{
			for (int i = 0; i < listGo.Count; i++)
			{
				listGo[i].SetActive(value: false);
				if (i == element - 1)
				{
					listGo[i].SetActive(flag);
				}
			}
		}
		if (((stageId != 1 || _firstStageMaxLevelSweepLightGO != listGo) && (stageId != 2 || _secondStageMaxLevelSweepLightGO != listGo) && (stageId != 3 || _thirdStageMaxLevelSweepLightGO != listGo) && (stageId != 3 || _allElitePointMaxLevelSweepLightGO != listGo) && (stageId != 3 || _allElitePointMaxLevelGO != listGo)) || listGo == null || listGo.Count <= 0)
		{
			return;
		}
		for (int j = 0; j < listGo.Count; j++)
		{
			listGo[j].SetActive(value: false);
			if (j == element - 1)
			{
				listGo[j].SetActive(isUpgrade & flag);
			}
		}
	}

	private void SetEffectActiveByElement(List<GameObject> listGo, int element, bool isActive)
	{
		if (listGo != null && listGo.Count > 0)
		{
			for (int i = 0; i < listGo.Count; i++)
			{
				listGo[i].SetActive(isActive && i == element - 1);
			}
		}
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		RefreshGamepadComp();
		ResyncDiscSelectionHighlightsWithoutTrail();
	}

	private void ResyncDiscSelectionHighlightsWithoutTrail()
	{
		if (_selectCharacter == null || !_currentSelectedNode.IsValid)
		{
			return;
		}
		if (_currentSelectedNode.NodeType == EliteNodeType.Point)
		{
			if (Model<EliteModel>.Interface.pointsDic.TryGetValue(_selectCharacter.Id, out var value) && _currentSelectedNode.Index >= 0 && _currentSelectedNode.Index < value.Count)
			{
				PointData pointData = value[_currentSelectedNode.Index];
				elitePointGroup.RefreshSelectedPoint(pointData.pointId, pointData.indexOfThreeProgress);
				eliteProgress.RefreshSelectedPoint(pointData.pointId, pointData.indexOfThreeProgress);
			}
			return;
		}
		int[] characterSkill = Model<EliteModel>.Interface.GetEliteTrainingMap(_selectCharacter.Id).characterSkill;
		if (_currentSelectedNode.Index >= 0 && _currentSelectedNode.Index < characterSkill.Length)
		{
			int pointId = characterSkill[_currentSelectedNode.Index];
			int num = _currentSelectedNode.Index + 1;
			elitePointGroup.RefreshSelectedPoint(pointId, num);
			eliteProgress.RefreshSelectedPoint(pointId, num);
			RefreshGamepadComp();
		}
	}

	public void RefreshCurrentSelectionVisual()
	{
		ResyncDiscSelectionHighlightsWithoutTrail();
	}

	private void EnsureScrollViewRuntimeReferences()
	{
		if (!(scrollRect == null))
		{
			if (_scrollViewRect == null)
			{
				_scrollViewRect = scrollRect.transform as RectTransform;
			}
			if (_rightStickScrollSupport == null)
			{
				_rightStickScrollSupport = scrollRect.GetComponent<RightStickScrollSupport>();
			}
		}
	}

	private Vector2 GetCenteredScrollViewAnchoredPosition()
	{
		RectTransform rectTransform = _scrollViewRect.parent as RectTransform;
		if (rectTransform == null)
		{
			return _scrollViewRect.anchoredPosition;
		}
		RectTransform effectiveContentRect = GetEffectiveContentRect();
		if (effectiveContentRect == null)
		{
			return _scrollViewRect.anchoredPosition;
		}
		Vector3 position = effectiveContentRect.TransformPoint(effectiveContentRect.rect.center);
		Vector2 vector = rectTransform.InverseTransformPoint(position);
		Vector2 anchoredPosition = _scrollViewRect.anchoredPosition;
		anchoredPosition.x += rectTransform.rect.center.x - vector.x;
		return anchoredPosition;
	}

	private void ApplyHiddenModeContentAnchoredPosition()
	{
		RectTransform effectiveContentRect = GetEffectiveContentRect();
		if (!(effectiveContentRect == null))
		{
			Vector2 anchoredPosition = effectiveContentRect.anchoredPosition;
			anchoredPosition.x = Mathf.Clamp(hiddenModeContentPosX, minX, maxX);
			effectiveContentRect.anchoredPosition = anchoredPosition;
		}
	}

	private RectTransform GetEffectiveContentRect()
	{
		if (!(contentRT != null))
		{
			if (!(scrollRect != null))
			{
				return null;
			}
			return scrollRect.content;
		}
		return contentRT;
	}

	private void SetScrollInteractionEnabled(bool enabled)
	{
		if (scrollRect != null)
		{
			scrollRect.StopMovement();
			scrollRect.velocity = Vector2.zero;
			scrollRect.enabled = enabled;
		}
		if (!(_rightStickScrollSupport == null))
		{
			if (enabled)
			{
				_rightStickScrollSupport.SetForbidScroll(isForbid: false);
				_rightStickScrollSupport.SetEnabled(enabled: true);
			}
			else
			{
				_rightStickScrollSupport.SetForbidScroll(isForbid: true);
				_rightStickScrollSupport.SetEnabled(enabled: false);
				_rightStickScrollSupport.ResetSmallContentOffset();
			}
		}
	}

	private static bool IsUIOpened(UI_TYPE uiType)
	{
		UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(uiType);
		if (firstUIState != UIState.Opening)
		{
			return firstUIState == UIState.Opened;
		}
		return true;
	}

	private EliteViewSubControllerType ResolveControllerType(EliteViewSubControllerType fallback)
	{
		EliteViewSubControllerType eliteViewSubControllerType;
		if (IsUIOpened(UI_TYPE.UI_POPUPELITEBREAK))
		{
			eliteViewSubControllerType = EliteViewSubControllerType.EliteBreak;
		}
		else if (IsUIOpened(UI_TYPE.UI_POPUPELITEBACKPOINT))
		{
			eliteViewSubControllerType = EliteViewSubControllerType.EliteBack;
		}
		else if (IsUIOpened(UI_TYPE.UI_POPUPELITERESET))
		{
			eliteViewSubControllerType = EliteViewSubControllerType.ElitePointReset;
		}
		else if (IsUIOpened(UI_TYPE.UI_ELITEOVERVIEW))
		{
			eliteViewSubControllerType = EliteViewSubControllerType.EliteEffectOverview;
		}
		else if (IsUIOpened(UI_TYPE.UI_POPUPELITELEVELUP))
		{
			eliteViewSubControllerType = (_isItemConversionSelectMode ? EliteViewSubControllerType.ItemConversionSelectItem : EliteViewSubControllerType.ItemConversion);
		}
		else if (IsUIOpened(UI_TYPE.UI_POPUPELITELEVELUPNEW))
		{
			eliteViewSubControllerType = fallback switch
			{
				EliteViewSubControllerType.SelectReinforcedMaterial => EliteViewSubControllerType.SelectReinforcedMaterial, 
				EliteViewSubControllerType.SelectEliteCurrency => EliteViewSubControllerType.SelectEliteCurrency, 
				_ => EliteViewSubControllerType.ElitePointUpGarde, 
			};
		}
		else
		{
			eliteViewSubControllerType = EliteViewSubControllerType.Main;
			_isItemConversionSelectMode = false;
		}
		if (_runtimeControllerType != eliteViewSubControllerType)
		{
			_runtimeControllerType = eliteViewSubControllerType;
			RefreshGamepadComp();
		}
		return _runtimeControllerType;
	}

	public EliteViewSubControllerType GetControllerType(EliteViewSubControllerType fallback)
	{
		return ResolveControllerType(fallback);
	}

	private void InitGameTipsDic()
	{
		actionDic.Clear();
		actionDic.Add("LargeMapView/Select", new GamePadTipsAction
		{
			inputAction = "LargeMapView/Select",
			localizeKey = 774,
			localizeTable = "Common"
		});
		actionDic.Add("LargeMapView/Return", new GamePadTipsAction
		{
			inputAction = "LargeMapView/Return",
			localizeKey = 606,
			localizeTable = "Common"
		});
		actionDic.Add("UI/View", new GamePadTipsAction
		{
			inputAction = "UI/View",
			localizeKey = 2596,
			localizeTable = "Common"
		});
		actionDic.Add("LargeMapView/MapTemple", new GamePadTipsAction
		{
			inputAction = "LargeMapView/MapTemple",
			localizeKey = 2597,
			localizeTable = "Common"
		});
		actionDic.Add("UI/LongPressX", new GamePadTipsAction
		{
			inputAction = "UI/LongPressX",
			bindingAction = "UI/LongPressX",
			needLongPress = true,
			localizeKey = 1147,
			localizeTable = "Common"
		});
		actionDic.Add("UI/SwitchInteractGamePadX", new GamePadTipsAction
		{
			inputAction = "UI/SwitchInteractGamePadX",
			localizeKey = 2165,
			localizeTable = "Common"
		});
	}

	private void AddTip(string actionKey)
	{
		if (actionDic.TryGetValue(actionKey, out var value))
		{
			_tipsActions.Add(value);
		}
	}

	private void RefreshGamepadComp()
	{
		if (!_isPopupDisplayDisc || gamePadTipsComp == null)
		{
			return;
		}
		gamePadTipsComp.ClearAllPrompts();
		if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			return;
		}
		if (actionDic.Count == 0)
		{
			InitGameTipsDic();
		}
		_tipsActions.Clear();
		switch (_runtimeControllerType)
		{
		case EliteViewSubControllerType.Main:
			AddTip("LargeMapView/Select");
			AddTip("LargeMapView/Return");
			AddTip("UI/View");
			break;
		case EliteViewSubControllerType.ElitePointUpGarde:
			AddTip("LargeMapView/Return");
			if (!IsSelectedTrialCharacter && CanShowElitePointBacktrackTip())
			{
				AddTip("LargeMapView/MapTemple");
			}
			if (!IsSelectedTrialCharacter && CanShowElitePointResetTip())
			{
				AddTip("UI/LongPressX");
			}
			AddTip("UI/SwitchInteractGamePadX");
			AddTip("UI/View");
			break;
		}
		gamePadTipsComp.RegisterInputActions(_tipsActions);
	}

	private bool CanShowElitePointResetTip()
	{
		if (_selectCharacter != null)
		{
			return _selectCharacter.GetEliteActiveLevel() > 0;
		}
		return false;
	}

	private bool CanShowElitePointBacktrackTip()
	{
		if (_selectCharacter == null || !_currentSelectedNode.IsValid || _currentSelectedNode.NodeType != EliteNodeType.Point)
		{
			return false;
		}
		if (!Model<EliteModel>.Interface.pointsDic.TryGetValue(_selectCharacter.Id, out var value) || _currentSelectedNode.Index < 0 || _currentSelectedNode.Index >= value.Count)
		{
			return false;
		}
		PointData pointData = value[_currentSelectedNode.Index];
		if (pointData.indexOfThreeProgress + 1 <= _stage)
		{
			return _selectCharacter.GetElitePointLevel(pointData.pointId) > 0;
		}
		return false;
	}

	private static void TrySubmitCurrentSelection()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	private static void MoveSelection(MoveDirection moveDirection)
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			AxisEventData eventData = new AxisEventData(EventSystemHelper.Shared)
			{
				moveDir = moveDirection
			};
			ExecuteEvents.Execute(currentSelected, eventData, ExecuteEvents.moveHandler);
		}
	}

	private void OpenOverview()
	{
		if (_selectCharacter != null && !IsUIOpened(UI_TYPE.UI_ELITEOVERVIEW))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ELITEOVERVIEW, new EliteOverviewViewData
			{
				_character = _selectCharacter
			});
		}
	}

	private bool CloseByControllerType(EliteViewSubControllerType controllerType)
	{
		switch (controllerType)
		{
		case EliteViewSubControllerType.EliteEffectOverview:
			_suppressNextMainReturn = true;
			Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_ELITEOVERVIEW);
			return true;
		case EliteViewSubControllerType.ItemConversion:
		case EliteViewSubControllerType.ItemConversionSelectItem:
			_suppressNextMainReturn = true;
			_isItemConversionSelectMode = false;
			Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_POPUPELITELEVELUP);
			return true;
		case EliteViewSubControllerType.SelectReinforcedMaterial:
		case EliteViewSubControllerType.ElitePointUpGarde:
			_suppressNextMainReturn = true;
			DispatchCharacterViewCanvasGroupVisible();
			Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_POPUPELITELEVELUPNEW);
			return true;
		case EliteViewSubControllerType.ElitePointReset:
			_suppressNextMainReturn = true;
			Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_POPUPELITERESET);
			return true;
		case EliteViewSubControllerType.EliteBack:
			_suppressNextMainReturn = true;
			Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_POPUPELITEBACKPOINT);
			return true;
		default:
			if (IsUIOpened(UI_TYPE.UI_POPUPELITELEVELUPNEW))
			{
				DispatchCharacterViewCanvasGroupVisible();
				Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_POPUPELITELEVELUPNEW);
				return true;
			}
			if (GetComponentInParent<CvEliteNew>()?.Context is CharacterView characterView)
			{
				characterView.Close();
				return true;
			}
			return false;
		}
	}

	private static void DispatchCharacterViewCanvasGroupVisible()
	{
		CharacterViewCanvasGroupRefreshEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterViewCanvasGroupRefreshEvt>();
		evt.alphaValue = 1f;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.SetCharacterViewCanvasGroup, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void HandleGamePadSelectAButtonInput(EliteViewSubControllerType controllerType)
	{
		controllerType = ResolveControllerType(controllerType);
		switch (controllerType)
		{
		case EliteViewSubControllerType.Main:
		case EliteViewSubControllerType.ElitePointUpGarde:
			if (!TryOpenCurrentEliteNodePopup())
			{
				TrySubmitCurrentSelection();
			}
			break;
		case EliteViewSubControllerType.SelectReinforcedMaterial:
		case EliteViewSubControllerType.ItemConversion:
		case EliteViewSubControllerType.ItemConversionSelectItem:
		case EliteViewSubControllerType.ElitePointReset:
		case EliteViewSubControllerType.EliteBack:
			TrySubmitCurrentSelection();
			break;
		case EliteViewSubControllerType.EliteEffectOverview:
			break;
		}
	}

	public void HandleGamePadSelectBButtonInput(EliteViewSubControllerType controllerType)
	{
		controllerType = ResolveControllerType(controllerType);
		HandleGamePadReturnButtonInput(controllerType);
	}

	public void HandleGamePadReturnButtonInput(EliteViewSubControllerType controllerType)
	{
		controllerType = ResolveControllerType(controllerType);
		if (controllerType == EliteViewSubControllerType.Main && _suppressNextMainReturn)
		{
			_suppressNextMainReturn = false;
			return;
		}
		if (controllerType != EliteViewSubControllerType.Main)
		{
			_suppressNextMainReturn = false;
		}
		CloseByControllerType(controllerType);
		ResolveControllerType(controllerType);
	}

	public void HandleGamePadSelectViewBtnInput(EliteViewSubControllerType controllerType)
	{
		controllerType = ResolveControllerType(controllerType);
		if (controllerType == EliteViewSubControllerType.Main || controllerType == EliteViewSubControllerType.ElitePointUpGarde)
		{
			OpenOverview();
			ResolveControllerType(controllerType);
		}
	}

	public void HandleGamePadSelectXBtnInput(EliteViewSubControllerType controllerType)
	{
		controllerType = ResolveControllerType(controllerType);
		if (controllerType == EliteViewSubControllerType.ElitePointUpGarde || controllerType == EliteViewSubControllerType.ItemConversion)
		{
			TrySubmitCurrentSelection();
		}
	}

	public void HandleGamePadSelectRightStickXBtnInput(EliteViewSubControllerType controllerType)
	{
		controllerType = ResolveControllerType(controllerType);
		if (controllerType == EliteViewSubControllerType.ElitePointUpGarde || controllerType == EliteViewSubControllerType.EliteEffectOverview)
		{
			MoveSelection(_moveHorizontalForward ? MoveDirection.Right : MoveDirection.Left);
			_moveHorizontalForward = !_moveHorizontalForward;
		}
	}

	public void HandleGamePadSelectRightStickYBtnInput(EliteViewSubControllerType controllerType)
	{
		controllerType = ResolveControllerType(controllerType);
		_ = 5;
	}

	public void HandleGamePadSelectYBtnInput(EliteViewSubControllerType controllerType)
	{
		controllerType = ResolveControllerType(controllerType);
		if (controllerType == EliteViewSubControllerType.ElitePointUpGarde || controllerType == EliteViewSubControllerType.SelectReinforcedMaterial)
		{
			TrySubmitCurrentSelection();
		}
	}

	public void HandleGamePadSelectLeftStickXBtnInput(EliteViewSubControllerType controllerType)
	{
		HandleGamePadSelectLeftStickXBtnInput(controllerType, 1f);
	}

	public void HandleGamePadSelectLeftStickXBtnInput(EliteViewSubControllerType controllerType, float value)
	{
		controllerType = ResolveControllerType(controllerType);
		switch (controllerType)
		{
		case EliteViewSubControllerType.Main:
		case EliteViewSubControllerType.ElitePointUpGarde:
			NavigateEliteNodeByDirection((value > 0f) ? EliteNodeMoveDirection.Right : EliteNodeMoveDirection.Left);
			break;
		case EliteViewSubControllerType.ItemConversion:
		case EliteViewSubControllerType.ItemConversionSelectItem:
		case EliteViewSubControllerType.ElitePointReset:
		case EliteViewSubControllerType.EliteBack:
			MoveSelection(_moveHorizontalForward ? MoveDirection.Right : MoveDirection.Left);
			_moveHorizontalForward = !_moveHorizontalForward;
			break;
		}
	}

	public void HandleGamePadSelectLeftStickYBtnInput(EliteViewSubControllerType controllerType)
	{
		HandleGamePadSelectLeftStickYBtnInput(controllerType, 1f);
	}

	public void HandleGamePadSelectLeftStickYBtnInput(EliteViewSubControllerType controllerType, float value)
	{
		controllerType = ResolveControllerType(controllerType);
		switch (controllerType)
		{
		case EliteViewSubControllerType.Main:
		case EliteViewSubControllerType.ElitePointUpGarde:
			NavigateEliteNodeByDirection(ResolveYAxisDirection(value));
			break;
		case EliteViewSubControllerType.SelectReinforcedMaterial:
		case EliteViewSubControllerType.ItemConversionSelectItem:
			MoveSelection((!_moveVerticalForward) ? MoveDirection.Up : MoveDirection.Down);
			_moveVerticalForward = !_moveVerticalForward;
			break;
		}
	}

	public void HandleGamePadLeftStickClickBtnInput(EliteViewSubControllerType controllerType)
	{
		controllerType = ResolveControllerType(controllerType);
		switch (controllerType)
		{
		case EliteViewSubControllerType.ElitePointUpGarde:
			_runtimeControllerType = EliteViewSubControllerType.SelectReinforcedMaterial;
			RefreshGamepadComp();
			break;
		case EliteViewSubControllerType.SelectReinforcedMaterial:
			_runtimeControllerType = EliteViewSubControllerType.ElitePointUpGarde;
			RefreshGamepadComp();
			break;
		case EliteViewSubControllerType.ItemConversion:
			_isItemConversionSelectMode = true;
			_runtimeControllerType = EliteViewSubControllerType.ItemConversionSelectItem;
			RefreshGamepadComp();
			break;
		case EliteViewSubControllerType.ItemConversionSelectItem:
			_isItemConversionSelectMode = false;
			_runtimeControllerType = EliteViewSubControllerType.ItemConversion;
			RefreshGamepadComp();
			break;
		case EliteViewSubControllerType.ElitePointReset:
		case EliteViewSubControllerType.EliteBack:
			TrySubmitCurrentSelection();
			break;
		case EliteViewSubControllerType.Main:
		case EliteViewSubControllerType.EliteEffectOverview:
			break;
		}
	}

	private void NavigateEliteNodeByDirection(EliteNodeMoveDirection direction)
	{
		if (_selectCharacter != null && !(Time.unscaledTime < _eliteNavigateCooldownUntilUnscaled) && (_currentSelectedNode.IsValid || TrySelectNode(EliteModel.CreatePointNode(0))))
		{
			EliteNodeId currentSelectedNode = _currentSelectedNode;
			if (Model<EliteModel>.Interface.TryGetMoveTarget(_currentSelectedNode, direction, out var targetNode))
			{
				CacheGamePadNavigationPrevious(currentSelectedNode);
				TrySelectNode(targetNode);
				_eliteNavigateCooldownUntilUnscaled = Time.unscaledTime + 0.22f;
			}
		}
	}

	private bool TrySelectNode(EliteNodeId nodeId)
	{
		if (_selectCharacter == null || !nodeId.IsValid)
		{
			_gamePadNavTrailActiveForNextRefresh = false;
			return false;
		}
		if (nodeId.NodeType == EliteNodeType.Point)
		{
			if (!Model<EliteModel>.Interface.pointsDic.TryGetValue(_selectCharacter.Id, out var value))
			{
				_gamePadNavTrailActiveForNextRefresh = false;
				return false;
			}
			if (nodeId.Index < 0 || nodeId.Index >= value.Count)
			{
				_gamePadNavTrailActiveForNextRefresh = false;
				return false;
			}
			PointData pointData = value[nodeId.Index];
			SelectElitePoint(pointData.pointId, pointData.indexOfThreeProgress);
			return true;
		}
		int[] characterSkill = Model<EliteModel>.Interface.GetEliteTrainingMap(_selectCharacter.Id).characterSkill;
		if (nodeId.Index < 0 || nodeId.Index >= characterSkill.Length)
		{
			_gamePadNavTrailActiveForNextRefresh = false;
			return false;
		}
		OnSelectTalentPoint(characterSkill[nodeId.Index], nodeId.Index + 1);
		return true;
	}

	private bool TrySelectNodeByElitePointId(int elitePointId, int indexOfThreeProgress)
	{
		if (_selectCharacter == null || elitePointId <= 0)
		{
			return false;
		}
		int[] characterSkill = Model<EliteModel>.Interface.GetEliteTrainingMap(_selectCharacter.Id).characterSkill;
		for (int i = 0; i < characterSkill.Length; i++)
		{
			if (characterSkill[i] == elitePointId)
			{
				return TrySelectNode(EliteModel.CreateTalentNode(i));
			}
		}
		if (!TryGetPointNodeRuntimeIndex(elitePointId, indexOfThreeProgress, out var runtimeIndex))
		{
			return false;
		}
		return TrySelectNode(EliteModel.CreatePointNode(runtimeIndex));
	}

	private bool TryGetPointNodeRuntimeIndex(int elitePointId, int indexOfThreeProgress, out int runtimeIndex)
	{
		runtimeIndex = -1;
		if (_selectCharacter == null)
		{
			return false;
		}
		if (!Model<EliteModel>.Interface.pointsDic.TryGetValue(_selectCharacter.Id, out var value) || value == null)
		{
			return false;
		}
		for (int i = 0; i < value.Count; i++)
		{
			PointData pointData = value[i];
			if (pointData.pointId == elitePointId && pointData.indexOfThreeProgress == indexOfThreeProgress)
			{
				runtimeIndex = i;
				return true;
			}
		}
		return false;
	}

	private bool TryOpenCurrentEliteNodePopup()
	{
		if (_selectCharacter == null)
		{
			return false;
		}
		if (!_currentSelectedNode.IsValid && !TrySelectNode(EliteModel.CreatePointNode(0)))
		{
			return false;
		}
		UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_POPUPELITELEVELUPNEW);
		if (_currentSelectedNode.NodeType == EliteNodeType.Point)
		{
			if (!Model<EliteModel>.Interface.pointsDic.TryGetValue(_selectCharacter.Id, out var value))
			{
				return false;
			}
			if (_currentSelectedNode.Index < 0 || _currentSelectedNode.Index >= value.Count)
			{
				return false;
			}
			PointData pointData = value[_currentSelectedNode.Index];
			Model<EliteModel>.Interface.IsTalentPoint = false;
			if (firstUIState != UIState.Opened)
			{
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPELITELEVELUPNEW, new PopupEliteLevelUpNewViewData
				{
					elitePointId = pointData.pointId,
					character = _selectCharacter,
					isTalentPoint = false,
					indexOfThreeProgress = pointData.indexOfThreeProgress,
					pointStageIndex = pointData.stageId
				});
				CharacterViewCanvasGroupRefreshEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterViewCanvasGroupRefreshEvt>();
				evt.alphaValue = 0f;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.SetCharacterViewCanvasGroup, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
			else
			{
				NotifyPopupSelectChanged(pointData.pointId, isTalent: false, pointData.indexOfThreeProgress, pointData.stageId);
			}
			return true;
		}
		int[] characterSkill = Model<EliteModel>.Interface.GetEliteTrainingMap(_selectCharacter.Id).characterSkill;
		if (_currentSelectedNode.Index < 0 || _currentSelectedNode.Index >= characterSkill.Length)
		{
			return false;
		}
		int index = _currentSelectedNode.Index;
		int elitePointId = characterSkill[index];
		Model<EliteModel>.Interface.IsTalentPoint = true;
		if (firstUIState != UIState.Opened)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPELITELEVELUPNEW, new PopupEliteLevelUpNewViewData
			{
				character = _selectCharacter,
				elitePointId = elitePointId,
				isTalentPoint = true,
				indexOfThreeProgress = index,
				pointStageIndex = index + 1
			});
			CharacterViewCanvasGroupRefreshEvt evt2 = Singleton<EventManager>.instance.GetEvt<CharacterViewCanvasGroupRefreshEvt>();
			evt2.alphaValue = 0f;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SetCharacterViewCanvasGroup, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
		}
		else
		{
			NotifyPopupSelectChanged(elitePointId, isTalent: true, index, index + 1);
		}
		return true;
	}

	public EliteNodeMoveDirection ResolveYAxisDirection(float value)
	{
		if (!(value > 0f))
		{
			return EliteNodeMoveDirection.Down;
		}
		return EliteNodeMoveDirection.Up;
	}
}
