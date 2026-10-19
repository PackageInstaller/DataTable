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
using ACT.Sound;
using ACT.UI.DataProxy;
using ACT.UI.EquipSort;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model;
using Runtime.UI.CommonComponent;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class EquipmentSubView : SubUIView<EquipmentSubInputController>, ICharacterSubView, ISubUIView, IBaseUIComponent
{
	public class EquipData : UIViewData
	{
		public int selectedIndex;

		public CharacterView characterView;
	}

	[Header("背包配置")]
	public GameObject bagRoot;

	public GameObject emptyRoot;

	public LocalizeStringEvent emptyText;

	public CommonScrollBagComponent bagComponent;

	[Header("UI组件")]
	public GameObject empty;

	public BImage equipIcon;

	public GameObject[] equipQualityStyles;

	public EquipDetailInfo equipDetailInfo;

	public ActToggle[] equipSlotToggles;

	[Header("替换按钮")]
	public ActButton leftBtn;

	public LocalizeStringEvent leftText;

	[Header("升级按钮")]
	public ActButton rightBtn;

	[Header("满级提示")]
	public GameObject maxLevelTip;

	[Header("角色已装备提示")]
	public CommonCharacterEquipComponent characterEquipComponent;

	[SerializeField]
	private GemHoleItems m_HoleItems;

	[SerializeField]
	private ActToggleGroup m_HoleItemsToggleGroup;

	[SerializeField]
	private EquipSortPanel m_EquipSortPanel;

	[SerializeField]
	private ActButton m_EquipSortButton;

	[SerializeField]
	private ActButton m_EquipFilterToggle;

	[SerializeField]
	private LocalizeStringEvent m_EquipFilterText;

	public PublicToggle m_AllAttrToggle;

	[SerializeField]
	private ActButton m_EquipFeatureDetailButton;

	[SerializeField]
	private ActButton m_AllAttrDetailButton;

	public EquipBuffDetail equipBuffDetail;

	public GameObject equipDetailInfoRoot;

	[Header("动画")]
	[SerializeField]
	private BetterAnimation m_SubviewAnimation;

	[SerializeField]
	private BetterAnimation m_BagAnimation;

	public GamePadTipsComp gamePadGroup;

	[SerializeField]
	private List<GameObject> m_SubviewObjectsNormal;

	[SerializeField]
	private List<GameObject> m_SubviewObjectsFilterNavigate;

	[SerializeField]
	private List<GameObject> m_SubviewObjectsEquipSortOpen;

	[SerializeField]
	private List<GameObject> m_SubviewObjectsPopUpOpen;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	private EquipData m_EquipData;

	private int m_CurrEquipIndex = -1;

	private Character m_Character;

	private ImageAssetStation m_Station;

	private bool _afterAnimation;

	private int m_SubviewBackConsumedFrame = -1;

	private bool m_ReturnToFilterNavigateOnEquipSortClose;

	private int m_RestoreEquipmentLayerFocusVersion;

	private bool m_BagOpen;

	private List<ItemUnifierProxy> m_Equips;

	private bool m_canRightStickScroll = true;

	public ViewControlLayer layer;

	private ContinuousNavigateData curNavigateState;

	private bool m_IsSortButtonSelectedInFilterMode;

	public RightStickScrollSupport RightStickScrollSupport;

	public ScrollRect ActiveDescScrollRect;

	public RightStickScrollSupport PopUpRightStickScrollSupport;

	public ScrollRect PopUpActiveDescScrollRect;

	private int _curSelectToggleIndex = -1;

	public CharacterView CharacterView { get; private set; }

	public Equip CurEquip => G.localPlayer.Inventory.GetEquip(m_Character.GetEquipId(m_CurrEquipIndex + 1));

	public ItemUnifierProxy SelectedEquip => bagComponent.SelectedModels.FirstOrDefault();

	public int Depth => 2;

	public ICharacterSubView lastSubView { get; set; }

	public bool FreezeCharacterOSA => true;

	public CharacterViewScene.CvSceneType SceneType => CharacterViewScene.CvSceneType.EquipmentSubview;

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

	public EquipmentSubviewInputState SubviewInputState { get; private set; }

	public event Action OnCancel;

	public void Init(CharacterView characterView)
	{
		CharacterView = characterView;
	}

	private void Awake()
	{
		m_Equips = ListPool<ItemUnifierProxy>.Get();
		m_EquipSortButton.SetBtnClick(OpenEquipSortPanel);
		m_EquipFilterToggle.SetBtnClick(OpenEquipSuitFilterView);
		for (int i = 0; i < equipSlotToggles.Length; i++)
		{
			ActToggle obj = equipSlotToggles[i];
			int index1 = i;
			obj.onToggleOn.AddListener(() =>
			{
				SelectEquipSlot(index1);
			});
		}
	}

	protected override void OnFocusOut()
	{
		base.OnFocusOut();
		curNavigateState?.Reset();
	}

	protected override void OnUnityDestroy()
	{
		if (bagComponent != null)
		{
			CommonScrollBagComponent commonScrollBagComponent = bagComponent;
			commonScrollBagComponent.OnUpdateEnd = (Action)Delegate.Remove(commonScrollBagComponent.OnUpdateEnd, new Action(OnBagUpdateEndFocusLayer));
			bagComponent.OnItemShow = null;
		}
		ItemUnifierProxy.ItemUnifierPool.Release(m_Equips);
		ListPool<ItemUnifierProxy>.Release(m_Equips);
		m_Equips = null;
	}

	public void Show(int characterId, ImageAssetStation station, ICharacterSource characterSource)
	{
		SetSubviewInputState(EquipmentSubviewInputState.Normal);
		m_Station = station;
		AfterAnimation = false;
		gameObject.SetActive(value: true);
		m_AllAttrToggle.isOn = false;
		m_EquipData = Context as EquipData;
		m_Character = G.localPlayer.GetCharacter(characterId);
		SelectEquipSlot(m_EquipData.selectedIndex);
		if (Model<CharacterModel>.Interface.SelectFirstDiscSlotInEquipmentSubview)
		{
			TrySelectFirstDiscSlotForGamepad();
			Model<CharacterModel>.Interface.SelectFirstDiscSlotInEquipmentSubview = false;
		}
		equipDetailInfo.Open(m_Character);
		characterEquipComponent.Station = station;
		UpdateDetailPanel();
		leftBtn.OnClick.AddListener(OnLeftBtnClick);
		rightBtn.OnClick.AddListener(OnRightBtnClick);
		equipDetailInfo.SetToggle(0);
		m_HoleItems.OnSlotClick = null;
		GemHoleItems holeItems = m_HoleItems;
		holeItems.OnSlotClick = (Action<EquipGemSlot>)Delegate.Combine(holeItems.OnSlotClick, new Action<EquipGemSlot>(OnGemSlotClick));
		UpdateGemSlot();
		UpdateButton();
		UpdateEquipStyle();
		m_SubviewAnimation.GetSequence("Show")?.OnComplete((AnimationBuilder _) =>
		{
			AfterAnimation = true;
		}).Play();
		m_BagAnimation.GetSequence("Show")?.Play();
		try
		{
			CharacterViewScene.Default.OverrideAnimationName = () => "SubViewShow";
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, OnSelectedEquipValueChanged);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Equip/Select_Animation", new AudioPlayOptions
		{
			attachTarget = transform
		});
		OnGamePadInit();
		ReBindBtnPrompt();
		FocusIn();
	}

	private void OnGemSlotClick(EquipGemSlot obj)
	{
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.EquipSelectSlot);
		m_AllAttrToggle.isOn = false;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_EQUIPGEM, new EquipGemViewData
		{
			GemIndex = m_HoleItems.levelHoles.IndexOf(obj),
			Equip = (SelectedEquip.Source as Equip)
		});
	}

	public void Hide()
	{
		m_SubviewBackConsumedFrame = -1;
		SetSubviewInputState(EquipmentSubviewInputState.Normal);
		m_CurrEquipIndex = -1;
		leftBtn.OnClick.RemoveListener(OnLeftBtnClick);
		rightBtn.OnClick.RemoveListener(OnRightBtnClick);
		gameObject.SetActive(value: false);
		AfterAnimation = false;
		try
		{
			CharacterViewScene.Default.OverrideAnimationName = null;
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		m_AllAttrToggle.isOn = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, OnSelectedEquipValueChanged);
		if (bagComponent != null)
		{
			CommonScrollBagComponent commonScrollBagComponent = bagComponent;
			commonScrollBagComponent.OnUpdateEnd = (Action)Delegate.Remove(commonScrollBagComponent.OnUpdateEnd, new Action(OnBagUpdateEndFocusLayer));
		}
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(InputController, "UI/UISpecial4", value: false);
		FocusOut();
	}

	public void Freeze()
	{
		m_AllAttrToggle.isOn = false;
	}

	public void UnFreeze(int characterId)
	{
		UpdateGemSlot();
		UpdateDetailPanel();
	}

	public void OnPopStack()
	{
		UpdateGemSlot();
		UpdateButton();
		UpdateDetailPanel();
		m_AllAttrToggle.isOn = false;
	}

	public void OnSelectCharacter(ICharacterSource characterSource)
	{
		m_Character = CharacterDataHelper.GetCharacterByCharacterSource(characterSource);
	}

	public void OnLeftBtnClick()
	{
		if (leftText.StringReference.TableEntryReference != LocalizationCommonData.CommonString.Unload && SelectedEquip != null && SelectedEquip.As<Equip>().WearCharacter != 0)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
			{
				titleId = 0,
				commonId = 41000040,
				OnConfirm = EquipItem
			});
		}
		else
		{
			EquipItem();
		}
		if (leftText.StringReference.TableEntryReference == LocalizationCommonData.CommonString.EquipmentSubView)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Equip/Equip", new AudioPlayOptions
			{
				attachTarget = transform
			});
		}
		else if (leftText.StringReference.TableEntryReference == LocalizationCommonData.CommonString.Unload)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Equip/Equip_Unequip", new AudioPlayOptions
			{
				attachTarget = transform
			});
		}
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.EquipWeapon);
	}

	public void OnRightBtnClick()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Equip/Enhance_Click", new AudioPlayOptions
		{
			attachTarget = transform
		});
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.EquipOpenLevelUp);
		Equip equip = SelectedEquip?.As<Equip>() ?? CurEquip;
		UpdateDetailPanel();
		Freeze();
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_EQUIPLEVELUP, new EquipLevelUpViewData
		{
			TargetEquipUid = equip.Uid,
			GemIndex = -1,
			closeAction = () =>
			{
				UnFreeze(m_Character.Id);
			}
		}).Forget();
	}

	private void UpdateDetailPanel()
	{
		if (CurEquip == null)
		{
			characterEquipComponent.Character = null;
		}
		if (SelectedEquip != null && SelectedEquip != ItemUnifierProxy.Empty)
		{
			Character character = G.localPlayer.GetCharacter(SelectedEquip.As<Equip>().WearCharacter);
			characterEquipComponent.Character = character;
		}
		else
		{
			characterEquipComponent.Character = null;
		}
		equipDetailInfo.UpdateContrastInfo(m_Character, SelectedEquip?.As<Equip>(), m_CurrEquipIndex);
	}

	public void SelectEquipSlot(int equipIndex)
	{
		if (m_CurrEquipIndex != equipIndex)
		{
			m_CurrEquipIndex = equipIndex;
			UpdateDetailPanel();
			UpdateSortPanel();
			FocusLayerAfterBagUpdateEnd();
			OpenEquipBag();
			UpdateGemSlot();
			UpdateButton();
			UpdateEquipStyle();
			UpdateEquipSlotToggleStyle();
		}
		SyncEquipSlotTogglePageIndex();
	}

	private void SyncEquipSlotTogglePageIndex()
	{
		if (equipSlotToggles != null && equipSlotToggles.Length != 0 && m_CurrEquipIndex >= 0)
		{
			_curSelectToggleIndex = Mathf.Clamp(m_CurrEquipIndex, 0, equipSlotToggles.Length - 1);
		}
	}

	public bool TrySelectFirstDiscSlotForGamepad()
	{
		if (equipSlotToggles == null || equipSlotToggles.Length == 0)
		{
			return false;
		}
		ActToggle actToggle = equipSlotToggles[0];
		if (actToggle == null)
		{
			return false;
		}
		actToggle.SetIsOn(val: true);
		ACT.ViewControl.SelectableEx component = actToggle.GetComponent<ACT.ViewControl.SelectableEx>();
		if (component == null || layer == null)
		{
			return false;
		}
		layer.DefaultSelect = component;
		if (gameObject.activeInHierarchy && SubviewInputState == EquipmentSubviewInputState.Normal)
		{
			layer.Focus();
		}
		return true;
	}

	private void OpenEquipBag()
	{
		bagComponent.ResetPositionAfterUpdate = true;
		m_BagOpen = true;
		bagRoot.SetActive(value: true);
		ItemUnifierProxy.ItemUnifierPool.Release(m_Equips);
		List<Equip> allBagEquip = CharacterDependHelper.GetAllBagEquip();
		for (int num = allBagEquip.Count - 1; num >= 0; num--)
		{
			Equip equip = allBagEquip[num];
			if (equip == null || equip.TypeIndex - 1 != m_CurrEquipIndex)
			{
				allBagEquip.RemoveAt(num);
			}
		}
		if (allBagEquip.Count == 0)
		{
			SetEmptyStyle();
			return;
		}
		foreach (Equip item in allBagEquip)
		{
			if (CanAddToBag(item))
			{
				m_Equips.Add(ItemUnifierProxy.ItemUnifierPool.Get(item));
			}
		}
		if (m_Equips.Count == 0)
		{
			SetEmptyStyle(LocalizationCommonData.CommonString.WithoutEquips);
			return;
		}
		if (emptyRoot != null)
		{
			emptyRoot.gameObject.SetActive(value: false);
		}
		m_Equips.Sort((ItemUnifierProxy x, ItemUnifierProxy y) => SortUtility.SortEquip(x.As<Equip>(), y.As<Equip>()));
		m_EquipSortPanel.SortEquips(m_Equips);
		ItemUnifierProxy itemUnifierProxy = m_Equips.Find((ItemUnifierProxy x) => x.As<Equip>().WearCharacter == m_Character.Id);
		if (itemUnifierProxy != null)
		{
			m_Equips.Remove(itemUnifierProxy);
			m_Equips.Insert(0, itemUnifierProxy);
		}
		bagComponent.Station = m_Station;
		bagComponent.SelectedModels.Clear();
		bagComponent.ItemSource = m_Equips;
		ItemUnifierProxy itemUnifierProxy2 = null;
		if (CurEquip != null)
		{
			itemUnifierProxy2 = m_Equips.Find((ItemUnifierProxy x) => object.Equals(x.Source, CurEquip));
		}
		bagComponent.SelectedModels.Add(itemUnifierProxy2 ?? m_Equips[0]);
		bagComponent.OnItemSelect = null;
		CommonScrollBagComponent commonScrollBagComponent = bagComponent;
		commonScrollBagComponent.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent.OnItemSelect, new Action<ItemUIComponentBase>(OnSelectedEquip));
		bagComponent.OnItemShow = null;
		CommonScrollBagComponent commonScrollBagComponent2 = bagComponent;
		commonScrollBagComponent2.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent2.OnItemShow, new Action<ItemUIComponentBase>(OnBagEquipItemShow));
		bagComponent.ItemShowType = ItemUIComponentBase.InitType.BagEquip;
		UpdateFilterText();
	}

	private void FocusLayerAfterBagUpdateEnd()
	{
		if (!(bagComponent == null))
		{
			CommonScrollBagComponent commonScrollBagComponent = bagComponent;
			commonScrollBagComponent.OnUpdateEnd = (Action)Delegate.Remove(commonScrollBagComponent.OnUpdateEnd, new Action(OnBagUpdateEndFocusLayer));
			CommonScrollBagComponent commonScrollBagComponent2 = bagComponent;
			commonScrollBagComponent2.OnUpdateEnd = (Action)Delegate.Combine(commonScrollBagComponent2.OnUpdateEnd, new Action(OnBagUpdateEndFocusLayer));
		}
	}

	private void OnBagUpdateEndFocusLayer()
	{
		if (bagComponent != null)
		{
			CommonScrollBagComponent commonScrollBagComponent = bagComponent;
			commonScrollBagComponent.OnUpdateEnd = (Action)Delegate.Remove(commonScrollBagComponent.OnUpdateEnd, new Action(OnBagUpdateEndFocusLayer));
		}
		if (!(this == null) && gameObject.activeInHierarchy && SubviewInputState == EquipmentSubviewInputState.Normal)
		{
			layer?.Focus();
		}
	}

	public void OnSelectedEquip(ItemUIComponentBase equip)
	{
		UpdateDetailPanel();
		UpdateGemSlot();
		UpdateButton();
		UpdateEquipStyle();
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
	}

	public void CloseBag()
	{
		m_BagOpen = false;
		bagRoot.SetActive(value: false);
		m_HoleItemsToggleGroup.SetAllToggleOff();
		bagComponent.ItemSource = null;
		bagComponent.SelectedModels.Clear();
	}

	private void EquipItem()
	{
		if (leftText.StringReference.TableEntryReference == LocalizationCommonData.CommonString.Exchange || leftText.StringReference.TableEntryReference == LocalizationCommonData.CommonString.EquipmentSubView)
		{
			Equip equip = SelectedEquip.As<Equip>();
			G.service.CharacterWearEquip(equip.Uid, m_Character.Id, (bool success) =>
			{
				if (success)
				{
					UpdateGemSlot();
					UpdateDetailPanel();
					UpdateButton();
					UpdateEquipStyle();
				}
			});
			return;
		}
		G.service.CharacterWearEquip(CurEquip.Uid, 0, (bool isTrue) =>
		{
			if (isTrue)
			{
				UpdateGemSlot();
				UpdateDetailPanel();
				UpdateButton();
				UpdateEquipStyle();
			}
		});
	}

	private bool CanAddToBag(Equip equip)
	{
		if (equip == null)
		{
			return false;
		}
		if (equip.TypeIndex - 1 != m_CurrEquipIndex)
		{
			return false;
		}
		if (equip.WearCharacter == m_Character.Id)
		{
			return true;
		}
		EquipSlotInfo suitFilterInfo = GetSuitFilterInfo();
		if (suitFilterInfo != null && suitFilterInfo.SuitIDs != null && suitFilterInfo.SuitIDs.Count > 0)
		{
			foreach (int suitID in suitFilterInfo.SuitIDs)
			{
				EquipSuitData data = CoreUtils.GetData(suitID, RuntimeConfigs.data.equipSuitDatas);
				if (data == null)
				{
					return false;
				}
				if (data.equipList.Contains(equip.Id))
				{
					return true;
				}
			}
			return false;
		}
		return true;
	}

	private EquipSlotInfo GetSuitFilterInfo()
	{
		if (Model<EquipModel>.Interface.SlotInfos.TryGetValue(m_Character.Id, out var value) && value != null && value.Length != 0)
		{
			return value[0];
		}
		return null;
	}

	private void UpdateEquipSlotToggleStyle()
	{
		equipSlotToggles[m_CurrEquipIndex].SetIsOn(val: true);
	}

	private void UpdateGemSlot()
	{
		m_HoleItems.Init(SelectedEquip?.As<Equip>() ?? CurEquip);
		UpdateTakeOnGemInput();
	}

	private void UpdateTakeOnGemInput()
	{
		Equip equip = SelectedEquip?.As<Equip>() ?? CurEquip;
		bool flag = equip != null && equip.AvailableSlotCount > 0;
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(InputController, "UI/UISpecial4", !flag);
	}

	private void UpdateSortPanel()
	{
		m_EquipSortPanel.Init(m_Character, m_CurrEquipIndex);
		m_EquipSortPanel.OnClose = null;
		EquipSortPanel equipSortPanel = m_EquipSortPanel;
		equipSortPanel.OnClose = (Action)Delegate.Combine(equipSortPanel.OnClose, (Action)(() =>
		{
			if (m_EquipSortPanel.IsFocused)
			{
				m_EquipSortPanel.FocusOut();
			}
			ExitEquipSortPanelState();
			OpenEquipBag();
		}));
	}

	private void UpdateEquipStyle()
	{
		ItemUnifierProxy selectedEquip = SelectedEquip;
		for (int i = 0; i < equipQualityStyles.Length; i++)
		{
			equipQualityStyles[i].SetActive(i == ((selectedEquip != null) ? new int?(selectedEquip.Quality - 1) : ((int?)null)));
		}
		empty.SetActive(selectedEquip == null);
		equipIcon.icon.gameObject.SetActive(selectedEquip != null);
		if (selectedEquip != null)
		{
			ItemData data = CoreUtils.GetData(selectedEquip.Id, RuntimeConfigs.data.itemDatas);
			m_Station.LoadItemIconAsync(data?.iconAddress ?? 0, equipIcon).Forget();
			if (Model<InventoryModel>.Interface.GetItemRedDotState(selectedEquip))
			{
				Model<InventoryModel>.Interface.SetItemRedDotState(InventoryTab.Equip, selectedEquip);
			}
		}
	}

	private void UpdateButton()
	{
		if (CurEquip == null && SelectedEquip == null)
		{
			leftBtn.gameObject.SetActive(value: false);
			rightBtn.gameObject.SetActive(value: false);
			maxLevelTip.SetActive(value: false);
			return;
		}
		if (SelectedEquip != null)
		{
			Equip equip = SelectedEquip.As<Equip>();
			int num = RuntimeConfigs.data.game.equipRareLevel[SelectedEquip.Quality - 1];
			rightBtn.gameObject.SetActive(equip.Level < num);
			rightBtn.Interactable(m_Equips.Count > 0);
			maxLevelTip.SetActive(equip.Level >= num);
		}
		leftBtn.gameObject.SetActive(m_Equips.Count > 0);
		leftBtn.Interactable(active: true);
		if (CurEquip == null)
		{
			leftText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.EquipmentSubView;
		}
		else if (SelectedEquip != null && CurEquip != null)
		{
			leftText.StringReference.TableEntryReference = ((CurEquip.WearCharacter == SelectedEquip.As<Equip>().WearCharacter) ? LocalizationCommonData.CommonString.Unload : LocalizationCommonData.CommonString.Exchange);
		}
	}

	private void SetEmptyStyle(LocalizationCommonData.CommonString emptyType = LocalizationCommonData.CommonString.NoEquip)
	{
		if (emptyRoot != null)
		{
			emptyRoot.gameObject.SetActive(value: true);
			emptyText.StringReference.TableEntryReference = emptyType;
		}
		bagComponent.OnItemSelect = null;
		bagComponent.ItemSource = m_Equips;
		bagComponent.SelectedModels.Clear();
		UpdateDetailPanel();
		UpdateEquipStyle();
		UpdateButton();
		UpdateGemSlot();
		UpdateFilterText();
	}

	private void UpdateFilterText()
	{
		bool flag = false;
		EquipSlotInfo suitFilterInfo = GetSuitFilterInfo();
		if (suitFilterInfo != null && suitFilterInfo.SuitIDs != null && suitFilterInfo.SuitIDs.Count > 0)
		{
			flag = true;
		}
		m_EquipFilterText.StringReference.TableEntryReference = (flag ? LocalizationCommonData.CommonString.SuitFilterApplying : LocalizationCommonData.CommonString.SuitFilter);
	}

	private void OnSelectedEquipValueChanged(BaseEventContent evt)
	{
		if (evt is ItemChangeEvt itemChangeEvt && itemChangeEvt.ItemProxies.Find((ItemUnifierProxy x) => object.Equals(x.Source, SelectedEquip?.Source) || object.Equals(x.Source, CurEquip)) != null)
		{
			UpdateGemSlot();
			UpdateDetailPanel();
			RefreshRightStickScrollForbid();
			ReBindBtnPrompt();
		}
	}

	private void OnBagEquipItemShow(ItemUIComponentBase cell)
	{
		if (!(cell == null))
		{
			if (!(cell.ItemUnifier?.Source is Equip))
			{
				cell.RedPointPath = string.Empty;
				return;
			}
			cell.RedDotType = RedDotType.Dot;
			cell.RedPointPath = Model<InventoryModel>.Interface.GetItemRedDotPath(InventoryTab.Equip, cell.ItemUnifier);
		}
	}

	private void OnBagItemClicked(ItemUIComponentBase cell)
	{
		_ = (cell?.ItemUnifier)?.Source is Equip;
	}

	public void OpenEquipSuitFilterView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_EQUIPSUITFILTER, new EquipSuitFilterViewData
		{
			Character = m_Character,
			EquipSlotIndex = m_CurrEquipIndex,
			CloseAction = () =>
			{
				SetSubviewInputState(EquipmentSubviewInputState.Normal);
				UpdateSortPanel();
				OpenEquipBag();
			}
		});
	}

	private void RefreshRightStickScrollForbid()
	{
		ScrollRect scrollRect = ((SubviewInputState == EquipmentSubviewInputState.PopUpOpen) ? PopUpActiveDescScrollRect : ActiveDescScrollRect);
		RightStickScrollSupport rightStickScrollSupport = ((SubviewInputState == EquipmentSubviewInputState.PopUpOpen) ? PopUpRightStickScrollSupport : RightStickScrollSupport);
		if (!(rightStickScrollSupport == null) && !(scrollRect == null))
		{
			Canvas.ForceUpdateCanvases();
			if (scrollRect.content != null)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(scrollRect.content);
			}
			bool flag = scrollRect.content != null && scrollRect.viewport != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
			rightStickScrollSupport.SetForbidScroll(!flag);
			m_canRightStickScroll = flag;
		}
	}

	public void OpenEquipSortPanel()
	{
		if (SubviewInputState == EquipmentSubviewInputState.FilterNavigate)
		{
			m_ReturnToFilterNavigateOnEquipSortClose = true;
		}
		SetSubviewInputState(EquipmentSubviewInputState.EquipSortOpen);
		m_EquipSortPanel.Open();
		m_EquipSortPanel.FocusIn();
		if (EventSystemHelper.Available && m_EquipSortPanel?.settingButton != null)
		{
			EventSystemHelper.SetSelectedGameObject(m_EquipSortPanel.settingButton.gameObject);
		}
	}

	private void SetSubviewInputState(EquipmentSubviewInputState state)
	{
		EquipmentSubviewInputState subviewInputState = SubviewInputState;
		if (subviewInputState != state)
		{
			ClearSubviewSelectionOnStateChange(subviewInputState);
			SubviewInputState = state;
			ApplySubviewStateObjectsVisibility();
			ReBindBtnPrompt();
			switch (state)
			{
			case EquipmentSubviewInputState.FilterNavigate:
				FocusEquipFilterModeTarget();
				break;
			case EquipmentSubviewInputState.Normal:
				ScheduleRestoreEquipmentLayerFocus();
				break;
			}
		}
	}

	private void ExitEquipSortPanelState()
	{
		if (m_ReturnToFilterNavigateOnEquipSortClose)
		{
			m_IsSortButtonSelectedInFilterMode = true;
			m_ReturnToFilterNavigateOnEquipSortClose = false;
			SetSubviewInputState(EquipmentSubviewInputState.FilterNavigate);
		}
		else
		{
			SetSubviewInputState(EquipmentSubviewInputState.Normal);
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (!gameObject.activeInHierarchy)
		{
			return;
		}
		if (type != DeviceInputMode.Gamepad)
		{
			if (SubviewInputState == EquipmentSubviewInputState.FilterNavigate)
			{
				SetSubviewInputState(EquipmentSubviewInputState.Normal);
			}
		}
		else
		{
			CloseEquipSortPanelIfOpen();
			ClosePopUpPanelIfOpen();
			layer.Focus();
		}
	}

	private void CloseEquipSortPanelIfOpen()
	{
		if (m_EquipSortPanel == null)
		{
			return;
		}
		if (!m_EquipSortPanel.gameObject.activeInHierarchy)
		{
			if (SubviewInputState == EquipmentSubviewInputState.EquipSortOpen)
			{
				ExitEquipSortPanelState();
			}
			return;
		}
		m_EquipSortPanel.Close();
		if (m_EquipSortPanel.IsFocused)
		{
			m_EquipSortPanel.FocusOut();
		}
	}

	private void ClosePopUpPanelIfOpen()
	{
		if ((equipDetailInfoRoot != null && equipDetailInfoRoot.activeSelf) || SubviewInputState == EquipmentSubviewInputState.PopUpOpen)
		{
			SetPopUpOpen(open: false);
		}
	}

	private void ClearSubviewSelectionOnStateChange(EquipmentSubviewInputState fromState)
	{
		if (fromState == EquipmentSubviewInputState.FilterNavigate)
		{
			ClearFilterButtonHover();
		}
		ClearEventSystemSelection();
	}

	private static void ClearEventSystemSelection()
	{
		if (!EventSystemHelper.Available)
		{
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (IDeselectHandler handler, BaseEventData data) =>
			{
				handler?.OnDeselect(data);
			});
			EventSystemHelper.SetSelectedGameObject(null);
		}
	}

	private void ClearFilterButtonHover()
	{
		if (EventSystemHelper.Available)
		{
			PointerEventData eventData = new PointerEventData(EventSystemHelper.Shared);
			ExecuteEvents.Execute(m_EquipSortButton?.gameObject, eventData, (IPointerExitHandler handler, BaseEventData data) =>
			{
				handler?.OnPointerExit((PointerEventData)data);
			});
			ExecuteEvents.Execute(m_EquipFilterToggle?.gameObject, eventData, (IPointerExitHandler handler, BaseEventData data) =>
			{
				handler?.OnPointerExit((PointerEventData)data);
			});
		}
	}

	private void ApplySubviewStateObjectsVisibility()
	{
		SetListActiveForState(m_SubviewObjectsFilterNavigate, SubviewInputState == EquipmentSubviewInputState.FilterNavigate);
		SetListActiveForState(m_SubviewObjectsEquipSortOpen, SubviewInputState == EquipmentSubviewInputState.EquipSortOpen);
		SetListActiveForState(m_SubviewObjectsPopUpOpen, SubviewInputState == EquipmentSubviewInputState.PopUpOpen);
		SetListActiveForState(m_SubviewObjectsNormal, SubviewInputState == EquipmentSubviewInputState.Normal);
	}

	private static void SetListActiveForState(List<GameObject> list, bool active)
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

	private void RaiseOnCancel()
	{
		OnCancel?.Invoke();
	}

	public bool TryConsumeSubviewBack()
	{
		if (Time.frameCount == m_SubviewBackConsumedFrame)
		{
			return true;
		}
		bool flag = m_EquipSortPanel != null && m_EquipSortPanel.gameObject.activeInHierarchy;
		if (SubviewInputState == EquipmentSubviewInputState.FilterNavigate)
		{
			SetSubviewInputState(EquipmentSubviewInputState.Normal);
			m_SubviewBackConsumedFrame = Time.frameCount;
			RaiseOnCancel();
			return true;
		}
		if (SubviewInputState == EquipmentSubviewInputState.PopUpOpen)
		{
			SetPopUpOpen(open: false);
			m_SubviewBackConsumedFrame = Time.frameCount;
			RaiseOnCancel();
			return true;
		}
		if ((SubviewInputState == EquipmentSubviewInputState.EquipSortOpen) | flag)
		{
			if (flag)
			{
				m_EquipSortPanel.Close();
				if (m_EquipSortPanel.IsFocused)
				{
					m_EquipSortPanel.FocusOut();
				}
			}
			else
			{
				ExitEquipSortPanelState();
			}
			m_SubviewBackConsumedFrame = Time.frameCount;
			RaiseOnCancel();
			return true;
		}
		return false;
	}

	private void ScheduleRestoreEquipmentLayerFocus()
	{
		RestoreEquipmentLayerFocusNextFrame(++m_RestoreEquipmentLayerFocusVersion).Forget();
	}

	private async UniTask RestoreEquipmentLayerFocusNextFrame(int version)
	{
		await UniTask.NextFrame();
		RestoreEquipmentLayerFocus(version);
	}

	private void RestoreEquipmentLayerFocus(int version)
	{
		if (version == m_RestoreEquipmentLayerFocusVersion && !(this == null) && gameObject.activeInHierarchy && SubviewInputState == EquipmentSubviewInputState.Normal && EventSystemHelper.Available)
		{
			if (layer != null)
			{
				layer.Focus();
			}
			else
			{
				layer.Root?.ReFocus();
			}
		}
	}

	public void CloseEquipmentSubview()
	{
		m_EquipData.characterView.CloseEquipSubView();
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
		switch (SubviewInputState)
		{
		case EquipmentSubviewInputState.FilterNavigate:
			_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
			_tipsActions.Add(_allInputPrompt["UI/Back"]);
			break;
		case EquipmentSubviewInputState.PopUpOpen:
			if (m_canRightStickScroll)
			{
				_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
			}
			_tipsActions.Add(_allInputPrompt["UI/Back"]);
			break;
		case EquipmentSubviewInputState.EquipSortOpen:
			_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
			_tipsActions.Add(_allInputPrompt["UI/Back"]);
			break;
		default:
			_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
			_tipsActions.Add(_allInputPrompt["UI/Back"]);
			if (m_canRightStickScroll)
			{
				_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
			}
			break;
		}
		gamePadGroup.RegisterInputActions(_tipsActions);
	}

	public void OnConfirm()
	{
		if (SubviewInputState == EquipmentSubviewInputState.PopUpOpen || SubviewInputState == EquipmentSubviewInputState.EquipSortOpen)
		{
			return;
		}
		if (SubviewInputState == EquipmentSubviewInputState.FilterNavigate)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (currentSelected == m_EquipSortButton?.gameObject)
			{
				m_ReturnToFilterNavigateOnEquipSortClose = true;
			}
			if (currentSelected != m_EquipFilterToggle?.gameObject)
			{
				SetSubviewInputState(EquipmentSubviewInputState.Normal);
			}
			if (currentSelected != null && EventSystemHelper.Available)
			{
				ExecuteEvents.Execute(currentSelected, new PointerEventData(EventSystemHelper.Shared), ExecuteEvents.pointerClickHandler);
			}
		}
		if (SubviewInputState == EquipmentSubviewInputState.Normal)
		{
			leftBtn?.OnSubmit(new BaseEventData(EventSystemHelper.Shared));
		}
	}

	public void OnUpgrade()
	{
		rightBtn?.OnSubmit(new BaseEventData(EventSystemHelper.Shared));
	}

	public void OnTakeOff()
	{
		leftBtn?.OnSubmit(new BaseEventData(EventSystemHelper.Shared));
	}

	public void OnNavigate(Vector2 value)
	{
		if (SubviewInputState != EquipmentSubviewInputState.PopUpOpen && SubviewInputState != EquipmentSubviewInputState.EquipSortOpen)
		{
			if (SubviewInputState == EquipmentSubviewInputState.FilterNavigate)
			{
				ContinuousNavigateUtility.StartContinuousNavigate(value, ref curNavigateState, OnEquipFilterNavigateSelect);
			}
			else if (EventSystemHelper.CurrentSelected != null)
			{
				ContinuousNavigateUtility.StartContinuousNavigate(value, ref curNavigateState, OnNavigateSelect);
			}
			else
			{
				layer.Focus();
			}
		}
	}

	private void OnNavigateSelect(MoveDirection moveDirection)
	{
		switch (moveDirection)
		{
		case MoveDirection.Down:
			layer.Root.SelectDown();
			break;
		case MoveDirection.Left:
			layer.Root.SelectLeft();
			break;
		case MoveDirection.Up:
			layer.Root.SelectUp();
			break;
		case MoveDirection.Right:
			layer.Root.SelectRight();
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

	public bool IsEquipSortPanelOpen()
	{
		if (SubviewInputState != EquipmentSubviewInputState.EquipSortOpen)
		{
			if (m_EquipSortPanel != null)
			{
				return m_EquipSortPanel.gameObject.activeInHierarchy;
			}
			return false;
		}
		return true;
	}

	private void OnEquipFilterNavigateSelect(MoveDirection moveDirection)
	{
		if (moveDirection == MoveDirection.Left || moveDirection == MoveDirection.Right)
		{
			m_IsSortButtonSelectedInFilterMode = !m_IsSortButtonSelectedInFilterMode;
			FocusEquipFilterModeTarget();
		}
	}

	private void FocusEquipFilterModeTarget()
	{
		if (!EventSystemHelper.Available)
		{
			return;
		}
		GameObject gameObject = ((!m_IsSortButtonSelectedInFilterMode) ? m_EquipFilterToggle?.gameObject : m_EquipSortButton?.gameObject);
		GameObject target = (m_IsSortButtonSelectedInFilterMode ? m_EquipFilterToggle?.gameObject : m_EquipSortButton?.gameObject);
		if (gameObject != null)
		{
			EventSystemHelper.SetSelectedGameObject(gameObject);
			ExecuteEvents.Execute(gameObject, new PointerEventData(EventSystemHelper.Shared), (IPointerEnterHandler handler, BaseEventData data) =>
			{
				handler?.OnPointerEnter((PointerEventData)data);
			});
			ExecuteEvents.Execute(target, new PointerEventData(EventSystemHelper.Shared), (IPointerExitHandler handler, BaseEventData data) =>
			{
				handler?.OnPointerExit((PointerEventData)data);
			});
		}
	}

	public void OnRightStickNavigate(Vector2 value)
	{
		if (!m_canRightStickScroll)
		{
			return;
		}
		ScrollRect scrollRect = ((SubviewInputState == EquipmentSubviewInputState.PopUpOpen) ? PopUpActiveDescScrollRect : ActiveDescScrollRect);
		if (SubviewInputState != EquipmentSubviewInputState.FilterNavigate && SubviewInputState != EquipmentSubviewInputState.EquipSortOpen)
		{
			ScrollRect scrollRect2 = scrollRect;
			if (!(scrollRect2 == null))
			{
				scrollRect2.velocity = new Vector2(0f, value.y * scrollRect.scrollSensitivity);
			}
		}
	}

	public void OnEquipSuitFilter()
	{
		m_IsSortButtonSelectedInFilterMode = false;
		SetSubviewInputState(EquipmentSubviewInputState.FilterNavigate);
	}

	public void OnChangeLockState()
	{
		equipDetailInfo?.gemLockBtn?.lockBtn?.OnSubmit(new BaseEventData(EventSystemHelper.Shared));
	}

	public void ShowEquipFeature()
	{
		m_EquipFeatureDetailButton?.OnSubmit(new BaseEventData(EventSystemHelper.Shared));
	}

	public void TakeOnGem()
	{
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.EquipSelectSlot);
		Equip equip = SelectedEquip?.As<Equip>() ?? CurEquip;
		if (equip != null && equip.AvailableSlotCount != 0)
		{
			m_AllAttrToggle.isOn = false;
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_EQUIPGEM, new EquipGemViewData
			{
				GemIndex = 0,
				Equip = equip
			});
		}
	}

	public void ShowAllFeature()
	{
		if (SubviewInputState == EquipmentSubviewInputState.PopUpOpen)
		{
			m_AllAttrDetailButton?.OnSubmit(new BaseEventData(EventSystemHelper.Shared));
		}
	}

	public void OpenPopUp()
	{
		if (!(m_AllAttrToggle == null))
		{
			m_AllAttrToggle.OnSubmit(new BaseEventData(EventSystemHelper.Shared));
			SetPopUpOpen(m_AllAttrToggle.isOn);
		}
	}

	private void SetPopUpOpen(bool open)
	{
		if (m_AllAttrToggle != null)
		{
			m_AllAttrToggle.isOn = open;
		}
		if (equipDetailInfoRoot != null)
		{
			equipDetailInfoRoot.SetActive(open);
		}
		SetSubviewInputState(open ? EquipmentSubviewInputState.PopUpOpen : EquipmentSubviewInputState.Normal);
		RefreshRightStickScrollForbid();
	}

	public void OnPagePre()
	{
		if (_curSelectToggleIndex > 0)
		{
			_curSelectToggleIndex--;
			for (int i = 0; i < equipSlotToggles.Length; i++)
			{
				equipSlotToggles[i].SetIsOn(i == _curSelectToggleIndex);
			}
		}
	}

	public void OnPageNext()
	{
		if (_curSelectToggleIndex < equipSlotToggles.Length - 1)
		{
			_curSelectToggleIndex++;
			for (int i = 0; i < equipSlotToggles.Length; i++)
			{
				equipSlotToggles[i].SetIsOn(i == _curSelectToggleIndex);
			}
		}
	}
}
