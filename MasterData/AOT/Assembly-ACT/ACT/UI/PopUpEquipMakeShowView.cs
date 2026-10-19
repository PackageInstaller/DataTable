using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.UI.ViewComponent.EquipBuildView;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Model.PowerModel;
using Runtime.UI.CommonComponent;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using ThirdParties.LoopScrollTools.Runtime;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class PopUpEquipMakeShowView : BaseUIView<PopUpEquipMakeShowViewInputController>
{
	private sealed class EquipChapterLoopSizeHelper : LoopScrollSizeHelper
	{
		private readonly List<float> m_PrefixHeights;

		public EquipChapterLoopSizeHelper(List<float> prefixHeights)
		{
			m_PrefixHeights = prefixHeights;
		}

		public Vector2 GetItemsSize(int itemsCount)
		{
			if (m_PrefixHeights == null || m_PrefixHeights.Count == 0 || itemsCount <= 0)
			{
				return Vector2.zero;
			}
			int num = m_PrefixHeights.Count - 1;
			if (itemsCount > num)
			{
				itemsCount = num;
			}
			return new Vector2(0f, m_PrefixHeights[itemsCount]);
		}
	}

	private PopUpEquipMakeShowViewData m_data;

	[Header("左侧")]
	[SerializeField]
	private LoopVerticalScrollRect m_AreaLoopVerticalScrollView;

	public GameObject equipScrollViewRoot;

	[SerializeField]
	private LoopVerticalScrollRect m_EquipLoopVerticalScrollView;

	public ActButton filterBtn;

	public LocalizeStringEvent filterText;

	public EquipBuildFilterPanel filterPanel;

	public GameObject equipBagEmptyState;

	[Header("中间")]
	[SerializeField]
	private EquipItem m_EquipItem;

	[Header("右侧")]
	public GameObject equipInfoEmptyState;

	public GameObject equipInfoRoot;

	[SerializeField]
	private AnimateToggle m_MaxLevelToggle;

	[SerializeField]
	private LocalizeStringEvent m_EquipName;

	[Space]
	[SerializeField]
	private BImage m_EquipTypeIcon;

	[SerializeField]
	private LocalizeStringEvent m_EquipTypeName;

	[SerializeField]
	private CommonNumberComponent m_EquipLevel;

	[SerializeField]
	private GameObject m_EquipExtraLevelRoot;

	[SerializeField]
	private TMP_Text m_EquipExtraLevel;

	[Space]
	[SerializeField]
	private LocalizeStringEvent m_MainPropertyName;

	[SerializeField]
	private TMP_Text m_MainPropertyNumber;

	[SerializeField]
	private BImage m_MainPropertyIcon;

	[SerializeField]
	private LocalizeStringEvent m_RandomProperty1Name;

	[SerializeField]
	private LocalizeStringEvent m_RandomProperty2Name;

	[Space]
	[SerializeField]
	private EquipBuffDetail m_EquipBuffDetail;

	[Space]
	[SerializeField]
	private CommonScrollBagComponent m_SpendMaterialComponent;

	[SerializeField]
	private CommonCoinComponent m_SpendCoinComponent;

	[Space]
	[SerializeField]
	private LocalizeStringEvent m_ConfirmBtnText;

	[SerializeField]
	private ActButton m_ConfirmBtn;

	[SerializeField]
	private ScrollRect m_FeatureOverviewScrollRect;

	[SerializeField]
	private RightStickScrollSupport m_RightStickScrollSupport;

	public GamePadTipsComp gamePadGroup;

	[SerializeField]
	private List<GameObject> m_CostFocusObjectsEquip;

	[SerializeField]
	private List<GameObject> m_CostFocusObjectsCoin;

	[SerializeField]
	private List<GameObject> m_CostFocusObjectsMaterial;

	[SerializeField]
	private List<GameObject> m_FilterFocusObjectsMaterial;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	private EquipData m_EquipItemData;

	private int m_CurrentChosenEquipId;

	private List<KeyValuePair<int, List<EquipSuitData>>> m_EquipSuits;

	private List<KeyValuePair<int, bool>> m_ChapterTypeList;

	private List<float> m_ChapterItemHeightPrefix;

	private EquipChapterLoopSizeHelper m_EquipChapterSizeHelper;

	private List<ItemUnifierProxy> m_CostMaterialList;

	private Dictionary<int, Equip> m_EquipData;

	private HashSet<int> m_RecipeKeyItemIds;

	private bool m_IsMaxPreview;

	private bool m_DisableListenReachTop;

	private bool m_canRightStickScroll = true;

	private bool m_CanBuildEquip;

	private bool m_CanExchangeMaterial;

	private bool m_BuildActionDisabledByView;

	public ViewControlLayer layerEquip;

	public ViewControlLayer layerCoin;

	public ViewControlLayer layerMaterial;

	public ViewControlLayer layerFilter;

	public ViewControlRoot root;

	private ContinuousNavigateData curNavigateState;

	public EquipBuffDetail equipBuffDetail;

	public ViewControlLayer layerChapter;

	public ViewControlRoot rootChapter;

	public int LastChosenEquipId { get; private set; }

	public int CurrentChosenEquipId
	{
		get
		{
			return m_CurrentChosenEquipId;
		}
		set
		{
			if (m_CurrentChosenEquipId != value)
			{
				LastChosenEquipId = m_CurrentChosenEquipId;
				m_CurrentChosenEquipId = value;
				m_EquipItemData = CoreUtils.GetData(CurrentChosenEquipId, RuntimeConfigs.data.equipDatas);
				OnChosenEquipChanged?.Invoke();
			}
		}
	}

	public int MaxLevel
	{
		get
		{
			if (m_EquipItemData == null)
			{
				return 0;
			}
			ItemData data = CoreUtils.GetData(m_EquipItemData.id, RuntimeConfigs.data.itemDatas);
			if (data == null)
			{
				return 0;
			}
			return RuntimeConfigs.data.game.equipRareLevel[data.quality - 1];
		}
	}

	public int CurrentLevel
	{
		get
		{
			if (!m_IsMaxPreview)
			{
				return 0;
			}
			return MaxLevel;
		}
	}

	public Action OnChosenEquipChanged { get; set; }

	public PopUpEquipMakeCostNavigateState CostNavigateState { get; private set; }

	public bool IsCostCoinOrMaterialFocus
	{
		get
		{
			if (CostNavigateState != PopUpEquipMakeCostNavigateState.Coin)
			{
				return CostNavigateState == PopUpEquipMakeCostNavigateState.Material;
			}
			return true;
		}
	}

	public bool IsFilterFocus => CostNavigateState == PopUpEquipMakeCostNavigateState.Filter;

	public bool IsNonEquipNavigateFocus => CostNavigateState != PopUpEquipMakeCostNavigateState.Equip;

	private void Awake()
	{
		m_EquipSuits = ListPool<KeyValuePair<int, List<EquipSuitData>>>.Get();
		m_ChapterTypeList = ListPool<KeyValuePair<int, bool>>.Get();
		m_ChapterItemHeightPrefix = ListPool<float>.Get();
		m_EquipChapterSizeHelper = new EquipChapterLoopSizeHelper(m_ChapterItemHeightPrefix);
		if (m_EquipLoopVerticalScrollView != null)
		{
			m_EquipLoopVerticalScrollView.sizeHelper = m_EquipChapterSizeHelper;
		}
		m_CostMaterialList = ListPool<ItemUnifierProxy>.Get();
		m_EquipData = DictionaryPool<int, Equip>.Get();
		OnChosenEquipChanged = (Action)Delegate.Combine(OnChosenEquipChanged, new Action(UpdateEquipItem));
		OnChosenEquipChanged = (Action)Delegate.Combine(OnChosenEquipChanged, new Action(UpdateTitle));
		OnChosenEquipChanged = (Action)Delegate.Combine(OnChosenEquipChanged, new Action(UpdateLevel));
		OnChosenEquipChanged = (Action)Delegate.Combine(OnChosenEquipChanged, new Action(UpdateMainPropertyInfo));
		OnChosenEquipChanged = (Action)Delegate.Combine(OnChosenEquipChanged, new Action(UpdateCostInfo));
		OnChosenEquipChanged = (Action)Delegate.Combine(OnChosenEquipChanged, new Action(UpdateBuffDetail));
		m_ConfirmBtn.OnClick.AddListener(BuildEquip);
		m_MaxLevelToggle.onValueChanged.AddListener(OnMaxPreviewSwitch);
		m_SpendMaterialComponent.OnItemSelect = (ItemUIComponentBase _) =>
		{
			SetCostNavigateState(PopUpEquipMakeCostNavigateState.Material);
			if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
			{
				CostNavigateState = PopUpEquipMakeCostNavigateState.Equip;
				layerEquip.ReFocus();
			}
		};
		filterBtn.SetBtnClick(OpenFilterPanel);
		if (filterPanel != null)
		{
			filterPanel.OnConfirm = DoFilter;
			filterPanel.OnClosed = OnFilterPanelClosed;
		}
	}

	private void OnDestroy()
	{
		foreach (KeyValuePair<int, List<EquipSuitData>> equipSuit in m_EquipSuits)
		{
			ListPool<EquipSuitData>.Release(equipSuit.Value);
		}
		m_EquipSuits.Clear();
		ListPool<KeyValuePair<int, List<EquipSuitData>>>.Release(m_EquipSuits);
		m_EquipSuits = null;
		m_ChapterTypeList.Clear();
		ListPool<KeyValuePair<int, bool>>.Release(m_ChapterTypeList);
		m_ChapterTypeList = null;
		if (m_EquipLoopVerticalScrollView != null)
		{
			m_EquipLoopVerticalScrollView.sizeHelper = null;
		}
		m_EquipChapterSizeHelper = null;
		if (m_ChapterItemHeightPrefix != null)
		{
			m_ChapterItemHeightPrefix.Clear();
			ListPool<float>.Release(m_ChapterItemHeightPrefix);
			m_ChapterItemHeightPrefix = null;
		}
		ItemUnifierProxy.ItemUnifierPool.Release(m_CostMaterialList);
		ListPool<ItemUnifierProxy>.Release(m_CostMaterialList);
		m_CostMaterialList = null;
		m_EquipData.Clear();
		DictionaryPool<int, Equip>.Release(m_EquipData);
		m_EquipData = null;
		m_RecipeKeyItemIds = null;
		OnChosenEquipChanged = (Action)Delegate.Remove(OnChosenEquipChanged, new Action(UpdateEquipItem));
		OnChosenEquipChanged = (Action)Delegate.Remove(OnChosenEquipChanged, new Action(UpdateTitle));
		OnChosenEquipChanged = (Action)Delegate.Remove(OnChosenEquipChanged, new Action(UpdateLevel));
		OnChosenEquipChanged = (Action)Delegate.Remove(OnChosenEquipChanged, new Action(UpdateMainPropertyInfo));
		OnChosenEquipChanged = (Action)Delegate.Remove(OnChosenEquipChanged, new Action(UpdateCostInfo));
		OnChosenEquipChanged = (Action)Delegate.Remove(OnChosenEquipChanged, new Action(UpdateBuffDetail));
		m_ConfirmBtn.OnClick.RemoveListener(BuildEquip);
		m_MaxLevelToggle.onValueChanged.RemoveListener(OnMaxPreviewSwitch);
		if (filterPanel != null)
		{
			filterPanel.OnConfirm = null;
			filterPanel.OnClosed = null;
		}
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, OnBagItemChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnPlayerAttributeChanged);
		Model<ObtainedItemModel>.Interface.OnObtainedItemAdded += OnModelObtainedItemAdded;
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, OnBagItemChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnPlayerAttributeChanged);
		Model<ObtainedItemModel>.Interface.OnObtainedItemAdded -= OnModelObtainedItemAdded;
		base.RemoveEventListener();
	}

	private void OnBagItemChanged(BaseEventContent evt)
	{
		if (evt is ItemChangeEvt { ItemProxies: not null } itemChangeEvt && IsCurrentBuildCostItemChanged(itemChangeEvt))
		{
			RefreshBuildButtonState();
		}
	}

	private void OnModelObtainedItemAdded(int itemId)
	{
		EnsureRecipeKeyItemCache();
		if (itemId > 0 && m_RecipeKeyItemIds.Contains(itemId))
		{
			RefreshEquipBagByRecipeUnlock();
		}
	}

	private bool IsCurrentBuildCostItemChanged(ItemChangeEvt itemChangeEvt)
	{
		if (m_EquipItemData == null)
		{
			return false;
		}
		EquipCreatMaterialData data = CoreUtils.GetData(m_EquipItemData.CreatmaterialListID, RuntimeConfigs.data.equipCreatMaterialDatas);
		if (data == null)
		{
			return false;
		}
		List<ItemUnifierProxy> itemProxies = itemChangeEvt.ItemProxies;
		List<ItemKv> equipMaterialItem = data.equipMaterialItem;
		for (int i = 0; i < itemProxies.Count; i++)
		{
			ItemUnifierProxy itemUnifierProxy = itemProxies[i];
			if (itemUnifierProxy == null)
			{
				continue;
			}
			for (int j = 0; j < equipMaterialItem.Count; j++)
			{
				if (itemUnifierProxy.Id == equipMaterialItem[j].id)
				{
					return true;
				}
			}
		}
		return false;
	}

	private void OnPlayerAttributeChanged(BaseEventContent evt)
	{
		if (evt is PlayerAttributeChangeEvt playerAttributeChangeEvt && m_SpendCoinComponent != null && playerAttributeChangeEvt.id == (int)m_SpendCoinComponent.itemId)
		{
			RefreshBuildButtonState();
		}
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		GenerateLeftEquips();
		GenerateLeftChapterTabs();
		if (m_EquipItemData != null)
		{
			UpdateEquipItem();
			UpdateTitle();
			UpdateLevel();
			UpdateMainPropertyInfo();
			UpdateBuffDetail();
			UpdateCostInfo();
		}
		UpdateFilterText();
		OnGamePadInit();
		SetCostNavigateState(PopUpEquipMakeCostNavigateState.Equip);
		ReBindBtnPrompt();
		layerEquip.Focus();
	}

	protected override void ReInit()
	{
		base.ReInit();
		Init();
	}

	private ScrollRect GetFeatureOverviewScrollRect()
	{
		if (m_FeatureOverviewScrollRect != null)
		{
			return m_FeatureOverviewScrollRect;
		}
		if (!(m_EquipBuffDetail != null))
		{
			return null;
		}
		return m_EquipBuffDetail.GetComponentInChildren<ScrollRect>(includeInactive: true);
	}

	private void RefreshRightStickScrollForbid()
	{
		ScrollRect featureOverviewScrollRect = GetFeatureOverviewScrollRect();
		RightStickScrollSupport rightStickScrollSupport = m_RightStickScrollSupport;
		if (rightStickScrollSupport == null || featureOverviewScrollRect == null)
		{
			m_canRightStickScroll = featureOverviewScrollRect != null && featureOverviewScrollRect.content != null && featureOverviewScrollRect.viewport != null && featureOverviewScrollRect.content.rect.height > featureOverviewScrollRect.viewport.rect.height;
			return;
		}
		Canvas.ForceUpdateCanvases();
		if (featureOverviewScrollRect.content != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(featureOverviewScrollRect.content);
		}
		bool flag = featureOverviewScrollRect.content != null && featureOverviewScrollRect.viewport != null && featureOverviewScrollRect.content.rect.height > featureOverviewScrollRect.viewport.rect.height;
		rightStickScrollSupport.SetForbidScroll(!flag);
		m_canRightStickScroll = flag;
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if ((bool)betterAnimation)
		{
			betterAnimation.GetSequence("Show")?.OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void OnPopStack()
	{
		base.OnPopStack();
		UpdateCostInfo();
		if (filterPanel != null && filterPanel.gameObject.activeSelf)
		{
			SetCostNavigateState(PopUpEquipMakeCostNavigateState.Filter);
			layerFilter?.ReFocus();
		}
		else
		{
			SetCostNavigateState(PopUpEquipMakeCostNavigateState.Equip);
			layerEquip.ReFocus();
		}
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
	}

	protected override void OnPushStack()
	{
		ResetContinuousNavigate();
		base.OnPushStack();
	}

	protected override void UnInit()
	{
		SetBuildActionDisabled(disabled: false);
		ResetContinuousNavigate();
		filterPanel?.ResetAllFilterRecords();
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		if ((bool)betterAnimation)
		{
			betterAnimation.GetSequence("Hide")?.OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void GenerateLeftChapterTabs()
	{
		FillUnlockedChapterTypeList();
		SetChapterTabsVisible(m_ChapterTypeList.Count > 0);
		m_AreaLoopVerticalScrollView.totalCount = m_ChapterTypeList.Count;
		m_AreaLoopVerticalScrollView.OnItemShow.RemoveAllListeners();
		m_AreaLoopVerticalScrollView.OnItemShow.AddListener((ILoopScrollDataSource l) =>
		{
			if (l is AreaTab areaTab)
			{
				areaTab.Station = Station;
				KeyValuePair<int, bool> keyValuePair = m_ChapterTypeList[areaTab.Index];
				bool hasEquip = IsAreaHasEquipSuits(areaTab.Index);
				areaTab.Init(keyValuePair.Key, keyValuePair.Value, hasEquip);
				areaTab.OnSelected = null;
				areaTab.OnSelected = (Action<int>)Delegate.Combine(areaTab.OnSelected, (Action<int>)((int index) =>
				{
					SelectChapterByIndex(index, scrollAreaTab: false);
				}));
			}
		});
		m_AreaLoopVerticalScrollView.RefillCells();
	}

	private void GenerateLeftEquips()
	{
		RebuildVisibleEquipSuits(applyPanelFilter: false);
		LastChosenEquipId = 0;
		if (m_EquipSuits.Count > 0 && m_EquipSuits[0].Value != null && m_EquipSuits[0].Value.Count > 0 && m_EquipSuits[0].Value[0].equipList != null && m_EquipSuits[0].Value[0].equipList.Length != 0)
		{
			CurrentChosenEquipId = m_EquipSuits[0].Value[0].equipList[0];
		}
		UpdateEmptyStateUI();
		m_EquipLoopVerticalScrollView.totalCount = m_EquipSuits.Count;
		m_EquipLoopVerticalScrollView.OnItemShow.RemoveAllListeners();
		m_EquipLoopVerticalScrollView.OnItemShow.AddListener((ILoopScrollDataSource l) =>
		{
			if (l is AreaEquipSuitItem areaEquipSuitItem)
			{
				areaEquipSuitItem.Station = Station;
				areaEquipSuitItem.Context = this;
				KeyValuePair<int, List<EquipSuitData>> keyValuePair = m_EquipSuits[areaEquipSuitItem.Index];
				VerticalLayoutGroup component = areaEquipSuitItem.GetComponent<VerticalLayoutGroup>();
				component.padding.bottom = 0;
				if (keyValuePair.Value == null || keyValuePair.Value.Count <= 0)
				{
					areaEquipSuitItem.OnHide();
					LayoutRebuilder.ForceRebuildLayoutImmediate(m_EquipLoopVerticalScrollView.content);
				}
				else
				{
					areaEquipSuitItem.OnShow();
					areaEquipSuitItem.gameObject.SetActive(value: true);
					areaEquipSuitItem.Init(keyValuePair.Key, keyValuePair.Value);
					LayoutRebuilder.ForceRebuildLayoutImmediate(m_EquipLoopVerticalScrollView.content);
					if (areaEquipSuitItem.Index == m_EquipLoopVerticalScrollView.totalCount - 1)
					{
						component.padding.bottom = Mathf.Max((int)(m_EquipLoopVerticalScrollView.viewport.rect.height - ((RectTransform)areaEquipSuitItem.transform).rect.height) + 1, 0);
					}
					else
					{
						component.padding.bottom = 0;
					}
					LayoutRebuilder.ForceRebuildLayoutImmediate(m_EquipLoopVerticalScrollView.content);
				}
			}
		});
		m_EquipLoopVerticalScrollView.OnItemHide.RemoveAllListeners();
		m_EquipLoopVerticalScrollView.OnItemHide.AddListener((ILoopScrollDataSource l) =>
		{
			if (l is AreaEquipSuitItem areaEquipSuitItem)
			{
				areaEquipSuitItem.GetComponent<VerticalLayoutGroup>().padding.bottom = 0;
			}
		});
		m_EquipLoopVerticalScrollView.OnItemReachBound.RemoveAllListeners();
		m_EquipLoopVerticalScrollView.OnItemReachBound.AddListener((ILoopScrollDataSource l, LoopScrollRectBase.ReachBoundDirection dir) =>
		{
			if (!m_DisableListenReachTop && l is AreaEquipSuitItem areaEquipSuitItem && dir == LoopScrollRectBase.ReachBoundDirection.Up)
			{
				int num = FindChapterIndexByEquipScrollIndex(areaEquipSuitItem.Index);
				if (num >= 0 && IsAreaHasEquipSuits(num) && m_ChapterTypeList.FindIndex((KeyValuePair<int, bool> x) => x.Value) != num)
				{
					SetChapterSelectedByIndex(num, scrollAreaTab: true);
				}
			}
		});
		CacheEquipChapterItemHeights();
		m_EquipLoopVerticalScrollView.RefillCells();
		PlayEquipBagEnterAnimation();
	}

	private void CacheEquipChapterItemHeights()
	{
		if (m_ChapterItemHeightPrefix == null)
		{
			return;
		}
		m_ChapterItemHeightPrefix.Clear();
		m_ChapterItemHeightPrefix.Add(0f);
		if (m_EquipLoopVerticalScrollView == null)
		{
			return;
		}
		m_EquipLoopVerticalScrollView.sizeHelper = m_EquipChapterSizeHelper;
		AreaEquipSuitItem areaEquipSuitItem = ((m_EquipLoopVerticalScrollView.item != null) ? m_EquipLoopVerticalScrollView.item.GetComponent<AreaEquipSuitItem>() : null);
		if (m_EquipLoopVerticalScrollView.viewport != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(m_EquipLoopVerticalScrollView.viewport);
		}
		float num = ((m_EquipLoopVerticalScrollView.viewport != null) ? m_EquipLoopVerticalScrollView.viewport.rect.height : 0f);
		float num2 = 0f;
		int num3 = m_EquipSuits.Count - 1;
		for (int i = 0; i < m_EquipSuits.Count; i++)
		{
			int suitCount = m_EquipSuits[i].Value?.Count ?? 0;
			float num4 = ((areaEquipSuitItem != null) ? areaEquipSuitItem.EstimateHeight(suitCount) : 0f);
			if (i == num3 && num > 0f)
			{
				num4 += (float)Mathf.Max((int)(num - num4) + 1, 0);
			}
			num2 += num4;
			m_ChapterItemHeightPrefix.Add(num2);
		}
	}

	private void PlayEquipBagEnterAnimation()
	{
		if (!(m_EquipLoopVerticalScrollView == null))
		{
			for (int i = 0; i < m_EquipLoopVerticalScrollView.Children.Count; i++)
			{
				m_EquipLoopVerticalScrollView.Children[i].GetComponent<AreaEquipSuitItem>()?.PlayCustomAnimation((float)i * 0.05f);
			}
		}
	}

	private void SetChapterSelectedByIndex(int index, bool scrollAreaTab)
	{
		if (index < 0 || index >= m_ChapterTypeList.Count || !IsAreaHasEquipSuits(index))
		{
			return;
		}
		for (int i = 0; i < m_ChapterTypeList.Count; i++)
		{
			m_ChapterTypeList[i] = new KeyValuePair<int, bool>(m_ChapterTypeList[i].Key, i == index);
		}
		RefreshVisibleChapterTabSelectState();
		if (scrollAreaTab && !(m_AreaLoopVerticalScrollView == null))
		{
			LoopScrollAsyncOperation loopScrollAsyncOperation = m_AreaLoopVerticalScrollView.ScrollToCellWithinTime(index, 0.05f);
			loopScrollAsyncOperation.Complete = (Action<LoopScrollAsyncOperation>)Delegate.Combine(loopScrollAsyncOperation.Complete, (Action<LoopScrollAsyncOperation>)((LoopScrollAsyncOperation toRelease) =>
			{
				RefreshVisibleChapterTabSelectState();
				LoopScrollAsyncOperation.LoopScrollAsyncOperationPool.Release(toRelease);
			}));
		}
	}

	private void SelectChapterByIndex(int index, bool scrollAreaTab)
	{
		if (IsAreaHasEquipSuits(index))
		{
			int num = FindEquipScrollIndexByChapterIndex(index);
			if (num >= 0 && !(m_EquipLoopVerticalScrollView == null))
			{
				m_DisableListenReachTop = true;
				m_EquipLoopVerticalScrollView.ScrollToCellWithinTime(num, 0f);
				m_DisableListenReachTop = false;
				SetChapterSelectedByIndex(index, scrollAreaTab);
			}
		}
	}

	private void RefreshVisibleChapterTabSelectState()
	{
		if (m_AreaLoopVerticalScrollView == null || m_AreaLoopVerticalScrollView.content == null)
		{
			return;
		}
		for (int i = 0; i < m_AreaLoopVerticalScrollView.content.childCount; i++)
		{
			AreaTab component = m_AreaLoopVerticalScrollView.content.GetChild(i).GetComponent<AreaTab>();
			if (!(component == null))
			{
				bool isOnWithoutNotify = IsAreaHasEquipSuits(component.Index) && component.Index >= 0 && component.Index < m_ChapterTypeList.Count && m_ChapterTypeList[component.Index].Value;
				if (!(component.Toggle == null))
				{
					component.Toggle.SetIsOnWithoutNotify(isOnWithoutNotify);
				}
			}
		}
	}

	private void OpenFilterPanel()
	{
		if (!(filterPanel == null) && CostNavigateState != PopUpEquipMakeCostNavigateState.Filter)
		{
			filterPanel.Open();
			SetCostNavigateState(PopUpEquipMakeCostNavigateState.Filter);
			layerFilter?.Focus();
		}
	}

	private void CloseFilterPanel()
	{
		if (filterPanel == null)
		{
			OnFilterPanelClosed();
		}
		else if (!filterPanel.gameObject.activeSelf)
		{
			OnFilterPanelClosed();
		}
		else
		{
			filterPanel.Close();
		}
	}

	private void OnFilterPanelClosed()
	{
		layerFilter?.UnFocus();
		SetCostNavigateState(PopUpEquipMakeCostNavigateState.Equip);
		layerEquip?.Focus();
	}

	private void UpdateFilterText()
	{
		if (!(filterText == null))
		{
			bool flag = filterPanel != null && filterPanel.HasActiveFilter();
			filterText.SetTable(LocalizeTable.Common);
			filterText.StringReference.TableEntryReference = (flag ? LocalizationCommonData.CommonString.SuitFilterApplying : LocalizationCommonData.CommonString.SuitFilter);
		}
	}

	private bool HasObtainedItem(int itemId)
	{
		if (Model<ObtainedItemModel>.HasInstance())
		{
			return Model<ObtainedItemModel>.Interface.HasObtained(itemId);
		}
		return false;
	}

	private bool IsEquipRecipeUnlocked(int equipId)
	{
		EquipData data = CoreUtils.GetData(equipId, RuntimeConfigs.data.equipDatas);
		if (data == null)
		{
			return false;
		}
		EquipCreatMaterialData data2 = CoreUtils.GetData(data.CreatmaterialListID, RuntimeConfigs.data.equipCreatMaterialDatas);
		if (data2?.keyItemIds == null || data2.keyItemIds.Length == 0)
		{
			return true;
		}
		for (int i = 0; i < data2.keyItemIds.Length; i++)
		{
			int num = data2.keyItemIds[i];
			if (num > 0 && !HasObtainedItem(num))
			{
				return false;
			}
		}
		return true;
	}

	private void EnsureRecipeKeyItemCache()
	{
		if (m_RecipeKeyItemIds != null)
		{
			return;
		}
		m_RecipeKeyItemIds = new HashSet<int>();
		foreach (KeyValuePair<int, EquipCreatMaterialData> equipCreatMaterialData in RuntimeConfigs.data.equipCreatMaterialDatas)
		{
			int[] array = equipCreatMaterialData.Value?.keyItemIds;
			if (array == null)
			{
				continue;
			}
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i] > 0)
				{
					m_RecipeKeyItemIds.Add(array[i]);
				}
			}
		}
	}

	private bool IsEquipStillVisible(int equipId)
	{
		if (equipId <= 0)
		{
			return false;
		}
		for (int i = 0; i < m_EquipSuits.Count; i++)
		{
			List<EquipSuitData> value = m_EquipSuits[i].Value;
			if (value == null)
			{
				continue;
			}
			for (int j = 0; j < value.Count; j++)
			{
				int[] equipList = value[j].equipList;
				if (equipList == null)
				{
					continue;
				}
				for (int k = 0; k < equipList.Length; k++)
				{
					if (equipList[k] == equipId)
					{
						return true;
					}
				}
			}
		}
		return false;
	}

	private void RebuildVisibleEquipSuits(bool applyPanelFilter)
	{
		foreach (KeyValuePair<int, List<EquipSuitData>> equipSuit in m_EquipSuits)
		{
			ListPool<EquipSuitData>.Release(equipSuit.Value);
		}
		m_EquipSuits.Clear();
		foreach (KeyValuePair<int, EquipSuitData> pair in RuntimeConfigs.data.equipSuitDatas)
		{
			List<EquipData> list = new List<EquipData>();
			int[] equipList = pair.Value.equipList;
			if (equipList != null)
			{
				foreach (int num in equipList)
				{
					if (IsEquipRecipeUnlocked(num))
					{
						EquipData data = CoreUtils.GetData(num, RuntimeConfigs.data.equipDatas);
						if (data != null)
						{
							list.Add(data);
						}
					}
				}
			}
			if (applyPanelFilter)
			{
				filterPanel?.DoFilter(list);
			}
			if (list.Count <= 0)
			{
				continue;
			}
			int num2 = m_EquipSuits.FindIndex((KeyValuePair<int, List<EquipSuitData>> x) => x.Key == pair.Value.suitArea);
			KeyValuePair<int, List<EquipSuitData>> item;
			if (num2 < 0)
			{
				item = new KeyValuePair<int, List<EquipSuitData>>(pair.Value.suitArea, ListPool<EquipSuitData>.Get());
				m_EquipSuits.Add(item);
			}
			else
			{
				item = m_EquipSuits[num2];
			}
			EquipSuitData item2 = new EquipSuitData(pair.Value.id, pair.Value.suitName, pair.Value.suitArea, pair.Value.suitSeq, list.Select((EquipData x) => x.id).ToArray(), pair.Value.sort);
			List<EquipSuitData> value = item.Value;
			bool flag = false;
			for (int num3 = 0; num3 < value.Count; num3++)
			{
				if (pair.Value.suitSeq < value[num3].suitSeq)
				{
					value.Insert(num3, item2);
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				value.Add(item2);
			}
		}
		m_EquipSuits.Sort((KeyValuePair<int, List<EquipSuitData>> x, KeyValuePair<int, List<EquipSuitData>> y) => x.Key - y.Key);
	}

	private void RefreshEquipBagByRecipeUnlock()
	{
		int currentChosenEquipId = CurrentChosenEquipId;
		RebuildVisibleEquipSuits(filterPanel != null && filterPanel.HasActiveFilter());
		UpdateFilterText();
		UpdateEmptyStateUI();
		RebuildEquipLoopScrollFromScratch();
		if (IsEquipStillVisible(currentChosenEquipId))
		{
			if (CurrentChosenEquipId != currentChosenEquipId)
			{
				CurrentChosenEquipId = currentChosenEquipId;
			}
		}
		else
		{
			SelectFirstAvailableEquipAfterFilter();
		}
		RefreshChapterTabsAfterEquipDataReady();
	}

	private void DoFilter()
	{
		RebuildVisibleEquipSuits(applyPanelFilter: true);
		UpdateFilterText();
		UpdateEmptyStateUI();
		RebuildEquipLoopScrollFromScratch();
		SelectFirstAvailableEquipAfterFilter();
		RefreshChapterTabsAfterEquipDataReady();
	}

	private void RebuildEquipLoopScrollFromScratch()
	{
		if (!(m_EquipLoopVerticalScrollView == null))
		{
			m_EquipLoopVerticalScrollView.ClearCellsPool();
			m_EquipLoopVerticalScrollView.totalCount = m_EquipSuits.Count;
			CacheEquipChapterItemHeights();
			m_EquipLoopVerticalScrollView.RefillCells();
		}
	}

	private void RefreshChapterTabsAfterEquipDataReady()
	{
		int selectedAreaId = 0;
		for (int i = 0; i < m_ChapterTypeList.Count; i++)
		{
			if (m_ChapterTypeList[i].Value)
			{
				selectedAreaId = m_ChapterTypeList[i].Key;
				break;
			}
		}
		FillUnlockedChapterTypeList(selectedAreaId);
		SetChapterTabsVisible(m_ChapterTypeList.Count > 0);
		if (!(m_AreaLoopVerticalScrollView == null))
		{
			m_AreaLoopVerticalScrollView.totalCount = m_ChapterTypeList.Count;
			m_AreaLoopVerticalScrollView.RefillCells();
		}
	}

	private void FillUnlockedChapterTypeList(int selectedAreaId = 0)
	{
		HashSet<int> hashSet = HashSetPool<int>.Get();
		foreach (KeyValuePair<int, EquipSuitData> equipSuitData in RuntimeConfigs.data.equipSuitDatas)
		{
			int suitArea = equipSuitData.Value.suitArea;
			if (hashSet.Contains(suitArea))
			{
				continue;
			}
			int[] equipList = equipSuitData.Value.equipList;
			if (equipList == null)
			{
				continue;
			}
			for (int i = 0; i < equipList.Length; i++)
			{
				if (IsEquipRecipeUnlocked(equipList[i]))
				{
					hashSet.Add(suitArea);
					break;
				}
			}
		}
		m_ChapterTypeList.Clear();
		foreach (int item in hashSet)
		{
			m_ChapterTypeList.Add(new KeyValuePair<int, bool>(item, value: false));
		}
		m_ChapterTypeList.Sort((KeyValuePair<int, bool> x, KeyValuePair<int, bool> y) => x.Key - y.Key);
		HashSetPool<int>.Release(hashSet);
		int num = ((selectedAreaId > 0) ? FindChapterIndexByAreaId(selectedAreaId) : (-1));
		if (num >= 0 && !IsAreaHasEquipSuits(num))
		{
			num = -1;
		}
		if (num < 0)
		{
			for (int num2 = 0; num2 < m_ChapterTypeList.Count; num2++)
			{
				if (IsAreaHasEquipSuits(num2))
				{
					num = num2;
					break;
				}
			}
		}
		if (num >= 0)
		{
			m_ChapterTypeList[num] = new KeyValuePair<int, bool>(m_ChapterTypeList[num].Key, value: true);
		}
	}

	private void SetChapterTabsVisible(bool visible)
	{
		if (m_AreaLoopVerticalScrollView != null)
		{
			m_AreaLoopVerticalScrollView.gameObject.SetActive(visible);
		}
	}

	private bool IsAreaHasEquipSuits(int chapterIndex)
	{
		if (chapterIndex < 0 || chapterIndex >= m_ChapterTypeList.Count)
		{
			return false;
		}
		int key = m_ChapterTypeList[chapterIndex].Key;
		int num = FindEquipScrollIndexByAreaId(key);
		if (num < 0)
		{
			return false;
		}
		List<EquipSuitData> value = m_EquipSuits[num].Value;
		if (value != null)
		{
			return value.Count > 0;
		}
		return false;
	}

	private int FindEquipScrollIndexByAreaId(int areaId)
	{
		for (int i = 0; i < m_EquipSuits.Count; i++)
		{
			if (m_EquipSuits[i].Key == areaId)
			{
				return i;
			}
		}
		return -1;
	}

	private int FindEquipScrollIndexByChapterIndex(int chapterIndex)
	{
		if (chapterIndex < 0 || chapterIndex >= m_ChapterTypeList.Count)
		{
			return -1;
		}
		return FindEquipScrollIndexByAreaId(m_ChapterTypeList[chapterIndex].Key);
	}

	private int FindChapterIndexByAreaId(int areaId)
	{
		for (int i = 0; i < m_ChapterTypeList.Count; i++)
		{
			if (m_ChapterTypeList[i].Key == areaId)
			{
				return i;
			}
		}
		return -1;
	}

	private int FindChapterIndexByEquipScrollIndex(int equipScrollIndex)
	{
		if (equipScrollIndex < 0 || equipScrollIndex >= m_EquipSuits.Count)
		{
			return -1;
		}
		return FindChapterIndexByAreaId(m_EquipSuits[equipScrollIndex].Key);
	}

	private bool HasAnySelectableEquip()
	{
		for (int i = 0; i < m_EquipSuits.Count; i++)
		{
			List<EquipSuitData> value = m_EquipSuits[i].Value;
			if (value != null && value.Count > 0)
			{
				int[] equipList = value[0].equipList;
				if (equipList != null && equipList.Length != 0)
				{
					return true;
				}
			}
		}
		return false;
	}

	private void UpdateEmptyStateUI()
	{
		bool flag = HasAnySelectableEquip();
		if (equipBagEmptyState != null)
		{
			equipBagEmptyState.SetActive(!flag);
		}
		if (equipInfoEmptyState != null)
		{
			equipInfoEmptyState.SetActive(!flag);
		}
		if (equipScrollViewRoot != null)
		{
			equipScrollViewRoot.SetActive(flag);
		}
		if (equipInfoRoot != null)
		{
			equipInfoRoot.SetActive(flag);
		}
		if (!flag)
		{
			ClearMiddleEquipItem();
		}
	}

	private void ClearMiddleEquipItem()
	{
		LastChosenEquipId = m_CurrentChosenEquipId;
		m_CurrentChosenEquipId = 0;
		m_EquipItemData = null;
		if (m_EquipItem != null)
		{
			m_EquipItem.Station = Station;
			m_EquipItem.Init(null);
		}
	}

	private void SelectFirstAvailableEquipAfterFilter()
	{
		int num = -1;
		for (int i = 0; i < m_EquipSuits.Count; i++)
		{
			List<EquipSuitData> value = m_EquipSuits[i].Value;
			if (value != null && value.Count > 0 && value[0].equipList != null && value[0].equipList.Length != 0)
			{
				num = i;
				break;
			}
		}
		int num2 = ((num >= 0) ? FindChapterIndexByEquipScrollIndex(num) : (-1));
		for (int j = 0; j < m_ChapterTypeList.Count; j++)
		{
			m_ChapterTypeList[j] = new KeyValuePair<int, bool>(m_ChapterTypeList[j].Key, j == num2);
		}
		RefreshVisibleChapterTabSelectState();
		if (num < 0)
		{
			ClearMiddleEquipItem();
		}
		else
		{
			CurrentChosenEquipId = m_EquipSuits[num].Value[0].equipList[0];
		}
	}

	private void UpdateEquipItem()
	{
		ItemData data = CoreUtils.GetData(CurrentChosenEquipId, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			if (!m_EquipData.TryGetValue(CurrentChosenEquipId, out var value))
			{
				value = new Equip();
				m_EquipData.Add(CurrentChosenEquipId, value);
			}
			value.Id = CurrentChosenEquipId;
			value.Level = CurrentLevel;
			value.Quality = data.quality;
			value.Refresh();
			m_EquipItem.Station = Station;
			m_EquipItem.Init(value);
		}
	}

	private void UpdateTitle()
	{
		if (m_EquipItemData == null)
		{
			return;
		}
		ItemData data = CoreUtils.GetData(m_EquipItemData.id, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			m_EquipName.StringReference.TableEntryReference = data.nameLocal;
			EquipData data2 = CoreUtils.GetData(CurrentChosenEquipId, RuntimeConfigs.data.equipDatas);
			if (data2 != null)
			{
				Station.LoadImageAsync(135, data2.equipType, m_EquipTypeIcon).Forget();
				LocalizedString stringReference = m_EquipTypeName.StringReference;
				stringReference.TableEntryReference = data2.equipType switch
				{
					1 => LocalizationCommonData.CommonString.Power, 
					2 => LocalizationCommonData.CommonString.Move, 
					3 => LocalizationCommonData.CommonString.Can, 
					4 => LocalizationCommonData.CommonString.Assist, 
					_ => throw new ArgumentOutOfRangeException(), 
				};
			}
		}
	}

	private void UpdateLevel()
	{
		if (m_EquipItemData != null)
		{
			m_EquipLevel.UpdateNumber(0L, MaxLevel);
			if (CurrentLevel > 0)
			{
				m_EquipExtraLevelRoot.SetActive(value: true);
				m_EquipExtraLevel.SetText(CurrentLevel.FastToString());
			}
			else
			{
				m_EquipExtraLevelRoot.SetActive(value: false);
			}
		}
	}

	private void UpdateMainPropertyInfo()
	{
		if (m_EquipItemData == null)
		{
			return;
		}
		EquipAttrData data = CoreUtils.GetData(m_EquipItemData.fixEquipAttrId, RuntimeConfigs.data.equipAttrDatas);
		if (data != null)
		{
			PropertyData data2 = CoreUtils.GetData(data.attrId, RuntimeConfigs.data.propertyDatas);
			if (data2 != null)
			{
				m_MainPropertyName.StringReference.TableEntryReference = data2.descLocal;
				m_MainPropertyNumber.SetText(data.attrList[CurrentLevel].FastToString(data2.judge ? 1 : (-1), data2.judge));
				Station.LoadImageAsync(146, data2.icon, m_MainPropertyIcon).Forget();
			}
		}
	}

	private void UpdateBuffDetail()
	{
		if (m_EquipItemData != null && CurrentChosenEquipId > 0)
		{
			Equip equip = ItemUnifierProxy.ItemUnifierPool.Get<Equip>(CurrentChosenEquipId, 0L).As<Equip>();
			equip.Level = 0;
			equip.Refresh();
			Equip equip2 = ItemUnifierProxy.ItemUnifierPool.Get<Equip>(CurrentChosenEquipId, 0L).As<Equip>();
			equip2.Level = CurrentLevel;
			equip2.Refresh();
			m_EquipBuffDetail.Init(equip, equip2);
			EquipLockedFeatureHelper.AddLockedEquipFeatures(equip2, m_EquipBuffDetail);
			RefreshRightStickScrollForbid();
			ReBindBtnPrompt();
		}
	}

	private void UpdateCostInfo()
	{
		if (m_EquipItemData == null)
		{
			return;
		}
		EquipCreatMaterialData data = CoreUtils.GetData(m_EquipItemData.CreatmaterialListID, RuntimeConfigs.data.equipCreatMaterialDatas);
		if (data == null)
		{
			return;
		}
		List<ItemKv> equipMaterialItem = data.equipMaterialItem;
		ItemUnifierProxy.ItemUnifierPool.Release(m_CostMaterialList);
		foreach (ItemKv item in equipMaterialItem)
		{
			m_CostMaterialList.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.id, item.count));
		}
		m_SpendMaterialComponent.Station = Station;
		m_SpendMaterialComponent.ItemSource = m_CostMaterialList;
		m_SpendCoinComponent.Station = Station;
		m_SpendCoinComponent.Init(data.coinEach);
		RefreshBuildButtonState();
		m_SpendMaterialComponent.OnUpdateEnd = null;
		CommonScrollBagComponent spendMaterialComponent = m_SpendMaterialComponent;
		spendMaterialComponent.OnUpdateEnd = (Action)Delegate.Combine(spendMaterialComponent.OnUpdateEnd, (Action)(() =>
		{
			m_SpendMaterialComponent.OnUpdateEnd = null;
			RefreshRightStickScrollForbid();
			ReBindBtnPrompt();
		}));
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
	}

	private void BuildEquip()
	{
		if (!m_CanBuildEquip)
		{
			OpenQuickPowerExchangeItemView();
			return;
		}
		G.service.EquipCreate(CurrentChosenEquipId, (bool x, RepeatedField<UniversalItem> items) =>
		{
			if (x)
			{
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_EQUIPBUILDSUCCESS, new EquipBuildSuccessViewData
				{
					newEquipUid = items[0].Uid
				}).Forget();
				UpdateCostInfo();
			}
		});
	}

	private void OpenQuickPowerExchangeItemView()
	{
		if (m_CanExchangeMaterial && TryGetQuickPowerExchangeItemViewData(out var viewData, out var _))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_QUICKPOWEREXCHANGEITEM, viewData);
		}
	}

	private bool TryGetQuickPowerExchangeItemViewData(out QuickPowerExchangeItemViewData viewData, out long totalPowerCost)
	{
		viewData = new QuickPowerExchangeItemViewData();
		totalPowerCost = 0L;
		if (m_EquipItemData == null)
		{
			return false;
		}
		EquipCreatMaterialData data = CoreUtils.GetData(m_EquipItemData.CreatmaterialListID, RuntimeConfigs.data.equipCreatMaterialDatas);
		if (data == null || m_SpendCoinComponent == null)
		{
			return false;
		}
		int itemId = (int)m_SpendCoinComponent.itemId;
		int num = (int)Math.Max(0L, data.coinEach - G.TryGetAttribute(itemId));
		if (num > 0)
		{
			if (!Model<PowerModel>.Interface.IsItemPowerExchangeUnlocked(itemId))
			{
				return false;
			}
			long requirePowerCount = Model<PowerModel>.Interface.GetRequirePowerCount(itemId, num);
			if (requirePowerCount <= 0)
			{
				return false;
			}
			viewData.NeedItemId = itemId;
			viewData.NeedItemCount = num;
			totalPowerCost = requirePowerCount;
			return true;
		}
		List<ItemKv> equipMaterialItem = data.equipMaterialItem;
		if (equipMaterialItem == null)
		{
			return totalPowerCost > 0;
		}
		for (int i = 0; i < equipMaterialItem.Count; i++)
		{
			ItemKv itemKv = equipMaterialItem[i];
			int num2 = Math.Max(0, itemKv.count - G.localPlayer.Inventory.GetItemCount(itemKv.id));
			if (num2 > 0)
			{
				if (!Model<PowerModel>.Interface.IsItemPowerExchangeUnlocked(itemKv.id))
				{
					return false;
				}
				long requirePowerCount2 = Model<PowerModel>.Interface.GetRequirePowerCount(itemKv.id, num2);
				if (requirePowerCount2 <= 0)
				{
					return false;
				}
				viewData.NeedItemId = itemKv.id;
				viewData.NeedItemCount = num2;
				totalPowerCost = requirePowerCount2;
				return true;
			}
		}
		return totalPowerCost > 0;
	}

	private void SetBuildActionDisabled(bool disabled)
	{
		if (disabled || m_BuildActionDisabledByView || IsFilterFocus)
		{
			m_BuildActionDisabledByView = disabled;
			ApplyUiSpecial1DisabledForCurrentNavigateState();
		}
	}

	private void ApplyUiSpecial1DisabledForCurrentNavigateState()
	{
		bool value = !IsFilterFocus && m_BuildActionDisabledByView;
		Singleton<GameInputActionManager>.instance.SetActionDisabled("UI/UISpecial1", value);
	}

	private void RefreshBuildButtonState()
	{
		bool canBuildEquip = Model<EquipModel>.Interface.CanBuildEquip(m_EquipItemData);
		m_CanBuildEquip = canBuildEquip;
		m_CanExchangeMaterial = !m_CanBuildEquip && TryGetQuickPowerExchangeItemViewData(out var _, out var _);
		bool flag = !m_CanBuildEquip && m_CanExchangeMaterial;
		m_ConfirmBtn.Interactable(m_CanBuildEquip | flag);
		if (m_ConfirmBtnText != null)
		{
			m_ConfirmBtnText.SetTable(LocalizeTable.Common);
			m_ConfirmBtnText.StringReference.TableEntryReference = (flag ? LocalizationCommonData.CommonString.ExchangeMaterial : LocalizationCommonData.CommonString.Build);
		}
		SetBuildActionDisabled(!(m_CanBuildEquip | flag));
	}

	private void OnMaxPreviewSwitch(bool isOpen)
	{
		m_IsMaxPreview = isOpen;
		if (m_EquipItemData != null)
		{
			UpdateLevel();
			UpdateBuffDetail();
			UpdateMainPropertyInfo();
			UpdateBuffDetail();
			UpdateEquipItem();
			RefreshRightStickScrollForbid();
			ReBindBtnPrompt();
		}
	}

	public void OpenAttributeIntoView()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_ATTRIBUTEINTRO, new AttributeIntroViewData
		{
			EquipId = CurrentChosenEquipId
		}).Forget();
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>();
		_allInputPrompt["UI/RSUpDownSelect"] = new GamePadTipsAction
		{
			inputAction = "UI/RSUpDownSelect",
			localizeKey = 2165,
			localizeTable = "Common"
		};
		_allInputPrompt["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		};
		_allInputPrompt["UI/Confirm"] = new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 774,
			localizeTable = "Common"
		};
		_allInputPrompt["UI/UISpecial2"] = new GamePadTipsAction
		{
			inputAction = "UI/UISpecial2",
			localizeKey = 300,
			localizeTable = "Common"
		};
	}

	private void ReBindBtnPrompt()
	{
		if (_allInputPrompt == null || gamePadGroup == null)
		{
			return;
		}
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		if (IsCostCoinOrMaterialFocus || IsFilterFocus)
		{
			_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
			_tipsActions.Add(_allInputPrompt["UI/Back"]);
		}
		else
		{
			_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
			_tipsActions.Add(_allInputPrompt["UI/Back"]);
			_tipsActions.Add(_allInputPrompt["UI/UISpecial2"]);
			if (m_canRightStickScroll)
			{
				_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
			}
		}
		gamePadGroup.RegisterInputActions(_tipsActions);
	}

	private void SetCostNavigateState(PopUpEquipMakeCostNavigateState state)
	{
		PopUpEquipMakeCostNavigateState costNavigateState = CostNavigateState;
		CostNavigateState = state;
		ApplyCostFocusObjectsVisibility();
		RefreshRightStickScrollForbid();
		if (costNavigateState != state)
		{
			ApplyUiSpecial1DisabledForCurrentNavigateState();
			ReBindBtnPrompt();
		}
	}

	private void ApplyCostFocusObjectsVisibility()
	{
		SetListActiveForCostFocus(m_CostFocusObjectsEquip, CostNavigateState == PopUpEquipMakeCostNavigateState.Equip);
		SetListActiveForCostFocus(m_CostFocusObjectsCoin, CostNavigateState == PopUpEquipMakeCostNavigateState.Coin);
		SetListActiveForCostFocus(m_CostFocusObjectsMaterial, CostNavigateState == PopUpEquipMakeCostNavigateState.Material);
		SetListActiveForCostFocus(m_FilterFocusObjectsMaterial, CostNavigateState == PopUpEquipMakeCostNavigateState.Filter);
	}

	private static void SetListActiveForCostFocus(List<GameObject> list, bool active)
	{
		if (list == null)
		{
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			GameObject gameObject = list[i];
			if (gameObject != null)
			{
				gameObject.SetActive(active);
			}
		}
	}

	public void OnConfirm()
	{
		if (CostNavigateState == PopUpEquipMakeCostNavigateState.Equip)
		{
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	public void OnGamePadBuildEquip()
	{
		if (CostNavigateState == PopUpEquipMakeCostNavigateState.Equip)
		{
			BuildEquip();
		}
	}

	public void OnCancle()
	{
		if (CostNavigateState == PopUpEquipMakeCostNavigateState.Filter)
		{
			CloseFilterPanel();
			return;
		}
		if (CostNavigateState == PopUpEquipMakeCostNavigateState.Equip)
		{
			Close();
			return;
		}
		SetCostNavigateState(PopUpEquipMakeCostNavigateState.Equip);
		layerEquip.Focus();
	}

	public void OnGamePadOpenFilter()
	{
		if (CostNavigateState == PopUpEquipMakeCostNavigateState.Equip)
		{
			OpenFilterPanel();
		}
	}

	public void ResetContinuousNavigate()
	{
		curNavigateState?.Reset();
	}

	public void OnNavigate(Vector2 value)
	{
		if (EventSystemHelper.CurrentSelected != null)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref curNavigateState, OnNavigateSelect);
		}
		else if (!root.ReFocus())
		{
			switch (CostNavigateState)
			{
			case PopUpEquipMakeCostNavigateState.Equip:
				layerEquip.ReFocus();
				break;
			case PopUpEquipMakeCostNavigateState.Coin:
				layerCoin.ReFocus();
				break;
			case PopUpEquipMakeCostNavigateState.Material:
				layerMaterial.ReFocus();
				break;
			case PopUpEquipMakeCostNavigateState.Filter:
				layerFilter.ReFocus();
				break;
			}
		}
	}

	private void OnNavigateSelect(MoveDirection moveDirection)
	{
		switch (moveDirection)
		{
		case MoveDirection.Down:
			root.SelectDown();
			break;
		case MoveDirection.Left:
			root.SelectLeft();
			break;
		case MoveDirection.Up:
			root.SelectUp();
			break;
		case MoveDirection.Right:
			root.SelectRight();
			break;
		}
		if (CostNavigateState != PopUpEquipMakeCostNavigateState.Equip)
		{
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	public void OnGamePadSelectMaterialList()
	{
		if (CostNavigateState == PopUpEquipMakeCostNavigateState.Equip)
		{
			layerMaterial.Focus();
			SetCostNavigateState(PopUpEquipMakeCostNavigateState.Material);
		}
	}

	public void OnGamePadSelectCoin()
	{
		if (CostNavigateState == PopUpEquipMakeCostNavigateState.Equip)
		{
			layerCoin.Focus();
			SetCostNavigateState(PopUpEquipMakeCostNavigateState.Coin);
		}
	}

	public void OnShowFeature()
	{
		if (CostNavigateState == PopUpEquipMakeCostNavigateState.Equip)
		{
			equipBuffDetail.OpenBuffDetail();
		}
	}

	public void OnGamePadSwitchLevelPreview()
	{
		if (CostNavigateState == PopUpEquipMakeCostNavigateState.Equip)
		{
			ExecuteEvents.Execute(m_MaxLevelToggle.gameObject, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	public void OnGamePadOpenRandomAttributePreview()
	{
		if (CostNavigateState == PopUpEquipMakeCostNavigateState.Equip)
		{
			OpenAttributeIntoView();
		}
	}

	public void OnGamePadScrollFeatureOverview(Vector2 value)
	{
		if (CostNavigateState == PopUpEquipMakeCostNavigateState.Equip && m_canRightStickScroll)
		{
			ScrollRect featureOverviewScrollRect = GetFeatureOverviewScrollRect();
			if (!(featureOverviewScrollRect == null))
			{
				featureOverviewScrollRect.velocity = new Vector2(0f, value.y * featureOverviewScrollRect.scrollSensitivity);
			}
		}
	}

	public void OnGamePadSwitchPageUp()
	{
		SwitchChapterByOffset(-1);
	}

	public void OnGamePadSwitchPageDown()
	{
		SwitchChapterByOffset(1);
	}

	private void SwitchChapterByOffset(int offset)
	{
		if (CostNavigateState == PopUpEquipMakeCostNavigateState.Equip && m_ChapterTypeList != null && m_ChapterTypeList.Count != 0)
		{
			int num = m_ChapterTypeList.FindIndex((KeyValuePair<int, bool> x) => x.Value);
			if (num < 0)
			{
				num = 0;
			}
			int num2 = FindNextValidChapterIndex(num, offset);
			if (num2 >= 0)
			{
				SelectChapterByIndex(num2, scrollAreaTab: true);
				SelectFirstEquipInChapter(FindEquipScrollIndexByChapterIndex(num2));
			}
		}
	}

	private int FindNextValidChapterIndex(int currentIndex, int offset)
	{
		if (offset == 0)
		{
			return -1;
		}
		for (int i = currentIndex + offset; i >= 0 && i < m_ChapterTypeList.Count; i += offset)
		{
			if (IsAreaHasEquipSuits(i))
			{
				return i;
			}
		}
		return -1;
	}

	private void SelectFirstEquipInChapter(int equipScrollIndex)
	{
		if (equipScrollIndex < 0 || equipScrollIndex >= m_EquipSuits.Count)
		{
			return;
		}
		List<EquipSuitData> value = m_EquipSuits[equipScrollIndex].Value;
		if (value != null && value.Count != 0 && value[0].equipList != null && value[0].equipList.Length != 0)
		{
			CurrentChosenEquipId = value[0].equipList[0];
			if (!TryFocusEquipItem(CurrentChosenEquipId, equipScrollIndex))
			{
				layerEquip?.Focus();
			}
		}
	}

	private bool TryFocusEquipItem(int equipId, int equipScrollIndex)
	{
		if (m_EquipLoopVerticalScrollView == null || m_EquipLoopVerticalScrollView.content == null)
		{
			return false;
		}
		for (int i = 0; i < m_EquipLoopVerticalScrollView.content.childCount; i++)
		{
			AreaEquipSuitItem component = m_EquipLoopVerticalScrollView.content.GetChild(i).GetComponent<AreaEquipSuitItem>();
			if (component == null || component.Index != equipScrollIndex)
			{
				continue;
			}
			ItemUIComponentBase[] componentsInChildren = component.GetComponentsInChildren<ItemUIComponentBase>(includeInactive: true);
			foreach (ItemUIComponentBase itemUIComponentBase in componentsInChildren)
			{
				if (!(itemUIComponentBase == null) && itemUIComponentBase.ItemUnifier != null && itemUIComponentBase.ItemUnifier.Id == equipId && itemUIComponentBase.gameObject.activeInHierarchy)
				{
					EventSystemHelper.SetSelectedGameObject(itemUIComponentBase.gameObject);
					return true;
				}
			}
			break;
		}
		return false;
	}
}
