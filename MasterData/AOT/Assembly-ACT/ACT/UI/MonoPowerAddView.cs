using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Model.PowerModel;
using Runtime.UI.CommonComponent.CommonTimer;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization.SmartFormat.PersistentVariables;

namespace ACT.UI;

public class MonoPowerAddView : TextPanel<PowerAddViewInputController>
{
	public PowerBar costPower;

	public RectTransform ItemParent;

	public NormalItemUIComponent ItemAsset;

	public int powerItemId;

	public TextPanel.Param raidCloseParm;

	public TextPanel.Param lackPowerRaidCloseParm;

	public ActButton cancelBtn;

	public ActButton confirmBtn;

	public GameObject nextRecoverTimerRoot;

	public GameObject recoverMaxTimerRoot;

	public GameObject powerIsMaxRoot;

	public CommonTimerComponent nextRecoverTimer;

	public CommonTimerComponent recoverMaxTimer;

	public ViewControlRoot viewControlRoot;

	public ViewControlLayer buttonControlLayer;

	public ViewControlLayer costControlLayer;

	public GameObject bottomPromptRoot;

	public OperateBtnPrompt cancelPrompt;

	public OperateBtnPrompt confirmPrompt;

	public OperateBtnPrompt powerBarPrompt;

	public OperateBtnPrompt changeLeftPrompt;

	public OperateBtnPrompt changeRightPrompt;

	private NormalItemUIComponent m_SelectedItem;

	private int m_leftCount;

	private bool m_CanOperate;

	private List<NormalItemUIComponent> itemPrefabs = new List<NormalItemUIComponent>();

	protected override void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Power_Refresh, OnRefresh);
		PowerModel powerModel = Model<PowerModel>.Interface;
		powerModel.OnPowerChanged = (Action)Delegate.Combine(powerModel.OnPowerChanged, new Action(OnPowerChange));
		cancelBtn?.SetBtnClick(Close);
		confirmBtn?.SetBtnClick(OnSubmit);
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Power_Refresh, OnRefresh);
		PowerModel powerModel = Model<PowerModel>.Interface;
		powerModel.OnPowerChanged = (Action)Delegate.Remove(powerModel.OnPowerChanged, new Action(OnPowerChange));
	}

	public void OnRefresh(BaseEventContent obj)
	{
		m_leftCount = RuntimeConfigs.data.game.freeDiamondExchangePowerNum - G.localPlayer.Profile.PowerDailyBuyNum;
		List<Item> list = new List<Item>();
		foreach (Item item in G.localPlayer.Inventory.Items)
		{
			if (item.itemType == 23 && !item.IsDisuse())
			{
				list.Add(item);
			}
		}
		list.Add(new Item
		{
			Id = 97,
			Count = (int)G.detailUserInfo.Attributes[97]
		});
		for (int num = itemPrefabs.Count - 1; num >= 0; num--)
		{
			UnityEngine.Object.Destroy(itemPrefabs[num].gameObject);
		}
		itemPrefabs.Clear();
		for (int i = 0; i < list.Count; i++)
		{
			NormalItemUIComponent normalItemUIComponent = UnityEngine.Object.Instantiate(ItemAsset, ItemParent);
			normalItemUIComponent.GetComponent<RectTransform>().SetSiblingIndex(ItemParent.childCount - 2);
			normalItemUIComponent.gameObject.SetActive(value: true);
			normalItemUIComponent.showDetailPanel = false;
			normalItemUIComponent.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Remove(normalItemUIComponent.OnItemClick, new UnityAction<ItemUIComponentBase>(OnClick));
			normalItemUIComponent.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(normalItemUIComponent.OnItemClick, new UnityAction<ItemUIComponentBase>(OnClick));
			normalItemUIComponent.Station = Station;
			normalItemUIComponent.SetData(list[i], 0L, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
			normalItemUIComponent.UpdatePerformance();
			itemPrefabs.Add(normalItemUIComponent);
		}
		void OnClick(ItemUIComponentBase arg0)
		{
			OnItemChoose(arg0 as NormalItemUIComponent, arg0.ItemUnifier.Id);
		}
	}

	public override UniTask PreInit()
	{
		if (nextRecoverTimer != null)
		{
			nextRecoverTimer.IsCountDown = true;
		}
		if (recoverMaxTimer != null)
		{
			recoverMaxTimer.IsCountDown = true;
		}
		return base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
		m_CanOperate = true;
		OnRefresh(null);
		RefreshPowerRecoverTimers();
		OnItemChoose(itemPrefabs[0], itemPrefabs[0].ItemUnifier.Id);
		GetController()?.RefreshSelection();
		UpdateBtnPromptActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad && viewControlRoot.CurrentFocusLayer != costControlLayer);
		UpdateBottomPromptActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad && viewControlRoot.CurrentFocusLayer == costControlLayer);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		BetterAnimation componentInChildren = ControlTransform.GetComponentInChildren<BetterAnimation>();
		if (componentInChildren != null)
		{
			componentInChildren.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
		betterAnimation?.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		BetterAnimation componentInChildren = ControlTransform.GetComponentInChildren<BetterAnimation>();
		if (componentInChildren != null)
		{
			componentInChildren.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
		betterAnimation?.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void UnInit()
	{
		base.UnInit();
		m_Param.OnCancel?.Invoke();
		m_SelectedItem = null;
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Popup_Close");
		GetController()?.UnFocus();
		for (int num = itemPrefabs.Count - 1; num >= 0; num--)
		{
			UnityEngine.Object.Destroy(itemPrefabs[num].gameObject);
		}
		itemPrefabs.Clear();
	}

	private void OnItemChoose(NormalItemUIComponent item, int id)
	{
		if (m_SelectedItem != null)
		{
			SetItemHighlightState(m_SelectedItem, isHighLight: false);
		}
		m_SelectedItem = item;
		SetItemHighlightState(m_SelectedItem, isHighLight: true);
		ItemData itemData = RuntimeConfigs.data.itemDatas[id];
		if (itemData.type == 999)
		{
			if (m_leftCount <= 0)
			{
				localStringEvent.StringReference.TableEntryReference = 510L;
				confirmBtn.interactable = false;
				return;
			}
			string[] texts = m_Param.texts;
			if (texts == null || texts.Length <= 0)
			{
				m_Param.texts = new string[3];
			}
			string[] texts2 = m_Param.texts;
			int count = RuntimeConfigs.data.game.freeDiamondExchangePowerCost[G.localPlayer.Profile.PowerDailyBuyNum].count;
			texts2[0] = count.ToString();
			m_Param.texts[1] = RuntimeConfigs.data.game.freeDiamondExchangePowerObtain.ToString();
			m_Param.texts[2] = m_leftCount.ToString();
			localStringEvent.StringReference.TableEntryReference = 501L;
			for (int i = 0; i < m_Param.texts.Length; i++)
			{
				localStringEvent.StringReference.GetVariable<string>(i.ToString()).Value = m_Param.texts[i];
			}
			if ((int)G.detailUserInfo.Attributes[97] < RuntimeConfigs.data.game.freeDiamondExchangePowerCost[G.localPlayer.Profile.PowerDailyBuyNum].count)
			{
				confirmBtn.interactable = false;
			}
			else
			{
				confirmBtn.interactable = true;
			}
		}
		else
		{
			confirmBtn.interactable = m_SelectedItem.ItemUnifier.Count > 0;
			int use = itemData.Use;
			Collection collection = RuntimeConfigs.data.collections[use];
			localStringEvent.StringReference.TableEntryReference = 2151L;
			Variable<string> variable = localStringEvent.StringReference.GetVariable<string>("0");
			int count = collection.certain[0].count;
			variable.Value = count.ToString();
			Variable<string> variable2 = localStringEvent.StringReference.GetVariable<string>("1");
			count = collection.certain[0].count;
			variable2.Value = count.ToString();
		}
	}

	public void OnSubmit()
	{
		ItemData itemData = RuntimeConfigs.data.itemDatas[m_SelectedItem.ItemUnifier.Id];
		int num = ((itemData.type == 999) ? RuntimeConfigs.data.game.freeDiamondExchangePowerObtain : RuntimeConfigs.data.collections[itemData.Use].certain[0].count);
		int stackLimit = RuntimeConfigs.data.itemDatas[96].stackLimit;
		if (Model<PowerModel>.Interface.PowerCount + num > stackLimit)
		{
			GameUtility.OpenToolTip(2152, "Common", new List<string> { stackLimit.FastToString() });
			return;
		}
		if (itemData.type == 999)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
			{
				commonId = 2149,
				texts = m_Param.texts,
				OnConfirm = () =>
				{
					PowerBuyFreeDiamond();
				},
				OnCancel = () =>
				{
					GetController()?.RefreshSelection();
				},
				cancelBtnDes = 14,
				confirmBtnDes = 13
			});
			return;
		}
		int itemId = m_SelectedItem.ItemUnifier.Id;
		int itemUid = m_SelectedItem.ItemUnifier.Uid;
		int b = Mathf.Min((int)m_SelectedItem.ItemUnifier.Count, GetLimitCount(itemId, stackLimit));
		b = Mathf.Max(1, b);
		Action<int> confirmClick = (int count) =>
		{
			G.service.UseItem(itemId, itemUid, count, 0, (bool flag, RepeatedField<Item> items, RepeatedField<UniversalItem> universalItems) =>
			{
				if (flag)
				{
					GameUtility.OpenPopReward(universalItems);
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.Power_Refresh, null);
				}
			});
			Close();
		};
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_USEITEM, new MonoUseItemView.UseItemData
		{
			Item = (m_SelectedItem.ItemUnifier.Source as Item),
			limitMin = 1,
			limitMax = Mathf.Min(20, b),
			confirmClick = confirmClick,
			onClose = () =>
			{
				GetController()?.RefreshSelection();
			}
		});
	}

	private void SetItemHighlightState(NormalItemUIComponent item, bool isHighLight)
	{
		if (!(item == null))
		{
			item.SetHighLightVisualOnly(isHighLight);
		}
	}

	private int GetLimitCount(int itemId, int powerLimit)
	{
		ItemData itemData = RuntimeConfigs.data.itemDatas[itemId];
		Collection collection = RuntimeConfigs.data.collections[itemData.Use];
		return (powerLimit - Model<PowerModel>.Interface.PowerCount) / collection.certain[0].count;
	}

	private void PowerBuyFreeDiamond()
	{
		G.service.PowerBuyFreeDiamond(async (int ack) =>
		{
			if (ack >= 0)
			{
				G.localPlayer.Profile.PowerRecoverTs = TimeManager.ServerTime.NowTimestamp;
				G.localPlayer.Profile.PowerDailyBuyNum = RuntimeConfigs.data.game.freeDiamondExchangePowerNum - ack;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.Power_Refresh, null);
				List<Item> list = new List<Item>();
				Item item = new Item
				{
					Id = powerItemId,
					Count = RuntimeConfigs.data.game.freeDiamondExchangePowerObtain
				};
				list.Add(item);
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(list));
				await CloseAsync();
				m_CanOperate = true;
			}
			else
			{
				Close();
			}
		});
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		UpdateBtnPromptActive(type == DeviceInputMode.Gamepad && viewControlRoot.CurrentFocusLayer != costControlLayer);
		UpdateBottomPromptActive(type == DeviceInputMode.Gamepad && viewControlRoot.CurrentFocusLayer == costControlLayer);
	}

	public void SelectLeftItem()
	{
		int num = itemPrefabs.IndexOf(m_SelectedItem);
		int index = ((num - 1 >= 0) ? (num - 1) : 0);
		OnItemChoose(itemPrefabs[index], itemPrefabs[index].ItemUnifier.Id);
	}

	public void SelectRightItem()
	{
		int num = itemPrefabs.IndexOf(m_SelectedItem);
		int index = ((num + 1 > itemPrefabs.Count - 1) ? (itemPrefabs.Count - 1) : (num + 1));
		OnItemChoose(itemPrefabs[index], itemPrefabs[index].ItemUnifier.Id);
	}

	public void ClickPowerBar()
	{
		costPower?.OnClick();
	}

	public void UpdateBtnPromptActive(bool isActive)
	{
		confirmPrompt?.SetVisible(isActive);
		cancelPrompt?.SetVisible(isActive);
		changeLeftPrompt?.SetVisible(isActive);
		changeRightPrompt?.SetVisible(isActive);
		powerBarPrompt?.SetVisible(isActive);
	}

	public void UpdateBottomPromptActive(bool isActive)
	{
		bottomPromptRoot?.SetActive(isActive);
	}

	private void OnPowerChange()
	{
		RefreshPowerRecoverTimers();
	}

	private void RefreshPowerRecoverTimers()
	{
		if (Model<PowerModel>.Interface.PowerCount >= RuntimeConfigs.data.game.powerLimit)
		{
			SetRecoverTimer(nextRecoverTimer, 0L);
			SetRecoverTimer(recoverMaxTimer, 0L);
		}
		else
		{
			SetRecoverTimer(nextRecoverTimer, Model<PowerModel>.Interface.NextRecoverTime);
			SetRecoverTimer(recoverMaxTimer, Model<PowerModel>.Interface.recoverToMaxTime);
		}
	}

	private void SetRecoverTimer(CommonTimerComponent timer, long recoverTimeStamp)
	{
		if (!(timer == null))
		{
			long num = ((recoverTimeStamp > 0) ? (recoverTimeStamp - TimeManager.ServerTime.NowTimestamp) : 0);
			if (num <= 0)
			{
				timer.Time = System.DateTime.MinValue;
				timer.gameObject.SetActive(value: false);
				nextRecoverTimerRoot.SetActive(value: false);
				recoverMaxTimerRoot.SetActive(value: false);
				powerIsMaxRoot.SetActive(value: true);
			}
			else
			{
				nextRecoverTimerRoot.SetActive(value: true);
				recoverMaxTimerRoot.SetActive(value: true);
				powerIsMaxRoot.SetActive(value: false);
				timer.gameObject.SetActive(value: true);
				timer.IsCountDown = true;
				System.DateTime minValue = System.DateTime.MinValue;
				timer.Time = minValue.Add(TimeSpan.FromMilliseconds(num));
			}
		}
	}
}
