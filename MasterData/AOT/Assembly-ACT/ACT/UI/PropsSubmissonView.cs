using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.MissionSystem;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class PropsSubmissonView : BaseUIView<PropsSubmissonViewInputController>
{
	public CommonWeaponBag commonWeaponBag;

	public MonoScrollBagComponent scrollBag;

	public CommonScrollBagComponent ScrollRect;

	public ActButton BtnConfim;

	public List<NormalItemUIComponent> PropsSubmitItemsUI;

	public ActButton BtnClose;

	public ActButton BtnBack;

	public GameObject emptyDes;

	public GameObject GamepadTipsRoot;

	public Dictionary<PropsSubmissonViewInputControlType, List<GameObject>> ControlDownPromts;

	public Dictionary<PropsSubmissonViewInputControlType, List<GameObject>> ControlPromts;

	public ViewControlRoot ViewControlRoot;

	public Dictionary<PropsSubmissonViewInputControlType, ViewControlLayer> ControlLayerDic;

	private MonoScrollBagComponent.Param scrollBagParam;

	private List<ItemSubmit> _submissionDataList = new List<ItemSubmit>();

	private List<Item> SubMissionItem = new List<Item>();

	private List<Item> Items = new List<Item>();

	private PropsSubmissonViewData m_data => uiViewData as PropsSubmissonViewData;

	private PropsSubmissonViewInputControlType ControlType
	{
		get
		{
			return GetController().ControlType;
		}
		set
		{
			GetController().ControlType = value;
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
		await base.PreInit();
		BtnConfim.SetBtnClick(ConfirmBtn);
		BtnBack.SetBtnClick(OnClose);
		BtnClose.SetBtnClick(OnClose);
		SetBagParam();
	}

	protected override void Init()
	{
		base.Init();
		ShowItem();
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
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public void OnClose()
	{
		SubmissionClose evt = Singleton<EventManager>.instance.GetEvt<SubmissionClose>();
		evt.id = m_data.id;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.SubmissionClose, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		Close();
	}

	private void SetBagParam()
	{
		GetAssistData();
		scrollBagParam.itemShowType = MonoScrollBagComponent.Param.ItemShowType.None;
		scrollBagParam.onSelectItem = ChooseAssist;
	}

	private void ChooseAssist(ItemUIComponentBase itemCell)
	{
		Item item = new Item();
		item.Id = itemCell.ItemUnifier.Id;
		item.Count = (int)itemCell.ItemUnifier.Count;
		PropsSubmitItemsUI[0].SetData(item, GetItemNeedCount(item.Id), ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.Both);
		PropsSubmitItemsUI[0].UpdatePerformance();
		PropsSubmitItemsUI[0].SetAddState(state: false);
		BtnConfim.Interactable(CheckIsEnough(item.Id));
		SubMissionItem.Clear();
		Item item2 = new Item();
		item2.Id = item.Id;
		item2.Count = item.Count;
		SubMissionItem.Add(item2);
	}

	private bool CheckIsEnough(int id)
	{
		for (int i = 0; i < _submissionDataList.Count; i++)
		{
			if (_submissionDataList[i].itemId == id)
			{
				Item itemInfo = G.localPlayer.Inventory.GetItemInfo(id);
				if (itemInfo != null && itemInfo.Count >= _submissionDataList[i].itemCount)
				{
					return true;
				}
			}
		}
		return false;
	}

	private int GetItemNeedCount(int id)
	{
		for (int i = 0; i < _submissionDataList.Count; i++)
		{
			if (id == _submissionDataList[i].itemId)
			{
				return _submissionDataList[i].itemCount;
			}
		}
		return 0;
	}

	private void GetAssistData()
	{
		scrollBagParam.allItems.items = new List<Item>();
		if (Singleton<MissionManager>.instance.GetMissionItemSubmit(m_data.id, out _submissionDataList))
		{
			for (int i = 0; i < _submissionDataList.Count; i++)
			{
				Item item = new Item();
				item.Id = _submissionDataList[i].itemId;
				item.Count = _submissionDataList[i].itemCount;
				scrollBagParam.allItems.items.Add(item);
			}
		}
	}

	public async void ShowItem()
	{
		SubMissionItem.Clear();
		foreach (NormalItemUIComponent item2 in PropsSubmitItemsUI)
		{
			item2.Release();
			item2.UpdatePerformance();
			item2.gameObject.SetActive(value: false);
		}
		if (_submissionDataList == null || _submissionDataList.Count == 0)
		{
			return;
		}
		commonWeaponBag.gameObject.SetActive(IsSingleSubmit());
		if (IsSingleSubmit())
		{
			PropsSubmitItemsUI[0].SetAddState(state: true);
			OpenBags();
			BtnConfim.Interactable(active: false);
			PropsSubmitItemsUI[0].gameObject.SetActive(value: true);
			return;
		}
		int num = 0;
		for (int i = 0; i < _submissionDataList.Count; i++)
		{
			if (i < PropsSubmitItemsUI.Count)
			{
				Item item = new Item();
				item.Id = _submissionDataList[i].itemId;
				item.Count = _submissionDataList[i].itemCount;
				Item itemInfo = G.localPlayer.Inventory.GetItemInfo(item.Id);
				if (itemInfo != null)
				{
					PropsSubmitItemsUI[i].SetData(itemInfo, _submissionDataList[i].itemCount, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.Both, autoReleaseData: true);
					PropsSubmitItemsUI[i].UpdatePerformance();
				}
				PropsSubmitItemsUI[i].SetNotObtainedState(itemInfo == null);
				if (itemInfo != null && itemInfo.Count >= item.Count)
				{
					num++;
				}
				PropsSubmitItemsUI[i].gameObject.SetActive(value: true);
				SubMissionItem.Add(item);
			}
		}
		BtnConfim.Interactable(num >= _submissionDataList.Count);
	}

	private bool IsSingleSubmit()
	{
		return false;
	}

	public void ConfirmBtn()
	{
		SendCommitMessage();
	}

	public async void SendCommitMessage()
	{
		BackToBattleMain();
		SubItemCommit evt = Singleton<EventManager>.instance.GetEvt<SubItemCommit>();
		evt.itemid = SubMissionItem[0].Id;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.SubItemCommit, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		SubmitItem evt2 = Singleton<EventManager>.instance.GetEvt<SubmitItem>();
		evt2.MissionId = m_data.id;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionN_ItemSubmit, evt2);
		Singleton<EventManager>.instance.ReleaseEvt(evt2);
		Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
		{
			tableName = LocalizationUtility.localizeTableName_Common,
			localizeId = 1019
		});
	}

	private void OpenBags()
	{
		SuchPropsSubmissonList(Items);
		emptyDes.SetActive(Items.Count <= 0);
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		ItemUnifierProxy.ItemUnifierPool.GetList(Items, list);
		ScrollRect.ItemSource = list;
		ScrollRect.OnItemShow = null;
		CommonScrollBagComponent scrollRect = ScrollRect;
		scrollRect.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(scrollRect.OnItemShow, new Action<ItemUIComponentBase>(ItemInit));
		ScrollRect.OnItemSelect = null;
		CommonScrollBagComponent scrollRect2 = ScrollRect;
		scrollRect2.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(scrollRect2.OnItemSelect, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			ChooseAssist(l);
		}));
		ScrollRect.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
	}

	public void ItemInit(ILoopScrollDataSource iLoopSource)
	{
		_ = iLoopSource is ItemUIComponentBase;
	}

	public void SuchPropsSubmissonList(List<Item> items)
	{
		items.Clear();
		int i;
		for (i = 0; i < _submissionDataList.Count; i++)
		{
			List<Item> list = G.localPlayer.Inventory.Items.FindAll((Item _) => _.Id == _submissionDataList[i].itemId);
			if (list.Count > 0)
			{
				items.AddRange(list);
				continue;
			}
			Item item = new Item();
			item.Id = _submissionDataList[i].itemId;
			item.Count = 0;
			items.Add(item);
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
		if (type == DeviceInputMode.Gamepad)
		{
			ChangeViewControl(PropsSubmissonViewInputControlType.Main);
		}
	}

	public void OnInputControllerActivate()
	{
		ChangeViewControl(PropsSubmissonViewInputControlType.Main);
	}

	public void ChangeViewControl(PropsSubmissonViewInputControlType propsSubmissonViewInputControlType)
	{
		PropsSubmissonViewInputControlType controlType = ControlType;
		ControlType = propsSubmissonViewInputControlType;
		ControlLayerDic[propsSubmissonViewInputControlType].ReFocus();
		for (int i = 0; i < GamepadTipsRoot.transform.GetChild(0).childCount; i++)
		{
			GamepadTipsRoot.transform.GetChild(0).GetChild(i).gameObject.SetActive(value: false);
		}
		foreach (GameObject item in ControlDownPromts[propsSubmissonViewInputControlType])
		{
			item.SetActive(value: true);
			LayoutRebuilder.ForceRebuildLayoutImmediate(item.GetComponent<RectTransform>());
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(GamepadTipsRoot.transform.GetChild(0).GetComponent<RectTransform>());
		for (int j = 0; j < ControlPromts[controlType].Count; j++)
		{
			ControlPromts[controlType][j].SetActive(value: false);
		}
		for (int k = 0; k < ControlPromts[propsSubmissonViewInputControlType].Count; k++)
		{
			ControlPromts[propsSubmissonViewInputControlType][k].SetActive(value: true);
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		}
	}

	public void OnConfirm()
	{
		if (!(EventSystemHelper.CurrentSelected == null))
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}
}
