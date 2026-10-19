using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class RecoveryItemView : BaseUIView<RecoveryItemViewInputController>
{
	private RecoveryItemViewData m_data;

	public CommonScrollBagComponent RecoveryScroll;

	public RectTransform _recoveryScroll;

	public RectTransform _recoveryContent;

	public EquipUIComponent EquipUIComponent;

	public GemUIComponent GemUIComponent;

	public BloodBottleUIComponent BloodBottleUIComponent;

	public BloodBottleMaterialUIComponent BloodBottleMatUIComponent;

	public NormalItemUIComponent ItemUIComponent;

	public CommonScrollBagComponent RewardScroll;

	public RectTransform _rewardScroll;

	public RectTransform _rewardContent;

	public ActButton CancelBtn;

	public ActButton ConfirmBtn;

	public ActButton CloseBtn;

	public ViewControlRoot ViewControlRoot;

	public ViewControlLayer RewardControlLayer;

	public ViewControlLayer BtnControlLayer;

	public GameObject GamepadTips;

	public GameObject LeftStickPromt;

	protected override void OnInputControllerCreate()
	{
		ChangeControlType(RecoveryItemViewControlType.Main);
		GamepadTips.SetActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad)
		{
			ChangeControlType(RecoveryItemViewControlType.Main);
		}
		else if (EventSystemHelper.CurrentSelected != null)
		{
			ItemUIComponentBase component = EventSystemHelper.CurrentSelected.GetComponent<ItemUIComponentBase>();
			if ((bool)component)
			{
				component.SetIsOn(val: false);
			}
		}
		GamepadTips.SetActive(type == DeviceInputMode.Gamepad);
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
	}

	protected override void Init()
	{
		base.Init();
		if (uiViewData == null)
		{
			return;
		}
		CancelBtn.SetBtnClick(Close);
		CloseBtn.SetBtnClick(Close);
		ConfirmBtn.SetBtnClick(OnClickConfirmBtnHandle);
		m_data = uiViewData as RecoveryItemViewData;
		float num = ItemUIComponent.GetComponent<RectTransform>().sizeDelta.x;
		LayoutElement component = ItemUIComponent.GetComponent<LayoutElement>();
		if (component != null)
		{
			num = ((component.preferredWidth > 0f) ? component.preferredWidth : num);
		}
		float b = 1024f;
		int count = m_data.RecoveryItems.Count;
		HorizontalLayoutGroup component2 = _recoveryContent.GetComponent<HorizontalLayoutGroup>();
		float a = (float)count * num + (float)(count - 1) * component2.spacing + (float)component2.padding.left + (float)component2.padding.right;
		_recoveryScroll.sizeDelta = new Vector2(Mathf.Min(a, b), _recoveryScroll.sizeDelta.y);
		RecoveryScroll.ClearBag();
		RecoveryScroll.Station = Station;
		RecoveryScroll.SelectMode = CommonScrollBagComponent.SelectModeType.Single;
		RecoveryScroll.ItemSource = m_data.RecoveryItems;
		RecoveryScroll.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		CommonScrollBagComponent recoveryScroll = RecoveryScroll;
		recoveryScroll.BeforeInstantiate = (Action<int>)Delegate.Combine(recoveryScroll.BeforeInstantiate, (Action<int>)((int index) =>
		{
			IBagItem source = m_data.RecoveryItems[index].Source;
			if (!(source is Equip))
			{
				if (!(source is Gem))
				{
					if (!(source is BloodBottleData))
					{
						if (source is BloodBottleMaterial)
						{
							RecoveryScroll.BindTemplate(BloodBottleMatUIComponent.gameObject);
						}
						else
						{
							RecoveryScroll.BindTemplate(ItemUIComponent.gameObject);
						}
					}
					else
					{
						RecoveryScroll.BindTemplate(BloodBottleUIComponent.gameObject);
					}
				}
				else
				{
					RecoveryScroll.BindTemplate(GemUIComponent.gameObject);
				}
			}
			else
			{
				RecoveryScroll.BindTemplate(EquipUIComponent.gameObject);
			}
		}));
		List<Item> list = (m_data.IsEquipDecompose ? GetEquipDecomposeRewards(m_data.RecoveryItems) : GetItemRecycleRewrds(m_data.RecoveryItems));
		List<ItemUnifierProxy> list2 = ListPool<ItemUnifierProxy>.Get();
		ItemUnifierProxy.ItemUnifierPool.GetList(list, list2);
		RewardScroll.Station = Station;
		RewardScroll.SelectMode = CommonScrollBagComponent.SelectModeType.Single;
		RewardScroll.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		RewardScroll.ItemSource = list2;
		b = _rewardScroll.sizeDelta.x;
		int count2 = list2.Count;
		component2 = _rewardContent.GetComponent<HorizontalLayoutGroup>();
		a = (float)count2 * num + (float)(count2 - 1) * component2.spacing + (float)component2.padding.left + (float)component2.padding.right;
		_rewardScroll.sizeDelta = new Vector2(Mathf.Min(a, b), _rewardScroll.sizeDelta.y);
	}

	private List<Item> GetItemRecycleRewrds(List<ItemUnifierProxy> recoveryItems)
	{
		List<Item> list = new List<Item>();
		for (int i = 0; i < recoveryItems.Count; i++)
		{
			ItemData itemData = RuntimeConfigs.data.itemDatas[recoveryItems[i].Id];
			if (itemData.deleteCompensate.Count <= 0)
			{
				continue;
			}
			for (int j = 0; j < itemData.deleteCompensate.Count; j++)
			{
				ItemKv itemKv = itemData.deleteCompensate[j];
				bool flag = false;
				foreach (Item item2 in list)
				{
					if (item2.Id == itemKv.id)
					{
						flag = true;
						item2.Count += (int)(itemKv.count * recoveryItems[i].Count);
						break;
					}
				}
				if (!flag)
				{
					Item item = new Item
					{
						Id = itemKv.id,
						Count = (int)(itemKv.count * recoveryItems[i].Count)
					};
					list.Add(item);
				}
			}
		}
		return list;
	}

	private List<Item> GetEquipDecomposeRewards(List<ItemUnifierProxy> recoveryItems)
	{
		List<Item> list = new List<Item>();
		foreach (ItemUnifierProxy recoveryItem in recoveryItems)
		{
			foreach (ItemKv item in CoreUtils.GetData(recoveryItem.GetItemData(RuntimeConfigs.data.equipDatas).GetLevelMaterialId(recoveryItem.As<Equip>().Level), RuntimeConfigs.data.equipMaterialDatas).RecyclingLv)
			{
				Item item2 = list.Find((Item x) => x.Id == item.id);
				if (item2 != null)
				{
					item2.Count += item.count;
					continue;
				}
				list.Add(new Item
				{
					Id = item.id,
					Count = item.count
				});
			}
		}
		return list;
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

	public override void Close()
	{
		base.Close();
	}

	private void OnClickConfirmBtnHandle()
	{
		if (m_data.IsEquipDecompose)
		{
			OnEquipDismantle();
			return;
		}
		RepeatedField<UniversalItem> repeatedField = new RepeatedField<UniversalItem>();
		for (int i = 0; i < m_data.RecoveryItems.Count; i++)
		{
			ItemUnifierProxy itemUnifierProxy = m_data.RecoveryItems[i];
			UniversalItem universalItem = new UniversalItem();
			universalItem.Index = itemUnifierProxy.Id;
			universalItem.Count = (int)itemUnifierProxy.Count;
			universalItem.Uid = itemUnifierProxy.Uid;
			repeatedField.Add(universalItem);
		}
		G.service.RecycleItemsReq(repeatedField, (RecycleItemsAck r) =>
		{
			if (r != null)
			{
				List<Item> newItems = ListPool<Item>.Get();
				foreach (UniversalItem item2 in r.Items)
				{
					Item item = new Item
					{
						Id = item2.Index,
						Count = item2.Count
					};
					newItems.Add(item);
				}
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(newItems), notSort: false, () =>
				{
					ListPool<Item>.Release(newItems);
				});
				Close();
				m_data.OnRecovery?.Invoke();
			}
		});
	}

	private void OnEquipDismantle()
	{
		List<int> equipUIDs = ListPool<int>.Get();
		foreach (ItemUnifierProxy recoveryItem in m_data.RecoveryItems)
		{
			equipUIDs.Add(recoveryItem.As<Equip>().Uid);
		}
		G.service.EquipDismantle(equipUIDs, (bool x, RepeatedField<Item> items) =>
		{
			ListPool<int>.Release(equipUIDs);
			if (x)
			{
				List<ItemUnifierProxy> tempList = ListPool<ItemUnifierProxy>.Get();
				ItemUnifierProxy.ItemUnifierPool.GetList(items, tempList);
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(tempList), notSort: false, () =>
				{
					ListPool<ItemUnifierProxy>.Release(tempList);
				});
				Close();
				m_data.OnRecovery?.Invoke();
			}
		});
	}

	public void ChangeControlType(RecoveryItemViewControlType controlType)
	{
		GetController().ControlType = controlType;
		if (controlType == RecoveryItemViewControlType.Main)
		{
			BtnControlLayer.UnFocus();
			BtnControlLayer.Focus();
		}
		else
		{
			RewardControlLayer.UnFocus();
			RewardControlLayer.Focus();
		}
		LeftStickPromt?.SetActive(controlType == RecoveryItemViewControlType.Main);
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		}
		if (GetController().ControlType == RecoveryItemViewControlType.Reward)
		{
			EventSystemHelper.CurrentSelected.GetComponent<ItemUIComponentBase>().SetIsOn(val: true);
		}
	}
}
