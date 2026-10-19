using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class EquipGemView : BaseUIView<EquipGemViewInputController>
{
	[Serializable]
	private struct GemTabStyle
	{
		public GameObject styleRoot;

		public GameObject gemHoleItemsRoot;

		public GemHoleItems gemHoleItems;

		public GameObject emptyGemHoleTip;

		public EquipBuffDetail equipBuffDetail;

		public LocalizeStringEvent equipName;

		public LocalizeStringEvent equipType;

		public BImage equipTypeIcon;

		public GameObject commonScrollBagRoot;

		public CommonScrollBagComponent commonScrollBag;

		public GameObject emptyBagTip;

		public GameObject gemDetailPanelRoot;

		public GemItemDetail gemDetailPanel;

		public LocalizeStringEvent gemDescription;

		public GameObject gemDetailPanelEmpty;

		[Header("提交按钮")]
		public GameObject confirmBtnRoot;

		public ActButton confirmBtnComponent;

		public LocalizeStringEvent confirmBtnText;

		[Header("动画")]
		public BetterAnimation animation;
	}

	[SerializeField]
	private GemTabStyle m_GemTabConfig;

	public GamePadTipsComp gamePadGroup;

	[SerializeField]
	private ScrollRect m_ScrollRect1;

	[SerializeField]
	private ScrollRect m_ScrollRect2;

	[SerializeField]
	private RightStickScrollSupport m_RightStickScrollSupport;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	private int m_ActiveScrollRectIndex;

	private bool m_RightStickHorizontalConsumed;

	private bool m_canRightStickScroll = true;

	private Equip m_Equip;

	private int m_MaxLevel;

	private List<ItemUnifierProxy> m_GemCollection;

	private EquipGemSlot m_FocusedSlot;

	private UnityAction<ItemUIComponentBase> m_BagItemClickAction;

	public ViewControlLayer layer;

	public ViewControlRoot root;

	private ContinuousNavigateData curNavigateState;

	private EquipGemViewData m_data => uiViewData as EquipGemViewData;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	private void Awake()
	{
		GemHoleItems gemHoleItems = m_GemTabConfig.gemHoleItems;
		gemHoleItems.OnSlotSelected = (Action<EquipGemSlot>)Delegate.Combine(gemHoleItems.OnSlotSelected, new Action<EquipGemSlot>(OnSelectGemSlot));
		m_GemTabConfig.confirmBtnComponent.SetBtnClick(EquipGem);
	}

	private void OnDestroy()
	{
		GemHoleItems gemHoleItems = m_GemTabConfig.gemHoleItems;
		gemHoleItems.OnSlotSelected = (Action<EquipGemSlot>)Delegate.Remove(gemHoleItems.OnSlotSelected, new Action<EquipGemSlot>(OnSelectGemSlot));
		m_GemTabConfig.confirmBtnComponent.OnClick.RemoveListener(EquipGem);
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		m_ActiveScrollRectIndex = 0;
		m_RightStickHorizontalConsumed = false;
		m_Equip = m_data.Equip;
		m_MaxLevel = RuntimeConfigs.data.game.equipRareLevel[m_Equip.GetQuality() - 1];
		SwitchToGemTab();
		EquipData data = CoreUtils.GetData(m_Equip.Id, RuntimeConfigs.data.equipDatas);
		if (data != null)
		{
			ItemData data2 = CoreUtils.GetData(m_Equip.Id, RuntimeConfigs.data.itemDatas);
			if (data2 != null)
			{
				m_GemTabConfig.equipName.SetTable(LocalizeTable.ShortCommon);
				m_GemTabConfig.equipName.StringReference.TableEntryReference = data2.nameLocal;
				m_GemTabConfig.equipType.SetTable(LocalizeTable.Common);
				LocalizedString stringReference = m_GemTabConfig.equipType.StringReference;
				stringReference.TableEntryReference = data.equipType switch
				{
					1 => LocalizationCommonData.CommonString.Power, 
					2 => LocalizationCommonData.CommonString.Move, 
					3 => LocalizationCommonData.CommonString.Can, 
					4 => LocalizationCommonData.CommonString.Assist, 
					_ => throw new ArgumentOutOfRangeException(), 
				};
				Station.LoadImageAsync(135, data.equipType, m_GemTabConfig.equipTypeIcon).Forget();
				m_GemTabConfig.gemHoleItems.PlayAnimation();
				OnGamePadInit();
				RefreshRightStickScrollForbid();
				ReBindBtnPrompt();
			}
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		CommonScrollBagComponent commonScrollBag = m_GemTabConfig.commonScrollBag;
		if (commonScrollBag != null)
		{
			commonScrollBag.OnItemSelect = null;
			commonScrollBag.OnItemShow = null;
			commonScrollBag.OnUpdateEnd = null;
			commonScrollBag.SelectedModels.Clear();
			commonScrollBag.ClearBag();
		}
		if (m_GemCollection != null)
		{
			ItemUnifierProxy.ItemUnifierPool.Release(m_GemCollection);
			ListPool<ItemUnifierProxy>.Release(m_GemCollection);
			m_GemCollection = null;
		}
		m_GemTabConfig.gemDetailPanel.Context = null;
		m_Equip = null;
		m_MaxLevel = 0;
		m_FocusedSlot = null;
		m_ActiveScrollRectIndex = 0;
		m_RightStickHorizontalConsumed = false;
		m_canRightStickScroll = true;
		_tipsActions?.Clear();
		_allInputPrompt = null;
		curNavigateState?.Reset();
		curNavigateState = null;
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void SwitchToGemTab()
	{
		m_GemTabConfig.styleRoot.SetActive(value: true);
		m_GemTabConfig.gemHoleItems.Init(m_Equip);
		m_GemTabConfig.equipBuffDetail.Init(m_Equip);
		if (m_Equip.AvailableSlotCount > 0)
		{
			m_GemTabConfig.gemHoleItemsRoot.SetActive(value: true);
			m_GemTabConfig.confirmBtnRoot.SetActive(value: true);
			m_GemTabConfig.emptyGemHoleTip.SetActive(value: false);
			m_GemTabConfig.gemHoleItems.Init(m_Equip, isTrialCharacter: false, m_data.GemIndex);
			m_data.GemIndex = 0;
		}
		else
		{
			m_GemTabConfig.gemHoleItemsRoot.SetActive(value: false);
			m_GemTabConfig.confirmBtnRoot.SetActive(value: false);
			m_GemTabConfig.emptyGemHoleTip.SetActive(value: true);
			OnSelectGemSlot(null);
		}
		m_GemTabConfig.animation.GetSequence("Show")?.Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Equip/Enhance/Disk_Open");
	}

	private void OnSelectGemSlot(EquipGemSlot slot)
	{
		if (slot == null)
		{
			try
			{
				m_GemTabConfig.gemDetailPanelEmpty.SetActive(value: true);
				m_GemTabConfig.gemDetailPanelRoot.SetActive(value: false);
				m_GemTabConfig.commonScrollBag.gameObject.SetActive(value: false);
				UpdateGemConfirmBtnStyle();
				RefreshRightStickScrollForbid();
				ReBindBtnPrompt();
				return;
			}
			catch (Exception exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception);
				}
			}
		}
		if (slot == m_FocusedSlot)
		{
			return;
		}
		if ((bool)m_FocusedSlot && m_FocusedSlot.GemSlotLevel == slot.GemSlotLevel)
		{
			m_FocusedSlot = slot;
			UpdateGemConfirmBtnStyle();
			return;
		}
		if (m_GemCollection == null)
		{
			m_GemCollection = ListPool<ItemUnifierProxy>.Get();
		}
		ItemUnifierProxy.ItemUnifierPool.Release(m_GemCollection);
		m_GemTabConfig.gemDetailPanelEmpty.SetActive(value: false);
		m_GemTabConfig.gemDetailPanelRoot.SetActive(value: true);
		m_GemTabConfig.commonScrollBag.gameObject.SetActive(value: true);
		m_FocusedSlot = slot;
		foreach (Gem item2 in CharacterDependHelper.GetAllBagGem())
		{
			EquipGemData data = CoreUtils.GetData(item2.Id, RuntimeConfigs.data.equipGemDatas);
			if (data != null && data.quality <= slot.GemSlotLevel)
			{
				ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get(item2);
				m_GemCollection.Add(item);
			}
		}
		m_GemCollection.Sort((ItemUnifierProxy y, ItemUnifierProxy x) => SortUtility.SortGem(x.As<Gem>(), y.As<Gem>()));
		if (m_GemCollection.Count == 0)
		{
			try
			{
				m_GemTabConfig.gemDetailPanelEmpty.SetActive(value: true);
				m_GemTabConfig.emptyBagTip.SetActive(value: true);
				m_GemTabConfig.gemDetailPanelRoot.SetActive(value: false);
				m_GemTabConfig.commonScrollBag.gameObject.SetActive(value: false);
				UpdateGemConfirmBtnStyle();
				RefreshRightStickScrollForbid();
				ReBindBtnPrompt();
				return;
			}
			catch (Exception exception2)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception2);
				}
			}
		}
		else
		{
			try
			{
				if (m_FocusedSlot.Gem != null)
				{
					ItemUnifierProxy itemUnifierProxy = m_GemCollection.FirstOrDefault((ItemUnifierProxy x) => x.As<Gem>().Uid == m_FocusedSlot.Gem.Uid);
					if (itemUnifierProxy != null)
					{
						m_GemCollection.Remove(itemUnifierProxy);
						m_GemCollection.Insert(0, itemUnifierProxy);
					}
				}
				CommonScrollBagComponent gemBag = m_GemTabConfig.commonScrollBag;
				gemBag.ResetPositionAfterUpdate = true;
				gemBag.Station = Station;
				gemBag.ItemSource = m_GemCollection;
				gemBag.SelectMode = CommonScrollBagComponent.SelectModeType.Single;
				gemBag.ItemShowType = ItemUIComponentBase.InitType.BagGem;
				gemBag.OnItemSelect = null;
				CommonScrollBagComponent commonScrollBagComponent = gemBag;
				commonScrollBagComponent.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent.OnItemSelect, new Action<ItemUIComponentBase>(OnSelectedBagGem));
				gemBag.OnItemShow = null;
				CommonScrollBagComponent commonScrollBagComponent2 = gemBag;
				commonScrollBagComponent2.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent2.OnItemShow, new Action<ItemUIComponentBase>(OnBagGemItemShow));
				gemBag.SelectedModels.Clear();
				gemBag.SelectedModels.Add(m_GemCollection[0]);
				m_GemTabConfig.gemDetailPanel.Station = Station;
				Gem gem = m_GemCollection[0].As<Gem>();
				m_GemTabConfig.gemDetailPanel.Context = gem;
				UpdateGemDescription(gem);
				gemBag.OnUpdateEnd = null;
				CommonScrollBagComponent commonScrollBagComponent3 = gemBag;
				commonScrollBagComponent3.OnUpdateEnd = (Action)Delegate.Combine(commonScrollBagComponent3.OnUpdateEnd, (Action)(() =>
				{
					gemBag.OnUpdateEnd = null;
					RefreshRightStickScrollForbid();
					ReBindBtnPrompt();
				}));
			}
			catch (Exception exception3)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception3);
				}
			}
		}
		UpdateGemConfirmBtnStyle();
	}

	private void UpdateGemConfirmBtnStyle()
	{
		ActButton confirmBtnComponent = m_GemTabConfig.confirmBtnComponent;
		List<ItemUnifierProxy> gemCollection = m_GemCollection;
		confirmBtnComponent.Interactable(gemCollection != null && gemCollection.Count > 0);
		if (m_FocusedSlot == null)
		{
			m_GemTabConfig.confirmBtnText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.EquipDiamond;
		}
		else if (m_FocusedSlot.Gem == null)
		{
			m_GemTabConfig.confirmBtnText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.EquipDiamond;
		}
		else if (m_FocusedSlot.Gem.Uid == m_GemTabConfig.gemDetailPanel.Context.Uid)
		{
			m_GemTabConfig.confirmBtnText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.UnloadDiamond;
		}
		else
		{
			m_GemTabConfig.confirmBtnText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.ExchangeDiamond;
		}
	}

	private void OnSelectedBagGem(ItemUIComponentBase itemUIComponentBase)
	{
		m_GemTabConfig.gemDetailPanel.Station = Station;
		Gem gem = itemUIComponentBase.ItemUnifier.As<Gem>();
		m_GemTabConfig.gemDetailPanel.Context = gem;
		UpdateGemDescription(gem);
		UpdateFeatureInfos();
		UpdateGemConfirmBtnStyle();
	}

	private void UpdateGemDescription(Gem gem)
	{
		LocalizeStringEvent gemDescription = m_GemTabConfig.gemDescription;
		if (!(gemDescription == null) && gem != null)
		{
			ItemData data = CoreUtils.GetData(gem.Id, RuntimeConfigs.data.itemDatas);
			if (data != null)
			{
				gemDescription.SetTable("longcommon");
				gemDescription.StringReference.TableEntryReference = data.descLocal;
			}
		}
	}

	private void UpdateFeatureInfos()
	{
		m_Equip.CalculateFeatureData();
		Equip equip = new Equip();
		equip.MargeFrom(m_Equip);
		Gem context = m_GemTabConfig.gemDetailPanel.Context;
		equip.GemSlots[m_FocusedSlot.Index].GemId = context.Uid;
		equip.CalculateFeatureData();
		m_GemTabConfig.equipBuffDetail.Init(m_Equip, equip);
	}

	private void EquipGem()
	{
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.EquipAddGem);
		bool isEquip = m_GemTabConfig.confirmBtnText.StringReference.TableEntryReference != LocalizationCommonData.CommonString.UnloadDiamond;
		Gem targetGem = m_GemTabConfig.gemDetailPanel.Context;
		bool flag = false;
		if (isEquip && targetGem.InlayEquip != 0)
		{
			Equip equip = G.localPlayer.Inventory.GetEquip(targetGem.InlayEquip);
			if (equip.WearCharacter != 0)
			{
				flag = true;
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
				{
					titleId = 0,
					commonId = ((equip.WearCharacter != m_Equip.WearCharacter) ? 41000052 : 41000053),
					OnConfirm = () =>
					{
						if (m_FocusedSlot.Gem != null)
						{
							GemSlot gemSlot = null;
							foreach (GemSlot gemSlot2 in equip.GemSlots)
							{
								if (gemSlot2.GemId == targetGem.Uid)
								{
									gemSlot = gemSlot2;
									break;
								}
							}
							if (gemSlot != null && (m_FocusedSlot.Gem.Level > gemSlot.SlotLevel || targetGem.Level > m_FocusedSlot.GemSlotLevel))
							{
								GameUtility.OpenToolTip(41000051);
							}
							else
							{
								DoWear();
							}
						}
						else
						{
							DoWear();
						}
					}
				});
			}
		}
		if (!flag)
		{
			DoWear();
		}
		void DoWear()
		{
			G.service.EquipWearGem(m_Equip.Uid, m_FocusedSlot.Index, isEquip, targetGem.Uid, (bool result) =>
			{
				if (result)
				{
					m_GemTabConfig.gemHoleItems.Init(m_Equip);
					UpdateFeatureInfos();
					UpdateGemConfirmBtnStyle();
					m_GemTabConfig.gemDetailPanel.Context = targetGem;
				}
			});
		}
	}

	private void OnBagGemItemShow(ItemUIComponentBase cell)
	{
		if (cell == null)
		{
			return;
		}
		if (!(cell.ItemUnifier?.Source is Gem))
		{
			cell.RedPointPath = string.Empty;
			return;
		}
		cell.RedDotType = RedDotType.Dot;
		cell.RedPointPath = Model<InventoryModel>.Interface.GetItemRedDotPath(InventoryTab.Disk, cell.ItemUnifier);
		if (m_BagItemClickAction == null)
		{
			m_BagItemClickAction = OnBagItemClicked;
		}
		cell.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(cell.OnItemClick, m_BagItemClickAction);
	}

	private void OnBagItemClicked(ItemUIComponentBase cell)
	{
		ItemUnifierProxy itemUnifierProxy = cell?.ItemUnifier;
		if (itemUnifierProxy?.Source is Gem && Model<InventoryModel>.Interface.GetItemRedDotState(itemUnifierProxy))
		{
			Model<InventoryModel>.Interface.SetItemRedDotState(InventoryTab.Disk, itemUnifierProxy);
		}
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
	}

	private void RefreshRightStickScrollForbid()
	{
		ScrollRect activeScrollRect = GetActiveScrollRect();
		RightStickScrollSupport rightStickScrollSupport = m_RightStickScrollSupport;
		if (rightStickScrollSupport == null || activeScrollRect == null)
		{
			m_canRightStickScroll = activeScrollRect != null && activeScrollRect.content != null && activeScrollRect.viewport != null && activeScrollRect.content.rect.height > activeScrollRect.viewport.rect.height;
			return;
		}
		rightStickScrollSupport.SetTargetScrollRect(activeScrollRect);
		Canvas.ForceUpdateCanvases();
		if (activeScrollRect.content != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(activeScrollRect.content);
		}
		bool flag = activeScrollRect.content != null && activeScrollRect.viewport != null && activeScrollRect.content.rect.height > activeScrollRect.viewport.rect.height;
		rightStickScrollSupport.SetForbidScroll(!flag);
		m_canRightStickScroll = flag;
	}

	private void ReBindBtnPrompt()
	{
		if (_allInputPrompt != null && !(gamePadGroup == null))
		{
			List<GamePadTipsAction> tipsActions = _tipsActions;
			if (tipsActions == null || tipsActions.Count <= 0)
			{
				_tipsActions = new List<GamePadTipsAction>();
			}
			gamePadGroup.ClearAllPrompts();
			_tipsActions.Clear();
			_tipsActions.Add(_allInputPrompt["UI/Back"]);
			if (m_canRightStickScroll)
			{
				_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
			}
			gamePadGroup.RegisterInputActions(_tipsActions);
		}
	}

	public void OnGamePadEquipGem()
	{
		m_GemTabConfig.confirmBtnComponent?.OnSubmit(new BaseEventData(EventSystemHelper.Shared));
	}

	public void OnNavigate(Vector2 value)
	{
		if (EventSystemHelper.CurrentSelected != null)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref curNavigateState, OnNavigateSelect);
		}
		else if (!root.ReFocus())
		{
			layer.Focus();
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
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	public void OnGamePadLockGem()
	{
		Gem targetGem = m_GemTabConfig.gemDetailPanel.Context;
		if (targetGem == null)
		{
			return;
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Lock");
		G.service.LockGem(targetGem.Uid, !targetGem.IsLock, (bool isSuccess) =>
		{
			if (isSuccess)
			{
				Gem gem = G.localPlayer.Inventory.GetGem(targetGem.Uid);
				m_GemTabConfig.gemDetailPanel.Context = gem;
				m_GemTabConfig.commonScrollBag.RefreshDatas();
				CommonScrollBagComponent gemBag = m_GemTabConfig.commonScrollBag;
				gemBag.OnUpdateEnd = null;
				CommonScrollBagComponent commonScrollBagComponent = gemBag;
				commonScrollBagComponent.OnUpdateEnd = (Action)Delegate.Combine(commonScrollBagComponent.OnUpdateEnd, (Action)(() =>
				{
					gemBag.OnUpdateEnd = null;
					RefreshRightStickScrollForbid();
					ReBindBtnPrompt();
				}));
			}
		});
	}

	public void OnGamePadShowAllFeature()
	{
		m_GemTabConfig.equipBuffDetail.OpenBuffDetail();
	}

	public void OnGamePadPagePre()
	{
		SwitchGemSlot(-1);
	}

	public void OnGamePadPageNext()
	{
		SwitchGemSlot(1);
	}

	public void OnRightStickNavigate(Vector2 value)
	{
		if (Mathf.Abs(value.x) >= 0.5f)
		{
			if (!m_RightStickHorizontalConsumed)
			{
				SwitchActiveScrollRect((value.x > 0f) ? 1 : (-1));
				m_RightStickHorizontalConsumed = true;
			}
		}
		else if (Mathf.Abs(value.x) <= 0.2f)
		{
			m_RightStickHorizontalConsumed = false;
		}
		ScrollRect activeScrollRect = GetActiveScrollRect();
		if (!(activeScrollRect == null) && m_canRightStickScroll)
		{
			activeScrollRect.velocity = new Vector2(0f, value.y * activeScrollRect.scrollSensitivity);
		}
	}

	private void SwitchActiveScrollRect(int step)
	{
		int availableScrollRectCount = GetAvailableScrollRectCount();
		if (availableScrollRectCount > 1)
		{
			m_ActiveScrollRectIndex = (m_ActiveScrollRectIndex + step + availableScrollRectCount) % availableScrollRectCount;
			RefreshRightStickScrollForbid();
			ReBindBtnPrompt();
		}
	}

	private int GetAvailableScrollRectCount()
	{
		int num = 0;
		if (m_ScrollRect1 != null)
		{
			num++;
		}
		if (m_ScrollRect2 != null)
		{
			num++;
		}
		return num;
	}

	private ScrollRect GetActiveScrollRect()
	{
		if (m_ScrollRect1 == null && m_ScrollRect2 == null)
		{
			return null;
		}
		if (m_ScrollRect1 != null && m_ScrollRect2 == null)
		{
			return m_ScrollRect1;
		}
		if (m_ScrollRect1 == null && m_ScrollRect2 != null)
		{
			return m_ScrollRect2;
		}
		if (m_ActiveScrollRectIndex != 0)
		{
			return m_ScrollRect2;
		}
		return m_ScrollRect1;
	}

	private void SwitchGemSlot(int step)
	{
		EquipGemSlot[] levelHoles = m_GemTabConfig.gemHoleItems.levelHoles;
		if (levelHoles == null || levelHoles.Length == 0 || step == 0)
		{
			return;
		}
		for (int i = ((m_FocusedSlot != null) ? m_FocusedSlot.Index : (-1)) + step; i >= 0 && i < levelHoles.Length; i += step)
		{
			EquipGemSlot equipGemSlot = levelHoles[i];
			if (equipGemSlot != null && equipGemSlot.gameObject.activeInHierarchy && equipGemSlot.GemSlotLevel > 0)
			{
				equipGemSlot.IsOn = true;
				break;
			}
		}
	}
}
