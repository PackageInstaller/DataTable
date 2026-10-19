using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class PopupTargetGachaView : BaseUIView<PopupTargetGachaViewInputController>
{
	[SerializeField]
	private ActButton closeButton;

	[SerializeField]
	private PopupTargetGachaViewTab tab;

	[SerializeField]
	private GameObject characterPage;

	[SerializeField]
	private GameObject rulePage;

	[SerializeField]
	private GameObject targetSelectedRoot;

	[SerializeField]
	private GameObject targetSelectionRoot;

	[SerializeField]
	private ResidentionalRewardCharacterCard selectedCharacterCard;

	[SerializeField]
	private Transform selectionCharacterCardRoot;

	[SerializeField]
	private GameObject characterCardPrefab;

	[SerializeField]
	private List<ResidentionalRewardCharacterCard> selectionCharacterCards = new List<ResidentionalRewardCharacterCard>();

	[SerializeField]
	public ViewControlRoot viewControlRoot;

	[SerializeField]
	public ViewControlLayer viewControlLayer;

	[SerializeField]
	private ActButton confirmButton;

	[SerializeField]
	private LocalizeStringEvent confirmButtonText;

	[SerializeField]
	private LocalizeStringEvent chargeValueText;

	[SerializeField]
	private ScrollRect ruleScrollRect;

	private PopupTargetGachaViewData m_data;

	private List<GachaItem> targetGachaItems;

	private int selectedTargetGachaItemId;

	private int currentTargetGachaItemId;

	private bool isCommunicating;

	public override async UniTask PreInit()
	{
		m_data = uiViewData as PopupTargetGachaViewData;
		closeButton?.SetBtnClick(Close, "event:/UI/Common/Popup_Close");
		confirmButton?.SetBtnClick(ConfirmOrCancelTarget);
		BindTabEvents();
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		ResetViewState();
		InitializeTargetState();
		RefreshChargeValue();
	}

	protected override void UnInit()
	{
		UnbindTabEvents();
		HideCharacterCards();
		targetGachaItems = null;
		selectedTargetGachaItemId = 0;
		currentTargetGachaItemId = 0;
		isCommunicating = false;
		m_data = null;
		base.UnInit();
	}

	protected override void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_GachaTargetStateChanged, OnGachaTargetStateChanged);
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_GachaTargetStateChanged, OnGachaTargetStateChanged);
		base.RemoveEventListener();
	}

	private void OnGachaTargetStateChanged(BaseEventContent obj)
	{
		if (obj is GachaTargetStateChangedEvent gachaTargetStateChangedEvent && m_data != null && gachaTargetStateChangedEvent.GachaId == m_data.GachaId)
		{
			currentTargetGachaItemId = gachaTargetStateChangedEvent.TargetGachaItemId;
			RefreshChargeValue();
			if (currentTargetGachaItemId == 0)
			{
				ShowTargetSelection();
			}
			else
			{
				ShowCurrentTarget();
			}
		}
	}

	private void BindTabEvents()
	{
		if (tab?.tabItems != null && tab.tabItems.Count >= 2)
		{
			tab.tabItems[0].onClick.AddListener(ShowCharacterPage);
			tab.tabItems[1].onClick.AddListener(ShowRulePage);
		}
	}

	private void UnbindTabEvents()
	{
		if (tab?.tabItems != null && tab.tabItems.Count >= 2)
		{
			tab.tabItems[0].onClick.RemoveListener(ShowCharacterPage);
			tab.tabItems[1].onClick.RemoveListener(ShowRulePage);
		}
	}

	private void ShowCharacterPage()
	{
		if (!isCommunicating && (!(tab != null) || tab.TrySwitchTo(0)))
		{
			SetCharacterPageActive(showCharacterPage: true);
			FocusFirstTargetCharacter();
			SelectFirstTargetCharacter();
		}
	}

	private void ShowRulePage()
	{
		if (!isCommunicating && (!(tab != null) || tab.TrySwitchTo(1)))
		{
			SetCharacterPageActive(showCharacterPage: false);
		}
	}

	private void SetCharacterPageActive(bool showCharacterPage)
	{
		characterPage?.SetActive(showCharacterPage);
		rulePage?.SetActive(!showCharacterPage);
		if (showCharacterPage && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			viewControlLayer?.Focus();
		}
	}

	private void ResetViewState()
	{
		selectedTargetGachaItemId = 0;
		currentTargetGachaItemId = 0;
		isCommunicating = false;
		tab?.SwitchToImmediately(0);
		if (ruleScrollRect != null)
		{
			ruleScrollRect.verticalNormalizedPosition = 1f;
		}
		SetCharacterPageActive(showCharacterPage: true);
	}

	private void InitializeTargetState()
	{
		targetGachaItems = ResolveTargetGachaItems();
		currentTargetGachaItemId = ((m_data != null) ? (Model<CardDrawModel>.Interface.GetGachaPoolUniqueData(m_data.GachaId)?.TargetGachaItemId ?? 0) : 0);
		if (currentTargetGachaItemId != 0)
		{
			ShowCurrentTarget();
		}
		else
		{
			ShowTargetSelection();
		}
	}

	private void ShowCurrentTarget()
	{
		HideCharacterCards();
		targetSelectedRoot?.SetActive(value: true);
		targetSelectionRoot?.SetActive(value: false);
		selectedTargetGachaItemId = 0;
		SetConfirmButtonText(LocalizationCommonData.CommonString.TargetGachaCancel);
		GachaItem gachaItem = targetGachaItems?.Find((GachaItem item) => item.id == currentTargetGachaItemId);
		if (gachaItem == null)
		{
			LogConfigError($"服务端定轨目标 {currentTargetGachaItemId} 未在角色池中找到");
			confirmButton?.Interactable(active: false);
			return;
		}
		if (selectedCharacterCard == null)
		{
			LogConfigError("未绑定当前定轨角色卡");
			confirmButton?.Interactable(active: false);
			return;
		}
		selectedCharacterCard.gameObject.SetActive(value: true);
		selectedCharacterCard.Init(gachaItem, Station);
		selectedCharacterCard.GoSelect.SetActive(value: true);
		selectedCharacterCard.GoCharacterCardMask.SetActive(value: false);
		selectedCharacterCard.BtnClick.SetBtnClick(null);
		selectedCharacterCard.BtnClick.Interactable(active: false);
		confirmButton?.Interactable(active: true);
	}

	private void ShowTargetSelection()
	{
		HideCharacterCards();
		targetSelectedRoot?.SetActive(value: false);
		targetSelectionRoot?.SetActive(value: true);
		currentTargetGachaItemId = 0;
		selectedTargetGachaItemId = 0;
		SetConfirmButtonText(LocalizationCommonData.CommonString.TargetGachaSelect);
		confirmButton?.Interactable(active: false);
		if (targetGachaItems != null)
		{
			RefreshCharacterCards(selectionCharacterCardRoot, selectionCharacterCards, targetGachaItems, selectable: true);
			if (targetGachaItems.Count > 0)
			{
				FocusFirstTargetCharacter();
				SelectFirstTargetCharacter();
			}
		}
	}

	private void SelectFirstTargetCharacter()
	{
		if (currentTargetGachaItemId == 0 && selectionCharacterCards.Count != 0)
		{
			ResidentionalRewardCharacterCard residentionalRewardCharacterCard = selectionCharacterCards[0];
			if (residentionalRewardCharacterCard != null && residentionalRewardCharacterCard.gameObject.activeInHierarchy)
			{
				SelectCharacter(residentionalRewardCharacterCard.id);
			}
		}
	}

	private void FocusFirstTargetCharacter()
	{
		if (selectionCharacterCards.Count != 0)
		{
			FocusTargetCharacter(selectionCharacterCards[0]);
		}
	}

	public void FocusSelectedTargetCharacter()
	{
		if (currentTargetGachaItemId == 0 && !(targetSelectionRoot == null) && targetSelectionRoot.activeInHierarchy)
		{
			ResidentionalRewardCharacterCard residentionalRewardCharacterCard = selectionCharacterCards.Find((ResidentionalRewardCharacterCard card) => card != null && card.id == selectedTargetGachaItemId);
			FocusTargetCharacter(residentionalRewardCharacterCard ?? ((selectionCharacterCards.Count > 0) ? selectionCharacterCards[0] : null));
		}
	}

	private void FocusTargetCharacter(ResidentionalRewardCharacterCard card)
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad && !(viewControlLayer == null) && !(card == null) && card.gameObject.activeInHierarchy && !(card.BtnClick == null))
		{
			ACT.ViewControl.SelectableEx component = card.BtnClick.GetComponent<ACT.ViewControl.SelectableEx>();
			if (!(component == null))
			{
				viewControlLayer.SetDefaultSelect(component);
				viewControlLayer.ReFocus();
				RefreshSelectedCharacterByGamepad();
			}
		}
	}

	private void RefreshCharacterCards(Transform root, List<ResidentionalRewardCharacterCard> cards, List<GachaItem> targetItems, bool selectable)
	{
		if (root == null || characterCardPrefab == null || targetItems == null)
		{
			return;
		}
		while (cards.Count < targetItems.Count)
		{
			cards.Add(UIUtility.AddWidget<ResidentionalRewardCharacterCard>(root, characterCardPrefab));
		}
		for (int i = 0; i < cards.Count; i++)
		{
			ResidentionalRewardCharacterCard residentionalRewardCharacterCard = cards[i];
			bool flag = i < targetItems.Count;
			residentionalRewardCharacterCard.gameObject.SetActive(flag);
			if (!flag)
			{
				continue;
			}
			GachaItem targetItem = targetItems[i];
			residentionalRewardCharacterCard.Init(targetItem, Station);
			residentionalRewardCharacterCard.GoSelect.SetActive(value: false);
			residentionalRewardCharacterCard.GoCharacterCardMask.SetActive(value: false);
			if (selectable)
			{
				residentionalRewardCharacterCard.BtnClick.SetBtnClick(() =>
				{
					SelectCharacter(targetItem.id);
				}, "event:/UI/Interface/DrawCard/RoleChoise");
				residentionalRewardCharacterCard.BtnClick.Interactable(active: true);
			}
			else
			{
				residentionalRewardCharacterCard.BtnClick.SetBtnClick(null);
				residentionalRewardCharacterCard.BtnClick.Interactable(active: false);
			}
		}
	}

	private void SetConfirmButtonText(LocalizationCommonData.CommonString localizeId)
	{
		if (confirmButtonText != null)
		{
			confirmButtonText.SetTable("Common");
			confirmButtonText.StringReference.TableEntryReference = localizeId;
		}
	}

	private void RefreshChargeValue()
	{
		if (!(chargeValueText == null) && m_data != null && RuntimeConfigs.data != null)
		{
			GachaPoolUniqueData gachaPoolUniqueData = Model<CardDrawModel>.Interface.GetGachaPoolUniqueData(m_data.GachaId);
			Gacha data = CoreUtils.GetData(m_data.GachaId, RuntimeConfigs.data.gachas);
			if (data == null)
			{
				LogConfigError($"Gacha {m_data.GachaId} 不存在，无法刷新充能值");
			}
			chargeValueText.SetTable("Common");
			chargeValueText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.ChargeValueText;
			chargeValueText.GetVariable<int>("0").Value = gachaPoolUniqueData?.TargetPoint ?? 0;
			chargeValueText.GetVariable<int>("1").Value = data?.maxTargetPoint ?? 0;
		}
	}

	private List<GachaItem> ResolveTargetGachaItems()
	{
		List<GachaItem> list = new List<GachaItem>();
		if (m_data == null || RuntimeConfigs.data == null)
		{
			LogConfigError("缺少弹窗参数或运行时配置");
			return list;
		}
		Gacha data = CoreUtils.GetData(m_data.GachaId, RuntimeConfigs.data.gachas);
		if (data == null)
		{
			LogConfigError($"Gacha {m_data.GachaId} 不存在");
			return list;
		}
		GachaPool data2 = CoreUtils.GetData(data.targetCharacterPool, RuntimeConfigs.data.gachaPools);
		if (data2 == null)
		{
			LogConfigError($"Gacha {data.id} 缺少定轨角色池");
			return list;
		}
		for (int i = 0; i < data2.gachaItemIDs.Length; i++)
		{
			GachaItem data3 = CoreUtils.GetData(data2.gachaItemIDs[i], RuntimeConfigs.data.gachaItems);
			if (data3 == null)
			{
				LogConfigError($"GachaItem {data2.gachaItemIDs[i]} 不存在");
			}
			else
			{
				list.Add(data3);
			}
		}
		return list;
	}

	private static void LogConfigError(string message)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("[PopupTargetGachaView] " + message);
		}
	}

	private void SelectCharacter(int targetGachaItemId)
	{
		if (isCommunicating || currentTargetGachaItemId != 0)
		{
			return;
		}
		selectedTargetGachaItemId = targetGachaItemId;
		for (int i = 0; i < selectionCharacterCards.Count; i++)
		{
			ResidentionalRewardCharacterCard residentionalRewardCharacterCard = selectionCharacterCards[i];
			if (residentionalRewardCharacterCard.gameObject.activeSelf)
			{
				bool active = residentionalRewardCharacterCard.id == selectedTargetGachaItemId;
				residentionalRewardCharacterCard.GoSelect.SetActive(active);
				residentionalRewardCharacterCard.GoCharacterCardMask.SetActive(value: false);
			}
		}
		confirmButton?.Interactable(active: true);
	}

	private void ConfirmOrCancelTarget()
	{
		if (!isCommunicating && m_data != null)
		{
			if (currentTargetGachaItemId != 0)
			{
				OpenCancelTargetConfirm();
			}
			else if (selectedTargetGachaItemId != 0)
			{
				SendSelectTarget();
			}
		}
	}

	private void SendSelectTarget()
	{
		SetCommunicationState(communicating: true);
		int targetGachaItemId = selectedTargetGachaItemId;
		ReportGachaClick();
		Model<CardDrawModel>.Interface.SendGachaTargetSelect(m_data.GachaId, targetGachaItemId, (GachaTargetSelectAck ack) =>
		{
			if (!(this == null) && m_data != null)
			{
				if (!isActiveAndEnabled)
				{
					isCommunicating = false;
				}
				else
				{
					SetCommunicationState(communicating: false);
					_ = ack?.PoolUnique;
				}
			}
		});
	}

	private void ReportGachaClick()
	{
		GachaClickEvent evt = EventTrackSolver.Instance.GetEvt<GachaClickEvent>();
		evt.gachaId = m_data.GachaId;
		evt.gachaType = 0;
		evt.type = 4;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void OpenCancelTargetConfirm()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPTARGETGACHACANCELCONFIRM, new PopupTargetGachaCancelConfirmViewData
		{
			GachaId = m_data.GachaId
		});
	}

	private void SetCommunicationState(bool communicating)
	{
		isCommunicating = communicating;
		for (int i = 0; i < selectionCharacterCards.Count; i++)
		{
			ResidentionalRewardCharacterCard residentionalRewardCharacterCard = selectionCharacterCards[i];
			if (residentionalRewardCharacterCard.gameObject.activeSelf)
			{
				residentionalRewardCharacterCard.BtnClick.Interactable(!communicating && currentTargetGachaItemId == 0);
			}
		}
		confirmButton?.Interactable(currentTargetGachaItemId != 0 || selectedTargetGachaItemId != 0);
	}

	private void HideCharacterCards()
	{
		selectedCharacterCard?.gameObject.SetActive(value: false);
		for (int i = 0; i < selectionCharacterCards.Count; i++)
		{
			selectionCharacterCards[i].gameObject.SetActive(value: false);
		}
	}

	public override void Close()
	{
		if (!isCommunicating)
		{
			base.Close();
		}
	}

	public void HandleGamepadConfirm()
	{
		confirmButton?.OnSubmit(null);
	}

	public void HandleGamepadCancel()
	{
		Close();
	}

	public void RefreshSelectedCharacterByGamepad()
	{
		if (!isCommunicating && currentTargetGachaItemId == 0 && !(targetSelectionRoot == null) && targetSelectionRoot.activeInHierarchy)
		{
			ResidentionalRewardCharacterCard residentionalRewardCharacterCard = EventSystemHelper.CurrentSelected?.GetComponentInParent<ResidentionalRewardCharacterCard>();
			if (residentionalRewardCharacterCard != null && residentionalRewardCharacterCard.gameObject.activeInHierarchy && selectionCharacterCards.Contains(residentionalRewardCharacterCard))
			{
				SelectCharacter(residentionalRewardCharacterCard.id);
			}
		}
	}

	public void HandleGamepadSwitchTab(bool next)
	{
		if (!isCommunicating)
		{
			if (next)
			{
				ShowRulePage();
			}
			else
			{
				ShowCharacterPage();
			}
		}
	}
}
